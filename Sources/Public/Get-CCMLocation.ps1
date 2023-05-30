Function global:Get-CCMLocation {
    <#
    .SYNOPSIS
        Queries CUCM for Location(s)
    .DESCRIPTION
        Queries CUCM for Location(s)
    .PARAMETER Name
        Name of Location. Use '%' for wildcard.
    .PARAMETER UUID
        UUID of Location.
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][String]$Name,
        [Parameter(ValueFromPipelineByPropertyName)][String]$UUID
    )
    # TODO: Searching by UUID doesn't seem to be working properly. Need to investigate.
    $ConfigFile = Get-CCMSettingsFile

    if ($Name -eq "") {
        $Name = "%"
    }

    if ($UUID -ne "") {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:getLocation>
              <uuid>$UUID</uuid>
              <returnedTags uuid="?">
                 <name>?</name>
                 <id>?</id>
                 <relatedLocations>
                    <relatedLocation uuid="?">
                       <locationName uuid="?">?</locationName>
                       <rsvpSetting>?</rsvpSetting>
                    </relatedLocation>
                 </relatedLocations>
                 <withinAudioBandwidth>?</withinAudioBandwidth>
                 <withinVideoBandwidth>?</withinVideoBandwidth>
                 <withinImmersiveKbits>?</withinImmersiveKbits>
                 <betweenLocations>
                    <betweenLocation uuid="?">
                       <locationName uuid="?">?</locationName>
                       <weight>?</weight>
                       <audioBandwidth>?</audioBandwidth>
                       <videoBandwidth>?</videoBandwidth>
                       <immersiveBandwidth>?</immersiveBandwidth>
                    </betweenLocation>
                 </betweenLocations>
              </returnedTags>
           </ns:getLocation>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        return $Response.Envelope.Body.getLocationResponse.return.location
    }
    else {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:listLocation>
              <searchCriteria>
                 <name>$Name</name>
              </searchCriteria>
              <returnedTags uuid="?">
                 <name>?</name>
                 <id>?</id>
                 <withinAudioBandwidth>?</withinAudioBandwidth>
                 <withinVideoBandwidth>?</withinVideoBandwidth>
                 <withinImmersiveKbits>?</withinImmersiveKbits>
              </returnedTags>
           </ns:listLocation>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content

        return $Response.Envelope.Body.listLocationResponse.return.location
    }
}
