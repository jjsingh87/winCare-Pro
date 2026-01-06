function Get-SystemHealth {
<#!
.SYNOPSIS
    Checks disk and memory (RAM) health on the system.
.EXAMPLE
    Get-SystemHealth
#>
    [CmdletBinding()]
    param ()
    try {
        $drives = Get-PSDrive -PSProvider 'FileSystem' | Select-Object Name, Free, Used, @{Name='Total';Expression={$_.Free + $_.Used}}
        $os = Get-CimInstance -ClassName Win32_OperatingSystem
        $totalMem = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
        $freeMem = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
        $usedMem = [math]::Round($totalMem - $freeMem, 2)
        [PSCustomObject]@{
            Drives = $drives
            TotalMemoryGB = $totalMem
            UsedMemoryGB = $usedMem
            FreeMemoryGB = $freeMem
        }
    } catch {
        Write-Error "Failed to retrieve system health: $_"
    }
}

function Get-UserSession {
<#!
.SYNOPSIS
    Lists currently logged-in users and their session information.
.EXAMPLE
    Get-UserSession
#>
    [CmdletBinding()]
    param ()
    try {
        $sessions = quser 2>$null | Select-Object -Skip 1 | ForEach-Object {
            $parts = $_ -split '\s+', 6
            [PSCustomObject]@{
                UserName = $parts[0]
                SessionName = $parts[1]
                Id = $parts[2]
                State = $parts[3]
                IdleTime = $parts[4]
                LogonTime = $parts[5]
            }
        }
        if ($sessions) { $sessions } else { Write-Output 'No user sessions found.' }
    } catch {
        Write-Error "Failed to retrieve user sessions: $_"
    }
}

function Get-NetworkInfo {
<#!
.SYNOPSIS
    Shows IP addresses, DNS servers, and network adapter status.
.EXAMPLE
    Get-NetworkInfo
#>
    [CmdletBinding()]
    param ()
    try {
        $adapters = Get-NetIPConfiguration | Select-Object InterfaceAlias, IPv4Address, IPv6Address, DNSServer, InterfaceDescription
        $adapters
    } catch {
        Write-Error "Failed to retrieve network info: $_"
    }
}

function Invoke-SystemReport {
<#!
.SYNOPSIS
    Generates a summary report of system health, services, users, and network info as a text file.
.PARAMETER Path
    The file path to save the report. Defaults to 'SystemReport.txt' in the current directory.
.EXAMPLE
    Invoke-SystemReport -Path C:\Reports\SystemReport.txt
#>
    [CmdletBinding()]
    param (
        [string]$Path = (Join-Path -Path (Get-Location) -ChildPath 'SystemReport.txt')
    )
    try {
        $report = @()
        $report += "==== System Health ===="
        $report += (Get-SystemHealth | Out-String)
        $report += "==== Stopped Auto Services ===="
        $report += (Test-ServiceStatus | Out-String)
        $report += "==== User Sessions ===="
        $report += (Get-UserSession | Out-String)
        $report += "==== Network Info ===="
        $report += (Get-NetworkInfo | Out-String)
        $report -join "`r`n" | Set-Content -Path $Path -Force
        Write-Output "System report saved to $Path"
    } catch {
        Write-Error "Failed to generate system report: $_"
    }
}

function Test-ServiceStatus {
<#!
.SYNOPSIS
    Finds stopped services set to start automatically.
.EXAMPLE
    Test-ServiceStatus
#>
    [CmdletBinding()]
    param ()
    try {
        $stopped = Get-Service | Where-Object { $_.StartType -eq 'Automatic' -and $_.Status -ne 'Running' }
        if ($stopped) {
            $stopped | Select-Object Name, DisplayName, Status, StartType
        } else {
            Write-Output 'All automatic services are running.'
        }
    } catch {
        Write-Error "Failed to check service status: $_"
    }
}

function Invoke-QuickCleanup {
<#!
.SYNOPSIS
    Removes temporary files from common temp directories. Supports -WhatIf.
.EXAMPLE
    Invoke-QuickCleanup -WhatIf
#>
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param ()
    $tempPaths = @($env:TEMP, $env:TMP, "$env:SystemRoot\Temp") | Select-Object -Unique
    foreach ($path in $tempPaths) {
        if (Test-Path $path) {
            try {
                Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
                    if ($PSCmdlet.ShouldProcess($_.FullName, 'Remove')) {
                        Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
                    }
                }
            } catch {
                Write-Warning "Could not clean $path: $_"
            }
        }
    }
}
