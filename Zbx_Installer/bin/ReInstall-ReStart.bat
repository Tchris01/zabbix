@echo off

IF "%PROCESSOR_ARCHITECTURE%"=="x86" (set bit=x32) else (set bit=x64)

IF "%bit%"=="x64" GOTO EXEC64
IF "%bit%"=="x32" GOTO EXEC32 else goto ERROR

:EXEC64
net stop "Zabbix Agent"
ping 127.0.0.1 -n 5 >NUL 2>&1
"C:\Program Files\Zabbix\bin\win64\zabbix_agentd.exe" -d
"C:\Program Files\Zabbix\bin\win64\zabbix_agentd.exe" -i -c "C:\Program Files\Zabbix\conf\zabbix_agent.conf"
ping 127.0.0.1 -n 5 >NUL 2>&1
net start "Zabbix Agent"
GOTO END

:EXEC32
net stop "Zabbix Agent"
ping 127.0.0.1 -n 5 >NUL 2>&1
"C:\Program Files\Zabbix\bin\win32\zabbix_agentd.exe" -d
"C:\Program Files\Zabbix\bin\win32\zabbix_agentd.exe" -i -c "C:\Program Files\Zabbix\conf\zabbix_agent.conf"
ping 127.0.0.1 -n 5 >NUL 2>&1
net start "Zabbix Agent"
GOTO END

:ERROR
echo "OS Detection failed"
ping 127.0.0.1 -n 5 >NUL 2>&1
exit 1

:END
echo "Installation OK"
ping 127.0.0.1 -n 5 >NUL 2>&1
exit 0