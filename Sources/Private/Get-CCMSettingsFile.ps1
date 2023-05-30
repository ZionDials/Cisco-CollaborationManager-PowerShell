Function global:Get-CCMSettingsFile {
	<#
	.SYNOPSIS
		Generates config file if not exist

	.DESCRIPTION
		Runs through Q&A to create config file and store in AppData.
		If Settings.xml or .cred file is in the current working directory those will
		supercede when Get-CCMSettingsFile is called.

	.PARAMETER Force
		Switch True/False

		# Toggles check if file exists, if used, ignores existing and creates new.

	.EXAMPLE
		Get-CCMSettingsFile

		# Returns settings from XML file if exists, else creates new then returns

	.EXAMPLE
		Get-CCMSettingsFile -Force

		# Creates new settings XML file
	#>
	param(
		[switch]$Force
	)

	# If Settings.xml is in current directory, use that instead of AppData version
	if (-not (Get-ChildItem Settings.xml -ErrorAction SilentlyContinue)) {
		$ccm_path = $MyInvocation.MyCommand.Module.PrivateData['ccm_path']
	} else {
		$ccm_path = (Get-Location).Path
	}

	# Get absolute path to module
	$mod_path  = $MyInvocation.MyCommand.Module.ModuleBase

	# If Settings.xml doesn't exist, run through Q&A for setup
	if (!(Test-Path -Path "$ccm_path\Settings.xml") -or $Force) {
		if (-not $Force) {
			Write-Warning "Unable to find '$ccm_path\Settings.xml' file"
			$createone = Read-Host "Would you like to create a new settings file? [Y/N]"
		} else { $createone = "Y" }
		if ($createone -eq "Y") {
			[string]$CCMURI        = Read-Host "Enter URI of Cisco UCM AXL"
			[string]$CCMAxlVersion = Read-Host "Enter AXL Version (e.g. 10.5)"
			$CCMAxlVersion = 'http://www.cisco.com/AXL/API/' + $CCMAxlVersion
			if ($CCMCredential = $host.ui.PromptForCredential('Cisco UCM Credentials Required', 'Please enter credentials for Cisco Unified Collaboration Manager.', '', "")){} else {
				Write-Warning "Need CCM credentials in order to proceed.`r`nPlease re-run script and enter the appropriate credentials."
				break
			}
			$CCMCredential | Export-CliXml -Path "$ccm_path\ccm.cred"

			Write-Host "Generating XML File..."

			[xml]$ConfigFile = (Get-Content "$mod_path\bin\SettingsTemplate.xml")
			$ConfigFile.Settings.CCM.uri     = $CCMURI
			$ConfigFile.Settings.CCM.version = $CCMAxlVersion
			$ConfigFile.Settings.CCM.auth    = "$ccm_path\ccm.cred"
			$ConfigFile.Save("$ccm_path\Settings.xml") | Out-Null

			Write-Host "File Created in '$ccm_path'"
		} else {
			Write-Warning "Need a settings.xml file in order to proceed`nQuitting..."
			exit
		}
	}

	# Import Settings XML File
	[xml]$ConfigFile = Get-Content "$ccm_path\Settings.xml"

	# If *.cred files are in current path, replace creds in $ConfigFile instance with those
	$whereAmI = (Get-Location).Path
	if (Test-Path -Path "$whereAmI\*.cred") {
		if (Test-Path -Path "$whereAmI\ccm.cred") {
			$ConfigFile.Settings.CCM.auth = "$whereAmI\ccm.cred"
		}
	}

	return $ConfigFile
}
