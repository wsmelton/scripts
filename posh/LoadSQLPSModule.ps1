function Load-SMOType {
	[cmdletbinding()]
	param(
		[int]$version,
		[switch]$outputOnly
	)
	switch ($version) {
		11 {Write-Verbose "Adding SMO for SQL Server 2012"; Add-Type -AssemblyName "Microsoft.SqlServer.Smo,Version=$($version).0.0.0,Culture=neutral,PublicKeyToken=89845dcd8080cc91"}
		12 {Write-Verbose "Adding SMO for SQL Server 2014"; Add-Type -AssemblyName "Microsoft.SqlServer.Smo,Version=$($version).0.0.0,Culture=neutral,PublicKeyToken=89845dcd8080cc91"}
		13 {Write-Verbose "Adding SMO for SQL Server 2016"; Add-Type -AssemblyName "Microsoft.SqlServer.Smo,Version=$($version).0.0.0,Culture=neutral,PublicKeyToken=89845dcd8080cc91"}
	}
	if ($outputOnly) {
		Write-Host -ForegroundColor Yellow "`nAdd-Type -AssemblyName ""Microsoft.SqlServer.Smo,Version=<version>.0.0.0,Culture=neutral,PublicKeyToken=89845dcd8080cc91""`n"
	}
}
