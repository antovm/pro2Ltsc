@echo off
>nul 2>&1 fsutil dirty query %systemdrive% && (goto gotAdmin) || (goto UACPrompt)
:gotAdmin
rem set variabili
set productkey=QPM6N-7J2WJ-P88HH-P3YRH-YY74H
:setPath
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Selezionare percorso installazione', 'Alert', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)"
for /f "delims=" %%A in ('powershell -Command "$folder = (New-Object -ComObject Shell.Application).BrowseForFolder(0, 'Seleziona una cartella', 0); if ($folder) { Write-Output $folder.Self.Path }"') do set "percorso=%%A"
if "%percorso%"=="" (
   echo Nessuna cartella selezionata! Si prega di riprovare.
    pause
    exit /b
)
echo Applicazione delle modifiche al registro...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName /t REG_SZ /d "Windows 10 Enterprise LTSC 2021" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionID /t REG_SZ /d "EnterpriseS" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CompositionEditionID /t REG_SZ /d "EnterpriseS" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ReleaseId /t REG_SZ /d "21H2" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion /t REG_SZ /d "21H2" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild /t REG_SZ /d "19044" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber /t REG_SZ /d "19a044" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v UBR /t REG_DWORD /d 292 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" /v ProductName /t REG_SZ /d "Windows 10 Enterprise LTSC 2021" /f /reg:32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" /v EditionID /t REG_SZ /d "EnterpriseS" /f /reg:32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" /v CompositionEditionID /t REG_SZ /d "EnterpriseS" /f  /reg:32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" /v ReleaseId /t REG_SZ /d "21H2" /f /reg:32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion /t REG_SZ /d "21H2" /f /reg:32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild /t REG_SZ /d "19044" /f /reg:32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber /t REG_SZ /d "19044" /f /reg:32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" /v UBR /t REG_DWORD /d 292 /f /reg:32
start %percorso%\setup.exe /eula accept /telemetry disable /priority normal /resizerecoverypartition enable /pkey %productkey% /auto upgrade /dynamicupdate disable /compat IgnoreWarning
taskkill /IM explorer.exe /F
start explorer.exe
echo Modifiche completate
pause
exit

:UACPrompt
echo non sei amministratore ciao
pause
