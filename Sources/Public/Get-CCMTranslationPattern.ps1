Function global:Get-CCMTranslationPattern {
    <#
    .SYNOPSIS
        Queries CUCM for Translation Patterns

    .DESCRIPTION
        Queries CUCM for Translation Patterns

    .PARAMETER Pattern
        Translation Pattern Pattern. Use '%' for wildcard.

    .PARAMETER RoutePartitionName
        Route Partition Description. Use '%' for wildcard.

    .PARAMETER UUID
        UUID for Translation Pattern
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][String]$Pattern,
        [Parameter(ValueFromPipelineByPropertyName)][String]$RoutePartitionName,
        [Parameter(ValueFromPipelineByPropertyName)][String]$UUID
    )
    $ConfigFile = Get-CCMSettingsFile

    if ($Pattern -eq "") {
        $Pattern = "%"
    }

    if ($RoutePartitionName -eq "") {
        $RoutePartitionName = "%"
    }

    if ($UUID -ne "") {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:getTransPattern sequence="?">
              <uuid>$UUID</uuid>
              <returnedTags uuid="?">
                 <pattern>?</pattern>
                 <description>?</description>
                 <usage>?</usage>
                 <routePartitionName uuid="?">?</routePartitionName>
                 <blockEnable>?</blockEnable>
                 <calledPartyTransformationMask>?</calledPartyTransformationMask>
                 <callingPartyTransformationMask>?</callingPartyTransformationMask>
                 <useCallingPartyPhoneMask>?</useCallingPartyPhoneMask>
                 <callingPartyPrefixDigits>?</callingPartyPrefixDigits>
                 <dialPlanName uuid="?">?</dialPlanName>
                 <digitDiscardInstructionName uuid="?">?</digitDiscardInstructionName>
                 <patternUrgency>?</patternUrgency>
                 <prefixDigitsOut>?</prefixDigitsOut>
                 <routeFilterName uuid="?">?</routeFilterName>
                 <callingLinePresentationBit>?</callingLinePresentationBit>
                 <callingNamePresentationBit>?</callingNamePresentationBit>
                 <connectedLinePresentationBit>?</connectedLinePresentationBit>
                 <connectedNamePresentationBit>?</connectedNamePresentationBit>
                 <patternPrecedence>?</patternPrecedence>
                 <provideOutsideDialtone>?</provideOutsideDialtone>
                 <callingPartyNumberingPlan>?</callingPartyNumberingPlan>
                 <callingPartyNumberType>?</callingPartyNumberType>
                 <calledPartyNumberingPlan>?</calledPartyNumberingPlan>
                 <calledPartyNumberType>?</calledPartyNumberType>
                 <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                 <resourcePriorityNamespaceName uuid="?">?</resourcePriorityNamespaceName>
                 <routeNextHopByCgpn>?</routeNextHopByCgpn>
                 <routeClass>?</routeClass>
                 <callInterceptProfileName uuid="?">?</callInterceptProfileName>
                 <releaseClause>?</releaseClause>
                 <useOriginatorCss>?</useOriginatorCss>
                 <dontWaitForIDTOnSubsequentHops>?</dontWaitForIDTOnSubsequentHops>
                 <isEmergencyServiceNumber>?</isEmergencyServiceNumber>
              </returnedTags>
           </ns:getTransPattern>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.getTransPatternResponse.return.transPattern | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                           = $_.uuid
                'pattern'                        = $_.pattern
                'description'                    = $_.description
                'usage'                          = $_.usage
                'routePartitionName'             = $_.routePartitionName.'#text'
                'blockEnable'                    = $_.blockEnable
                'calledPartyTransformationMask'  = $_.calledPartyTransformationMask
                'callingPartyTransformationMask' = $_.callingPartyTransformationMask
                'useCallingPartyPhoneMask'       = $_.useCallingPartyPhoneMask
                'callingPartyPrefixDigits'       = $_.callingPartyPrefixDigits
                'dialPlanName'                   = $_.dialPlanName
                'digitDiscardInstructionName'    = $_.digitDiscardInstructionName
                'patternUrgency'                 = $_.patternUrgency
                'prefixDigitsOut'                = $_.prefixDigitsOut
                'routeFilterName'                = $_.routeFilterName
                'callingLinePresentationBit'     = $_.callingLinePresentationBit
                'callingNamePresentationBit'     = $_.callingNamePresentationBit
                'connectedLinePresentationBit'   = $_.connectedLinePresentationBit
                'connectedNamePresentationBit'   = $_.connectedNamePresentationBit
                'patternPrecedence'              = $_.patternPrecedence
                'provideOutsideDialtone'         = $_.provideOutsideDialtone
                'callingPartyNumberingPlan'      = $_.callingPartyNumberingPlan
                'callingPartyNumberType'         = $_.callingPartyNumberType
                'calledPartyNumberingPlan'       = $_.calledPartyNumberingPlan
                'calledPartyNumberType'          = $_.calledPartyNumberType
                'callingSearchSpaceName'         = $_.callingSearchSpaceName.'#text'
                'resourcePriorityNamespaceName'  = $_.resourcePriorityNamespaceName
                'routeNextHopByCgpn'             = $_.routeNextHopByCgpn
                'routeClass'                     = $_.routeClass
                'callInterceptProfileName'       = $_.callInterceptProfileName
                'releaseClause'                  = $_.releaseClause
                'useOriginatorCss'               = $_.useOriginatorCss
                'dontWaitForIDTOnSubsequentHops' = $_.dontWaitForIDTOnSubsequentHops
                'isEmergencyServiceNumber'       = $_.isEmergencyServiceNumber
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
           <ns:listTransPattern sequence="?">
              <searchCriteria>
                 <pattern>$Pattern</pattern>
                 <routePartitionName>$RoutePartitionName</routePartitionName>
              </searchCriteria>
              <returnedTags uuid="?">
                 <pattern>?</pattern>
                 <description>?</description>
                 <usage>?</usage>
                 <routePartitionName uuid="?">?</routePartitionName>
                 <blockEnable>?</blockEnable>
                 <calledPartyTransformationMask>?</calledPartyTransformationMask>
                 <callingPartyTransformationMask>?</callingPartyTransformationMask>
                 <useCallingPartyPhoneMask>?</useCallingPartyPhoneMask>
                 <callingPartyPrefixDigits>?</callingPartyPrefixDigits>
                 <dialPlanName uuid="?">?</dialPlanName>
                 <digitDiscardInstructionName uuid="?">?</digitDiscardInstructionName>
                 <patternUrgency>?</patternUrgency>
                 <prefixDigitsOut>?</prefixDigitsOut>
                 <routeFilterName uuid="?">?</routeFilterName>
                 <callingLinePresentationBit>?</callingLinePresentationBit>
                 <callingNamePresentationBit>?</callingNamePresentationBit>
                 <connectedLinePresentationBit>?</connectedLinePresentationBit>
                 <connectedNamePresentationBit>?</connectedNamePresentationBit>
                 <patternPrecedence>?</patternPrecedence>
                 <provideOutsideDialtone>?</provideOutsideDialtone>
                 <callingPartyNumberingPlan>?</callingPartyNumberingPlan>
                 <callingPartyNumberType>?</callingPartyNumberType>
                 <calledPartyNumberingPlan>?</calledPartyNumberingPlan>
                 <calledPartyNumberType>?</calledPartyNumberType>
                 <callingSearchSpaceName uuid="?">?</callingSearchSpaceName>
                 <resourcePriorityNamespaceName uuid="?">?</resourcePriorityNamespaceName>
                 <routeNextHopByCgpn>?</routeNextHopByCgpn>
                 <routeClass>?</routeClass>
                 <callInterceptProfileName uuid="?">?</callInterceptProfileName>
                 <releaseClause>?</releaseClause>
                 <useOriginatorCss>?</useOriginatorCss>
                 <dontWaitForIDTOnSubsequentHops>?</dontWaitForIDTOnSubsequentHops>
                 <isEmergencyServiceNumber>?</isEmergencyServiceNumber>
              </returnedTags>
           </ns:listTransPattern>
        </soapenv:Body>
     </soapenv:Envelope>
"@
        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.listTransPatternResponse.return.transPattern | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                           = $_.uuid
                'pattern'                        = $_.pattern
                'description'                    = $_.description
                'usage'                          = $_.usage
                'routePartitionName'             = $_.routePartitionName.'#text'
                'blockEnable'                    = $_.blockEnable
                'calledPartyTransformationMask'  = $_.calledPartyTransformationMask
                'callingPartyTransformationMask' = $_.callingPartyTransformationMask
                'useCallingPartyPhoneMask'       = $_.useCallingPartyPhoneMask
                'callingPartyPrefixDigits'       = $_.callingPartyPrefixDigits
                'dialPlanName'                   = $_.dialPlanName
                'digitDiscardInstructionName'    = $_.digitDiscardInstructionName
                'patternUrgency'                 = $_.patternUrgency
                'prefixDigitsOut'                = $_.prefixDigitsOut
                'routeFilterName'                = $_.routeFilterName
                'callingLinePresentationBit'     = $_.callingLinePresentationBit
                'callingNamePresentationBit'     = $_.callingNamePresentationBit
                'connectedLinePresentationBit'   = $_.connectedLinePresentationBit
                'connectedNamePresentationBit'   = $_.connectedNamePresentationBit
                'patternPrecedence'              = $_.patternPrecedence
                'provideOutsideDialtone'         = $_.provideOutsideDialtone
                'callingPartyNumberingPlan'      = $_.callingPartyNumberingPlan
                'callingPartyNumberType'         = $_.callingPartyNumberType
                'calledPartyNumberingPlan'       = $_.calledPartyNumberingPlan
                'calledPartyNumberType'          = $_.calledPartyNumberType
                'callingSearchSpaceName'         = $_.callingSearchSpaceName.'#text'
                'resourcePriorityNamespaceName'  = $_.resourcePriorityNamespaceName
                'routeNextHopByCgpn'             = $_.routeNextHopByCgpn
                'routeClass'                     = $_.routeClass
                'callInterceptProfileName'       = $_.callInterceptProfileName
                'releaseClause'                  = $_.releaseClause
                'useOriginatorCss'               = $_.useOriginatorCss
                'dontWaitForIDTOnSubsequentHops' = $_.dontWaitForIDTOnSubsequentHops
                'isEmergencyServiceNumber'       = $_.isEmergencyServiceNumber
            }
            $Result = New-Object PSObject -Property $hash
            return $Result
        }
    }
}
