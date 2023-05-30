Function global:Get-CCMPhysicalLocation {
    <#
    .SYNOPSIS
        Queries CUCM for Physical Location(s)

    .DESCRIPTION
        Queries CUCM for Physical Location(s)

    .PARAMETER Description
        Department for Physical Location(s). Use '%' for wildcard.

    .PARAMETER Name
        Name of Physical Location(s). Use '%' for wildcard.

    .PARAMETER First
        Number of records to return.

    .PARAMETER Skip
        Number of records to skip.

    .PARAMETER UUID
        UUID of Physical Location.
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][Int]$First,
        [Parameter(ValueFromPipelineByPropertyName)][Int]$Skip,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Description,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Name,
        [Parameter(ValueFromPipelineByPropertyName)][String]$UUID
    )
    $ConfigFile = Get-CCMSettingsFile

    if ($Description -eq "") {
        $Description = "%"
    }

    if ($Name -eq "") {
        $Name = "%"
    }

    if ($UUID -ne "") {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:getPhysicalLocation>
              <uuid>$UUID</uuid>
              <returnedTags uuid="?">
                 <name>?</name>
                 <description>?</description>
              </returnedTags>
           </ns:getPhysicalLocation>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        return $Response.Envelope.Body.getPhysicalLocationResponse.return.physicalLocation
    }
    else {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:listPhysicalLocation>
              <searchCriteria>
                 <name>$Name</name>
                 <description>$Description</description>
              </searchCriteria>
              <returnedTags uuid="?">
                 <name>?</name>
                 <description>?</description>
              </returnedTags>
              $(if ($Skip -ne "") {"<skip>$Skip</skip>"})
              $(if ($First -ne "") {"<first>$First</first>"})
              </ns:listPhysicalLocation>
              </soapenv:Body>
           </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content

        return $Response.Envelope.Body.listPhysicalLocationResponse.return.physicalLocation
    }
}
