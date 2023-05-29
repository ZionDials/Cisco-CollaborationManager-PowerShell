Function global:Get-CCMDevicePool {
    <#
    .SYNOPSIS
        Queries CCM for Device Pool(s)
    .DESCRIPTION
        Queries CCM for Device Pool(s)
    .PARAMETER Name
        Name of Device Pool(s). Use '%' for wildcard.
    .PARAMETER UUID
        UUID of Device Pool.
    #>
    param(
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
           <ns:getDevicePool sequence="?">
              <uuid>$UUID</uuid>
              <returnedTags uuid="?">
                 <name>?</name>
                 <autoSearchSpaceName uuid="?">?</autoSearchSpaceName>
                 <dateTimeSettingName uuid="?">?</dateTimeSettingName>
                 <callManagerGroupName uuid="?">?</callManagerGroupName>
                 <mediaResourceListName uuid="?">?</mediaResourceListName>
                 <regionName uuid="?">?</regionName>
                 <networkLocale>?</networkLocale>
                 <srstName uuid="?">?</srstName>
                 <connectionMonitorDuration>?</connectionMonitorDuration>
                 <automatedAlternateRoutingCssName uuid="?">?</automatedAlternateRoutingCssName>
                 <aarNeighborhoodName uuid="?">?</aarNeighborhoodName>
                 <locationName uuid="?">?</locationName>
                 <mobilityCssName uuid="?">?</mobilityCssName>
                 <physicalLocationName uuid="?">?</physicalLocationName>
                 <deviceMobilityGroupName uuid="?">?</deviceMobilityGroupName>
                 <revertPriority>?</revertPriority>
                 <singleButtonBarge>?</singleButtonBarge>
                 <joinAcrossLines>?</joinAcrossLines>
                 <cgpnTransformationCssName uuid="?">?</cgpnTransformationCssName>
                 <cdpnTransformationCssName uuid="?">?</cdpnTransformationCssName>
                 <localRouteGroupName uuid="?">?</localRouteGroupName>
                 <geoLocationName uuid="?">?</geoLocationName>
                 <geoLocationFilterName uuid="?">?</geoLocationFilterName>
                 <callingPartyNationalPrefix>?</callingPartyNationalPrefix>
                 <callingPartyInternationalPrefix>?</callingPartyInternationalPrefix>
                 <callingPartyUnknownPrefix>?</callingPartyUnknownPrefix>
                 <callingPartySubscriberPrefix>?</callingPartySubscriberPrefix>
                 <adjunctCallingSearchSpace uuid="?">?</adjunctCallingSearchSpace>
                 <callingPartyNationalStripDigits>?</callingPartyNationalStripDigits>
                 <callingPartyInternationalStripDigits>?</callingPartyInternationalStripDigits>
                 <callingPartyUnknownStripDigits>?</callingPartyUnknownStripDigits>
                 <callingPartySubscriberStripDigits>?</callingPartySubscriberStripDigits>
                 <callingPartyNationalTransformationCssName uuid="?">?</callingPartyNationalTransformationCssName>
                 <callingPartyInternationalTransformationCssName uuid="?">?</callingPartyInternationalTransformationCssName>
                 <callingPartyUnknownTransformationCssName uuid="?">?</callingPartyUnknownTransformationCssName>
                 <callingPartySubscriberTransformationCssName uuid="?">?</callingPartySubscriberTransformationCssName>
                 <calledPartyNationalPrefix>?</calledPartyNationalPrefix>
                 <calledPartyInternationalPrefix>?</calledPartyInternationalPrefix>
                 <calledPartyUnknownPrefix>?</calledPartyUnknownPrefix>
                 <calledPartySubscriberPrefix>?</calledPartySubscriberPrefix>
                 <calledPartyNationalStripDigits>?</calledPartyNationalStripDigits>
                 <calledPartyInternationalStripDigits>?</calledPartyInternationalStripDigits>
                 <calledPartyUnknownStripDigits>?</calledPartyUnknownStripDigits>
                 <calledPartySubscriberStripDigits>?</calledPartySubscriberStripDigits>
                 <calledPartyNationalTransformationCssName uuid="?">?</calledPartyNationalTransformationCssName>
                 <calledPartyInternationalTransformationCssName uuid="?">?</calledPartyInternationalTransformationCssName>
                 <calledPartyUnknownTransformationCssName uuid="?">?</calledPartyUnknownTransformationCssName>
                 <calledPartySubscriberTransformationCssName uuid="?">?</calledPartySubscriberTransformationCssName>
                 <imeEnrolledPatternGroupName uuid="?">?</imeEnrolledPatternGroupName>
                 <cntdPnTransformationCssName uuid="?">?</cntdPnTransformationCssName>
                 <localRouteGroup>
                    <name>?</name>
                    <value>?</value>
                 </localRouteGroup>
                 <redirectingPartyTransformationCSS uuid="?">?</redirectingPartyTransformationCSS>
                 <callingPartyTransformationCSS uuid="?">?</callingPartyTransformationCSS>
                 <wirelessLanProfileGroup uuid="?">?</wirelessLanProfileGroup>
                 <elinGroup uuid="?">?</elinGroup>
                 <mraServiceDomain uuid="?">?</mraServiceDomain>
              </returnedTags>
           </ns:getDevicePool>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.getDevicePoolResponse.return.devicePool | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                                           = $_.uuid
                'name'                                           = $_.name
                'autoSearchSpaceName'                            = $_.autoSearchSpaceName
                'dateTimeSettingName'                            = $_.dateTimeSettingName."#text"
                'callManagerGroupName'                           = $_.callManagerGroupName."#text"
                'mediaResourceListName'                          = $_.mediaResourceListName."#text"
                'regionName'                                     = $_.regionName."#text"
                'networkLocale'                                  = $_.networkLocale
                'srstName'                                       = $_.srstName."#text"
                'connectionMonitorDuration'                      = $_.connectionMonitorDuration
                'automatedAlternateRoutingCssName'               = $_.automatedAlternateRoutingCssName
                'aarNeighborhoodName'                            = $_.aarNeighborhoodName
                'locationName'                                   = $_.locationName."#text"
                'mobilityCssName'                                = $_.mobilityCssName
                'physicalLocationName'                           = $_.physicalLocationName."#text"
                'deviceMobilityGroupName'                        = $_.deviceMobilityGroupName
                'revertPriority'                                 = $_.revertPriority
                'singleButtonBarge'                              = $_.singleButtonBarge
                'joinAcrossLines'                                = $_.joinAcrossLines
                'cgpnTransformationCssName'                      = $_.cgpnTransformationCssName
                'cdpnTransformationCssName'                      = $_.cdpnTransformationCssName
                'geoLocationName'                                = $_.geoLocationName
                'geoLocationFilterName'                          = $_.geoLocationFilterName
                'callingPartyNationalPrefix'                     = $_.callingPartyNationalPrefix
                'callingPartyInternationalPrefix'                = $_.callingPartyInternationalPrefix
                'callingPartyUnknownPrefix'                      = $_.callingPartyUnknownPrefix
                'callingPartySubscriberPrefix'                   = $_.callingPartySubscriberPrefix
                'adjunctCallingSearchSpace'                      = $_.adjunctCallingSearchSpace
                'callingPartyNationalStripDigits'                = $_.callingPartyNationalStripDigits
                'callingPartyInternationalStripDigits'           = $_.callingPartyInternationalStripDigits
                'callingPartyUnknownStripDigits'                 = $_.callingPartyUnknownStripDigits
                'callingPartySubscriberStripDigits'              = $_.callingPartySubscriberStripDigits
                'callingPartyNationalTransformationCssName'      = $_.callingPartyNationalTransformationCssName
                'callingPartyInternationalTransformationCssName' = $_.callingPartyInternationalTransformationCssName
                'callingPartyUnknownTransformationCssName'       = $_.callingPartyUnknownTransformationCssName
                'callingPartySubscriberTransformationCssName'    = $_.callingPartySubscriberTransformationCssName
                'calledPartyNationalPrefix'                      = $_.calledPartyNationalPrefix
                'calledPartyInternationalPrefix'                 = $_.calledPartyInternationalPrefix
                'calledPartyUnknownPrefix'                       = $_.calledPartyUnknownPrefix
                'calledPartySubscriberPrefix'                    = $_.calledPartySubscriberPrefix
                'calledPartyNationalStripDigits'                 = $_.calledPartyNationalStripDigits
                'calledPartyInternationalStripDigits'            = $_.calledPartyInternationalStripDigits
                'calledPartyUnknownStripDigits'                  = $_.calledPartyUnknownStripDigits
                'calledPartySubscriberStripDigits'               = $_.calledPartySubscriberStripDigits
                'calledPartyNationalTransformationCssName'       = $_.calledPartyNationalTransformationCssName
                'calledPartyInternationalTransformationCssName'  = $_.calledPartyInternationalTransformationCssName
                'calledPartyUnknownTransformationCssName'        = $_.calledPartyUnknownTransformationCssName
                'calledPartySubscriberTransformationCssName'     = $_.calledPartySubscriberTransformationCssName
                'imeEnrolledPatternGroupName'                    = $_.imeEnrolledPatternGroupName
                'mraServiceDomain'                               = $_.mraServiceDomain
            }
            $Result = New-Object PSObject -Property $hash
            return $Result
        }
    }
    else {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CUCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:listDevicePool sequence="?">
              <searchCriteria>
                 <name>$Name</name>
              </searchCriteria>
              <returnedTags uuid="?">
                 <name>?</name>
                 <autoSearchSpaceName uuid="?">?</autoSearchSpaceName>
                 <dateTimeSettingName uuid="?">?</dateTimeSettingName>
                 <callManagerGroupName uuid="?">?</callManagerGroupName>
                 <mediaResourceListName uuid="?">?</mediaResourceListName>
                 <regionName uuid="?">?</regionName>
                 <networkLocale>?</networkLocale>
                 <srstName uuid="?">?</srstName>
                 <connectionMonitorDuration>?</connectionMonitorDuration>
                 <automatedAlternateRoutingCssName uuid="?">?</automatedAlternateRoutingCssName>
                 <aarNeighborhoodName uuid="?">?</aarNeighborhoodName>
                 <locationName uuid="?">?</locationName>
                 <mobilityCssName uuid="?">?</mobilityCssName>
                 <physicalLocationName uuid="?">?</physicalLocationName>
                 <deviceMobilityGroupName uuid="?">?</deviceMobilityGroupName>
                 <revertPriority>?</revertPriority>
                 <singleButtonBarge>?</singleButtonBarge>
                 <joinAcrossLines>?</joinAcrossLines>
                 <cgpnTransformationCssName uuid="?">?</cgpnTransformationCssName>
                 <cdpnTransformationCssName uuid="?">?</cdpnTransformationCssName>
                 <localRouteGroupName uuid="?">?</localRouteGroupName>
                 <geoLocationName uuid="?">?</geoLocationName>
                 <geoLocationFilterName uuid="?">?</geoLocationFilterName>
                 <callingPartyNationalPrefix>?</callingPartyNationalPrefix>
                 <callingPartyInternationalPrefix>?</callingPartyInternationalPrefix>
                 <callingPartyUnknownPrefix>?</callingPartyUnknownPrefix>
                 <callingPartySubscriberPrefix>?</callingPartySubscriberPrefix>
                 <adjunctCallingSearchSpace uuid="?">?</adjunctCallingSearchSpace>
                 <callingPartyNationalStripDigits>?</callingPartyNationalStripDigits>
                 <callingPartyInternationalStripDigits>?</callingPartyInternationalStripDigits>
                 <callingPartyUnknownStripDigits>?</callingPartyUnknownStripDigits>
                 <callingPartySubscriberStripDigits>?</callingPartySubscriberStripDigits>
                 <callingPartyNationalTransformationCssName uuid="?">?</callingPartyNationalTransformationCssName>
                 <callingPartyInternationalTransformationCssName uuid="?">?</callingPartyInternationalTransformationCssName>
                 <callingPartyUnknownTransformationCssName uuid="?">?</callingPartyUnknownTransformationCssName>
                 <callingPartySubscriberTransformationCssName uuid="?">?</callingPartySubscriberTransformationCssName>
                 <calledPartyNationalPrefix>?</calledPartyNationalPrefix>
                 <calledPartyInternationalPrefix>?</calledPartyInternationalPrefix>
                 <calledPartyUnknownPrefix>?</calledPartyUnknownPrefix>
                 <calledPartySubscriberPrefix>?</calledPartySubscriberPrefix>
                 <calledPartyNationalStripDigits>?</calledPartyNationalStripDigits>
                 <calledPartyInternationalStripDigits>?</calledPartyInternationalStripDigits>
                 <calledPartyUnknownStripDigits>?</calledPartyUnknownStripDigits>
                 <calledPartySubscriberStripDigits>?</calledPartySubscriberStripDigits>
                 <calledPartyNationalTransformationCssName uuid="?">?</calledPartyNationalTransformationCssName>
                 <calledPartyInternationalTransformationCssName uuid="?">?</calledPartyInternationalTransformationCssName>
                 <calledPartyUnknownTransformationCssName uuid="?">?</calledPartyUnknownTransformationCssName>
                 <calledPartySubscriberTransformationCssName uuid="?">?</calledPartySubscriberTransformationCssName>
                 <imeEnrolledPatternGroupName uuid="?">?</imeEnrolledPatternGroupName>
                 <localRouteGroup>
                    <name>?</name>
                    <value>?</value>
                 </localRouteGroup>
                 <mraServiceDomain uuid="?">?</mraServiceDomain>
              </returnedTags>
           </ns:listDevicePool>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.listDevicePoolResponse.return.devicePool | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                                           = $_.uuid
                'name'                                           = $_.name
                'autoSearchSpaceName'                            = $_.autoSearchSpaceName
                'dateTimeSettingName'                            = $_.dateTimeSettingName."#text"
                'callManagerGroupName'                           = $_.callManagerGroupName."#text"
                'mediaResourceListName'                          = $_.mediaResourceListName."#text"
                'regionName'                                     = $_.regionName."#text"
                'networkLocale'                                  = $_.networkLocale
                'srstName'                                       = $_.srstName."#text"
                'connectionMonitorDuration'                      = $_.connectionMonitorDuration
                'automatedAlternateRoutingCssName'               = $_.automatedAlternateRoutingCssName
                'aarNeighborhoodName'                            = $_.aarNeighborhoodName
                'locationName'                                   = $_.locationName."#text"
                'mobilityCssName'                                = $_.mobilityCssName
                'physicalLocationName'                           = $_.physicalLocationName."#text"
                'deviceMobilityGroupName'                        = $_.deviceMobilityGroupName
                'revertPriority'                                 = $_.revertPriority
                'singleButtonBarge'                              = $_.singleButtonBarge
                'joinAcrossLines'                                = $_.joinAcrossLines
                'cgpnTransformationCssName'                      = $_.cgpnTransformationCssName
                'cdpnTransformationCssName'                      = $_.cdpnTransformationCssName
                'geoLocationName'                                = $_.geoLocationName
                'geoLocationFilterName'                          = $_.geoLocationFilterName
                'callingPartyNationalPrefix'                     = $_.callingPartyNationalPrefix
                'callingPartyInternationalPrefix'                = $_.callingPartyInternationalPrefix
                'callingPartyUnknownPrefix'                      = $_.callingPartyUnknownPrefix
                'callingPartySubscriberPrefix'                   = $_.callingPartySubscriberPrefix
                'adjunctCallingSearchSpace'                      = $_.adjunctCallingSearchSpace
                'callingPartyNationalStripDigits'                = $_.callingPartyNationalStripDigits
                'callingPartyInternationalStripDigits'           = $_.callingPartyInternationalStripDigits
                'callingPartyUnknownStripDigits'                 = $_.callingPartyUnknownStripDigits
                'callingPartySubscriberStripDigits'              = $_.callingPartySubscriberStripDigits
                'callingPartyNationalTransformationCssName'      = $_.callingPartyNationalTransformationCssName
                'callingPartyInternationalTransformationCssName' = $_.callingPartyInternationalTransformationCssName
                'callingPartyUnknownTransformationCssName'       = $_.callingPartyUnknownTransformationCssName
                'callingPartySubscriberTransformationCssName'    = $_.callingPartySubscriberTransformationCssName
                'calledPartyNationalPrefix'                      = $_.calledPartyNationalPrefix
                'calledPartyInternationalPrefix'                 = $_.calledPartyInternationalPrefix
                'calledPartyUnknownPrefix'                       = $_.calledPartyUnknownPrefix
                'calledPartySubscriberPrefix'                    = $_.calledPartySubscriberPrefix
                'calledPartyNationalStripDigits'                 = $_.calledPartyNationalStripDigits
                'calledPartyInternationalStripDigits'            = $_.calledPartyInternationalStripDigits
                'calledPartyUnknownStripDigits'                  = $_.calledPartyUnknownStripDigits
                'calledPartySubscriberStripDigits'               = $_.calledPartySubscriberStripDigits
                'calledPartyNationalTransformationCssName'       = $_.calledPartyNationalTransformationCssName
                'calledPartyInternationalTransformationCssName'  = $_.calledPartyInternationalTransformationCssName
                'calledPartyUnknownTransformationCssName'        = $_.calledPartyUnknownTransformationCssName
                'calledPartySubscriberTransformationCssName'     = $_.calledPartySubscriberTransformationCssName
                'imeEnrolledPatternGroupName'                    = $_.imeEnrolledPatternGroupName
                'mraServiceDomain'                               = $_.mraServiceDomain
            }
            $Result = New-Object PSObject -Property $hash
            return $Result
        }
    }
}
