
Import-Certificate -FilePath C:\Users\cloudteam\Desktop\ems_ssl_certificates\Fortinet_Cloud_Demo_CA.crt -CertStoreLocation Cert:\LocalMachine\My\
$secure_password = ConvertTo-SecureString "password" -AsPlainText -Force
Import-PfxCertificate -FilePath C:\Users\cloudteam\Desktop\ems_ssl_certificates\EMS_Demo_Server.pfx -CertStoreLocation Cert:\LocalMachine\My\ -Password $secure_password