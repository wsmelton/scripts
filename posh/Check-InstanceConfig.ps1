#region Links
<#
NOTE: Links are subject to change by Microsoft
Server Configuration Options BOL:
SQL Server 2014 - http://technet.microsoft.com/en-us/library/ms189631(v=sql.120).aspx
SQL Server 2012 - http://technet.microsoft.com/en-us/library/ms189631(v=sql.110).aspx
SQL Server 2008 R2 - http://technet.microsoft.com/en-us/library/ms189631(v=sql.105).aspx
SQL Server 2008 - http://technet.microsoft.com/en-us/library/ms189631(v=sql.100).aspx
SQL Server 2005 - http://technet.microsoft.com/en-us/library/ms189631(v=sql.90).aspx
SQL Server 2000 - http://technet.microsoft.com/en-us/library/aa196706(v=sql.80).aspx
#>
#endregion Links

# $sqlConfigDefaults - Default_ values table for each version
#region $sqlConfigDefaults
# Create Table to store queries in
$sqlConfigDefaults = New-Object System.Data.DataTable "DefaultTable"

# Name the columns
$colConfigOption = "ConfigOption"
$colSQL2014 = "Default_2014"
$colSQL2012 = "Default_2012"
$colSQL2008 = "Default_2008"
$colSQL2005 = "Default_2005"
$colSQL2000 = "Default_2000"

# create columns
$cConfigOption = New-Object System.Data.DataColumn $colConfigOption,([string])
$cSQL14 = New-Object System.Data.DataColumn $colSQL2014,([int])
$cSQL12 = New-Object System.Data.DataColumn $colSQL2012,([int])
$cSQL08 = New-Object System.Data.DataColumn $colSQL2008,([int])
$cSQL05 = New-Object System.Data.DataColumn $colSQL2005,([int])
$cSQL00 = New-Object System.Data.DataColumn $colSQL2000,([int])

# Add the columns to the table
$sqlConfigDefaults.Columns.Add($cConfigOption)
$sqlConfigDefaults.Columns.Add($cSQL14)
$sqlConfigDefaults.Columns.Add($cSQL12)
$sqlConfigDefaults.Columns.Add($cSQL08)
$sqlConfigDefaults.Columns.Add($cSQL05)
$sqlConfigDefaults.Columns.Add($cSQL00)

# add data to the columns
# Apply rule "-9" = does not apply to version of SQL Server
$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'access check cache bucket count'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = -9
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'access check cache quota'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = -9
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Ad Hoc Distributed Queries'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'affinity I/O mask'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'affinity mask'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'affinity64 I/O mask'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'affinity64 mask'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Agent XPs'
$row.Default_2014 = 1
$row.Default_2012 = 1
$row.Default_2008 = 1
$row.Default_2005 = 1
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'allow updates'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'awe enabled'
$row.Default_2014 = -9
$row.Default_2012 = -9
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'backup compression default'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = -9
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'blocked process threshold'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'c2 audit mode'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'clr enabled'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'common criteria compliance enabled'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'contained database authentication'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = -9
$row.Default_2005 = -9
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'cost threshold for parallelism'
$row.Default_2014 = 5
$row.Default_2012 = 5
$row.Default_2008 = 5
$row.Default_2005 = 5
$row.Default_2000 = 5
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'cross db ownership chaining'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'cursor threshold'
$row.Default_2014 = -1
$row.Default_2012 = -1
$row.Default_2008 = -1
$row.Default_2005 = -1
$row.Default_2000 = -1
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Database Mail XPs'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Default_ full-text language'
$row.Default_2014 = 1033
$row.Default_2012 = 1033
$row.Default_2008 = 1033
$row.Default_2005 = 1033
$row.Default_2000 = 1033
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Default_ language'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Default_ trace enabled'
$row.Default_2014 = 1
$row.Default_2012 = 1
$row.Default_2008 = 1
$row.Default_2005 = 1
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'disallow results from triggers'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'EKM provided enabled'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = -9
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'filestream access level'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = -9
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'fill factor'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'ft crawl bandwidth (max)'
$row.Default_2014 = 100
$row.Default_2012 = 100
$row.Default_2008 = 100
$row.Default_2005 = 100
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'ft crawl bandwidth (min)'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'ft notify bandwidth (max)'
$row.Default_2014 = 100
$row.Default_2012 = 100
$row.Default_2008 = 100
$row.Default_2005 = 100
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'ft notify bandwidth (min)'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'index create memory'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'in-doubt xact resolution'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'lightweight pooling'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'locks'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'max degree of parallelism'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'max full-text crawl range'
$row.Default_2014 = 4
$row.Default_2012 = 4
$row.Default_2008 = 4
$row.Default_2005 = 4
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'max server memory'
$row.Default_2014 = 2147483647
$row.Default_2012 = 2147483647
$row.Default_2008 = 2147483647
$row.Default_2005 = 2147483647
$row.Default_2000 = 2147483647
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'max text repl size'
$row.Default_2014 = 65536
$row.Default_2012 = 65536
$row.Default_2008 = 65536
$row.Default_2005 = 65536
$row.Default_2000 = 65536
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'max worker threads'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 255
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'media retention'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'min memory per query'
$row.Default_2014 = 1024
$row.Default_2012 = 1024
$row.Default_2008 = 1024
$row.Default_2005 = 1024
$row.Default_2000 = 1024
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'min server memory'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'nested triggers'
$row.Default_2014 = 1
$row.Default_2012 = 1
$row.Default_2008 = 1
$row.Default_2005 = 1
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'network packet size'
$row.Default_2014 = 4096
$row.Default_2012 = 4096
$row.Default_2008 = 4096
$row.Default_2005 = 4096
$row.Default_2000 = 4096
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Ole Automation Procedures'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'open objects'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'optimize for ad hoc workloads'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = -9
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'PH timeout'
$row.Default_2014 = 60
$row.Default_2012 = 60
$row.Default_2008 = 60
$row.Default_2005 = 60
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'precompute rank'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'priority boost'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'query governor cost limit'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'query wait'
$row.Default_2014 = -1
$row.Default_2012 = -1
$row.Default_2008 = -1
$row.Default_2005 = -1
$row.Default_2000 = -1
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'recovery interval'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'remote access'
$row.Default_2014 = 1
$row.Default_2012 = 1
$row.Default_2008 = 1
$row.Default_2005 = 1
$row.Default_2000 = 1
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'remote admin connections'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'remote login timeout'
$row.Default_2014 = 10
$row.Default_2012 = 10
$row.Default_2008 = 20
$row.Default_2005 = 20
$row.Default_2000 = 20
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'remote proc trans'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'remote query timeout'
$row.Default_2014 = 600
$row.Default_2012 = 600
$row.Default_2008 = 600
$row.Default_2005 = 600
$row.Default_2000 = 600
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Replication XPs'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'scan for startup procs'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'server trigger recursion'
$row.Default_2014 = 1
$row.Default_2012 = 1
$row.Default_2008 = 1
$row.Default_2005 = 1
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'set working set size'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'show advanced options'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'SMO and DMO XPs'
$row.Default_2014 = 1
$row.Default_2012 = 1
$row.Default_2008 = 1
$row.Default_2005 = 1
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'SQL Mail XPs'
$row.Default_2014 = -9
$row.Default_2012 = -9
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'transform noise words'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'two digit year cutoff'
$row.Default_2014 = 2049
$row.Default_2012 = 2049
$row.Default_2008 = 2049
$row.Default_2005 = 2049
$row.Default_2000 = 2049
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'user connections'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'user options'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = 0
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'xp_cmdshell'
$row.Default_2014 = 0
$row.Default_2012 = 0
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

#These two are SQL Server Express only
$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'user instance timeout'
$row.Default_2014 = -9
$row.Default_2012 = -9
$row.Default_2008 = 60
$row.Default_2005 = 60
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'user instances enabled'
$row.Default_2014 = -9
$row.Default_2012 = -9
$row.Default_2008 = 0
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Web Assistant Procedures'
$row.Default_2014 = -9
$row.Default_2012 = -9
$row.Default_2008 = -9
$row.Default_2005 = 0
$row.Default_2000 = -9
$sqlConfigDefaults.Rows.Add($row);

$row = $sqlConfigDefaults.NewRow()
$row.ConfigOption = 'Using Nested Triggers'
$row.Default_2014 = -9
$row.Default_2012 = -9
$row.Default_2008 = -9
$row.Default_2005 = -9
$row.Default_2000 = 1
$sqlConfigDefaults.Rows.Add($row);

#endregion $sqlConfigDefaults

#region $sql<ver>_Defaults
$sql2014_Defaults = $sqlConfigDefaults | where {$_.Default_2014 -ne -9}
$sql2012_Defaults = $sqlConfigDefaults | where {$_.Default_2012 -ne -9}
$sql2008_Defaults = $sqlConfigDefaults | where {$_.Default_2008 -ne -9}
$sql2005_Defaults = $sqlConfigDefaults | where {$_.Default_2005 -ne -9}
$sql2000_Defaults = $sqlConfigDefaults | where {$_.Default_2000 -ne -9}
#endregion $sql<ver>_Defaults

# Load SMO
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | Out-Null

function Pull-SqlConfig {
<#
	.SYNOPSIS
		Pulls the instance configuration options for the SQL Server instance
	.DESCRIPTION
		Pulls the sp_configure values from an instance
	.PARAMETER server
		the SQL Server instance
    .PARAMETER defaultPort
        switch to specify connecting to default port used by SQL Server, alias -dp
    .PARAMETER port
        the specific port to connect to the SQL Server instance, invalid if used with -defaultPort
	.EXAMPLE
	For default instance, and default port
    Pull-SqlConfig -server MyServer
	.EXAMPLE
	For named instance, and specific port
    Pull-SqlConfig -server MyServer\MyInstance -port 49158
#>

    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0
            )]
        [ValidateNotNull()]
        [Alias("instance")]
        [string]$server,

        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=1
            )]
        [AllowNull()]
        [int]$port
    )

    if ( $port ) {
            $cn = "Data Source = $($server),$($port); Initial Catalog = master; trusted_connection = true;"
            $s = New-Object Microsoft.SqlServer.Management.Smo.Server
            $s.ConnectionContext.ConnectionString = $cn
        }
    else {
            $s = New-Object 'Microsoft.SqlServer.Management.Smo.Server' $server
        }

    $s.Configuration.Properties
}

function Check-SqlRunConfig {
<#
	.SYNOPSIS
		Checks the running values to the configured values of SQL Server instance
	.DESCRIPTION
		Pulls the sp_configure values from an instance to compare to the running to the configured value
	.PARAMETER server
		the SQL Server instance
    .PARAMETER defaultPort
        switch to specify connecting to default port used by SQL Server, alias -dp
    .PARAMETER port
        the specific port to connect to the SQL Server instance, invalid if used with -defaultPort
	.EXAMPLE
	For default instance, and default port
    Check-SqlRunConfig -server MyServer
	.EXAMPLE
	For named instance, and specific port
    Check-SqlRunConfig -server MyServer\MyInstance -port 49158
#>

    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0
            )]
        [ValidateNotNull()]
        [Alias("instance")]
        [string]$server,

        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=1
            )]
        [AllowNull()]
        [int]$port
    )

    if ( $port ) {
            $cn = "Data Source = $($server),$($port); Initial Catalog = master; trusted_connection = true;"
            $s = New-Object Microsoft.SqlServer.Management.Smo.Server
            $s.ConnectionContext.ConnectionString = $cn
        }
    else {
            $s = New-Object 'Microsoft.SqlServer.Management.Smo.Server' $server
        }

    $s.Configuration.Properties | 
        where {$_.RunValue -ne $_.ConfigValue} | 
            select @{Label="Name";Expression={$_.DisplayName}},
                @{Label="value_in_use";Expression={$_.RunValue}},
                @{Label="value";Expression={$_.ConfigValue}}
}

function Check-SqlRunDefault {
<#
	.SYNOPSIS
		Checks the running values to the default values of SQL Server instance
	.DESCRIPTION
		Pulls the sp_configure values from an instance to compare to the default values in data table, based on version
	.PARAMETER server
		the SQL Server instance
    .PARAMETER defaultPort
        switch to specify connecting to default port used by SQL Server, alias -dp
    .PARAMETER port
        the specific port to connect to the SQL Server instance, invalid if used with -defaultPort
	.EXAMPLE
	For default instance, and default port
    Check-SqlRunDefault -server MyServer
	.EXAMPLE
	For named instance, and specific port
    Check-SqlRunDefault -server MyServer\MyInstance -port 49158
#>

    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0
            )]
        [ValidateNotNull()]
        [Alias("instance")]
        [string]$server,

        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=1
            )]
        [AllowNull()]
        [int]$port
    )

    if ( $port ) {
            $cn = "Data Source = $($server),$($port); Initial Catalog = master; trusted_connection = true;"
            $s = New-Object Microsoft.SqlServer.Management.Smo.Server
            $s.ConnectionContext.ConnectionString = $cn
    }
    else {
            $s = New-Object 'Microsoft.SqlServer.Management.Smo.Server' $server
    }

    $inUse = $s.Configuration.Properties

    switch ($s.VersionMajor) {
        #SQL Server 2000
        8 {
            foreach ($d in $sql2000_Defaults) {
                $inUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -ne $d.Default_2000} | 
                    Select @{Label="Name";Expression={$_.DisplayName}}, 
                        @{Label="value_in_use";Expression={$_.RunValue}}, 
                        @{Label="default";Expression={$d.Default_2000}}
            }
        }
        
        #SQL Server 2005
        9 {
            foreach ($d in $sql2005_Defaults) {
                $inUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -ne $d.Default_2005} | 
                    Select @{Label="Name";Expression={$_.DisplayName}}, 
                        @{Label="value_in_use";Expression={$_.RunValue}}, 
                        @{Label="default";Expression={$d.Default_2005}}
            }
        }

        #SQL Server 2008/2008 R2
        10 {
            foreach ($d in $sql2008_Defaults) {
                $inUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -ne $d.Default_2008} | 
                    Select @{Label="Name";Expression={$_.DisplayName}}, 
                        @{Label="value_in_use";Expression={$_.RunValue}}, 
                        @{Label="default";Expression={$d.Default_2008}}
            }
        }
        
        #SQL Server 2012
        11 {
            foreach ($d in $sql2012_Defaults) {
                $inUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -ne $d.Default_2012} | 
                    Select @{Label="Name";Expression={$_.DisplayName}}, 
                        @{Label="value_in_use";Expression={$_.RunValue}}, 
                        @{Label="default";Expression={$d.Default_2012}}
            }
        }
        
        #SQL Server 2014
        12 {
            foreach ($d in $sql2014_Defaults) {
                $inUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -ne $d.Default_2014} | 
                    Select @{Label="Name";Expression={$_.DisplayName}}, 
                        @{Label="value_in_use";Expression={$_.RunValue}}, 
                        @{Label="default";Expression={$d.Default_2014}}
            }
        }
    }
}

function Check-SqlBadDefaults {
<#
	.SYNOPSIS
		Pulls specific configuration options running values to compare to default value based on version
	.DESCRIPTION
		Pulls specific sp_configure values from an instance to compare to the default values in data table, based on version. Specific options being pulled are those you generally do not want to leave as default values. 
	.PARAMETER server
		the SQL Server instance
    .PARAMETER defaultPort
        switch to specify connecting to default port used by SQL Server, alias -dp
    .PARAMETER port
        the specific port to connect to the SQL Server instance, invalid if used with -defaultPort
	.EXAMPLE
	For default instance, and default port
    Check-SqlBadDefaults -server MyServer
	.EXAMPLE
	For named instance, and specific port
    Check-SqlBadDefaults -server MyServer\MyInstance -port 49158
#>

    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0
            )]
        [ValidateNotNull()]
        [Alias("instance")]
        [string]$server,

        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=1
            )]
        [AllowNull()]
        [int]$port
    )
    if ( $port ) {
            $cn = "Data Source = $($server),$($port); Initial Catalog = master; trusted_connection = true;"
            $s = New-Object Microsoft.SqlServer.Management.Smo.Server
            $s.ConnectionContext.ConnectionString = $cn
    }
    else {
            $s = New-Object 'Microsoft.SqlServer.Management.Smo.Server' $server
    }

    $inUse = $s.Configuration.Properties

    $BadDefaults = 
        'backup compression default',
        'cost threshold for parallelism',
        'max degree of parallelism',
        'max server memory',
        'min server memory',
        'optimize for ad hoc workloads',
        'remote admin connections'

    $badInUse = 
        foreach ($b in $BadDefaults) {
            $inUse | where {$_.DisplayName -eq $b}
        }
    
    switch ($s.VersionMajor) {
        #SQL Server 2000
        8 {
            foreach ($d in $sql2000_Defaults) {
                $badInUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -eq $d.Default_2000} |
                    Select @{Label="Name";Expression={$_.DisplayName}},
                        @{Label="value_in_use";Expression={$_.RunValue}},
                        @{Label="bad_default";Expression={$d.Default_2000}}
            }
        }

        #SQL Server 2005
        9 {
            foreach ($d in $sql2005_Defaults) {
                $badInUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -eq $d.Default_2005} |
                    Select @{Label="Name";Expression={$_.DisplayName}},
                        @{Label="value_in_use";Expression={$_.RunValue}},
                        @{Label="bad_default";Expression={$d.Default_2005}}
            }
        }

        #SQL Server 2008/2008 R2
        10 {
            foreach ($d in $sql2008_Defaults) {
                $badInUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -eq $d.Default_2008} |
                    Select @{Label="Name";Expression={$_.DisplayName}},
                        @{Label="value_in_use";Expression={$_.RunValue}},
                        @{Label="bad_default";Expression={$d.Default_2008}}
            }
        }

        #SQL Server 2012
        11 {
            foreach ($d in $sql2012_Defaults) {
                $badInUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -eq $d.Default_2012} |
                    Select @{Label="Name";Expression={$_.DisplayName}},
                        @{Label="value_in_use";Expression={$_.RunValue}},
                        @{Label="bad_default";Expression={$d.Default_2012}}
            }
        }

        #SQL Server 2014
        12 {
            foreach ($d in $sql2014_Defaults) {
                $badInUse | where {$_.DisplayName -eq $d.ConfigOption -and $_.RunValue -eq $d.Default_2014} |
                    Select @{Label="Name";Expression={$_.DisplayName}},
                        @{Label="value_in_use";Expression={$_.RunValue}},
                        @{Label="bad_default";Expression={$d.Default_2014}}
            }
        }

    }
}
