# Printer Installation Script

I created this script to automate some processes at work related to printer installation and application setup.

## Description

This script allows you to choose the applications you want to install and the printers you want to set up. It provides a menu for selecting application choices and prompts for printer choices. The script installs the selected applications silently and configures the specified printers with the required drivers and ports.

## Requirements

- PowerShell version 5.1 or later.

## Installation

1. Clone or download the script to your local machine.
2. Ensure that PowerShell execution policy allows script execution. You can set the execution policy by running `Set-ExecutionPolicy` command with appropriate options.
3. Modify the script as needed, replacing the dummy values with the actual printer names, driver name, and port names.
4. Run the script using PowerShell by navigating to the script directory and executing the command `.\installer.ps1`.

## Usage

1. When prompted, enter the installation choice number for the desired applications. For example, enter `1` to install Google Drive.
2. Next, enter the printer choices by specifying the corresponding numbers separated by commas. For example, enter `1,2,3` to install Printer1, Printer2, and Printer3.
3. The script will install the selected applications silently and configure the specified printers.
4. After installation, the script will display the installed printer information.

## Note

- The script assumes that the printer driver INF file is located in the same directory as the script. Make sure to provide the correct path to the driver INF file in the script if it is located elsewhere.
- Modify the installer paths in the script's installer choice section to match the actual installer paths on your system.

Feel free to modify and adapt the script according to your specific requirements.

## License

This script is released under the [MIT License](LICENSE).
