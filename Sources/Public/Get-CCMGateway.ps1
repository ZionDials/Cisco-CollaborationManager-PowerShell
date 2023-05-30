# Copyright (c) 2023 Zion Dials <me@ziondials.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

Function global:Get-CCMGateway {
    <#
    .SYNOPSIS
        Queries CCM for Gateway(s)
    .DESCRIPTION
        Queries CCM for Gateway(s)
    .PARAMETER Name
        Name of Gateway(s). Use '%' for wildcard.
    .PARAMETER UUID
        UUID of Gateway.
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][Int]$First,
        [Parameter(ValueFromPipelineByPropertyName)][Int]$Skip,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Description,
        [Parameter(ValueFromPipelineByPropertyName)][String]$DomainName,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Product,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Protocol,
        [Parameter(ValueFromPipelineByPropertyName)][String]$UUID
    )
    $ConfigFile = Get-CCMSettingsFile

    if ($Description -eq "") {
        $Description = "%"
    }

    if ($DomainName -eq "") {
        $DomainName = "%"
    }

    if ($Product -eq "") {
        $Product = "%"
    }

    if ($Protocol -eq "") {
        $Protocol = "%"
    }

    if ($UUID -ne "") {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
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
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:listGateway>
              <searchCriteria>
                 <domainName>$DomainName</domainName>
                 <description>$Description</description>
                 <product>$Product</product>
                 <protocol>$Protocol</protocol>
              </searchCriteria>
              <returnedTags uuid="?">
                 <domainName>?</domainName>
                 <description>?</description>
                 <product>?</product>
                 <protocol>?</protocol>
                 <callManagerGroupName uuid="?">?</callManagerGroupName>
                 <scratch>?</scratch>
                 <loadInformation>?</loadInformation>
              </returnedTags>
              $(if ($Skip -ne "") {"<skip>$Skip</skip>"})
              $(if ($First -ne "") {"<first>$First</first>"})
           </ns:listGateway>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.listGatewayResponse.return.gateway | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                 = $_.uuid
                'domainName'           = $_.domainName
                'description'          = $_.description
                'product'              = $_.product
                'protocol'             = $_.protocol
                'callManagerGroupName' = $_.callManagerGroupName."#text"
                'scratch'              = $_.scratch
                'loadInformation'      = $_.loadInformation
            }
            $Result = New-Object PSObject -Property $hash
            return $Result
        }
    }
}
