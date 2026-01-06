
# WinCare-Pro

A professional PowerShell module for Windows system health checks, service status monitoring, and quick cleanup tasks.


## Features

- **Get-SystemHealth**: Check disk and memory (RAM) health.
- **Test-ServiceStatus**: Find stopped services set to start automatically.
- **Invoke-QuickCleanup**: Remove temporary files from common temp directories (supports `-WhatIf`).
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
   Get-UserSession
   Get-NetworkInfo
   Invoke-SystemReport -Path "C:\\Reports\\SystemReport.txt"
   ```

## How to Contribute

1. Fork the repository on GitHub.
2. Create a new branch for your feature or bugfix.
3. Follow PowerShell best practices (use Verb-Noun naming, comment-based help, error handling).
4. Submit a pull request with a clear description of your changes.

## License

This project is licensed under the MIT License.
