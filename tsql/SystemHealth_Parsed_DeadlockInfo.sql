/*
Code referenced on blog post: https://meltondba.wordpress.com/2013/10/10/xml-glad-that-is-over/
This code should work on SQL Server 2012 and higher
*/
/*
To make this code work on SQL Server 2008 (and R2) change the xDeadlock CTE to the following code:
select CAST(XEventData.XEvent.value('(data/value)[1]', 'varchar(max)') as xml) as DeadlockGraph
FROM
	(select CAST(target_data as xml) as TargetData
	from sys.dm_xe_session_targets st
	join sys.dm_xe_sessions s on s.address = st.event_session_address
	where name = 'system_health') AS Data
CROSS APPLY TargetData.nodes ('RingBufferTarget/event[@name="xml_deadlock_report"]') AS XEventData (XEvent)
*/

;WITH xDeadlock (Contents)
AS
(
select CAST(XEventData.XEvent.value('(data/value)[1]', 'varchar(max)') as xml) as DeadlockGraph
FROM
	(select CAST(target_data as xml) as TargetData
	from sys.dm_xe_session_targets st
	join sys.dm_xe_sessions s on s.address = st.event_session_address
	where name = 'system_health') AS Data
CROSS APPLY TargetData.nodes ('RingBufferTarget/event[@name="xml_deadlock_report"]') AS XEventData (XEvent)
), Victims AS
(
SELECT    ID = Victims.List.value('@id', 'varchar(50)')
FROM xDeadlock
CROSS APPLY xDeadlock.Contents.nodes('//deadlock/victim-list/victimProcess') AS Victims (List)
), Locks AS
(
SELECT  --xDeadlock.DeadlockID,
        MainLock.Process.value('@id', 'varchar(100)') AS LockID,
        OwnerList.Owner.value('@id', 'varchar(200)') AS LockProcessId,
        REPLACE(MainLock.Process.value('local-name(.)', 'varchar(100)'), 'lock', '') AS LockEvent,
        MainLock.Process.value('@objectname', 'sysname') AS ObjectName,
        OwnerList.Owner.value('@mode', 'varchar(10)') AS LockMode,
        MainLock.Process.value('@dbid', 'INTEGER') AS Database_id,
        MainLock.Process.value('@associatedObjectId', 'BIGINT') AS AssociatedObjectId,
        MainLock.Process.value('@WaitType', 'varchar(100)') AS WaitType,
        WaiterList.Owner.value('@id', 'varchar(200)') AS WaitProcessId,
        WaiterList.Owner.value('@mode', 'varchar(10)') AS WaitMode
FROM    xDeadlock
        CROSS APPLY xDeadlock.Contents.nodes('//deadlock/resource-list') AS Locks (list)
        CROSS APPLY Locks.List.nodes('*') AS MainLock (Process)
        CROSS APPLY MainLock.Process.nodes('owner-list/owner') AS OwnerList (Owner)
        CROSS APPLY MainLock.Process.nodes('waiter-list/waiter') AS WaiterList (Owner)
), Process AS 
(
-- get the data from the process node
SELECT  --xDeadlock.DeadlockID,
        [Victim] = CONVERT(BIT, CASE WHEN Deadlock.Process.value('@id', 'varchar(50)') = ISNULL(Deadlock.Process.value('../../@victim', 'varchar(50)'), v.ID) 
                                     THEN 1
                                     ELSE 0
                                END),
        [LockMode] = Deadlock.Process.value('@lockMode', 'varchar(10)'), -- how is this different from in the resource-list section?
        [ProcessID] = Process.ID, --Deadlock.Process.value('@id', 'varchar(50)'),
        [KPID] = Deadlock.Process.value('@kpid', 'int'), -- kernel-process id / thread ID number
        [SPID] = Deadlock.Process.value('@spid', 'int'), -- system process id (connection to sql)
        [SBID] = Deadlock.Process.value('@sbid', 'int'), -- system batch id / request_id (a query that a SPID is running)
        [ECID] = Deadlock.Process.value('@ecid', 'int'), -- execution context ID (a worker thread running part of a query)
        [IsolationLevel] = Deadlock.Process.value('@isolationlevel', 'varchar(200)'),
        [WaitResource] = Deadlock.Process.value('@waitresource', 'varchar(200)'),
        [LogUsed] = Deadlock.Process.value('@logused', 'int'),
        [ClientApp] = Deadlock.Process.value('@clientapp', 'varchar(100)'),
        [HostName] = Deadlock.Process.value('@hostname', 'varchar(20)'),
        [LoginName] = Deadlock.Process.value('@loginname', 'varchar(20)'),
        [TransactionTime] = Deadlock.Process.value('@lasttranstarted', 'datetime'),
        [BatchStarted] = Deadlock.Process.value('@lastbatchstarted', 'datetime'),
        [BatchCompleted] = Deadlock.Process.value('@lastbatchcompleted', 'datetime'),
        [InputBuffer] = Input.Buffer.query('.'),
        xDeadlock.[Contents],
        [QueryStatement] = Execution.Frame.value('.', 'varchar(max)'),
        TranCount = Deadlock.Process.value('@trancount', 'int')
FROM    xDeadlock
        CROSS APPLY xDeadlock.Contents.nodes('//deadlock/process-list/process') AS Deadlock (Process)
        CROSS APPLY (SELECT Deadlock.Process.value('@id', 'varchar(50)') ) AS Process (ID)
        LEFT JOIN Victims v ON Process.ID = v.ID
        CROSS APPLY Deadlock.Process.nodes('inputbuf') AS Input (Buffer)
        CROSS APPLY Deadlock.Process.nodes('executionStack') AS Execution (Frame)
)
-- get the columns in the desired order
SELECT  p.Victim,
        p.LockMode,
        LockedObject = NULLIF(l.ObjectName, ''),
        l.database_id,
        l.AssociatedObjectId,
        LockProcess = p.ProcessID,
        p.KPID,
        p.SPID,
        p.SBID,
        p.ECID,
        p.TranCount,
        l.LockEvent,
        LockedMode = l.LockMode,
        l.WaitProcessID,
        l.WaitMode,
        p.WaitResource,
        l.WaitType,
        p.IsolationLevel,
        p.LogUsed,
        p.ClientApp,
        p.HostName,
        p.LoginName,
        p.TransactionTime,
        p.BatchStarted,
        p.BatchCompleted,
        p.InputBuffer
FROM    
	Locks l
	JOIN Process p ON p.ProcessID = l.LockProcessID
--WHERE p.TransactionTime > '2013-10-01'
ORDER BY p.Victim DESC,
        p.ProcessId;

