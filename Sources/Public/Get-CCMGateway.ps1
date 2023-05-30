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
           <ns:getGateway sequence="?">
              <uuid>$UUID</uuid>
              <returnedTags uuid="?">
                 <domainName>?</domainName>
                 <description>?</description>
                 <product>?</product>
                 <protocol>?</protocol>
                 <callManagerGroupName uuid="?">?</callManagerGroupName>
                 <units>
                    <unit>
                       <index>?</index>
                       <product>?</product>
                       <subunits>
                          <subunit>
                             <index>?</index>
                             <product>?</product>
                             <beginPort>?</beginPort>
                          </subunit>
                       </subunits>
                    </unit>
                 </units>
                 <scratch>?</scratch>
                 <vendorConfig></vendorConfig>
                 <versionStamp>?</versionStamp>
                 <loadInformation>?</loadInformation>
              </returnedTags>
           </ns:getGateway>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        $Response.Envelope.Body.getGatewayResponse.return.gateway | ForEach-Object {
            $hash = [ordered]@{
                'uuid'                  = $_.uuid
                'domainName'            = $_.domainName
                'description'           = $_.description
                'product'               = $_.product
                'protocol'              = $_.protocol
                'callManagerGroupName'  = $_.callManagerGroupName."#text"
                'units'                 = $_.units.unit
                'scratch'               = $_.scratch
                'ModemPassthrough'      = $_.vendorConfig.ModemPassthrough
                'CiscoFaxRelay'         = $_.vendorConfig.CiscoFaxRelay
                'T38FaxRelay'           = $_.vendorConfig.T38FaxRelay
                'rtpPackageCapability'  = $_.vendorConfig.rtpPackageCapability
                'mtPackageCapability'   = $_.vendorConfig.mtPackageCapability
                'resPackageCapability'  = $_.vendorConfig.resPackageCapability
                'prePackageCapability'  = $_.vendorConfig.prePackageCapability
                'sstPackageCapability'  = $_.vendorConfig.sstPackageCapability
                'rtpUnreachableOnOff'   = $_.vendorConfig.rtpUnreachableOnOff
                'rtpUnreachableTimeout' = $_.vendorConfig.rtpUnreachableTimeout
                'rtcpReportInterval'    = $_.vendorConfig.rtcpReportInterval
                'simpleSdpEnable'       = $_.vendorConfig.simpleSdpEnable
                'versionStamp'          = $_.versionStamp
                'loadInformation'       = $_.loadInformation
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
