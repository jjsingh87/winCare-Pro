
# WinCare-Pro

A professional PowerShell module for Windows system health checks, service status monitoring, and quick cleanup tasks.



## Features

- **Get-SystemHealth**: Check disk and memory (RAM) health.
- **Test-ServiceStatus**: Find stopped services set to start automatically.
- **Invoke-QuickCleanup**: Remove temporary files from common temp directories (supports `-WhatIf`).
- **Register-ScheduledCleanup**: Schedule automatic cleanup of temp files using Windows Task Scheduler (daily or weekly).
- **Get-UserSession**: List currently logged-in users and their session info.
- **Get-NetworkInfo**: Show IP addresses, DNS, and network adapter status.
- **Invoke-SystemReport**: Generate a summary report (disk, RAM, services, users, network) as a text file.

## How to Install

1. Clone the repository or download the module files:

   ```powershell
   git clone https://github.com/yourusername/WinCare-Pro.git
   ```

2. Import the module in PowerShell:

   ```powershell
   Import-Module "<path-to-folder>\WinCare-Pro\WinCare.psd1"
   ```

3. Use the functions as needed:

   ```powershell
   Get-SystemHealth
   Test-ServiceStatus
   Invoke-QuickCleanup -WhatIf
   Register-ScheduledCleanup -Frequency Daily -Time '03:00'   # Schedule daily cleanup at 3 AM
   Register-ScheduledCleanup -Frequency Weekly -Time '04:00' -TaskName 'MyCleanupTask'   # Weekly cleanup
   Get-UserSession
   Get-NetworkInfo
   Invoke-SystemReport -Path "C:\\Reports\\SystemReport.txt"
   ```

## Scheduled Cleanup Usage

You can automate temp file cleanup by scheduling it with Windows Task Scheduler:

```powershell
# Schedule daily cleanup at 2 AM
Register-ScheduledCleanup -Frequency Daily -Time '02:00'

# Schedule weekly cleanup at 4 AM with a custom task name
Register-ScheduledCleanup -Frequency Weekly -Time '04:00' -TaskName 'MyCleanupTask'
```

The scheduled task will run as SYSTEM and invoke the module's cleanup function at the specified interval.

## How to Contribute

1. Fork the repository on GitHub.
2. Create a new branch for your feature or bugfix.
3. Follow PowerShell best practices (use Verb-Noun naming, comment-based help, error handling).
4. Submit a pull request with a clear description of your changes.

## License

This project is licensed under the MIT License.
