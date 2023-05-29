Function global:Get-CCMVersion {
    <#
    .SYNOPSIS
        Queries CUCM for Version

    .DESCRIPTION
        Queries CUCM for Version
    #>
    $ConfigFile = Get-CCMSettingsFile

    $SOAP = @"
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CUCM.version)">
    <soapenv:Header/>
    <soapenv:Body>
       <ns:getCCMVersion>
          <processNodeName></processNodeName>
       </ns:getCCMVersion>
    </soapenv:Body>
 </soapenv:Envelope>
"@

    $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
    $Version = $Response.Envelope.Body.getCCMVersionResponse.return.componentVersion.version

    return $Version
}
