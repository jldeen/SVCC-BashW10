#chocolatey install
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

#x11 Server install 
$title = "x11 Server Install"
$message = "Which x11 Server would you like to install and configure?"

$xming = New-Object System.Management.Automation.Host.ChoiceDescription "&Xming", `
    "Installs Xming."
$vcxsrv = New-Object System.Management.Automation.Host.ChoiceDescription "&VcXsrv", `
    "Installs VcXsrv."
$cancel = New-Object System.Management.Automation.Host.ChoiceDescription "&Cancel", `
    "Cancels out of install."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($xming, $vcxsrv, $cancel)
$install = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($install)
    {
        0 {
            Write-Host "You selected Xming."
            Write-Host "Installing Xming x11 Server."
            choco install xming -y
        }
        1 {
            Write-Host "You selected VcXsrv."
            Write-Host "Installing VcXsrv x11 Server"
            choco install vcxsrv -y
        }
        2 {
            Write-Host "You selected the option to cancel."
            Write-Host "Canceling and exiting installation process!";Exit
        }
    }
