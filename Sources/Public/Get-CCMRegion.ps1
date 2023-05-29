Function global:Get-CCMRegion {
    <#
    .SYNOPSIS
        Queries CUCM for Region(s)

    .DESCRIPTION
        Queries CUCM for Region(s)

    .PARAMETER Name
        Name of Region(s). Use '%' for wildcard.

    .PARAMETER First
        Number of records to return.

    .PARAMETER Skip
        Number of records to skip.

    .PARAMETER UUID
        UUID of Region.
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][Int]$First,
        [Parameter(ValueFromPipelineByPropertyName)][Int]$Skip,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Name,
        [Parameter(ValueFromPipelineByPropertyName)][String]$UUID
    )
    $ConfigFile = Get-CCMSettingsFile

    if ($Name -eq "") {
        $Name = "%"
    }

    if ($UUID -ne "") {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CUCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:getRegion>
              <uuid>$UUID</uuid>
              <returnedTags uuid="?">
                 <name>?</name>
                 <relatedRegions>
                    <relatedRegion uuid="?">
                       <regionName uuid="?">?</regionName>
                       <bandwidth>?</bandwidth>
                       <videoBandwidth>?</videoBandwidth>
                       <lossyNetwork>?</lossyNetwork>
                       <codecPreference uuid="?">?</codecPreference>
                       <immersiveVideoBandwidth>?</immersiveVideoBandwidth>
                    </relatedRegion>
                 </relatedRegions>
                 <defaultCodec>?</defaultCodec>
              </returnedTags>
           </ns:getRegion>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        return $Response.Envelope.Body.getRegionResponse.return.region
    }
    else {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CUCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:listRegion>
              <searchCriteria>
                 <name>$Name</name>
              </searchCriteria>
              <returnedTags uuid="?">
                 <name>?</name>
                 <defaultCodec>?</defaultCodec>
              </returnedTags>
              $(if ($Skip -ne "") {"<skip>$Skip</skip>"})
              $(if ($First -ne "") {"<first>$First</first>"})
           </ns:listRegion>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content

        return $Response.Envelope.Body.listRegionResponse.return.region
    }
}
