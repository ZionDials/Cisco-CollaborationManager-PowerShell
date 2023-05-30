Function global:Get-CCMPhone {
    <#
    .SYNOPSIS
        Queries CUCM for Phone(s)

    .DESCRIPTION
        Queries CUCM for Phone(s)

    .PARAMETER CSS
        Calling Search Space for Phone(s). Use '%' for wildcard.

    .PARAMETER DP
        Device Pool of Phone(s). Use '%' for wildcard.

    .PARAMETER Description
        Description of Phone(s). Use '%' for wildcard.

    .PARAMETER First
        Number of records to return.

    .PARAMETER Name
        Name of Phone(s). Use '%' for wildcard.

    .PARAMETER Protocol
        Connection Protocol of Phone(s). Use '%' for wildcard.

    .PARAMETER Skip
        Number of records to skip.

    .PARAMETER SP
        Security Profile of Phone(s). Use '%' for wildcard.

    .PARAMETER UUID
        UUID of Phone.
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][Int]$First,
        [Parameter(ValueFromPipelineByPropertyName)][Int]$Skip,
        [Parameter(ValueFromPipelineByPropertyName)][String]$CSS,
        [Parameter(ValueFromPipelineByPropertyName)][String]$DP,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Description,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Name,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Protocol,
        [Parameter(ValueFromPipelineByPropertyName)][String]$SP,
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

    if ($Protocol -eq "") {
        $Protocol = "%"
    }

    if ($SP -eq "") {
        $SP = "%"
    }

    if ($UUID -ne "") {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:getPhone>
              <uuid>$UUID</uuid>
              <returnedTags>
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
                 <commonPhoneConfigName uuid="?">?</commonPhoneConfigName>
                 <networkLocation>?</networkLocation>
                 <locationName uuid="?">?</locationName>
                 <mediaResourceListName uuid="?">?</mediaResourceListName>
                 <networkHoldMohAudioSourceId>?</networkHoldMohAudioSourceId>
                 <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                 <automatedAlternateRoutingCssName uuid="?">?</automatedAlternateRoutingCssName>
                 <aarNeighborhoodName uuid="?">?</aarNeighborhoodName>
                 <loadInformation special="?">?</loadInformation>
                 <vendorConfig>
                 </vendorConfig>
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
                 <lines>
                    <line>
                       <index>?</index>
                       <label>?</label>
                       <display>?</display>
                       <dirn uuid="?">
                          <pattern>?</pattern>
                          <routePartitionName uuid="?">?</routePartitionName>
                       </dirn>
                       <ringSetting>?</ringSetting>
                       <consecutiveRingSetting>?</consecutiveRingSetting>
                       <ringSettingIdlePickupAlert>?</ringSettingIdlePickupAlert>
                       <ringSettingActivePickupAlert>?</ringSettingActivePickupAlert>
                       <displayAscii>?</displayAscii>
                       <e164Mask>?</e164Mask>
                       <dialPlanWizardId>?</dialPlanWizardId>
                       <mwlPolicy>?</mwlPolicy>
                       <maxNumCalls>?</maxNumCalls>
                       <busyTrigger>?</busyTrigger>
                       <callInfoDisplay>
                          <callerName>?</callerName>
                          <callerNumber>?</callerNumber>
                          <redirectedNumber>?</redirectedNumber>
                          <dialedNumber>?</dialedNumber>
                       </callInfoDisplay>
                       <recordingProfileName uuid="?">?</recordingProfileName>
                       <monitoringCssName uuid="?">?</monitoringCssName>
                       <recordingFlag>?</recordingFlag>
                       <audibleMwi>?</audibleMwi>
                       <speedDial>?</speedDial>
                       <partitionUsage>?</partitionUsage>
                       <associatedEndusers>
                          <enduser>
                             <userId>?</userId>
                          </enduser>
                       </associatedEndusers>
                       <missedCallLogging>?</missedCallLogging>
                       <recordingMediaSource>?</recordingMediaSource>
                    </line>
                    <lineIdentifier>
                       <directoryNumber>?</directoryNumber>
                       <routePartitionName>?</routePartitionName>
                    </lineIdentifier>
                 </lines>
                 <numberOfButtons>?</numberOfButtons>
                 <phoneTemplateName uuid="?">?</phoneTemplateName>
                 <speeddials>
                    <speeddial>
                       <dirn>?</dirn>
                       <label>?</label>
                       <index>?</index>
                    </speeddial>
                 </speeddials>
                 <busyLampFields>
                    <busyLampField>
                       <blfDest>?</blfDest>
                       <blfDirn>?</blfDirn>
                       <routePartition>?</routePartition>
                       <label>?</label>
                       <associatedBlfSdFeatures>
                          <feature>?</feature>
                       </associatedBlfSdFeatures>
                       <index>?</index>
                    </busyLampField>
                 </busyLampFields>
                 <primaryPhoneName uuid="?">?</primaryPhoneName>
                 <ringSettingIdleBlfAudibleAlert>?</ringSettingIdleBlfAudibleAlert>
                 <ringSettingBusyBlfAudibleAlert>?</ringSettingBusyBlfAudibleAlert>
                 <blfDirectedCallParks>
                    <blfDirectedCallPark>
                       <label>?</label>
                       <directedCallParkId>?</directedCallParkId>
                       <directedCallParkDnAndPartition>
                          <dnPattern>?</dnPattern>
                          <routePartitionName uuid="?">?</routePartitionName>
                       </directedCallParkDnAndPartition>
                       <index>?</index>
                    </blfDirectedCallPark>
                 </blfDirectedCallParks>
                 <addOnModules>
                    <addOnModule uuid="?">
                       <loadInformation special="?">?</loadInformation>
                       <model>?</model>
                       <index>?</index>
                    </addOnModule>
                 </addOnModules>
                 <userLocale>?</userLocale>
                 <networkLocale>?</networkLocale>
                 <idleTimeout>?</idleTimeout>
                 <authenticationUrl>?</authenticationUrl>
                 <directoryUrl>?</directoryUrl>
                 <idleUrl>?</idleUrl>
                 <informationUrl>?</informationUrl>
                 <messagesUrl>?</messagesUrl>
                 <proxyServerUrl>?</proxyServerUrl>
                 <servicesUrl>?</servicesUrl>
                 <services>
                    <service uuid="?">
                       <telecasterServiceName uuid="?">?</telecasterServiceName>
                       <name>?</name>
                       <url>?</url>
                       <urlButtonIndex>?</urlButtonIndex>
                       <urlLabel>?</urlLabel>
                       <serviceNameAscii>?</serviceNameAscii>
                       <phoneService>?</phoneService>
                       <phoneServiceCategory>?</phoneServiceCategory>
                       <vendor>?</vendor>
                       <version>?</version>
                       <priority>?</priority>
                    </service>
                 </services>
                 <softkeyTemplateName uuid="?">?</softkeyTemplateName>
                 <loginUserId>?</loginUserId>
                 <defaultProfileName uuid="?">?</defaultProfileName>
                 <enableExtensionMobility>?</enableExtensionMobility>
                 <currentProfileName uuid="?">?</currentProfileName>
                 <loginTime>?</loginTime>
                 <loginDuration>?</loginDuration>
                 <currentConfig>
                    <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                    <phoneTemplateName uuid="?">?</phoneTemplateName>
                    <mlppDomainId>?</mlppDomainId>
                    <mlppIndicationStatus>?</mlppIndicationStatus>
                    <preemption>?</preemption>
                    <softkeyTemplateName uuid="?">?</softkeyTemplateName>
                    <ignorePresentationIndicators>?</ignorePresentationIndicators>
                    <singleButtonBarge>?</singleButtonBarge>
                    <joinAcrossLines>?</joinAcrossLines>
                    <callInfoPrivacyStatus>?</callInfoPrivacyStatus>
                    <dndStatus>?</dndStatus>
                    <dndRingSetting>?</dndRingSetting>
                    <dndOption>?</dndOption>
                    <alwaysUsePrimeLine>?</alwaysUsePrimeLine>
                    <alwaysUsePrimeLineForVoiceMessage>?</alwaysUsePrimeLineForVoiceMessage>
                    <emccCallingSearchSpaceName uuid="?">?</emccCallingSearchSpaceName>
                    <deviceName>?</deviceName>
                    <model>?</model>
                    <product>?</product>
                    <deviceProtocol>?</deviceProtocol>
                    <class>?</class>
                    <addressMode>?</addressMode>
                    <allowAutoConfig>?</allowAutoConfig>
                    <remoteSrstOption>?</remoteSrstOption>
                    <remoteSrstIp>?</remoteSrstIp>
                    <remoteSrstPort>?</remoteSrstPort>
                    <remoteSipSrstIp>?</remoteSipSrstIp>
                    <remoteSipSrstPort>?</remoteSipSrstPort>
                    <geolocationInfo>?</geolocationInfo>
                    <remoteLocationName>?</remoteLocationName>
                 </currentConfig>
                 <singleButtonBarge>?</singleButtonBarge>
                 <joinAcrossLines>?</joinAcrossLines>
                 <builtInBridgeStatus>?</builtInBridgeStatus>
                 <callInfoPrivacyStatus>?</callInfoPrivacyStatus>
                 <hlogStatus>?</hlogStatus>
                 <ownerUserName uuid="?">?</ownerUserName>
                 <ignorePresentationIndicators>?</ignorePresentationIndicators>
                 <packetCaptureMode>?</packetCaptureMode>
                 <packetCaptureDuration>?</packetCaptureDuration>
                 <subscribeCallingSearchSpaceName uuid="?">?</subscribeCallingSearchSpaceName>
                 <rerouteCallingSearchSpaceName uuid="?">?</rerouteCallingSearchSpaceName>
                 <allowCtiControlFlag>?</allowCtiControlFlag>
                 <presenceGroupName uuid="?">?</presenceGroupName>
                 <unattendedPort>?</unattendedPort>
                 <requireDtmfReception>?</requireDtmfReception>
                 <rfc2833Disabled>?</rfc2833Disabled>
                 <certificateOperation>?</certificateOperation>
                 <authenticationMode>?</authenticationMode>
                 <keySize>?</keySize>
                 <keyOrder>?</keyOrder>
                 <ecKeySize>?</ecKeySize>
                 <authenticationString>?</authenticationString>
                 <certificateStatus>?</certificateStatus>
                 <upgradeFinishTime>?</upgradeFinishTime>
                 <deviceMobilityMode>?</deviceMobilityMode>
                 <roamingDevicePoolName uuid="?">?</roamingDevicePoolName>
                 <remoteDevice>?</remoteDevice>
                 <dndOption>?</dndOption>
                 <dndRingSetting>?</dndRingSetting>
                 <dndStatus>?</dndStatus>
                 <isActive>?</isActive>
                 <isDualMode>?</isDualMode>
                 <mobilityUserIdName uuid="?">?</mobilityUserIdName>
                 <phoneSuite>?</phoneSuite>
                 <phoneServiceDisplay>?</phoneServiceDisplay>
                 <isProtected>?</isProtected>
                 <mtpRequired>?</mtpRequired>
                 <mtpPreferedCodec>?</mtpPreferedCodec>
                 <dialRulesName uuid="?">?</dialRulesName>
                 <sshUserId>?</sshUserId>
                 <sshPwd>?</sshPwd>
                 <digestUser>?</digestUser>
                 <outboundCallRollover>?</outboundCallRollover>
                 <hotlineDevice>?</hotlineDevice>
                 <secureInformationUrl>?</secureInformationUrl>
                 <secureDirectoryUrl>?</secureDirectoryUrl>
                 <secureMessageUrl>?</secureMessageUrl>
                 <secureServicesUrl>?</secureServicesUrl>
                 <secureAuthenticationUrl>?</secureAuthenticationUrl>
                 <secureIdleUrl>?</secureIdleUrl>
                 <alwaysUsePrimeLine>?</alwaysUsePrimeLine>
                 <alwaysUsePrimeLineForVoiceMessage>?</alwaysUsePrimeLineForVoiceMessage>
                 <featureControlPolicy uuid="?">?</featureControlPolicy>
                 <deviceTrustMode>?</deviceTrustMode>
                 <earlyOfferSupportForVoiceCall>?</earlyOfferSupportForVoiceCall>
                 <requireThirdPartyRegistration>?</requireThirdPartyRegistration>
                 <blockIncomingCallsWhenRoaming>?</blockIncomingCallsWhenRoaming>
                 <homeNetworkId>?</homeNetworkId>
                 <AllowPresentationSharingUsingBfcp>?</AllowPresentationSharingUsingBfcp>
                 <confidentialAccess>
                    <confidentialAccessMode>?</confidentialAccessMode>
                    <confidentialAccessLevel>?</confidentialAccessLevel>
                 </confidentialAccess>
                 <requireOffPremiseLocation>?</requireOffPremiseLocation>
                 <allowiXApplicableMedia>?</allowiXApplicableMedia>
                 <cgpnIngressDN uuid="?">?</cgpnIngressDN>
                 <useDevicePoolCgpnIngressDN>?</useDevicePoolCgpnIngressDN>
                 <msisdn>?</msisdn>
                 <enableCallRoutingToRdWhenNoneIsActive>?</enableCallRoutingToRdWhenNoneIsActive>
                 <wifiHotspotProfile uuid="?">?</wifiHotspotProfile>
                 <wirelessLanProfileGroup uuid="?">?</wirelessLanProfileGroup>
                 <elinGroup uuid="?">?</elinGroup>
                 <enableActivationID>?</enableActivationID>
                 <activationIDStatus>?</activationIDStatus>
                 <mraServiceDomain uuid="?">?</mraServiceDomain>
                 <allowMraMode>?</allowMraMode>
              </returnedTags>
           </ns:getPhone>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content

        return $Response.Envelope.Body.getPhoneResponse.return.phone

    }
    else {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:listPhone>
              <searchCriteria>
                 <name>$Name</name>
                 <description>$Description</description>
                 <protocol>$Protocol</protocol>
                 <callingSearchSpaceName>$CSS</callingSearchSpaceName>
                 <devicePoolName>$DP</devicePoolName>
                 <securityProfileName>$SP</securityProfileName>
              </searchCriteria>
              <returnedTags>
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
                 <commonPhoneConfigName uuid="?">?</commonPhoneConfigName>
                 <networkLocation>?</networkLocation>
                 <locationName uuid="?">?</locationName>
                 <mediaResourceListName uuid="?">?</mediaResourceListName>
                 <networkHoldMohAudioSourceId>?</networkHoldMohAudioSourceId>
                 <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                 <automatedAlternateRoutingCssName uuid="?">?</automatedAlternateRoutingCssName>
                 <aarNeighborhoodName uuid="?">?</aarNeighborhoodName>
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
                 <numberOfButtons>?</numberOfButtons>
                 <phoneTemplateName uuid="?">?</phoneTemplateName>
                 <primaryPhoneName uuid="?">?</primaryPhoneName>
                 <ringSettingIdleBlfAudibleAlert>?</ringSettingIdleBlfAudibleAlert>
                 <ringSettingBusyBlfAudibleAlert>?</ringSettingBusyBlfAudibleAlert>
                 <userLocale>?</userLocale>
                 <networkLocale>?</networkLocale>
                 <idleTimeout>?</idleTimeout>
                 <authenticationUrl>?</authenticationUrl>
                 <directoryUrl>?</directoryUrl>
                 <idleUrl>?</idleUrl>
                 <informationUrl>?</informationUrl>
                 <messagesUrl>?</messagesUrl>
                 <proxyServerUrl>?</proxyServerUrl>
                 <servicesUrl>?</servicesUrl>
                 <softkeyTemplateName uuid="?">?</softkeyTemplateName>
                 <loginUserId>?</loginUserId>
                 <defaultProfileName uuid="?">?</defaultProfileName>
                 <enableExtensionMobility>?</enableExtensionMobility>
                 <currentProfileName uuid="?">?</currentProfileName>
                 <loginTime>?</loginTime>
                 <loginDuration>?</loginDuration>
                 <currentConfig>
                    <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                    <phoneTemplateName uuid="?">?</phoneTemplateName>
                    <mlppDomainId>?</mlppDomainId>
                    <mlppIndicationStatus>?</mlppIndicationStatus>
                    <preemption>?</preemption>
                    <softkeyTemplateName uuid="?">?</softkeyTemplateName>
                    <ignorePresentationIndicators>?</ignorePresentationIndicators>
                    <singleButtonBarge>?</singleButtonBarge>
                    <joinAcrossLines>?</joinAcrossLines>
                    <callInfoPrivacyStatus>?</callInfoPrivacyStatus>
                    <dndStatus>?</dndStatus>
                    <dndRingSetting>?</dndRingSetting>
                    <dndOption>?</dndOption>
                    <alwaysUsePrimeLine>?</alwaysUsePrimeLine>
                    <alwaysUsePrimeLineForVoiceMessage>?</alwaysUsePrimeLineForVoiceMessage>
                    <emccCallingSearchSpaceName uuid="?">?</emccCallingSearchSpaceName>
                    <deviceName>?</deviceName>
                    <model>?</model>
                    <product>?</product>
                    <deviceProtocol>?</deviceProtocol>
                    <class>?</class>
                    <addressMode>?</addressMode>
                    <allowAutoConfig>?</allowAutoConfig>
                    <remoteSrstOption>?</remoteSrstOption>
                    <remoteSrstIp>?</remoteSrstIp>
                    <remoteSrstPort>?</remoteSrstPort>
                    <remoteSipSrstIp>?</remoteSipSrstIp>
                    <remoteSipSrstPort>?</remoteSipSrstPort>
                    <geolocationInfo>?</geolocationInfo>
                    <remoteLocationName>?</remoteLocationName>
                 </currentConfig>
                 <singleButtonBarge>?</singleButtonBarge>
                 <joinAcrossLines>?</joinAcrossLines>
                 <builtInBridgeStatus>?</builtInBridgeStatus>
                 <callInfoPrivacyStatus>?</callInfoPrivacyStatus>
                 <hlogStatus>?</hlogStatus>
                 <ownerUserName uuid="?">?</ownerUserName>
                 <ignorePresentationIndicators>?</ignorePresentationIndicators>
                 <packetCaptureMode>?</packetCaptureMode>
                 <packetCaptureDuration>?</packetCaptureDuration>
                 <subscribeCallingSearchSpaceName uuid="?">?</subscribeCallingSearchSpaceName>
                 <rerouteCallingSearchSpaceName uuid="?">?</rerouteCallingSearchSpaceName>
                 <allowCtiControlFlag>?</allowCtiControlFlag>
                 <presenceGroupName uuid="?">?</presenceGroupName>
                 <unattendedPort>?</unattendedPort>
                 <requireDtmfReception>?</requireDtmfReception>
                 <rfc2833Disabled>?</rfc2833Disabled>
                 <certificateOperation>?</certificateOperation>
                 <authenticationMode>?</authenticationMode>
                 <keySize>?</keySize>
                 <keyOrder>?</keyOrder>
                 <ecKeySize>?</ecKeySize>
                 <authenticationString>?</authenticationString>
                 <certificateStatus>?</certificateStatus>
                 <upgradeFinishTime>?</upgradeFinishTime>
                 <deviceMobilityMode>?</deviceMobilityMode>
                 <roamingDevicePoolName uuid="?">?</roamingDevicePoolName>
                 <remoteDevice>?</remoteDevice>
                 <dndOption>?</dndOption>
                 <dndRingSetting>?</dndRingSetting>
                 <dndStatus>?</dndStatus>
                 <isActive>?</isActive>
                 <isDualMode>?</isDualMode>
                 <mobilityUserIdName uuid="?">?</mobilityUserIdName>
                 <phoneSuite>?</phoneSuite>
                 <phoneServiceDisplay>?</phoneServiceDisplay>
                 <isProtected>?</isProtected>
                 <mtpRequired>?</mtpRequired>
                 <mtpPreferedCodec>?</mtpPreferedCodec>
                 <dialRulesName uuid="?">?</dialRulesName>
                 <sshUserId>?</sshUserId>
                 <digestUser>?</digestUser>
                 <outboundCallRollover>?</outboundCallRollover>
                 <hotlineDevice>?</hotlineDevice>
                 <secureInformationUrl>?</secureInformationUrl>
                 <secureDirectoryUrl>?</secureDirectoryUrl>
                 <secureMessageUrl>?</secureMessageUrl>
                 <secureServicesUrl>?</secureServicesUrl>
                 <secureAuthenticationUrl>?</secureAuthenticationUrl>
                 <secureIdleUrl>?</secureIdleUrl>
                 <alwaysUsePrimeLine>?</alwaysUsePrimeLine>
                 <alwaysUsePrimeLineForVoiceMessage>?</alwaysUsePrimeLineForVoiceMessage>
                 <featureControlPolicy uuid="?">?</featureControlPolicy>
                 <deviceTrustMode>?</deviceTrustMode>
                 <earlyOfferSupportForVoiceCall>?</earlyOfferSupportForVoiceCall>
                 <requireThirdPartyRegistration>?</requireThirdPartyRegistration>
                 <blockIncomingCallsWhenRoaming>?</blockIncomingCallsWhenRoaming>
                 <homeNetworkId>?</homeNetworkId>
                 <AllowPresentationSharingUsingBfcp>?</AllowPresentationSharingUsingBfcp>
                 <confidentialAccess>
                    <confidentialAccessMode>?</confidentialAccessMode>
                    <confidentialAccessLevel>?</confidentialAccessLevel>
                 </confidentialAccess>
                 <requireOffPremiseLocation>?</requireOffPremiseLocation>
                 <allowiXApplicableMedia>?</allowiXApplicableMedia>
                 <enableCallRoutingToRdWhenNoneIsActive>?</enableCallRoutingToRdWhenNoneIsActive>
                 <enableActivationID>?</enableActivationID>
                 <mraServiceDomain uuid="?">?</mraServiceDomain>
                 <allowMraMode>?</allowMraMode>
              </returnedTags>
              $(if ($Skip -ne "") {"<skip>$Skip</skip>"})
              $(if ($First -ne "") {"<first>$First</first>"})
           </ns:listPhone>
        </soapenv:Body>
     </soapenv:Envelope>
"@
        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.listPhoneResponse.return.phone | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                                  = $_.uuid
                'name'                                  = $_.name
                'description'                           = $_.description
                'product'                               = $_.product
                'model'                                 = $_.model
                'class'                                 = $_.class
                'protocol'                              = $_.protocol
                'protocolSide'                          = $_.protocolSide
                'callingSearchSpaceName'                = $_.callingSearchSpaceName.'#text'
                'devicePoolName'                        = $_.devicePoolName.'#text'
                'commonDeviceConfigName'                = $_.commonDeviceConfigName.'#text'
                'commonPhoneConfigName'                 = $_.commonPhoneConfigName.'#text'
                'networkLocation'                       = $_.networkLocation
                'locationName'                          = $_.locationName.'#text'
                'mediaResourceListName'                 = $_.mediaResourceListName
                'automatedAlternateRoutingCssName'      = $_.automatedAlternateRoutingCssName
                'aarNeighborhoodName'                   = $_.aarNeighborhoodName
                'traceFlag'                             = $_.traceFlag
                'mlppIndicationStatus'                  = $_.mlppIndicationStatus
                'preemption'                            = $_.preemption
                'useTrustedRelayPoint'                  = $_.useTrustedRelayPoint
                'retryVideoCallAsAudio'                 = $_.retryVideoCallAsAudio
                'securityProfileName'                   = $_.securityProfileName.'#text'
                'sipProfileName'                        = $_.sipProfileName.'#text'
                'cgpnTransformationCssName'             = $_.cgpnTransformationCssName
                'useDevicePoolCgpnTransformCss'         = $_.useDevicePoolCgpnTransformCss
                'geoLocationName'                       = $_.geoLocationName
                'geoLocationFilterName'                 = $_.geoLocationFilterName
                'sendGeoLocation'                       = $_.sendGeoLocation
                'numberOfButtons'                       = $_.numberOfButtons
                'phoneTemplateName'                     = $_.phoneTemplateName.'#text'
                'primaryPhoneName'                      = $_.primaryPhoneName
                'ringSettingIdleBlfAudibleAlert'        = $_.ringSettingIdleBlfAudibleAlert
                'ringSettingBusyBlfAudibleAlert'        = $_.ringSettingBusyBlfAudibleAlert
                'softkeyTemplateName'                   = $_.softkeyTemplateName
                'defaultProfileName'                    = $_.defaultProfileName
                'enableExtensionMobility'               = $_.enableExtensionMobility
                'currentProfileName'                    = $_.currentProfileName
                'singleButtonBarge'                     = $_.singleButtonBarge
                'joinAcrossLines'                       = $_.joinAcrossLines
                'builtInBridgeStatus'                   = $_.builtInBridgeStatus
                'callInfoPrivacyStatus'                 = $_.callInfoPrivacyStatus
                'hlogStatus'                            = $_.hlogStatus
                'ownerUserName'                         = $_.ownerUserName.'#text'
                'ignorePresentationIndicators'          = $_.ignorePresentationIndicators
                'packetCaptureMode'                     = $_.packetCaptureMode
                'packetCaptureDuration'                 = $_.packetCaptureDuration
                'subscribeCallingSearchSpaceName'       = $_.subscribeCallingSearchSpaceName
                'rerouteCallingSearchSpaceName'         = $_.rerouteCallingSearchSpaceName
                'allowCtiControlFlag'                   = $_.allowCtiControlFlag
                'presenceGroupName'                     = $_.presenceGroupName.'#text'
                'unattendedPort'                        = $_.unattendedPort
                'requireDtmfReception'                  = $_.requireDtmfReception
                'rfc2833Disabled'                       = $_.rfc2833Disabled
                'certificateOperation'                  = $_.certificateOperation
                'authenticationMode'                    = $_.authenticationMode
                'keySize'                               = $_.keySize
                'keyOrder'                              = $_.keyOrder
                'ecKeySize'                             = $_.ecKeySize
                'authenticationString'                  = $_.authenticationString
                'certificateStatus'                     = $_.certificateStatus
                'upgradeFinishTime'                     = $_.upgradeFinishTime
                'deviceMobilityMode'                    = $_.deviceMobilityMode
                'roamingDevicePoolName'                 = $_.roamingDevicePoolName
                'remoteDevice'                          = $_.remoteDevice
                'dndOption'                             = $_.dndOption
                'dndStatus'                             = $_.dndStatus
                'isActive'                              = $_.isActive
                'isDualMode'                            = $_.isDualMode
                'mobilityUserIdName'                    = $_.mobilityUserIdName
                'phoneSuite'                            = $_.phoneSuite
                'phoneServiceDisplay'                   = $_.phoneServiceDisplay
                'isProtected'                           = $_.isProtected
                'mtpRequired'                           = $_.mtpRequired
                'mtpPreferedCodec'                      = $_.mtpPreferedCodec
                'dialRulesName'                         = $_.dialRulesName
                'sshUserId'                             = $_.sshUserId
                'outboundCallRollover'                  = $_.outboundCallRollover
                'hotlineDevice'                         = $_.hotlineDevice
                'alwaysUsePrimeLine'                    = $_.alwaysUsePrimeLine
                'alwaysUsePrimeLineForVoiceMessage'     = $_.alwaysUsePrimeLineForVoiceMessage
                'featureControlPolicy'                  = $_.featureControlPolicy
                'deviceTrustMode'                       = $_.deviceTrustMode
                'earlyOfferSupportForVoiceCall'         = $_.earlyOfferSupportForVoiceCall
                'AllowPresentationSharingUsingBfcp'     = $_.AllowPresentationSharingUsingBfcp
                'confidentialAccess'                    = $_.confidentialAccess.confidentialAccessLevel
                'requireOffPremiseLocation'             = $_.requireOffPremiseLocation
                'allowiXApplicableMedia'                = $_.allowiXApplicableMedia
                'enableCallRoutingToRdWhenNoneIsActive' = $_.enableCallRoutingToRdWhenNoneIsActive
                'enableActivationID'                    = $_.enableActivationID
                'mraServiceDomain'                      = $_.mraServiceDomain
                'allowMraMode'                          = $_.allowMraMode
            }
            $Result = New-Object PSObject -Property $hash
            return $Result
        }
    }
}
