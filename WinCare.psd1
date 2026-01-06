@{
    # Script module or binary module file associated with this manifest
    RootModule = 'WinCare.psm1'
    ModuleVersion = '1.0.0'
    GUID = 'b1e2c3d4-5678-4abc-9def-1234567890ab'
    Author = 'Your Name'
    CompanyName = 'Your Company or GitHub Username'
    Copyright = '(c) 2026 Your Name. All rights reserved.'
    Description = 'A PowerShell module for system health checks, service status, and quick cleanup.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @('Get-SystemHealth', 'Test-ServiceStatus', 'Invoke-QuickCleanup', 'Get-UserSession', 'Get-NetworkInfo', 'Invoke-SystemReport', 'Register-ScheduledCleanup')
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
    PrivateData = @{
        PSData = @{
            Tags = @('System', 'Health', 'Cleanup', 'Services', 'Windows')
            LicenseUri = 'https://opensource.org/licenses/MIT'
            ProjectUri = 'https://github.com/yourusername/WinCare-Pro'
            ReleaseNotes = 'Initial release.'
        }
    }
}
