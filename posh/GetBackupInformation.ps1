<#
	.SYNOPSIS
		Script to pull out information about backup files
	.DESCRIPTION
		Script to pull out information of a single or multiple backup files
	.PARAMETER connectionString
		String. Connection string to connect to SQL Server instance.
  .PARAMETER bacupfiles
    System.IO.FileInfo array. File information array.
  .PARAMETER csvFile
    String. Full path to CSV file for output of backup information, file is deleted if it exist.
	.PARAMETER delimiter
		String. Delimiter for CSV file.
	.EXAMPLE
	Output backup information to console of all backups in directory, using SQL Server instance on local host
    GetBackupInformation -cn "Server=localhost;Integrated Security=true;Initial Catalog=master;" -backupFiles (Get-ChildItem C:\temp\backups)
	.EXAMPLE
	Output backup information of single backup to console, using SQL Server instance on local host
    GetBackupInformation -cn "Server=localhost;Integrated Security=true;Initial Catalog=master;" -backupFiles (Get-ChildItem C:\temp\backups\MyBackup.bak)
	.EXAMPLE
	Output backup information to CSV of all backups in directory, using SQL Server instance on local host
    GetBackupInformation -cn "Server=localhost;Integrated Security=true;Initial Catalog=master;" -backupFiles (Get-ChildItem C:\temp\backups) -csvFile C:\temp\BackupInfo.csv -delimiter "|"
#>
[cmdletbinding()]
param(
    [Parameter(Mandatory = $false,Position = 0)]
	[Alias("cn")]
    [string]$connectionString = "Server=localhost\number12;Integrated Security=true;Initial Catalog=master;",
    [Parameter(Mandatory = $false,Position = 1)]
	[Alias("bkfiles")]
    [System.IO.FileInfo[]]$backupFiles,
    [Parameter(Mandatory = $false,Position = 2)]
	[Alias("csv")]
    [string]$csvFile,
    [Parameter(Mandatory = $false,Position = 3)]
    [string]$delimiter = "|" 
)

    $sqlcn = New-Object System.Data.SqlClient.SqlConnection
    $sqlcn.ConnectionString = $connectionString
    try {
        $sqlcn.Open();
    }
    catch
    {
	    $errText = $error[0].ToString()
	    if ($rrText.Contains("Failed to connect"))
	    {
		    Write-Verbose "Connection failed."
		    Return "Connection failed to $server"
            $error[0] | select *
	    }
    }

	if ($csvFile) {
		if (Test-Path $csvFile) {
			Remove-Item $csvFile -Force
		}
	}
    
    $result = [pscustomobject]@{BackupFile=$null; DatabaseName=$null; CompatibilityLevel=0; RecoveryModel=$null; LogicalName=$null; FileGroupName=$null; sizeMB=0; sizeGB=0; Type=$null; LocalDrive=$null}
    foreach ($b in $backupFiles) {

    $qryHeader = @"
RESTORE HEADERONLY FROM DISK = N'$($b.FullName)';
"@
		$sqlcmd = $sqlcn.CreateCommand()
		$sqlcmd.CommandText= $qryHeader

		$adp = New-Object System.Data.SqlClient.SqlDataAdapter $sqlcmd
		$dataHeader = New-Object System.Data.DataSet
		$adp.Fill($dataHeader) | Out-Null

        $headerRowCount = $dataHeader.Tables[0].Rows.Count
		if ($headerRowCount -eq 1) {
			$qryFilelist = @"
RESTORE FILELISTONLY FROM DISK = N'$($b.FullName)';
"@
			$sqlcmd.CommandText= $qryFilelist
			$dataFilelist = New-Object System.Data.DataSet
			$adp.Fill($dataFilelist) | Out-Null

			$fileListRowCount = $dataFilelist.Tables[0].Rows.Count
			for ($f=0; $fileListRowCount -gt $f; $f++) {
				$result.BackupFile = $b.Name
				$result.DatabaseName = $dataHeader.Tables[0].Rows.DatabaseName
				$result.CompatibilityLevel = $dataHeader.Tables[0].Rows.CompatibilityLevel
				$result.RecoveryModel = $dataHeader.Tables[0].Rows.RecoveryModel
				$result.LogicalName = $dataFilelist.Tables[0].Rows[$f].LogicalName
				$result.FileGroupName = $dataFilelist.Tables[0].Rows[$f].FileGroupName
				$result.sizeMB = $dataFilelist.Tables[0].Rows[$f].size/1mb
				$result.sizeGB = $dataFilelist.Tables[0].Rows[$f].size/1gb
				$result.Type = $dataFilelist.Tables[0].Rows[$f].Type
				$result.LocalDrive = $null

				if ($csvFile) {
					$result | Export-Csv -Path $csvFile -Delimiter $delimiter -NoClobber -NoTypeInformation -Append
				}
				else {
					$result
				}
			} #end for fileListRowCount
		} # end single backup set
		else {
			#clearing the contents of the dataset
			$dataFileList.Reset()

			for ($h=0; $headerRowCount -gt $h; $h++) {
				#for getting backup info within backup set need to specify file number
				$fileNum = 1

				$qryFilelist = @"
RESTORE FILELISTONLY FROM DISK = N'$($b.FullName)' WITH FILE = $($fileNum);
"@
				$sqlcmd.CommandText= $qryFilelist
				$dataFilelist = New-Object System.Data.DataSet
				$adp.Fill($dataFilelist) | Out-Null

				$fileListRowCount = $dataFilelist.Tables[0].Rows.Count
				for ($f=0; $fileListRowCount -gt $f; $f++) {
					$result.BackupFile = $b.Name
					$result.DatabaseName = $dataHeader.Tables[0].Rows[$h].DatabaseName
					$result.CompatibilityLevel = $dataHeader.Tables[0].Rows[$h].CompatibilityLevel
					$result.RecoveryModel = $dataHeader.Tables[0].Rows[$h].RecoveryModel
					$result.LogicalName = $dataFilelist.Tables[0].Rows[$f].LogicalName
					$result.FileGroupName = $dataFilelist.Tables[0].Rows[$f].FileGroupName
					$result.sizeMB = $dataFilelist.Tables[0].Rows[$f].size/1mb
					$result.sizeGB = $dataFilelist.Tables[0].Rows[$f].size/1gb
					$result.Type = $dataFilelist.Tables[0].Rows[$f].Type
					$result.LocalDrive = $null
					if ($csvFile) {
						$result | Export-Csv -Path $csvFile -Delimiter $delimiter -NoClobber -NoTypeInformation -Append
					}
					else {
						$result
					}
				} #end for fileListRowCount

				#this is to clear the dataset as we are done with te current data
				$dataFileList.Reset()
				#incrementing file number to get the next backup set
				$fileNum++
			} #end for headerRowCount
		}
    } #end foreach file
#close the connection to SQL Server
$sqlcn.Close();

#start up Excel automatically by uncommenting below line
#Start-Process Excel.exe
