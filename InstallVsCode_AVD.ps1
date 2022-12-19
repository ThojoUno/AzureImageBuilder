write-host 'AIB Customization: Install MS VS Code'
# Download URL, you may need to update this if it changes
$downloadUrl = "https://go.microsoft.com/fwlink/?LinkID=623230"

# What to name the file and where to put it
$installerFile = "vscode-install.exe"
$installerPath = (Join-Path $env:TEMP $installerFile)

# Install Options
# Reference:
# http://stackoverflow.com/questions/42582230/how-to-install-visual-studio-code-silently-without-auto-open-when-installation
# http://www.jrsoftware.org/ishelp/
# I'm using /silent, use /verysilent for no UI

# Install with the context menu, file association, and add to path options (and don't run code after install: 
#$installerArguments = "/silent /mergetasks='!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath'"

#Install with default options, and don't run code after install.
$installerArguments = "/VERYSILENT /MERGETASKS='!runcode'"

write-host "Downloading $installerFile..."
Invoke-Webrequest $downloadUrl -UseBasicParsing -OutFile $installerPath

write-host "Installing $installerPath..."
Start-Process $installerPath -ArgumentList $installerArguments

Do {
    $id = $(Get-Process | Select MainWindowTitle,ProcessName,Id | where{$_.MainWindowTitle -like "Get Started - Visual Studio Code*"}).id
    write-host "Waiting for VS Code installation to complete..."
    start-sleep 5
} While ($id -eq $null)

Stop-Process $id 

write-host "Cleanup the downloaded file."
Remove-Item $installerPath -Force

write-host 'AIB Customization: Finished MS VS Code' 

