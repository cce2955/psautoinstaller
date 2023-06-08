# Prompt the user for the installation choice
$installChoice = Read-Host "Please enter your installation choice (1: Google Drive, 2: Visualizer, 3: Centegix, 4: Office, 5: Common, 6: Full):"

# Define the installer paths
$installers = @{
    "1" = "$drivePath\installers\GoogleDriveSetup.exe"
    "2" = "$drivePath\installers\Visualizer_win10_v3.0.737.0.msi"
    "3" = "$drivePath\centegix\Centegix-Setup-1.10.3-win32.msi"
    "4" = "$drivePath\installers\OfficeSetup.exe"
}

# Function to handle installation, error handling, and logging
function InstallApplication($installerPath, $applicationName) {
    if (Test-Path $installerPath) {
        Write-Host "Installing $applicationName..."
        try {
            Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait
            Write-Host "$applicationName installation completed."
        } catch {
            $errorMessage = "An error occurred during $applicationName installation: $_"
            Write-Host $errorMessage
            if ($logFile) {
                Add-Content -Path $logFile -Value $errorMessage
            }
        }
    }
}

# Check the user's installation choice
switch ($installChoice) {
    "1" { InstallApplication $installers["1"] "Google Drive" }
    "2" {
        InstallApplication $installers["2"] "Visualizer"
        $visualizerInstallationDirectory = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IPEVO\Visualizer"
        Write-Host "Please manually pin Visualizer to the taskbar after installation."
        Write-Host "1. Open the installation directory of Visualizer: $visualizerInstallationDirectory"
        Write-Host "2. Right-click on 'Visualizer.exe' and select 'Pin to taskbar'."
        Start-Process $visualizerInstallationDirectory
    }
    "3" { InstallApplication $installers["3"] "Centegix" }
    "4" { InstallApplication $installers["4"] "Office" }
    "5" {
        InstallApplication $installers["1"] "Google Drive"
        InstallApplication $installers["2"] "Visualizer"
        $visualizerInstallationDirectory = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IPEVO\Visualizer"
        Write-Host "Please manually pin Visualizer to the taskbar after installation."
        Write-Host "1. Open the installation directory of Visualizer: $visualizerInstallationDirectory"
        Write-Host "2. Right-click on 'Visualizer.exe' and select 'Pin to taskbar'."
        Start-Process $visualizerInstallationDirectory
    }
    "6" {
        foreach ($installerPath in $installers.Values) {
            $applicationName = [System.IO.Path]::GetFileNameWithoutExtension($installerPath)
            InstallApplication $installerPath $applicationName
        }
        $visualizerInstallationDirectory = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\IPEVO\Visualizer"
        Write-Host "Please manually pin Visualizer to the taskbar after installation."
        Write-Host "1. Open the installation directory of Visualizer: $visualizerInstallationDirectory"
        Write-Host "2. Right-click on 'Visualizer.exe' and select 'Pin to taskbar'."
        Start-Process $visualizerInstallationDirectory
    }
}

# Get the current script directory
$scriptDirectory = Split-Path -Parent -Path $MyInvocation.MyCommand.Path

# Define printer details
$printerName1 = "Printer1"
$printerName2 = "Printer2"
$printerName3 = "Printer3"

$driverName = "DummyDriver"
$portName1 = "DummyPort1"
$portName2 = "DummyPort2"
$portName3 = "DummyPort3"

$driverInfPath = Join-Path -Path $scriptDirectory -ChildPath "dummy.inf"

# Check if the printer drivers are already installed
$driverExists = Get-PrinterDriver -Name $driverName -ErrorAction SilentlyContinue

# If the driver doesn't exist, install it
if (-not $driverExists) {
    Add-PrinterDriver -Name $driverName -InfPath $driverInfPath
}

# Check if the printer ports are already created
$portExists1 = Get-PrinterPort -Name $portName1 -ErrorAction SilentlyContinue
$portExists2 = Get-PrinterPort -Name $portName2 -ErrorAction SilentlyContinue
$portExists3 = Get-PrinterPort -Name $portName3 -ErrorAction SilentlyContinue

# If the ports don't exist, create them
if (-not $portExists1) {
    Add-PrinterPort -Name $portName1 -PrinterHostAddress $portName1
}
if (-not $portExists2) {
    Add-PrinterPort -Name $portName2 -PrinterHostAddress $portName2
}
if (-not $portExists3) {
    Add-PrinterPort -Name $portName3 -PrinterHostAddress $portName3
}

# Define a helper function to install a printer
function InstallPrinter($printerName, $portName) {
    Add-Printer -Name $printerName -DriverName $driverName -PortName $portName

    # Display the installed printer information
    $installedPrinter = Get-Printer -Name $printerName
    Write-Host "Installed Printer:"
    Write-Host "Name: $($installedPrinter.Name)"
    Write-Host "DriverName: $($installedPrinter.DriverName)"
    Write-Host "PortName: $($installedPrinter.PortName)"
}

# Prompt the user for the printer choices
$printerChoices = Read-Host "Please enter the printer choices (1: Printer1, 2: Printer2, 3: Printer3), separated by commas (e.g., 1,2,3):"
$printerChoices = $printerChoices -split ","

# Install the selected printers
foreach ($choice in $printerChoices) {
    switch ($choice) {
        "1" {
            InstallPrinter $printerName1 $portName1
        }
        "2" {
            InstallPrinter $printerName2 $portName2
        }
        "3" {
            InstallPrinter $printerName3 $portName3
        }
        default {
            Write-Host "Invalid printer choice: $choice"
        }
    }
}
