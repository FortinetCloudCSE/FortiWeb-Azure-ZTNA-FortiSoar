$LogFile = "C:\temp\startup.log";

# Setup WinRM
winrm delete winrm/config/listener?Address=*+Transport=HTTP  2>$Null
winrm delete winrm/config/listener?Address=*+Transport=HTTPS 2>$Null
winrm create winrm/config/listener?Address=*+Transport=HTTP
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="0"}'
winrm set winrm/config '@{MaxTimeoutms="7200000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service '@{MaxConcurrentOperationsPerUser="12000"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
$Key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$Setting = 'LocalAccountTokenFilterPolicy'
Set-ItemProperty -Path $Key -Name $Setting -Value 1 -Force
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Stop-Service -Name WinRM
Set-Service -Name WinRM -StartupType Automatic
Start-Service -Name WinRM
Enable-NetFirewallRule -DisplayName 'Windows Remote Management (HTTP-In)'

# Install FortiClient
$Installer = "C:\Windows\Temp\" + "FortiClient.msi"
Invoke-WebRequest "https://sallams3.s3.amazonaws.com/FortiClientSetup_7.2.0.0690_x64/FortiClientSetup_7.2.0.0690_x64/FortiClient.msi" -OutFile $Installer
Start-Process -WorkingDirectory "C:\Windows\Temp" -FilePath "cmd.exe" -ArgumentList "/c","FortiClient.msi","/passive","/quiet INSTALLLEVEL=100 DESKTOPSHORTCUT=1 FEATURE_SEL_ZTNA=1 FEATURE_SEL_VULNERABILITYSCAN=1 FEATURE_SEL_SECACCESS=1 FEATURE_SEL_SECFABRIC=1 FEATURE_SEL_ADVPROTECT=1 FEATURE_SEL_PAM=1" -Verb RunAs -Wait 
"FortiClient installed." | Out-File -FilePath $LogFile -Append;