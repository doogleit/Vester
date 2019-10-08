# Test file for the Vester module - https://github.com/WahlNetwork/Vester
# Called via Invoke-Pester VesterTemplate.Tests.ps1

# Test title, e.g. 'DNS Servers'
$Title = 'Misc PowerOff Enable'

# Test description: How New-VesterConfig explains this value to the user
$Description = 'Action to take on system power-off request (0=halt only, 1=power off)'

# The config entry stating the desired values
$Desired = $cfg.host.MiscPowerButton

# The test value's data type, to help with conversion: bool/string/int
$Type = 'int'

# The command(s) to pull the actual value for comparison
# $Object will scope to the folder this test is in (Cluster, Host, etc.)
[ScriptBlock]$Actual = {
    (Get-AdvancedSetting -Entity $Object | Where-Object -FilterScript {
        $_.Name -eq 'Misc.PowerOffEnable'
    }).Value
}

# The command(s) to match the environment to the config
# Use $Object to help filter, and $Desired to set the correct value
[ScriptBlock]$Fix = {
    Get-AdvancedSetting -Entity $Object | Where-Object -FilterScript {
            $_.Name -eq 'Misc.PowerOffEnable'
        } | Set-AdvancedSetting -Value $Desired -Confirm:$false -ErrorAction Stop
}