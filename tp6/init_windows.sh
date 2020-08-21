#ajout d'un admin
net user aniss /add /y
net user aniss Password123
net localgroup administrators aniss /add
echo ${base64encode(file("./test.txt"))} > tmp2.b64 && certutil -decode tmp2.b64 C:/test.txt
#configurer le Bureau à distance
remoteusercredentials = Get-Credential
ConvertTo-SecureString -String "Password123" -AsPlainText -Force | ConvertFrom-SecureString | Set-Content "password.txt"
$servicename = "cloudservice"
$username = "RemoteDesktopUser"
$securepassword = Get-Content -Path "password.txt" | ConvertTo-SecureString
$expiry = $(Get-Date).AddDays(1)
$credential = New-Object System.Management.Automation.PSCredential $username,$securepassword
Set-AzureServiceRemoteDesktopExtension -ServiceName $servicename -Credential $credential -Expiration $expiry
