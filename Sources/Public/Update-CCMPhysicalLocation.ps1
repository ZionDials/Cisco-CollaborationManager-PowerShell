Function global:Update-CCMPhysicalLocation {
    <#
    .SYNOPSIS
        Updates CUCM Physical Location

    .DESCRIPTION
        Updates CUCM Physical Location

    .PARAMETER NewDescription
        New Description of Physical Location.

    .PARAMETER NewName
        New Name of Physical Location.

    .PARAMETER UUID
        UUID of Physical Location.
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][String]$NewDescription,
        [Parameter(ValueFromPipelineByPropertyName)][String]$NewName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName)][String]$UUID
    )
    $ConfigFile = Get-CCMSettingsFile

    if ($NewDescription -eq "" -and $NewName -eq "") {
        Write-Error "NewDescription or NewName must be specified."
        exit
    }

    $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CUCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:updatePhysicalLocation>
              <uuid>$UUID</uuid>
              $(if ($NewName -ne "") {<newName>$NewName</newName>})
              $(if ($NewDescription -ne "") {<description>$NewDescription</description>})
           </ns:updatePhysicalLocation>
        </soapenv:Body>
     </soapenv:Envelope>
"@

    $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
    return $Response.Envelope.Body.updatePhysicalLocationResponse.return
}
