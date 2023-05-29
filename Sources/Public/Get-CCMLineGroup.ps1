Function global:Get-CCMLineGroup {
    <#
    .SYNOPSIS
        Queries CUCM for Line Group(s)

    .DESCRIPTION
        Queries CUCM for Line Group(s)

    .PARAMETER Name
        Name of Line Group(s). Use '%' for wildcard.

    .PARAMETER First
        Number of records to return.

    .PARAMETER Skip
        Number of records to skip.

    .PARAMETER UUID
        UUID of Line Group.
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
           <ns:getLineGroup>
              <uuid>$UUID</uuid>
              <returnedTags uuid="?">
                 <distributionAlgorithm>?</distributionAlgorithm>
                 <rnaReversionTimeOut>?</rnaReversionTimeOut>
                 <huntAlgorithmNoAnswer>?</huntAlgorithmNoAnswer>
                 <huntAlgorithmBusy>?</huntAlgorithmBusy>
                 <huntAlgorithmNotAvailable>?</huntAlgorithmNotAvailable>
                 <members>
                    <member uuid="?">
                       <lineSelectionOrder>?</lineSelectionOrder>
                       <directoryNumber uuid="?">
                          <pattern>?</pattern>
                          <routePartitionName uuid="?">?</routePartitionName>
                       </directoryNumber>
                    </member>
                 </members>
                 <name>?</name>
                 <autoLogOffHunt>?</autoLogOffHunt>
              </returnedTags>
           </ns:getLineGroup>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content
        return $Response.Envelope.Body.getLineGroupResponse.return.lineGroup
    }
    else {
        $SOAP = @"
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="$($ConfigFile.Settings.CUCM.version)">
        <soapenv:Header/>
        <soapenv:Body>
        <ns:listLineGroup>
            <searchCriteria>
            <name>$Name</name>
            </searchCriteria>
            <returnedTags uuid="?">
            <distributionAlgorithm>?</distributionAlgorithm>
            <rnaReversionTimeOut>?</rnaReversionTimeOut>
            <huntAlgorithmNoAnswer>?</huntAlgorithmNoAnswer>
            <huntAlgorithmBusy>?</huntAlgorithmBusy>
            <huntAlgorithmNotAvailable>?</huntAlgorithmNotAvailable>
            <name>?</name>
            <autoLogOffHunt>?</autoLogOffHunt>
            </returnedTags>
              $(if ($Skip -ne "") {"<skip>$Skip</skip>"})
              $(if ($First -ne "") {"<first>$First</first>"})
           </ns:listLineGroup>
        </soapenv:Body>
     </soapenv:Envelope>
"@

        $Response = [xml](Invoke-CCMAPIRequest -Request $SOAP).Content

        return $Response.Envelope.Body.listLineGroupResponse.return.lineGroup
    }
}
