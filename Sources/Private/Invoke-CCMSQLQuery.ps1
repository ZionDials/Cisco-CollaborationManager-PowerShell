Function Invoke-CCMSQLRequest {
	<#
	.SYNOPSIS
		Queries CCM and returns error or result

	.DESCRIPTION
		Queries CCM and returns error or result

	.PARAMETER Request
		SQL Request
	#>
	param(
		[Parameter(Mandatory,ValueFromPipelineByPropertyName)][String]$Request
	)

	$ConfigFile = Get-CCMSettingsFile

	$SOAP = @"
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CUCM.version)">
	<soapenv:Header/>
	<soapenv:Body>
		<ns:executeSQLQuery>
			<sql>$Request</sql>
		</ns:executeSQLQuery>
	</soapenv:Body>
</soapenv:Envelope>
"@

	$response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
	return $response.Envelope.Body.executeSQLQueryResponse.return.row
}
