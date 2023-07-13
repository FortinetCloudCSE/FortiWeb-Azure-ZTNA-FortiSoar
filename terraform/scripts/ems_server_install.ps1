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
netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new action=allow localip=any remoteip=any

$Installer = $env:TEMP + "\FortiClientSetup_6.0.1.1131_x64.exe";
Invoke-WebRequest "https://sallams3.s3.amazonaws.com/FortiClientSetup_7.2.0.0690_x64/FortiClientEndpointManagementServer_7.2.0.0689_x64.exe" -OutFile $Installer;
Start-Process -FilePath $Installer -Args "cmd.exe /c FortiClientSetup_6.0.1.1131_x64.exe /quiet" -Verb RunAs -Wait;
"FortiClient EMS Server installed." | Out-File -FilePath $LogFile -Append;
# Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
# net start "OpenSSH SSH Server"
# New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\cmd.exe" -PropertyType String -Force
# Start-Service sshd
# Set-Service -Name sshd -StartupType 'Automatic'

