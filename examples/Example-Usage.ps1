# Example usage of WinCare-Pro

# Import the module
Import-Module "<path-to-folder>\WinCare-Pro\WinCare.psd1"

# Check system health
display Get-SystemHealth

# Check for stopped auto-start services
Test-ServiceStatus

# Perform a quick cleanup (dry run)
Invoke-QuickCleanup -WhatIf
