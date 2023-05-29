Function global:Get-CCMSIPTrunk {
    <#
    .SYNOPSIS
        Queries CUCM for SIP Trunk(s)

    .DESCRIPTION
        Queries CUCM for SIP Trunk(s)

    .PARAMETER CSS
        Calling Search Space for SIP Trunk(s). Use '%' for wildcard.

    .PARAMETER Description
        Description of SIP Trunk(s). Use '%' for wildcard.

    .PARAMETER DP
        Device Pool of SIP Trunk(s). Use '%' for wildcard.

    .PARAMETER First
        Number of records to return.

    .PARAMETER Name
        Name of SIP Trunk(s). Use '%' for wildcard.

    .PARAMETER Skip
        Number of records to skip.

    .PARAMETER UUID
        UUID of SIP Trunk.
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][Int]$First,
        [Parameter(ValueFromPipelineByPropertyName)][Int]$Skip,
        [Parameter(ValueFromPipelineByPropertyName)][String]$CSS,
        [Parameter(ValueFromPipelineByPropertyName)][String]$DP,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Description,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Name,
        [Parameter(ValueFromPipelineByPropertyName)][String]$UUID
    )
    $ConfigFile = Get-CCMSettingsFile

    if ($CSS -eq "") {
        $CSS = "%"
    }

    if ($DP -eq "") {
        $DP = "%"
    }

    if ($Description -eq "") {
        $Description = "%"
    }

    if ($Name -eq "") {
        $Name = "%"
    }

    if ($UUID -ne "") {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CUCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:getSipTrunk >
              <uuid>$UUID</uuid>
              <returnedTags ctiid="?" uuid="?">
                 <name>?</name>
                 <description>?</description>
                 <product>?</product>
                 <model>?</model>
                 <class>?</class>
                 <protocol>?</protocol>
                 <protocolSide>?</protocolSide>
                 <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                 <devicePoolName uuid="?">?</devicePoolName>
                 <commonDeviceConfigName uuid="?">?</commonDeviceConfigName>
                 <networkLocation>?</networkLocation>
                 <locationName uuid="?">?</locationName>
                 <mediaResourceListName uuid="?">?</mediaResourceListName>
                 <networkHoldMohAudioSourceId>?</networkHoldMohAudioSourceId>
                 <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                 <automatedAlternateRoutingCssName uuid="?">?</automatedAlternateRoutingCssName>
                 <aarNeighborhoodName uuid="?">?</aarNeighborhoodName>
                 <packetCaptureMode>?</packetCaptureMode>
                 <packetCaptureDuration>?</packetCaptureDuration>
                 <loadInformation special="?">?</loadInformation>
                 <versionStamp>?</versionStamp>
                 <traceFlag>?</traceFlag>
                 <mlppDomainId>?</mlppDomainId>
                 <mlppIndicationStatus>?</mlppIndicationStatus>
                 <preemption>?</preemption>
                 <useTrustedRelayPoint>?</useTrustedRelayPoint>
                 <retryVideoCallAsAudio>?</retryVideoCallAsAudio>
                 <securityProfileName uuid="?">?</securityProfileName>
                 <sipProfileName uuid="?">?</sipProfileName>
                 <cgpnTransformationCssName uuid="?">?</cgpnTransformationCssName>
                 <useDevicePoolCgpnTransformCss>?</useDevicePoolCgpnTransformCss>
                 <geoLocationName uuid="?">?</geoLocationName>
                 <geoLocationFilterName uuid="?">?</geoLocationFilterName>
                 <sendGeoLocation>?</sendGeoLocation>
                 <cdpnTransformationCssName uuid="?">?</cdpnTransformationCssName>
                 <useDevicePoolCdpnTransformCss>?</useDevicePoolCdpnTransformCss>
                 <unattendedPort>?</unattendedPort>
                 <transmitUtf8>?</transmitUtf8>
                 <subscribeCallingSearchSpaceName uuid="?">?</subscribeCallingSearchSpaceName>
                 <rerouteCallingSearchSpaceName uuid="?">?</rerouteCallingSearchSpaceName>
                 <referCallingSearchSpaceName uuid="?">?</referCallingSearchSpaceName>
                 <mtpRequired>?</mtpRequired>
                 <presenceGroupName uuid="?">?</presenceGroupName>
                 <unknownPrefix>?</unknownPrefix>
                 <destAddrIsSrv>?</destAddrIsSrv>
                 <tkSipCodec>?</tkSipCodec>
                 <sigDigits enable="?">?</sigDigits>
                 <connectedNamePresentation>?</connectedNamePresentation>
                 <connectedPartyIdPresentation>?</connectedPartyIdPresentation>
                 <callingPartySelection>?</callingPartySelection>
                 <callingname>?</callingname>
                 <callingLineIdPresentation>?</callingLineIdPresentation>
                 <prefixDn>?</prefixDn>
                 <externalPresentationInfo>
                    <isAnonymous>?</isAnonymous>
                    <presentationInfo>
                       <externalPresentationNumber>?</externalPresentationNumber>
                       <externalPresentationName>?</externalPresentationName>
                    </presentationInfo>
                 </externalPresentationInfo>
                 <acceptInboundRdnis>?</acceptInboundRdnis>
                 <acceptOutboundRdnis>?</acceptOutboundRdnis>
                 <srtpAllowed>?</srtpAllowed>
                 <srtpFallbackAllowed>?</srtpFallbackAllowed>
                 <isPaiEnabled>?</isPaiEnabled>
                 <sipPrivacy>?</sipPrivacy>
                 <isRpidEnabled>?</isRpidEnabled>
                 <sipAssertedType>?</sipAssertedType>
                 <trustReceivedIdentity>?</trustReceivedIdentity>
                 <dtmfSignalingMethod>?</dtmfSignalingMethod>
                 <routeClassSignalling>?</routeClassSignalling>
                 <sipTrunkType>?</sipTrunkType>
                 <pstnAccess>?</pstnAccess>
                 <imeE164TransformationName uuid="?">?</imeE164TransformationName>
                 <useImePublicIpPort>?</useImePublicIpPort>
                 <useDevicePoolCntdPnTransformationCss>?</useDevicePoolCntdPnTransformationCss>
                 <cntdPnTransformationCssName uuid="?">?</cntdPnTransformationCssName>
                 <useDevicePoolCgpnTransformCssUnkn>?</useDevicePoolCgpnTransformCssUnkn>
                 <rdnTransformationCssName uuid="?">?</rdnTransformationCssName>
                 <useDevicePoolRdnTransformCss>?</useDevicePoolRdnTransformCss>
                 <useOrigCallingPartyPresOnDivert>?</useOrigCallingPartyPresOnDivert>
                 <sipNormalizationScriptName uuid="?">?</sipNormalizationScriptName>
                 <runOnEveryNode>?</runOnEveryNode>
                 <destinations>
                    <destination uuid="?">
                       <addressIpv4>?</addressIpv4>
                       <addressIpv6>?</addressIpv6>
                       <port>?</port>
                       <sortOrder>?</sortOrder>
                    </destination>
                 </destinations>
                 <unknownStripDigits>?</unknownStripDigits>
                 <cgpnTransformationUnknownCssName uuid="?">?</cgpnTransformationUnknownCssName>
                 <tunneledProtocol>?</tunneledProtocol>
                 <asn1RoseOidEncoding>?</asn1RoseOidEncoding>
                 <qsigVariant>?</qsigVariant>
                 <pathReplacementSupport>?</pathReplacementSupport>
                 <enableQsigUtf8>?</enableQsigUtf8>
                 <scriptParameters>?</scriptParameters>
                 <scriptTraceEnabled>?</scriptTraceEnabled>
                 <trunkTrafficSecure>?</trunkTrafficSecure>
                 <callingAndCalledPartyInfoFormat>?</callingAndCalledPartyInfoFormat>
                 <useCallerIdCallerNameinUriOutgoingRequest>?</useCallerIdCallerNameinUriOutgoingRequest>
                 <service>?</service>
                 <parameterLabel>?</parameterLabel>
                 <originatingParameterValue>?</originatingParameterValue>
                 <terminatingParameterValue>?</terminatingParameterValue>
                 <outboundUriRoutingInstructions>?</outboundUriRoutingInstructions>
                 <requestUriDomainName>?</requestUriDomainName>
                 <enableCiscoRecordingQsigTunneling>?</enableCiscoRecordingQsigTunneling>
                 <recordingInformation>?</recordingInformation>
                 <calledPartyUnknownTransformationCssName uuid="?">?</calledPartyUnknownTransformationCssName>
                 <calledPartyUnknownPrefix>?</calledPartyUnknownPrefix>
                 <calledPartyUnknownStripDigits>?</calledPartyUnknownStripDigits>
                 <useDevicePoolCalledCssUnkn>?</useDevicePoolCalledCssUnkn>
                 <confidentialAccess>
                    <confidentialAccessMode>?</confidentialAccessMode>
                    <confidentialAccessLevel>?</confidentialAccessLevel>
                 </confidentialAccess>
              </returnedTags>
           </ns:getSipTrunk>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.getSipTrunkResponse.return.sipTrunk | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                                      = $_.uuid
                'name'                                      = $_.name
                'description'                               = $_.description
                'product'                                   = $_.product
                'model'                                     = $_.model
                'class'                                     = $_.class
                'protocol'                                  = $_.protocol
                'protocolSide'                              = $_.protocolSide
                'callingSearchSpaceName'                    = $_.callingSearchSpaceName."#text"
                'devicePoolName'                            = $_.devicePoolName."#text"
                'commonDeviceConfigName'                    = $_.commonDeviceConfigName."#text"
                'networkLocation'                           = $_.networkLocation
                'locationName'                              = $_.locationName."#text"
                'mediaResourceListName'                     = $_.mediaResourceListName
                'networkHoldMohAudioSourceId'               = $_.networkHoldMohAudioSourceId
                'userHoldMohAudioSourceId'                  = $_.userHoldMohAudioSourceId
                'automatedAlternateRoutingCssName'          = $_.automatedAlternateRoutingCssName
                'aarNeighborhoodName'                       = $_.aarNeighborhoodName
                'packetCaptureMode'                         = $_.packetCaptureMode
                'packetCaptureDuration'                     = $_.packetCaptureDuration
                'loadInformation'                           = $_.loadInformation."#text"
                'traceFlag'                                 = $_.traceFlag
                'mlppIndicationStatus'                      = $_.mlppIndicationStatus
                'preemption'                                = $_.preemption
                'useTrustedRelayPoint'                      = $_.useTrustedRelayPoint
                'retryVideoCallAsAudio'                     = $_.retryVideoCallAsAudio
                'securityProfileName'                       = $_.securityProfileName."#text"
                'sipProfileName'                            = $_.sipProfileName."#text"
                'cgpnTransformationCssName'                 = $_.cgpnTransformationCssName
                'useDevicePoolCgpnTransformCss'             = $_.useDevicePoolCgpnTransformCss
                'rdnTransformationCssName'                  = $_.rdnTransformationCssName
                'useDevicePoolRdnTransformCss'              = $_.useDevicePoolRdnTransformCss
                'geoLocationName'                           = $_.geoLocationName
                'geoLocationFilterName'                     = $_.geoLocationFilterName
                'sendGeoLocation'                           = $_.sendGeoLocation
                'cdpnTransformationCssName'                 = $_.cdpnTransformationCssName
                'useDevicePoolCdpnTransformCss'             = $_.useDevicePoolCdpnTransformCss
                'unattendedPort'                            = $_.unattendedPort
                'transmitUtf8'                              = $_.transmitUtf8
                'subscribeCallingSearchSpaceName'           = $_.subscribeCallingSearchSpaceName."#text"
                'rerouteCallingSearchSpaceName'             = $_.rerouteCallingSearchSpaceName."#text"
                'referCallingSearchSpaceName'               = $_.referCallingSearchSpaceName."#text"
                'mtpRequired'                               = $_.mtpRequired
                'presenceGroupName'                         = $_.presenceGroupName."#text"
                'unknownPrefix'                             = $_.unknownPrefix
                'tkSipCodec'                                = $_.tkSipCodec
                'sigDigits'                                 = $_.sigDigits."#text"
                'connectedNamePresentation'                 = $_.connectedNamePresentation
                'connectedPartyIdPresentation'              = $_.connectedPartyIdPresentation
                'callingPartySelection'                     = $_.callingPartySelection
                'callingname'                               = $_.callingname
                'callingLineIdPresentation'                 = $_.callingLineIdPresentation
                'prefixDn'                                  = $_.prefixDn
                'acceptInboundRdnis'                        = $_.acceptInboundRdnis
                'acceptOutboundRdnis'                       = $_.acceptOutboundRdnis
                'srtpAllowed'                               = $_.srtpAllowed
                'srtpFallbackAllowed'                       = $_.srtpFallbackAllowed
                'isPaiEnabled'                              = $_.isPaiEnabled
                'sipPrivacy'                                = $_.sipPrivacy
                'isRpidEnabled'                             = $_.isRpidEnabled
                'sipAssertedType'                           = $_.sipAssertedType
                'trustReceivedIdentity'                     = $_.trustReceivedIdentity
                'dtmfSignalingMethod'                       = $_.dtmfSignalingMethod
                'routeClassSignalling'                      = $_.routeClassSignalling
                'sipTrunkType'                              = $_.sipTrunkType
                'pstnAccess'                                = $_.pstnAccess
                'imeE164TransformationName'                 = $_.imeE164TransformationName
                'useImePublicIpPort'                        = $_.useImePublicIpPort
                'useDevicePoolCntdPnTransformationCss'      = $_.useDevicePoolCntdPnTransformationCss
                'useOrigCallingPartyPresOnDivert'           = $_.useOrigCallingPartyPresOnDivert
                'useDevicePoolCgpnTransformCssUnkn'         = $_.useDevicePoolCgpnTransformCssUnkn
                'sipNormalizationScriptName'                = $_.sipNormalizationScriptName
                'runOnEveryNode'                            = $_.runOnEveryNode
                'unknownStripDigits'                        = $_.unknownStripDigits
                'cgpnTransformationUnknownCssName'          = $_.cgpnTransformationUnknownCssName
                'tunneledProtocol'                          = $_.tunneledProtocol
                'asn1RoseOidEncoding'                       = $_.asn1RoseOidEncoding
                'qsigVariant'                               = $_.qsigVariant
                'pathReplacementSupport'                    = $_.pathReplacementSupport
                'enableQsigUtf8'                            = $_.enableQsigUtf8
                'scriptParameters'                          = $_.scriptParameters
                'scriptTraceEnabled'                        = $_.scriptTraceEnabled
                'trunkTrafficSecure'                        = $_.trunkTrafficSecure
                'callingAndCalledPartyInfoFormat'           = $_.callingAndCalledPartyInfoFormat
                'useCallerIdCallerNameinUriOutgoingRequest' = $_.useCallerIdCallerNameinUriOutgoingRequest
                'requestUriDomainName'                      = $_.requestUriDomainName
                'enableCiscoRecordingQsigTunneling'         = $_.enableCiscoRecordingQsigTunneling
                'calledPartyUnknownTransformationCssName'   = $_.calledPartyUnknownTransformationCssName
                'calledPartyUnknownPrefix'                  = $_.calledPartyUnknownPrefix
                'calledPartyUnknownStripDigits'             = $_.calledPartyUnknownStripDigits
                'useDevicePoolCalledCssUnkn'                = $_.useDevicePoolCalledCssUnkn
                'confidentialAccessMode'                    = $_.confidentialAccess.confidentialAccessMode
                'confidentialAccessLevel'                   = $_.confidentialAccess.confidentialAccessLevel
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
           <ns:listSipTrunk>
              <searchCriteria>
                 <name>$Name</name>
                 <description>$Description</description>
                 <callingSearchSpaceName>$CSS</callingSearchSpaceName>
                 <devicePoolName>$DP</devicePoolName>
              </searchCriteria>
              <returnedTags ctiid="?" uuid="?">
                 <name>?</name>
                 <description>?</description>
                 <product>?</product>
                 <model>?</model>
                 <class>?</class>
                 <protocol>?</protocol>
                 <protocolSide>?</protocolSide>
                 <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                 <devicePoolName uuid="?">?</devicePoolName>
                 <commonDeviceConfigName uuid="?">?</commonDeviceConfigName>
                 <networkLocation>?</networkLocation>
                 <locationName uuid="?">?</locationName>
                 <mediaResourceListName uuid="?">?</mediaResourceListName>
                 <networkHoldMohAudioSourceId>?</networkHoldMohAudioSourceId>
                 <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                 <automatedAlternateRoutingCssName uuid="?">?</automatedAlternateRoutingCssName>
                 <aarNeighborhoodName uuid="?">?</aarNeighborhoodName>
                 <packetCaptureMode>?</packetCaptureMode>
                 <packetCaptureDuration>?</packetCaptureDuration>
                 <loadInformation special="?">?</loadInformation>
                 <traceFlag>?</traceFlag>
                 <mlppIndicationStatus>?</mlppIndicationStatus>
                 <preemption>?</preemption>
                 <useTrustedRelayPoint>?</useTrustedRelayPoint>
                 <retryVideoCallAsAudio>?</retryVideoCallAsAudio>
                 <securityProfileName uuid="?">?</securityProfileName>
                 <sipProfileName uuid="?">?</sipProfileName>
                 <cgpnTransformationCssName uuid="?">?</cgpnTransformationCssName>
                 <useDevicePoolCgpnTransformCss>?</useDevicePoolCgpnTransformCss>
                 <geoLocationName uuid="?">?</geoLocationName>
                 <geoLocationFilterName uuid="?">?</geoLocationFilterName>
                 <sendGeoLocation>?</sendGeoLocation>
                 <cdpnTransformationCssName uuid="?">?</cdpnTransformationCssName>
                 <useDevicePoolCdpnTransformCss>?</useDevicePoolCdpnTransformCss>
                 <unattendedPort>?</unattendedPort>
                 <transmitUtf8>?</transmitUtf8>
                 <subscribeCallingSearchSpaceName uuid="?">?</subscribeCallingSearchSpaceName>
                 <rerouteCallingSearchSpaceName uuid="?">?</rerouteCallingSearchSpaceName>
                 <referCallingSearchSpaceName uuid="?">?</referCallingSearchSpaceName>
                 <mtpRequired>?</mtpRequired>
                 <presenceGroupName uuid="?">?</presenceGroupName>
                 <unknownPrefix>?</unknownPrefix>
                 <destAddrIsSrv>?</destAddrIsSrv>
                 <tkSipCodec>?</tkSipCodec>
                 <sigDigits enable="?">?</sigDigits>
                 <connectedNamePresentation>?</connectedNamePresentation>
                 <connectedPartyIdPresentation>?</connectedPartyIdPresentation>
                 <callingPartySelection>?</callingPartySelection>
                 <callingname>?</callingname>
                 <callingLineIdPresentation>?</callingLineIdPresentation>
                 <prefixDn>?</prefixDn>
                 <acceptInboundRdnis>?</acceptInboundRdnis>
                 <acceptOutboundRdnis>?</acceptOutboundRdnis>
                 <srtpAllowed>?</srtpAllowed>
                 <srtpFallbackAllowed>?</srtpFallbackAllowed>
                 <isPaiEnabled>?</isPaiEnabled>
                 <sipPrivacy>?</sipPrivacy>
                 <isRpidEnabled>?</isRpidEnabled>
                 <sipAssertedType>?</sipAssertedType>
                 <trustReceivedIdentity>?</trustReceivedIdentity>
                 <dtmfSignalingMethod>?</dtmfSignalingMethod>
                 <routeClassSignalling>?</routeClassSignalling>
                 <sipTrunkType>?</sipTrunkType>
                 <pstnAccess>?</pstnAccess>
                 <imeE164TransformationName uuid="?">?</imeE164TransformationName>
                 <useImePublicIpPort>?</useImePublicIpPort>
                 <useDevicePoolCntdPnTransformationCss>?</useDevicePoolCntdPnTransformationCss>
                 <useDevicePoolCgpnTransformCssUnkn>?</useDevicePoolCgpnTransformCssUnkn>
                 <rdnTransformationCssName uuid="?">?</rdnTransformationCssName>
                 <useDevicePoolRdnTransformCss>?</useDevicePoolRdnTransformCss>
                 <useOrigCallingPartyPresOnDivert>?</useOrigCallingPartyPresOnDivert>
                 <sipNormalizationScriptName uuid="?">?</sipNormalizationScriptName>
                 <runOnEveryNode>?</runOnEveryNode>
                 <unknownStripDigits>?</unknownStripDigits>
                 <cgpnTransformationUnknownCssName uuid="?">?</cgpnTransformationUnknownCssName>
                 <tunneledProtocol>?</tunneledProtocol>
                 <asn1RoseOidEncoding>?</asn1RoseOidEncoding>
                 <qsigVariant>?</qsigVariant>
                 <pathReplacementSupport>?</pathReplacementSupport>
                 <enableQsigUtf8>?</enableQsigUtf8>
                 <scriptParameters>?</scriptParameters>
                 <scriptTraceEnabled>?</scriptTraceEnabled>
                 <trunkTrafficSecure>?</trunkTrafficSecure>
                 <callingAndCalledPartyInfoFormat>?</callingAndCalledPartyInfoFormat>
                 <useCallerIdCallerNameinUriOutgoingRequest>?</useCallerIdCallerNameinUriOutgoingRequest>
                 <requestUriDomainName>?</requestUriDomainName>
                 <enableCiscoRecordingQsigTunneling>?</enableCiscoRecordingQsigTunneling>
                 <calledPartyUnknownTransformationCssName uuid="?">?</calledPartyUnknownTransformationCssName>
                 <calledPartyUnknownPrefix>?</calledPartyUnknownPrefix>
                 <calledPartyUnknownStripDigits>?</calledPartyUnknownStripDigits>
                 <useDevicePoolCalledCssUnkn>?</useDevicePoolCalledCssUnkn>
                 <confidentialAccess>
                    <confidentialAccessMode>?</confidentialAccessMode>
                    <confidentialAccessLevel>?</confidentialAccessLevel>
                 </confidentialAccess>
              </returnedTags>
                $(if ($Skip -ne "") {"<skip>$Skip</skip>"})
                $(if ($First -ne "") {"<first>$First</first>"})
           </ns:listSipTrunk>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.listSipTrunkResponse.return.sipTrunk | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                                      = $_.uuid
                'name'                                      = $_.name
                'description'                               = $_.description
                'product'                                   = $_.product
                'model'                                     = $_.model
                'class'                                     = $_.class
                'protocol'                                  = $_.protocol
                'protocolSide'                              = $_.protocolSide
                'callingSearchSpaceName'                    = $_.callingSearchSpaceName."#text"
                'devicePoolName'                            = $_.devicePoolName."#text"
                'commonDeviceConfigName'                    = $_.commonDeviceConfigName."#text"
                'networkLocation'                           = $_.networkLocation
                'locationName'                              = $_.locationName."#text"
                'mediaResourceListName'                     = $_.mediaResourceListName
                'networkHoldMohAudioSourceId'               = $_.networkHoldMohAudioSourceId
                'userHoldMohAudioSourceId'                  = $_.userHoldMohAudioSourceId
                'automatedAlternateRoutingCssName'          = $_.automatedAlternateRoutingCssName
                'aarNeighborhoodName'                       = $_.aarNeighborhoodName
                'packetCaptureMode'                         = $_.packetCaptureMode
                'packetCaptureDuration'                     = $_.packetCaptureDuration
                'loadInformation'                           = $_.loadInformation."#text"
                'traceFlag'                                 = $_.traceFlag
                'mlppIndicationStatus'                      = $_.mlppIndicationStatus
                'preemption'                                = $_.preemption
                'useTrustedRelayPoint'                      = $_.useTrustedRelayPoint
                'retryVideoCallAsAudio'                     = $_.retryVideoCallAsAudio
                'securityProfileName'                       = $_.securityProfileName."#text"
                'sipProfileName'                            = $_.sipProfileName."#text"
                'cgpnTransformationCssName'                 = $_.cgpnTransformationCssName
                'useDevicePoolCgpnTransformCss'             = $_.useDevicePoolCgpnTransformCss
                'rdnTransformationCssName'                  = $_.rdnTransformationCssName
                'useDevicePoolRdnTransformCss'              = $_.useDevicePoolRdnTransformCss
                'geoLocationName'                           = $_.geoLocationName
                'geoLocationFilterName'                     = $_.geoLocationFilterName
                'sendGeoLocation'                           = $_.sendGeoLocation
                'cdpnTransformationCssName'                 = $_.cdpnTransformationCssName
                'useDevicePoolCdpnTransformCss'             = $_.useDevicePoolCdpnTransformCss
                'unattendedPort'                            = $_.unattendedPort
                'transmitUtf8'                              = $_.transmitUtf8
                'subscribeCallingSearchSpaceName'           = $_.subscribeCallingSearchSpaceName."#text"
                'rerouteCallingSearchSpaceName'             = $_.rerouteCallingSearchSpaceName."#text"
                'referCallingSearchSpaceName'               = $_.referCallingSearchSpaceName."#text"
                'mtpRequired'                               = $_.mtpRequired
                'presenceGroupName'                         = $_.presenceGroupName."#text"
                'unknownPrefix'                             = $_.unknownPrefix
                'tkSipCodec'                                = $_.tkSipCodec
                'sigDigits'                                 = $_.sigDigits."#text"
                'connectedNamePresentation'                 = $_.connectedNamePresentation
                'connectedPartyIdPresentation'              = $_.connectedPartyIdPresentation
                'callingPartySelection'                     = $_.callingPartySelection
                'callingname'                               = $_.callingname
                'callingLineIdPresentation'                 = $_.callingLineIdPresentation
                'prefixDn'                                  = $_.prefixDn
                'acceptInboundRdnis'                        = $_.acceptInboundRdnis
                'acceptOutboundRdnis'                       = $_.acceptOutboundRdnis
                'srtpAllowed'                               = $_.srtpAllowed
                'srtpFallbackAllowed'                       = $_.srtpFallbackAllowed
                'isPaiEnabled'                              = $_.isPaiEnabled
                'sipPrivacy'                                = $_.sipPrivacy
                'isRpidEnabled'                             = $_.isRpidEnabled
                'sipAssertedType'                           = $_.sipAssertedType
                'trustReceivedIdentity'                     = $_.trustReceivedIdentity
                'dtmfSignalingMethod'                       = $_.dtmfSignalingMethod
                'routeClassSignalling'                      = $_.routeClassSignalling
                'sipTrunkType'                              = $_.sipTrunkType
                'pstnAccess'                                = $_.pstnAccess
                'imeE164TransformationName'                 = $_.imeE164TransformationName
                'useImePublicIpPort'                        = $_.useImePublicIpPort
                'useDevicePoolCntdPnTransformationCss'      = $_.useDevicePoolCntdPnTransformationCss
                'useOrigCallingPartyPresOnDivert'           = $_.useOrigCallingPartyPresOnDivert
                'useDevicePoolCgpnTransformCssUnkn'         = $_.useDevicePoolCgpnTransformCssUnkn
                'sipNormalizationScriptName'                = $_.sipNormalizationScriptName
                'runOnEveryNode'                            = $_.runOnEveryNode
                'unknownStripDigits'                        = $_.unknownStripDigits
                'cgpnTransformationUnknownCssName'          = $_.cgpnTransformationUnknownCssName
                'tunneledProtocol'                          = $_.tunneledProtocol
                'asn1RoseOidEncoding'                       = $_.asn1RoseOidEncoding
                'qsigVariant'                               = $_.qsigVariant
                'pathReplacementSupport'                    = $_.pathReplacementSupport
                'enableQsigUtf8'                            = $_.enableQsigUtf8
                'scriptParameters'                          = $_.scriptParameters
                'scriptTraceEnabled'                        = $_.scriptTraceEnabled
                'trunkTrafficSecure'                        = $_.trunkTrafficSecure
                'callingAndCalledPartyInfoFormat'           = $_.callingAndCalledPartyInfoFormat
                'useCallerIdCallerNameinUriOutgoingRequest' = $_.useCallerIdCallerNameinUriOutgoingRequest
                'requestUriDomainName'                      = $_.requestUriDomainName
                'enableCiscoRecordingQsigTunneling'         = $_.enableCiscoRecordingQsigTunneling
                'calledPartyUnknownTransformationCssName'   = $_.calledPartyUnknownTransformationCssName
                'calledPartyUnknownPrefix'                  = $_.calledPartyUnknownPrefix
                'calledPartyUnknownStripDigits'             = $_.calledPartyUnknownStripDigits
                'useDevicePoolCalledCssUnkn'                = $_.useDevicePoolCalledCssUnkn
                'confidentialAccessMode'                    = $_.confidentialAccess.confidentialAccessMode
                'confidentialAccessLevel'                   = $_.confidentialAccess.confidentialAccessLevel
            }
            $Result = New-Object PSObject -Property $hash
            return $Result
        }
    }
}
