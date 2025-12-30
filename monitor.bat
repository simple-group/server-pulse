@echo off
setlocal EnableDelayedExpansion

:: Initialisation des variables d'historique
set "h_ping="
set "h_web="
set /a cycle=0

:BOUCLE
set /a cycle+=1
cls
echo =================================================
echo      MONITORING PRO V1.5 - Cycle !cycle!
echo =================================================
echo.

set "count_ok_ping=0"
set "count_ok_web=0"
set "total=0"

:: Debut de creation du fichier de donnees
(
    echo const lastUpdate = "%date% %time%";
    echo const cycleCount = !cycle!;
    echo const serverData = [
) > data.temp

:: Lecture de sites.txt (URL=A, MotCle=B, Opt1=C, Opt2=D)
for /f "usebackq tokens=1-4 delims=," %%A in ("sites.txt") do (
    set /a total+=1
    set "status_ping=KO"
    set "status_web=KO"
    set "cssClass=offline"
    
    :: Detection des options noping ou noweb
    set "isNoPing=0"
    set "isNoWeb=0"
    if /I "%%C"=="noping" set "isNoPing=1"
    if /I "%%D"=="noping" set "isNoPing=1"
    if /I "%%C"=="noweb" set "isNoWeb=1"
    if /I "%%D"=="noweb" set "isNoWeb=1"

    echo Analyse de %%A...

    :: 1. Verification PING
    if "!isNoPing!"=="1" (
        set "status_ping=N/A"
        set /a count_ok_ping+=1
    ) else (
        ping -n 1 -w 1000 %%A >nul 2>&1
        if !errorlevel! equ 0 (
            set "status_ping=OK"
            set /a count_ok_ping+=1
        )
    )

    :: 2. Verification WEB
    if "!isNoWeb!"=="1" (
        set "status_web=N/A"
        set /a count_ok_web+=1
    ) else (
        powershell -ExecutionPolicy Bypass -Command "$u='http://%%A'; try { $r = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 5; if ($r.Content -match '%%B') { exit 0 } else { exit 1 } } catch { exit 1 }" >nul 2>&1
        if !errorlevel! equ 0 (
            set "status_web=OK"
            set /a count_ok_web+=1
        ) else (
            powershell -ExecutionPolicy Bypass -Command "$u='https://%%A'; try { $r = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 5; if ($r.Content -match '%%B') { exit 0 } else { exit 1 } } catch { exit 1 }" >nul 2>&1
            if !errorlevel! equ 0 (
                set "status_web=OK"
                set /a count_ok_web+=1
            )
        )
    )

    :: 3. Logique CSS (Online / Warning / Offline)
    if "!status_ping!"=="OK" (
        if "!status_web!"=="OK" (set "cssClass=online")
        if "!status_web!"=="N/A" (set "cssClass=online")
        if "!status_web!"=="KO" (set "cssClass=warning")
    ) else if "!status_ping!"=="N/A" (
        if "!status_web!"=="OK" (set "cssClass=online")
        if "!status_web!"=="KO" (set "cssClass=offline")
    )

    :: Ecriture securisee dans le fichier JSON
    echo { name: "%%A", ping: "!status_ping!", web: "!status_web!", class: "!cssClass!" }, >> data.temp
)

:: Mise a jour de l'historique (Graphique)
set "h_ping=!h_ping!!count_ok_ping!,"
set "h_web=!h_web!!count_ok_web!,"

(
    echo ];
    echo const historyPing = [!h_ping!];
    echo const historyWeb = [!h_web!];
    echo const totalServers = !total!;
) >> data.temp

:: Finalisation du fichier data.js
move /Y data.temp data.js >nul

echo.
echo Dashboard mis a jour. Attente 60s...
timeout /t 60 >nul
goto BOUCLE