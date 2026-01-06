# WinCare-Pro Pester Tests

Describe 'WinCare-Pro Module' {
    BeforeAll {
        Import-Module "$PSScriptRoot/../WinCare.psd1" -Force
    }

    It 'Get-SystemHealth returns system health object' {
        $result = Get-SystemHealth
        $result | Should -BeOfType 'PSCustomObject'
        $result.Drives | Should -Not -BeNullOrEmpty
        $result.TotalMemoryGB | Should -BeGreaterThan 0
    }

    It 'Test-ServiceStatus returns expected output' {
        $result = Test-ServiceStatus
        $result | Should -Not -BeNullOrEmpty
    }

    It 'Invoke-QuickCleanup supports -WhatIf' {
        { Invoke-QuickCleanup -WhatIf } | Should -Not -Throw
    }

    It 'Get-UserSession returns user session info or message' {
        $result = Get-UserSession
        ($result -is [string] -or $result -is [PSCustomObject] -or $result -is [System.Array]) | Should -Be $true
    }

    It 'Get-NetworkInfo returns network info' {
        $result = Get-NetworkInfo
        $result | Should -Not -BeNullOrEmpty
    }

    It 'Invoke-SystemReport creates a report file' {
        $testPath = Join-Path -Path $env:TEMP -ChildPath 'TestSystemReport.txt'
        if (Test-Path $testPath) { Remove-Item $testPath -Force }
        Invoke-SystemReport -Path $testPath
        Test-Path $testPath | Should -Be $true
        Remove-Item $testPath -Force
        }

        It 'Register-ScheduledCleanup supports -WhatIf for Daily' {
            { Register-ScheduledCleanup -Frequency Daily -Time '01:00' -TaskName 'TestCleanupTask' -WhatIf } | Should -Not -Throw
        }

        It 'Register-ScheduledCleanup supports -WhatIf for Weekly' {
            { Register-ScheduledCleanup -Frequency Weekly -Time '02:00' -TaskName 'TestCleanupTaskWeekly' -WhatIf } | Should -Not -Throw
    }
}
