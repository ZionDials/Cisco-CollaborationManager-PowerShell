Function global:Get-CCMPhoneLine {
    <#
    .SYNOPSIS
        Queries CUCM for Phone Line(s)

    .DESCRIPTION
        Queries CUCM for Phone Line(s)

    .PARAMETER Description
        Description of Phone Line(s). Use '%' for wildcard.

    .PARAMETER Pattern
        Pattern of Phone Line(s). Use '%' for wildcard.

    .PARAMETER RoutePartitionName
        Route Partition Name of Phone Line(s). Use '%' for wildcard.

    .PARAMETER First
        Number of records to return.

    .PARAMETER Skip
        Number of records to skip.

    .PARAMETER UUID
        UUID of Phone Line.
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][Int]$First,
        [Parameter(ValueFromPipelineByPropertyName)][Int]$Skip,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Description,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Pattern,
        [Parameter(ValueFromPipelineByPropertyName)][String]$RoutePartitionName,
        [Parameter(ValueFromPipelineByPropertyName)][String]$UUID
    )
    $ConfigFile = Get-CCMSettingsFile

    if ($Pattern -eq "") {
        $Pattern = "%"
    }

    if ($Description -eq "") {
        $Description = "%"
    }

    if ($RoutePartitionName -eq "") {
        $RoutePartitionName = "%"
    }

    if ($UUID -ne "") {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:getLine sequence="?">
              <uuid>$UUID</uuid>
              <returnedTags uuid="?">
                 <pattern>?</pattern>
                 <description>?</description>
                 <usage>?</usage>
                 <routePartitionName uuid="?">?</routePartitionName>
                 <aarNeighborhoodName uuid="?">?</aarNeighborhoodName>
                 <aarDestinationMask>?</aarDestinationMask>
                 <aarKeepCallHistory>?</aarKeepCallHistory>
                 <aarVoiceMailEnabled>?</aarVoiceMailEnabled>
                 <callForwardAll>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <secondaryCallingSearchSpaceName uuid="?">?</secondaryCallingSearchSpaceName>
                    <destination>?</destination>
                 </callForwardAll>
                 <callForwardBusy>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                 </callForwardBusy>
                 <callForwardBusyInt>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                 </callForwardBusyInt>
                 <callForwardNoAnswer>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                    <duration>?</duration>
                 </callForwardNoAnswer>
                 <callForwardNoAnswerInt>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                    <duration>?</duration>
                 </callForwardNoAnswerInt>
                 <callForwardNoCoverage>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                 </callForwardNoCoverage>
                 <callForwardNoCoverageInt>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                 </callForwardNoCoverageInt>
                 <callForwardOnFailure>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                 </callForwardOnFailure>
                 <callForwardAlternateParty>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                    <duration>?</duration>
                 </callForwardAlternateParty>
                 <callForwardNotRegistered>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                 </callForwardNotRegistered>
                 <callForwardNotRegisteredInt>
                    <forwardToVoiceMail>?</forwardToVoiceMail>
                    <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                    <destination>?</destination>
                 </callForwardNotRegisteredInt>
                 <callPickupGroupName uuid="?">?</callPickupGroupName>
                 <autoAnswer>?</autoAnswer>
                 <networkHoldMohAudioSourceId>?</networkHoldMohAudioSourceId>
                 <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                 <callingIdPresentationWhenDiverted>?</callingIdPresentationWhenDiverted>
                 <alertingName>?</alertingName>
                 <asciiAlertingName>?</asciiAlertingName>
                 <presenceGroupName uuid="?">?</presenceGroupName>
                 <shareLineAppearanceCssName uuid="?">?</shareLineAppearanceCssName>
                 <voiceMailProfileName uuid="?">?</voiceMailProfileName>
                 <patternPrecedence>?</patternPrecedence>
                 <releaseClause>?</releaseClause>
                 <hrDuration>?</hrDuration>
                 <hrInterval>?</hrInterval>
                 <cfaCssPolicy>?</cfaCssPolicy>
                 <defaultActivatedDeviceName uuid="?">?</defaultActivatedDeviceName>
                 <parkMonForwardNoRetrieveDn>?</parkMonForwardNoRetrieveDn>
                 <parkMonForwardNoRetrieveIntDn>?</parkMonForwardNoRetrieveIntDn>
                 <parkMonForwardNoRetrieveVmEnabled>?</parkMonForwardNoRetrieveVmEnabled>
                 <parkMonForwardNoRetrieveIntVmEnabled>?</parkMonForwardNoRetrieveIntVmEnabled>
                 <parkMonForwardNoRetrieveCssName uuid="?">?</parkMonForwardNoRetrieveCssName>
                 <parkMonForwardNoRetrieveIntCssName uuid="?">?</parkMonForwardNoRetrieveIntCssName>
                 <parkMonReversionTimer>?</parkMonReversionTimer>
                 <partyEntranceTone>?</partyEntranceTone>
                 <directoryURIs>
                    <directoryUri uuid="?">
                       <isPrimary>?</isPrimary>
                       <uri>?</uri>
                       <partition uuid="?">?</partition>
                       <advertiseGloballyViaIls>?</advertiseGloballyViaIls>
                    </directoryUri>
                 </directoryURIs>
                 <allowCtiControlFlag>?</allowCtiControlFlag>
                 <rejectAnonymousCall>?</rejectAnonymousCall>
                 <patternUrgency>?</patternUrgency>
                 <confidentialAccess>
                    <confidentialAccessMode>?</confidentialAccessMode>
                    <confidentialAccessLevel>?</confidentialAccessLevel>
                 </confidentialAccess>
                 <externalCallControlProfile uuid="?">?</externalCallControlProfile>
                 <enterpriseAltNum>
                    <numMask>?</numMask>
                    <isUrgent>?</isUrgent>
                    <addLocalRoutePartition>?</addLocalRoutePartition>
                    <routePartition uuid="?">?</routePartition>
                    <advertiseGloballyIls>?</advertiseGloballyIls>
                 </enterpriseAltNum>
                 <e164AltNum>
                    <numMask>?</numMask>
                    <isUrgent>?</isUrgent>
                    <addLocalRoutePartition>?</addLocalRoutePartition>
                    <routePartition uuid="?">?</routePartition>
                    <advertiseGloballyIls>?</advertiseGloballyIls>
                 </e164AltNum>
                 <pstnFailover>?</pstnFailover>
                 <callControlAgentProfile>?</callControlAgentProfile>
                 <associatedDevices>
                    <device>?</device>
                 </associatedDevices>
                 <useEnterpriseAltNum>?</useEnterpriseAltNum>
                 <useE164AltNum>?</useE164AltNum>
                 <active>?</active>
                 <externalPresentationInfo>
                    <isAnonymous>?</isAnonymous>
                    <presentationInfo>
                       <externalPresentationNumber>?</externalPresentationNumber>
                       <externalPresentationName>?</externalPresentationName>
                    </presentationInfo>
                 </externalPresentationInfo>
              </returnedTags>
           </ns:getLine>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.getLineResponse.return.line | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                                 = $_.uuid
                'pattern'                              = $_.pattern
                'description'                          = $_.description
                'usage'                                = $_.usage
                'routePartitionName'                   = $_.routePartitionName."#text"
                'aarNeighborhoodName'                  = $_.aarNeighborhoodName
                'aarDestinationMask'                   = $_.aarDestinationMask
                'aarKeepCallHistory'                   = $_.aarKeepCallHistory
                'aarVoiceMailEnabled'                  = $_.aarVoiceMailEnabled
                'callForwardAll'                       = $_.callForwardAll
                'callForwardBusy'                      = $_.callForwardBusy
                'callForwardBusyInt'                   = $_.callForwardBusyInt
                'callForwardNoAnswer'                  = $_.callForwardNoAnswer
                'callForwardNoAnswerInt'               = $_.callForwardNoAnswerInt
                'callForwardNoCoverage'                = $_.callForwardNoCoverage
                'callForwardNoCoverageInt'             = $_.callForwardNoCoverageInt
                'callForwardOnFailure'                 = $_.callForwardOnFailure
                'callForwardAlternateParty'            = $_.callForwardAlternateParty
                'callForwardNotRegistered'             = $_.callForwardNotRegistered
                'callForwardNotRegisteredInt'          = $_.callForwardNotRegisteredInt
                'callPickupGroupName'                  = $_.callPickupGroupName."#text"
                'autoAnswer'                           = $_.autoAnswer
                'networkHoldMohAudioSourceId'          = $_.networkHoldMohAudioSourceId
                'userHoldMohAudioSourceId'             = $_.userHoldMohAudioSourceId
                'callingIdPresentationWhenDiverted'    = $_.callingIdPresentationWhenDiverted
                'alertingName'                         = $_.alertingName
                'asciiAlertingName'                    = $_.asciiAlertingName
                'presenceGroupName'                    = $_.presenceGroupName."#text"
                'shareLineAppearanceCssName'           = $_.shareLineAppearanceCssName
                'voiceMailProfileName'                 = $_.voiceMailProfileName."#text"
                'patternPrecedence'                    = $_.patternPrecedence
                'releaseClause'                        = $_.releaseClause
                'hrDuration'                           = $_.hrDuration
                'hrInterval'                           = $_.hrInterval
                'cfaCssPolicy'                         = $_.cfaCssPolicy
                'defaultActivatedDeviceName'           = $_.defaultActivatedDeviceName
                'parkMonForwardNoRetrieveDn'           = $_.parkMonForwardNoRetrieveDn
                'parkMonForwardNoRetrieveIntDn'        = $_.parkMonForwardNoRetrieveIntDn
                'parkMonForwardNoRetrieveVmEnabled'    = $_.parkMonForwardNoRetrieveVmEnabled
                'parkMonForwardNoRetrieveIntVmEnabled' = $_.parkMonForwardNoRetrieveIntVmEnabled
                'parkMonForwardNoRetrieveCssName'      = $_.parkMonForwardNoRetrieveCssName
                'parkMonForwardNoRetrieveIntCssName'   = $_.parkMonForwardNoRetrieveIntCssName
                'parkMonReversionTimer'                = $_.parkMonReversionTimer
                'partyEntranceTone'                    = $_.partyEntranceTone
                'directoryURIs'                        = $_.directoryURIs
                'allowCtiControlFlag'                  = $_.allowCtiControlFlag
                'rejectAnonymousCall'                  = $_.rejectAnonymousCall
                'patternUrgency'                       = $_.patternUrgency
                'confidentialAccess'                   = $_.confidentialAccess.confidentialAccessLevel
                'externalCallControlProfile'           = $_.externalCallControlProfile
                'enterpriseAltNum'                     = $_.enterpriseAltNum
                'e164AltNum'                           = $_.e164AltNum
                'pstnFailover'                         = $_.pstnFailover
                'callControlAgentProfile'              = $_.callControlAgentProfile
                'associatedDevices'                    = $_.associatedDevices.device
                'useEnterpriseAltNum'                  = $_.useEnterpriseAltNum
                'useE164AltNum'                        = $_.useE164AltNum
                'active'                               = $_.active
                'externalPresentationInfo'             = $_.externalPresentationInfo
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
           <ns:listLine>
              <searchCriteria>
                 <pattern>$Pattern</pattern>
                 <description>$Description</description>
                 <routePartitionName>$RoutePartitionName</routePartitionName>
              </searchCriteria>
              <returnedTags uuid="?">
                 <pattern>?</pattern>
                 <description>?</description>
                 <usage>?</usage>
                 <routePartitionName uuid="?">?</routePartitionName>
                 <aarNeighborhoodName uuid="?">?</aarNeighborhoodName>
                 <aarDestinationMask>?</aarDestinationMask>
                 <aarKeepCallHistory>?</aarKeepCallHistory>
                 <aarVoiceMailEnabled>?</aarVoiceMailEnabled>
                 <callPickupGroupName uuid="?">?</callPickupGroupName>
                 <autoAnswer>?</autoAnswer>
                 <networkHoldMohAudioSourceId>?</networkHoldMohAudioSourceId>
                 <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                 <callingIdPresentationWhenDiverted>?</callingIdPresentationWhenDiverted>
                 <alertingName>?</alertingName>
                 <asciiAlertingName>?</asciiAlertingName>
                 <presenceGroupName uuid="?">?</presenceGroupName>
                 <shareLineAppearanceCssName uuid="?">?</shareLineAppearanceCssName>
                 <voiceMailProfileName uuid="?">?</voiceMailProfileName>
                 <patternPrecedence>?</patternPrecedence>
                 <releaseClause>?</releaseClause>
                 <hrDuration>?</hrDuration>
                 <hrInterval>?</hrInterval>
                 <cfaCssPolicy>?</cfaCssPolicy>
                 <defaultActivatedDeviceName uuid="?">?</defaultActivatedDeviceName>
                 <parkMonForwardNoRetrieveDn>?</parkMonForwardNoRetrieveDn>
                 <parkMonForwardNoRetrieveIntDn>?</parkMonForwardNoRetrieveIntDn>
                 <parkMonForwardNoRetrieveVmEnabled>?</parkMonForwardNoRetrieveVmEnabled>
                 <parkMonForwardNoRetrieveIntVmEnabled>?</parkMonForwardNoRetrieveIntVmEnabled>
                 <parkMonForwardNoRetrieveCssName uuid="?">?</parkMonForwardNoRetrieveCssName>
                 <parkMonForwardNoRetrieveIntCssName uuid="?">?</parkMonForwardNoRetrieveIntCssName>
                 <parkMonReversionTimer>?</parkMonReversionTimer>
                 <partyEntranceTone>?</partyEntranceTone>
                 <allowCtiControlFlag>?</allowCtiControlFlag>
                 <rejectAnonymousCall>?</rejectAnonymousCall>
                 <confidentialAccess>
                    <confidentialAccessMode>?</confidentialAccessMode>
                    <confidentialAccessLevel>?</confidentialAccessLevel>
                 </confidentialAccess>
                 <externalCallControlProfile uuid="?">?</externalCallControlProfile>
                 <enterpriseAltNum>
                    <numMask>?</numMask>
                    <isUrgent>?</isUrgent>
                    <addLocalRoutePartition>?</addLocalRoutePartition>
                    <routePartition uuid="?">?</routePartition>
                    <advertiseGloballyIls>?</advertiseGloballyIls>
                 </enterpriseAltNum>
                 <e164AltNum>
                    <numMask>?</numMask>
                    <isUrgent>?</isUrgent>
                    <addLocalRoutePartition>?</addLocalRoutePartition>
                    <routePartition uuid="?">?</routePartition>
                    <advertiseGloballyIls>?</advertiseGloballyIls>
                 </e164AltNum>
                 <pstnFailover>?</pstnFailover>
              </returnedTags>
                   $(if ($Skip -ne "") {"<skip>$Skip</skip>"})
                   $(if ($First -ne "") {"<first>$First</first>"})
           </ns:listLine>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content

        $Response.Envelope.Body.listLineResponse.return.line | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                                 = $_.uuid
                'pattern'                              = $_.pattern
                'description'                          = $_.description
                'usage'                                = $_.usage
                'routePartitionName'                   = $_.routePartitionName."#text"
                'externalCallControlProfile'           = $_.externalCallControlProfile
                'aarNeighborhoodName'                  = $_.aarNeighborhoodName
                'aarDestinationMask'                   = $_.aarDestinationMask
                'aarKeepCallHistory'                   = $_.aarKeepCallHistory
                'aarVoiceMailEnabled'                  = $_.aarVoiceMailEnabled
                'callPickupGroupName'                  = $_.callPickupGroupName."#text"
                'autoAnswer'                           = $_.autoAnswer
                'networkHoldMohAudioSourceId'          = $_.networkHoldMohAudioSourceId
                'userHoldMohAudioSourceId'             = $_.userHoldMohAudioSourceId
                'callingIdPresentationWhenDiverted'    = $_.callingIdPresentationWhenDiverted
                'alertingName'                         = $_.alertingName
                'asciiAlertingName'                    = $_.asciiAlertingName
                'presenceGroupName'                    = $_.presenceGroupName."#text"
                'shareLineAppearanceCssName'           = $_.shareLineAppearanceCssName
                'voiceMailProfileName'                 = $_.voiceMailProfileName."#text"
                'patternPrecedence'                    = $_.patternPrecedence
                'releaseClause'                        = $_.releaseClause
                'confidentialAccess'                   = $_.confidentialAccess.confidentialAccessLevel
                'hrDuration'                           = $_.hrDuration
                'hrInterval'                           = $_.hrInterval
                'cfaCssPolicy'                         = $_.cfaCssPolicy
                'defaultActivatedDeviceName'           = $_.defaultActivatedDeviceName
                'parkMonForwardNoRetrieveDn'           = $_.parkMonForwardNoRetrieveDn
                'parkMonForwardNoRetrieveIntDn'        = $_.parkMonForwardNoRetrieveIntDn
                'parkMonForwardNoRetrieveVmEnabled'    = $_.parkMonForwardNoRetrieveVmEnabled
                'parkMonForwardNoRetrieveIntVmEnabled' = $_.parkMonForwardNoRetrieveIntVmEnabled
                'parkMonForwardNoRetrieveCssName'      = $_.parkMonForwardNoRetrieveCssName
                'parkMonForwardNoRetrieveIntCssName'   = $_.parkMonForwardNoRetrieveIntCssName
                'parkMonReversionTimer'                = $_.parkMonReversionTimer
                'partyEntranceTone'                    = $_.partyEntranceTone
            }
            $Result = New-Object PSObject -Property $hash
            return $Result
        }
    }
}
