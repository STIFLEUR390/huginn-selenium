@echo off
setlocal EnableDelayedExpansion

echo [INFO] Telechargement de la liste des proxys...

:: Créer un fichier temporaire pour stocker la réponse JSON
set "temp_json=%TEMP%\proxy_list.json"
set "temp_proxies=%TEMP%\proxies.txt"

:: Télécharger la liste des proxies
curl -s "https://proxylist.geonode.com/api/proxy-list?limit=500&page=1&sort_by=lastChecked&sort_type=desc" > "%temp_json%"

:: Utiliser PowerShell pour extraire les proxies (équivalent à jq)
powershell -Command "$json = Get-Content '%temp_json%' | ConvertFrom-Json; $json.data | Where-Object { $_.protocols -contains 'http' } | Select-Object -First 50 | ForEach-Object { $_.ip + ':' + $_.port } | Out-File -FilePath '%temp_proxies%' -Encoding utf8"

:: Lire le fichier de proxies et le formater en une seule ligne séparée par des virgules
set "proxy_list="
for /f "tokens=*" %%a in (%temp_proxies%) do (
    if defined proxy_list (
        set "proxy_list=!proxy_list!,%%a"
    ) else (
        set "proxy_list=%%a"
    )
)

echo [INFO] Proxys enregistres: !proxy_list!

:: Mettre à jour le fichier .env
set "env_file=%~dp0.env"
set "temp_env=%TEMP%\temp_env.txt"

:: Créer un fichier temporaire avec la nouvelle valeur PROXY_LIST
>nul 2>nul type nul > "%temp_env%"
for /f "tokens=*" %%a in (%env_file%) do (
    set "line=%%a"
    if "!line:~0,11!"=="PROXY_LIST=" (
        echo PROXY_LIST=!proxy_list!>> "%temp_env%"
    ) else (
        echo !line!>> "%temp_env%"
    )
)

:: Remplacer le fichier .env par le fichier temporaire
copy /y "%temp_env%" "%env_file%" >nul

echo [INFO] Fichier .env mis a jour avec la nouvelle liste de proxys

:: Nettoyer les fichiers temporaires
del "%temp_json%" 2>nul
del "%temp_proxies%" 2>nul
del "%temp_env%" 2>nul

echo [INFO] Terminé