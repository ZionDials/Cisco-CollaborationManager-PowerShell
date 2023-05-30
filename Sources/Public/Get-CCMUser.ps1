Function global:Get-CCMUser {
    <#
    .SYNOPSIS
        Queries CUCM for User(s)

    .DESCRIPTION
        Queries CUCM for User(s)

    .PARAMETER Department
        Department for User(s). Use '%' for wildcard.

    .PARAMETER FirstName
        First Name of User(s). Use '%' for wildcard.

    .PARAMETER LastName
        Last Name of User(s). Use '%' for wildcard.

    .PARAMETER First
        Number of records to return.

    .PARAMETER UserID
        User ID of User(s). Use '%' for wildcard.

    .PARAMETER Skip
        Number of records to skip.

    .PARAMETER UUID
        UUID of User.
    #>
    param(
        [Parameter(ValueFromPipelineByPropertyName)][Int]$First,
        [Parameter(ValueFromPipelineByPropertyName)][Int]$Skip,
        [Parameter(ValueFromPipelineByPropertyName)][String]$Department,
        [Parameter(ValueFromPipelineByPropertyName)][String]$FirstName,
        [Parameter(ValueFromPipelineByPropertyName)][String]$LastName,
        [Parameter(ValueFromPipelineByPropertyName)][String]$UUID,
        [Parameter(ValueFromPipelineByPropertyName)][String]$UserID
    )
    $ConfigFile = Get-CCMSettingsFile

    if ($Department -eq "") {
        $Department = "%"
    }

    if ($FirstName -eq "") {
        $FirstName = "%"
    }

    if ($LastName -eq "") {
        $LastName = "%"
    }

    if ($UserID -eq "") {
        $UserID = "%"
    }

    if ($UUID -ne "") {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
           <ns:getUser>
              <uuid>$UUID</uuid>
              <returnedTags uuid="?">
                 <firstName>?</firstName>
                 <displayName>?</displayName>
                 <middleName>?</middleName>
                 <lastName>?</lastName>
                 <emMaxLoginTime>?</emMaxLoginTime>
                 <userid>?</userid>
                 <password>?</password>
                 <pin>?</pin>
                 <mailid>?</mailid>
                 <department>?</department>
                 <manager>?</manager>
                 <userLocale>?</userLocale>
                 <associatedDevices>
                    <device>?</device>
                 </associatedDevices>
                 <primaryExtension>
                    <pattern>?</pattern>
                    <routePartitionName>?</routePartitionName>
                 </primaryExtension>
                 <associatedPc>?</associatedPc>
                 <associatedGroups>
                    <userGroup>
                       <name>?</name>
                       <userRoles>
                          <userRole>?</userRole>
                       </userRoles>
                    </userGroup>
                 </associatedGroups>
                 <enableCti>?</enableCti>
                 <digestCredentials>?</digestCredentials>
                 <phoneProfiles>
                    <profileName uuid="?">?</profileName>
                 </phoneProfiles>
                 <defaultProfile uuid="?">?</defaultProfile>
                 <presenceGroupName uuid="?">?</presenceGroupName>
                 <subscribeCallingSearchSpaceName uuid="?">?</subscribeCallingSearchSpaceName>
                 <enableMobility>?</enableMobility>
                 <enableMobileVoiceAccess>?</enableMobileVoiceAccess>
                 <maxDeskPickupWaitTime>?</maxDeskPickupWaitTime>
                 <remoteDestinationLimit>?</remoteDestinationLimit>
                 <associatedRemoteDestinationProfiles>
                    <remoteDestinationProfile>?</remoteDestinationProfile>
                 </associatedRemoteDestinationProfiles>
                 <passwordCredentials>
                    <pwdCredPolicyName uuid="?">?</pwdCredPolicyName>
                    <pwdCredUserCantChange>?</pwdCredUserCantChange>
                    <pwdCredUserMustChange>?</pwdCredUserMustChange>
                    <pwdCredDoesNotExpire>?</pwdCredDoesNotExpire>
                    <pwdCredTimeChanged>?</pwdCredTimeChanged>
                    <pwdCredTimeAdminLockout>?</pwdCredTimeAdminLockout>
                    <pwdCredLockedByAdministrator>?</pwdCredLockedByAdministrator>
                    <pwdResetHackCount>?</pwdResetHackCount>
                 </passwordCredentials>
                 <pinCredentials>
                    <pinCredPolicyName uuid="?">?</pinCredPolicyName>
                    <pinCredUserCantChange>?</pinCredUserCantChange>
                    <pinCredUserMustChange>?</pinCredUserMustChange>
                    <pinCredDoesNotExpire>?</pinCredDoesNotExpire>
                    <pinCredTimeChanged>?</pinCredTimeChanged>
                    <pinCredTimeAdminLockout>?</pinCredTimeAdminLockout>
                    <pinCredLockedByAdministrator>?</pinCredLockedByAdministrator>
                    <pinResetHackCount>?</pinResetHackCount>
                 </pinCredentials>
                 <associatedTodAccess>
                    <todAccess>?</todAccess>
                 </associatedTodAccess>
                 <status>?</status>
                 <enableEmcc>?</enableEmcc>
                 <associatedCapfProfiles>
                    <capfProfileInstanceId>?</capfProfileInstanceId>
                 </associatedCapfProfiles>
                 <ctiControlledDeviceProfiles>
                    <profileName uuid="?">?</profileName>
                 </ctiControlledDeviceProfiles>
                 <patternPrecedence>?</patternPrecedence>
                 <numericUserId>?</numericUserId>
                 <mlppPassword>?</mlppPassword>
                 <customUserFields>
                    <customUserField>
                       <name>?</name>
                       <value>?</value>
                    </customUserField>
                 </customUserFields>
                 <homeCluster>?</homeCluster>
                 <imAndPresenceEnable>?</imAndPresenceEnable>
                 <serviceProfile uuid="?">?</serviceProfile>
                 <lineAppearanceAssociationForPresences>
                    <lineAppearanceAssociationForPresence uuid="?">
                       <laapAssociate uuid="?">?</laapAssociate>
                       <laapProductType>?</laapProductType>
                       <laapDeviceName>?</laapDeviceName>
                       <laapDirectory>?</laapDirectory>
                       <laapPartition>?</laapPartition>
                       <laapDescription>?</laapDescription>
                    </lineAppearanceAssociationForPresence>
                 </lineAppearanceAssociationForPresences>
                 <directoryUri>?</directoryUri>
                 <telephoneNumber>?</telephoneNumber>
                 <title>?</title>
                 <mobileNumber>?</mobileNumber>
                 <homeNumber>?</homeNumber>
                 <pagerNumber>?</pagerNumber>
                 <extensionsInfo>
                    <extension uuid="?">
                       <sortOrder>?</sortOrder>
                       <pattern uuid="?">?</pattern>
                       <routePartition>?</routePartition>
                       <linePrimaryUri>?</linePrimaryUri>
                       <partition uuid="?">?</partition>
                    </extension>
                 </extensionsInfo>
                 <selfService>?</selfService>
                 <userProfile uuid="?">?</userProfile>
                 <calendarPresence>?</calendarPresence>
                 <ldapDirectoryName uuid="?">?</ldapDirectoryName>
                 <userIdentity>?</userIdentity>
                 <nameDialing>?</nameDialing>
                 <ipccExtension uuid="?">?</ipccExtension>
                 <ipccRoutePartition uuid="?">?</ipccRoutePartition>
                 <convertUserAccount uuid="?">?</convertUserAccount>
                 <enableUserToHostConferenceNow>?</enableUserToHostConferenceNow>
                 <attendeesAccessCode>?</attendeesAccessCode>
                 <zeroHop>?</zeroHop>
                 <customerName uuid="?">?</customerName>
                 <associatedHeadsets>
                    <headset>?</headset>
                 </associatedHeadsets>
              </returnedTags>
           </ns:getUser>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.getUserResponse.return.user | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                                  = $_.uuid
                'firstName'                             = $_.firstName
                'middleName'                            = $_.middleName
                'lastName'                              = $_.lastName
                'emMaxLoginTime'                        = $_.emMaxLoginTime
                'userid'                                = $_.userid
                'mailid'                                = $_.mailid
                'department'                            = $_.department
                'manager'                               = $_.manager
                'userLocale'                            = $_.userLocale
                'primaryExtension'                      = $_.primaryExtension."#text"
                'associatedPc'                          = $_.associatedPc
                'associatedGroups'                      = $_.associatedGroups.userGroup
                'associatedDevices'                     = $_.associatedDevices.device
                'enableCti'                             = $_.enableCti
                'subscribeCallingSearchSpaceName'       = $_.subscribeCallingSearchSpaceName
                'enableMobility'                        = $_.enableMobility
                'enableMobileVoiceAccess'               = $_.enableMobileVoiceAccess
                'maxDeskPickupWaitTime'                 = $_.maxDeskPickupWaitTime
                'remoteDestinationLimit'                = $_.remoteDestinationLimit
                'status'                                = $_.status
                'presenceGroupName'                     = $_.presenceGroupName."#text"
                'enableEmcc'                            = $_.enableEmcc
                'patternPrecedence'                     = $_.patternPrecedence
                'numericUserId'                         = $_.numericUserId
                'mlppPassword'                          = $_.mlppPassword
                'homeCluster'                           = $_.homeCluster
                'imAndPresenceEnable'                   = $_.imAndPresenceEnable
                'serviceProfile'                        = $_.serviceProfile."#text"
                'directoryUri'                          = $_.directoryUri
                'ldapDirectoryName'                     = $_.ldapDirectoryName."#text"
                'convertUserAccount'                    = $_.convertUserAccount."#text"
                'telephoneNumber'                       = $_.telephoneNumber
                'title'                                 = $_.title
                'mobileNumber'                          = $_.mobileNumber
                'homeNumber'                            = $_.homeNumber
                'lineAppearanceAssociationForPresences' = $_.lineAppearanceAssociationForPresences.lineAppearanceAssociationForPresence | ForEach-Object {
                    $hash = [ordered]@{
                        'uuid'            = $_.'uuid'
                        'laapAssociate'   = $_.laapAssociate
                        'laapProductType' = $_.laapProductType
                        'laapDeviceName'  = $_.laapDeviceName
                        'laapDirectory'   = $_.laapDirectory
                        'laapPartition'   = $_.laapPartition
                        'laapDescription' = $_.laapDescription
                    }
                    $Result = New-Object PSObject -Property $hash
                    return $Result
                }
                'pagerNumber'                           = $_.pagerNumber
                'calendarPresence'                      = $_.calendarPresence
                'userIdentity'                          = $_.userIdentity
                'customerName'                          = $_.customerName
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
           <ns:listUser>
              <searchCriteria>
                 <firstName>$FirstName</firstName>
                 <lastName>$LastName</lastName>
                 <userid>$UserID</userid>
                 <department>$Department</department>
              </searchCriteria>
              <returnedTags uuid="?">
                 <firstName>?</firstName>
                 <middleName>?</middleName>
                 <lastName>?</lastName>
                 <emMaxLoginTime>?</emMaxLoginTime>
                 <userid>?</userid>
                 <mailid>?</mailid>
                 <department>?</department>
                 <manager>?</manager>
                 <userLocale>?</userLocale>
                 <primaryExtension>
                    <pattern>?</pattern>
                    <routePartitionName>?</routePartitionName>
                 </primaryExtension>
                 <associatedPc>?</associatedPc>
                 <enableCti>?</enableCti>
                 <subscribeCallingSearchSpaceName uuid="?">?</subscribeCallingSearchSpaceName>
                 <enableMobility>?</enableMobility>
                 <enableMobileVoiceAccess>?</enableMobileVoiceAccess>
                 <maxDeskPickupWaitTime>?</maxDeskPickupWaitTime>
                 <remoteDestinationLimit>?</remoteDestinationLimit>
                 <status>?</status>
                 <enableEmcc>?</enableEmcc>
                 <patternPrecedence>?</patternPrecedence>
                 <numericUserId>?</numericUserId>
                 <mlppPassword>?</mlppPassword>
                 <homeCluster>?</homeCluster>
                 <imAndPresenceEnable>?</imAndPresenceEnable>
                 <serviceProfile uuid="?">?</serviceProfile>
                 <directoryUri>?</directoryUri>
                 <telephoneNumber>?</telephoneNumber>
                 <title>?</title>
                 <mobileNumber>?</mobileNumber>
                 <homeNumber>?</homeNumber>
                 <pagerNumber>?</pagerNumber>
                 <calendarPresence>?</calendarPresence>
                 <userIdentity>?</userIdentity>
                 <customerName uuid="?">?</customerName>
              </returnedTags>
              $(if ($Skip -ne "") {"<skip>$Skip</skip>"})
              $(if ($First -ne "") {"<first>$First</first>"})
           </ns:listUser>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content

        $Response.Envelope.Body.listUserResponse.return.user | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                            = $_.uuid
                'firstName'                       = $_.firstName
                'middleName'                      = $_.middleName
                'lastName'                        = $_.lastName
                'emMaxLoginTime'                  = $_.emMaxLoginTime
                'userid'                          = $_.userid
                'mailid'                          = $_.mailid
                'department'                      = $_.department
                'manager'                         = $_.manager
                'userLocale'                      = $_.userLocale
                'primaryExtension'                = $_.primaryExtension."#text"
                'associatedPc'                    = $_.associatedPc
                'enableCti'                       = $_.enableCti
                'subscribeCallingSearchSpaceName' = $_.subscribeCallingSearchSpaceName
                'enableMobility'                  = $_.enableMobility
                'enableMobileVoiceAccess'         = $_.enableMobileVoiceAccess
                'maxDeskPickupWaitTime'           = $_.maxDeskPickupWaitTime
                'remoteDestinationLimit'          = $_.remoteDestinationLimit
                'status'                          = $_.status
                'enableEmcc'                      = $_.enableEmcc
                'patternPrecedence'               = $_.patternPrecedence
                'numericUserId'                   = $_.numericUserId
                'mlppPassword'                    = $_.mlppPassword
                'homeCluster'                     = $_.homeCluster
                'imAndPresenceEnable'             = $_.imAndPresenceEnable
                'serviceProfile'                  = $_.serviceProfile."#text"
                'directoryUri'                    = $_.directoryUri
                'telephoneNumber'                 = $_.telephoneNumber
                'title'                           = $_.title
                'mobileNumber'                    = $_.mobileNumber
                'homeNumber'                      = $_.homeNumber
                'pagerNumber'                     = $_.pagerNumber
                'calendarPresence'                = $_.calendarPresence
                'userIdentity'                    = $_.userIdentity
                'customerName'                    = $_.customerName
            }
            $Result = New-Object PSObject -Property $hash
            return $Result
        }
    }
}
