Function global:Get-CCMServers {
    <#
    .SYNOPSIS
        Queries CUCM for Collaboration Manager Servers

    .DESCRIPTION
        Queries CUCM for Collaboration Manager Servers
    #>

    $SQL = "select * from callmanager"

    $Response = Invoke-CCMSQLRequest -Request $SQL

    return $Response
}
