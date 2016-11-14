<#
Author: 		Shawn Melton
Date:			2015-06-10
Script:			LoadStackExchangeToSQLServer.ps1
Purpose:		Provide a method(s) to download and import StackExchange dump data into a SQL Server database
#>

#region GlobalVariables
# URL to download the StackExchange Archive files
$script:SEArchiveSite = "https://archive.org/download/stackexchange"

# Set alias to use for working with 7-Zip, assumes default installation was performed
$szPath = "$env:ProgramFiles\7-Zip\7z.exe"
if (Test-Path $szPath)
{
	Set-Alias sz $szPath -Scope Global
}
#endregion GlobalVariables

#region RequiredFunction
<#
.SYNOPSIS
Creates a DataTable for an object (http://poshcode.org/2119)
.DESCRIPTION
Creates a DataTable based on an objects properties.
.INPUTS
Object
    Any object can be piped to Out-DataTable
.OUTPUTS
   System.Data.DataTable
.EXAMPLE
$dt = Get-Alias | Out-DataTable
This example creates a DataTable from the properties of Get-Alias and assigns output to $dt variable
.NOTES
Adapted from script by Marc van Orsouw see link
Version History
v1.0   - Chad Miller - Initial Release
v1.1   - Chad Miller - Fixed Issue with Properties
.LINK
http://thepowershellguy.com/blogs/posh/archive/2007/01/21/powershell-gui-scripblock-monitor-script.aspx
#>
function Out-DataTable {
    [CmdletBinding()]
    param([Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $true)] [PSObject[]]$InputObject)

    Begin
    {
        $dt = new-object Data.datatable  
        $First = $true 
    }
    Process
    {
        foreach ($object in $InputObject)
        {
            $DR = $DT.NewRow()  
            foreach($property in $object.PsObject.get_properties())
            {  
                if ($first)
                {  
                    $Col =  new-object Data.DataColumn  
                    $Col.ColumnName = $property.Name.ToString()  
                    $DT.Columns.Add($Col)
                }  
                if ($property.IsArray)
                { $DR.Item($property.Name) =$property.value | ConvertTo-XML -AS String -NoTypeInformation -Depth 1 }  
                else { $DR.Item($property.Name) = $property.value }  
            }  
            $DT.Rows.Add($DR)  
            $First = $false
        }
    } 
     
    End
    {
        Write-Output @(,($dt))
    }

}
#endregion RequiredFunction

#region Get
function Get-StackExchangeArchive {
<#
	.SYNOPSIS
		Downloads the specified 7-Zip file for the site specified
	.DESCRIPTION
		Downloads the Archive of the specified StackExchange network site
	.PARAMETER siteName
		String. The [siteName].stackexchange.com; with meta sites you can reference them as "meta.dba".
    .PARAMETER downloadPath
        String. The path to download the archive file to on your local or network directory
    .PARAMETER getReadme
        Switch. Will download the ReadMe.txt file as well.
	.EXAMPLE
	Download a non-meta site in StackExchange network
    Get-StackExchangeArchive -siteName skeptics -downloadPath 'C:\temp\MyDumpSite'
	.EXAMPLE
	Download a meta site in StachExchange network
	Get-StackExchangeArchive -siteName meta.ell -downloadPath 'C:\temp\MyDumpSite'
	.EXAMPLE
	Download a site and the readme file for StackExchanage Archives
	Get-StackExchangeArchive -siteName dba -downloadPath 'C:\Temp\MyDumpSite' -getReadme
#>
	[CmdletBinding()]
	param (
		[Parameter(
			Mandatory = $true,
			Position = 0
		)]
		[ValidateNotNull()]
		[Alias("site")]
		[string[]]$siteName,
		
		[Parameter(
			Mandatory = $true,
			Position = 1
		)]
		[ValidateNotNull()]
		[string]$downloadPath,
		
		[Parameter(
			Mandatory = $false,
			Position = 2)]
		[switch]$getReadme
	)
	
	# provide option to create path if it does not exist
	if ( !(Test-Path $downloadPath -PathType Container) ) {
		Write-Verbose "Path: $downloadPath == DOES NOT EXIST"
		$decision = Read-Host "Do you want to create $downloadPath (Y/N)?: "
		if ($decision -eq 'Y') {
			try { New-Item $downloadPath -ItemType Directory -Force }
			catch { $errText = $error[0].ToString(); $errText }
		}
	}
	
	Write-Verbose "URL being used: $SEArchiveSite"
	try {
		$siteDumpList = Invoke-WebRequest $SEArchiveSite | select -ExpandProperty Links | where { $_ -match ".7z" } | select -ExpandProperty innerText
	}
	catch {
		$errText = $error[0].ToString()
		if ($errText.Contains("remote server returned an error")) {
			Write-Verbose "Error returned by archive.org"
			Return "Error returned: $errText"
		}
		else {
			Write-Error $errText
		}
	}
	
	if ($getReadme) {
		Write-Verbose "Downloading ReadMe.txt"
		$readme = Invoke-WebRequest $SEArchiveSite | select -ExpandProperty Links | where { $_ -eq "readme.txt" } | select -ExpandProperty innerText
		$source = "$SEarchiveSite/$readme"
		$destination = "$downloadPath\$readme"
		Write-Verbose "Source path: $source"
		Write-Verbose "Destination path: $destination"
		try {
			Invoke-WebRequest $source -OutFile $destination
		}
		catch {
			$errText = $error[0].ToString()
			if ($errText.Contains("remote server returned an error")) {
				Write-Verbose "Error returned by archive.org"
				Return "Error returned: $errText"
			}
			else {
				Write-Error $errText
			}
		}
		if (Test-Path $destination) {
			Write-Verbose "Download completed for $destination"
		}
		else {
			Write-Verbose "Something went wrong and the file $destination does not exist"
		}
	}

	Write-Verbose "Number of files found from URL: $($siteDumpList.Count)"

    if ($siteName -match "stackoverflow")
    {
        $decision = Read-Host -Prompt "Are you sure you want to download those big, freaking files???? Y/N"
        if ($decision -eq 'Y') {
            Write-Verbose "Alright you asked for it..."
            
            $Badges = "$SEArchiveSite/stackoverflow.com-Badges.7z"
            $Comments = "$SEArchiveSite/stackoverflow.com-Comments.7z"
            $PostHistory = "$SEArchiveSite/stackoverflow.com-PostHistory.7z"
            $PostLinks = "$SEArchiveSite/stackoverflow.com-PostLinks.7z"
            $Posts = "$SEArchiveSite/stackoverflow.com-Posts.7z"
            $Tags = "$SEArchiveSite/stackoverflow.com-Tags.7z"
            $Users = "$SEArchiveSite/stackoverflow.com-Users.7z"
            $Votes = "$SEArchiveSite/stackoverflow.com-Votes.7z"

		    $destBadges = "$downloadPath\stackoverflow.com-Badges.7z"
            $destComments = "$downloadPath\stackoverflow.com-Comments.7z"
            $destPostHistory = "$downloadPath\stackoverflow.com-PostHistory.7z"
            $destPostLinks = "$downloadPath\stackoverflow.com-PostLinks.7z"
            $destPosts = "$downloadPath\stackoverflow.com-Posts.7z"
            $destTags = "$downloadPath\stackoverflow.com-Tags.7z"
            $destUsers = "$downloadPath\stackoverflow.com-Users.7z"
            $destVotes = "$downloadPath\stackoverflow.com-Votes.7z"

		    try {
		        Write-Verbose "Destination path: $destBadges"
		        Write-Verbose "Source path: $Badges"
			    Invoke-WebRequest $Badges -OutFile $destBadges
			}
			catch {
			    $errText = $error[0].ToString()
			    if ($errText.Contains("remote server returned an error")) {
				    Write-Verbose "Error returned by archive.org"
				    Return "Error returned: $errText"
			    }
			    else {
				    Write-Error $errText
			    }
		    }
			try {
		        Write-Verbose "Destination path: $destComments"
                Write-Verbose "Source path: $Comments"
                Invoke-WebRequest $Comments -OutFile $destComments
			}
			catch {
			    $errText = $error[0].ToString()
			    if ($errText.Contains("remote server returned an error")) {
				    Write-Verbose "Error returned by archive.org"
				    Return "Error returned: $errText"
			    }
			    else {
				    Write-Error $errText
			    }
		    }
			try {
  		        Write-Verbose "Destination path: $destPostHistory"
                Write-Verbose "Source path: $PostHistory"
                Invoke-WebRequest $PostHistory -OutFile $destPostHistory
			}
			catch {
			    $errText = $error[0].ToString()
			    if ($errText.Contains("remote server returned an error")) {
				    Write-Verbose "Error returned by archive.org"
				    Return "Error returned: $errText"
			    }
			    else {
				    Write-Error $errText
			    }
		    }
			try {
                Write-Verbose "Destination path: $destPostLinks"
                Write-Verbose "Source path: $PostLinks"
                Invoke-WebRequest $PostLinks -OutFile $destPostLinks
			}
			catch {
			    $errText = $error[0].ToString()
			    if ($errText.Contains("remote server returned an error")) {
				    Write-Verbose "Error returned by archive.org"
				    Return "Error returned: $errText"
			    }
			    else {
				    Write-Error $errText
			    }
		    }
			try {
				Write-Verbose "Destination path: $destPosts"
		        Write-Verbose "Source path: $Posts"
			    Invoke-WebRequest $Posts -OutFile $destPosts
			}
			catch {
			    $errText = $error[0].ToString()
			    if ($errText.Contains("remote server returned an error")) {
				    Write-Verbose "Error returned by archive.org"
				    Return "Error returned: $errText"
			    }
			    else {
				    Write-Error $errText
			    }
		    }
			try {
		        Write-Verbose "Destination path: $destTags"
		        Write-Verbose "Source path: $Tags"
			    Invoke-WebRequest $Tags -OutFile $destTags
			}
			catch {
			    $errText = $error[0].ToString()
			    if ($errText.Contains("remote server returned an error")) {
				    Write-Verbose "Error returned by archive.org"
				    Return "Error returned: $errText"
			    }
			    else {
				    Write-Error $errText
			    }
		    }
			try {
		        Write-Verbose "Destination path: $destUsers"
		        Write-Verbose "Source path: $Users"
			    Invoke-WebRequest $Users -OutFile $destUsers
			}
			catch {
			    $errText = $error[0].ToString()
			    if ($errText.Contains("remote server returned an error")) {
				    Write-Verbose "Error returned by archive.org"
				    Return "Error returned: $errText"
			    }
			    else {
				    Write-Error $errText
			    }
		    }
			try {
		        Write-Verbose "Destination path: $destVotes"
		        Write-Verbose "Source path: $Votes"
			    Invoke-WebRequest $Votes -OutFile $destVotes
		    }
		    catch {
			    $errText = $error[0].ToString()
			    if ($errText.Contains("remote server returned an error")) {
				    Write-Verbose "Error returned by archive.org"
				    Return "Error returned: $errText"
			    }
			    else {
				    Write-Error $errText
			    }
		    }
        }
        else {
            Write-Verbose "Cancelling"
        }
    }
    else {
	    $SiteToGrab = $siteDumpList | where {$_ -match "^$siteName"}
	    Write-Verbose "Number of site(s) found: $($SiteToGrab.Count)"
	    if ($SiteToGrab.Count -eq 1) {
		    Write-Verbose "Your siteName has been found: $SiteToGrab"
		
		    $source = "$SEArchiveSite/$SiteToGrab"
		    $destination = "$downloadPath\$SiteToGrab"
		    Write-Verbose "Source path: $source"
		    Write-Verbose "Destination path: $destination"

		    try {
			    Invoke-WebRequest $source -OutFile $destination
		    }
		    catch {
			    $errText = $error[0].ToString()
			    if ($errText.Contains("remote server returned an error")) {
				    Write-Verbose "Error returned by archive.org"
				    Return "Error returned: $errText"
			    }
			    else {
				    Write-Error $errText
			    }
		    }
		    if (Test-Path $destination) {
			    Write-Verbose "Download completed for $destination"
		    }
		    else {
			    Write-Verbose "Something went wrong and the file $destination does not exist"
		    }
	    }
	    elseif ($SiteToGrab.Count -gt 1) {
		    Write-Verbose "More than one file was found"
		    $decision = Read-Host "Do you want to download all files Y/N?"
		    if ($decision -eq 'Y') {
			    foreach ($s in $SiteToGrab) {
				    Write-Verbose "Your siteName has been found: $s"
				    $source = "$SEArchiveSite/$s"
				    $destination = "$downloadPath\$s"

				    Write-Verbose "Source path: $source"
				    Write-Verbose "Destination path: $destination"

				    try {
					    Invoke-WebRequest $source -OutFile $destination
				    }
				    catch {
					    $errText = $error[0].ToString()
					    if ($errText.Contains("remote server returned an error")) {
						    Write-Verbose "Error returned by archive.org"
						    Return "Error returned: $errText"
					    }
					    else {
						    Write-Error $errText
					    }
				    }
				    if (Test-Path $destination) {
					    Write-Verbose "Download completed for $destination"
				    }
				    else {
					    Write-Verbose "Something went wrong and the file $destination does not exist"
				    }
			    }
		    }
		    elseif ($decision -eq 'N') {
			    Write-Verbose "Cancelling"
		    }
		    else {
			    Write-Verbose "Response was not recognized"
		    }
	    }
    }
}
#endregion Get

#region Unzip
function Unzip-StackExchangeArchive {
<#
	.SYNOPSIS
		Uses 7-Zip to list and extract a zipped file with extension *.7z
	.DESCRIPTION
		Utilizes alias "sz" created within the module StackExchange that calls CLI of 7-Zip
	.PARAMETER filename
		The zipped file to be uncompressed.
	.PARAMETER listContents
		Will list the contents of each zipped file
	.EXAMPLE
	Extract single zipped file and list contents
    Unzip-StackExchangeArchive 'C:\Temp\MyZippedFile.7z' -listContents
#>
	[CmdletBinding()]
	param (
		[Parameter(
			Mandatory = $true,
			Position = 0
		)]
		[ValidateNotNull()]
		[Alias("file")]
		[string]$filename,
		[Parameter(
			Mandatory = $false,
			Position = 1
		)]
		[switch]$listContents
	)
	
	if (Test-Path $filename) {
		if ($listContents) {
			sz l $filename
			Write-Verbose "Extracting contents of $filename"
			sz e $filename
		}
		else {
			Write-Verbose "Extracting contents to $filename"
			sz e $filename
		}
	}
	else {
		Write-Verbose "File does not exist: $filename"
		Return "File not found"
	}
}
#endregion Unzip

#region dataload
function Load-SeArchiveToSql {
<#
	.SYNOPSIS
		Pulls XML dump file and bulk loads into database
	.DESCRIPTION
		Imports the XML dump file and then uses bulk load method to import into specified database
	.PARAMETER pathToFiles
		String. The path to where the uncompressed XML files are located for the StackExchange site
    .PARAMETER server
        String. SQL Server instance were database is located
    .PARAMETER database
        String. Database where you want to import the data
    .PARAMETER schema
        String. Defaults to "dbo", specify schema if using specific one
    .PARAMETER tableList
        String array. List of tables to be used to import data, accepts array of values
    .PARAMATER batchSize
        Integer. If you want to set the batch size for the bulk copy process, otherwise it is not set. Good to use if loading StackOverflow site data.
	.EXAMPLE
	Import one table to specific schema
    Load-DataDumpToSql -pathToFiles 'C:\temp\quant.stackexchange.com' -server MANATARMS\SQL12 -database StackExchange -schema quant -tableList Badges
	.EXAMPLE
	Import multiple tables to specific schema
	Load-DataDumpToSql -pathToFiles 'C:\temp\quant.stackexchange.com' -server MANATARMS\SQL12 -database StackExchange -schema quant -tableList 'Badges','Votes'
	.EXAMPLE
	Import all files into database, using default schema, and verbose logging
	$files = Get-ChildItem 'C:\temp\quant.stackexchange.com' -filter *.xml | select -ExpandProperty BaseName
    Load-DataDumpToSql -pathToFiles 'C:\temp\quant.stackexchange.com' -server MANATARMS\SQL12 -database StackExchange -tableList $files -Verbose
    .EXAMPLE
    Setting the batch size
    Load-DataDumpToSql -pathToFiles 'C:\temp\quant.stackexchange.com' -server MANATARMS\SQL12 -database StackExchange -schema quant -tableList 'Badges','Votes' -batchSize 1000
#>

	[cmdletbinding()]
	param (
		[string]$pathToFiles,
        [string]$server,
        [string]$database,
        [string]$schema = 'dbo',
        [string[]]$tableList,
        [int]$batchSize
	)
	
	if ( !(Test-Path $pathToFiles) ) {
		Write-Error -Message "***The path provided does not exist***"
        Break;
	}
    
    Push-Location
    Set-Location $pathToFiles

    $Files = Get-ChildItem -Path $pathToFiles -Filter *.xml | select Name, BaseName

    $sqlCn = New-Object System.Data.SqlClient.SqlConnection("Data Source=$($server);Integrated Security=SSPI;Initial Catalog=$($database)");
    try {
        $sqlCn.Open();
        $bulkLoad = New-Object ("System.Data.SqlClient.SqlBulkCopy") $sqlCn
        if ($batchSize -ne $null) { $bulkLoad.BatchSize = $batchSize }
    }
    catch
    {
    	$errText = $error[0].ToString()
    	if ($errText.Contains("Failed to connect")) {
		    Write-Verbose "Connection to $server failed."
		    Return "Connection failed to $server"
	    }
		else {
			Write-Error $errText
			break;
		}
    }

    $totalFiles = $files.Count
    $totalTables = $tableList.Count
    $i = 1
    $x = 1
    foreach ($f in $Files) {
        Write-Progress -Id 1 -Activity "Working on Files" -Status "Processing $($f.Name)" -PercentComplete $i
        foreach ($t in $tableList) {
            Write-Progress -Id 2 -Activity "Working on Tables" -Status "Processing $t" -PercentComplete $x
                if (Test-Path $f.Name )
                {
                        if ($t -eq $f.BaseName) {
                            switch ($t) {
                                "Badges" {
                                    Write-Verbose "Found Badges file..."
                                    [xml]$badges = Get-Content $f.Name
                                    $badgesDt = $badges.badges.Row | select Id, UserId, Name, Date | Out-DataTable
                                    $bulkLoad.DestinationTableName = "$schema.$t"
                                    Write-Verbose "Bulk loading Badges file..."
                                    $bulkLoad.WriteToServer($badgesDt)
                                }
                                "Comments" {  
                                    Write-Verbose "Found Comments file..."
                                    [xml]$comments = Get-Content $f.Name
                                    $commentsDt = $comments.comments.row | select Id, PostId, Score, Text, CreationDate, UserId | Out-DataTable
                                    $bulkLoad.DestinationTableName = "$schema.$t"
                                    Write-Verbose "Bulk loading Comments file..."
                                    $bulkLoad.WriteToServer($commentsDt)
                                }
                                "PostHistory" {
                                    Write-Verbose "Found PostHistory file..."
                                    [xml]$postHistory = Get-Content $f.Name
                                    $postHistoryDt = $postHistory.posthistory.row | select Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, 
                                        UserId, UserDisplayName, Comment, Text, CloseReasonId | Out-DataTable
                                    $bulkLoad.DestinationTableName = "$schema.$t"
                                    Write-Verbose "Bulk loading PostHistory file..."
                                    $bulkLoad.WriteToServer($postHistoryDt)
                                }
                                "PostLinks" {
                                    Write-Verbose "Found PostLinks file..."
                                    [xml]$postLink = Get-Content $f.Name
                                    $postLinkDt = $postLink.postlinks.row | select Id, CreationDate, PostId, RelatedPostId, LinkTypeId | Out-DataTable
                                    $bulkLoad.DestinationTableName = "$schema.$t"
                                    Write-Verbose "Bulk loading PostLinks file..."
                                    $bulkLoad.WriteToServer($postLinkDt)
                                }
                                "Posts" {
                                    Write-Verbose "Found Posts file..."
                                    [xml]$posts = Get-Content $f.Name
                                    $postsDt = $posts.posts.row | select Id, PostTypeId, ParentId, AcceptedAnswerId, CreationDate, Score, ViewCount,
                                        Body, OwnerUserId, LastEditorUserId, LastEditorDisplayName, LastEditDate, LastActivityDate, CommunityOwnedDate,
                                        ClosedDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount | Out-DataTable
                                    $bulkLoad.DestinationTableName = "$schema.$t"
                                    Write-Verbose "Bulk loading Posts file..."
                                    $bulkLoad.WriteToServer($postsDt)
                                }
                                "Tags" {
                                    Write-Verbose "Found Tags file..."
                                    [xml]$tags = Get-Content $f.Name
                                    $tagsDt = $tags.tags.row | select Id, TagName, Count, ExcerptPostId, WikiPostId | Out-DataTable
                                    $bulkLoad.DestinationTableName = "$schema.$t"
                                    Write-Verbose "Bulk loading Tags file..."
                                    $bulkLoad.WriteToServer($tagsDt)
                                }
                                "Users" {
                                    Write-Verbose "Found Users file..."
                                    [xml]$users = Get-Content $f.Name
                                    $usersDt = $users.users.row | select Id, Reputation, CreationDate, DisplayName, EmailHash, LastAccessDate, WebsiteUrl,
                                        Location, Age, AboutMe, Views, UpVotes, DownVotes, ProfileImageUrl, AccountId | Out-DataTable
                                    $bulkLoad.DestinationTableName = "$schema.$t"
                                    Write-Verbose "Bulk loading Users file..."
                                    $bulkLoad.WriteToServer($usersDt)
                                }
                                "Votes" {
                                    Write-Verbose "Found Votes file..."
                                    [xml]$votes = Get-Content $f.Name
                                    $votesDt = $votes.votes.row | select Id, PostId, VoteTypeId, UserId, CreationDate, BountyAmount | Out-DataTable
                                    $bulkLoad.DestinationTableName = "$schema.$t"
                                    Write-Verbose "Bulk loading Votes file..."
                                    $bulkLoad.WriteToServer($votesDt)
                                }
                            }
                        }
                    }
                else {
                    Write-Warning "No valid files found in provided directory"
                }
            $x++
        }
        $i++

    }
    $sqlCn.Close()

    Pop-Location
}
#endregion dataload
