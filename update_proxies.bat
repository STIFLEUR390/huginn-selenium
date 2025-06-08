@echo off
setlocal EnableDelayedExpansion

echo [INFO] Telechargement de la liste des proxys...

:: Créer un fichier temporaire pour stocker la réponse JSON
set "temp_json=%TEMP%\proxy_list.json"
set "temp_proxies=%TEMP%\proxies.txt"

:: Télécharger la liste des proxies depuis l'API ProxyScrape
echo [INFO] Telechargement depuis l'API ProxyScrape...
curl -s "https://api.proxyscrape.com/v4/free-proxy-list/get?request=display_proxies&protocol=http&proxy_format=ipport&format=text&timeout=20000" > "%temp_proxies%"

:: Vérifier si le fichier de proxies a été téléchargé correctement
if not exist "%temp_proxies%" (
    echo [ERREUR] Impossible de télécharger la liste des proxys!
    exit /b 1
)

:: Vérifier si le fichier de proxies n'est pas vide
for %%I in ("%temp_proxies%") do if %%~zI==0 (
    echo [ERREUR] Le fichier de proxies téléchargé est vide!
    exit /b 1
)

echo [INFO] Liste de proxys téléchargée avec succès.

:: Vérifier si le fichier de proxies a été créé correctement
if not exist "%temp_proxies%" (
    echo [ERREUR] Impossible d'extraire les proxys!
    exit /b 1
)

:: Vérifier si le fichier de proxies n'est pas vide
for %%I in ("%temp_proxies%") do if %%~zI==0 (
    echo [ERREUR] Aucun proxy HTTP trouvé!
    exit /b 1
)

:: Lire le fichier de proxies et le formater en une seule ligne séparée par des virgules
set "proxy_list="
for /f "usebackq delims=" %%a in ("%temp_proxies%") do (
    set "line=%%a"
    set "line=!line:~0!"
    if defined proxy_list (
        set "proxy_list=!proxy_list!,!line!"
    ) else (
        set "proxy_list=!line!"
    )
)

echo [INFO] Proxys enregistres: !proxy_list!

:: Enregistrer la liste des proxys dans un fichier texte
set "proxy_file=%~dp0proxy_list.txt"

:: Écrire la liste des proxys dans le fichier
>nul 2>nul type nul > "%proxy_file%"

:: Vérifier si la liste des proxys n'est pas vide
if not defined proxy_list (
    echo [ERREUR] La liste des proxys est vide!
    echo Aucun proxy disponible > "%proxy_file%"
) else (
    echo [INFO] Ecriture de !proxy_list! dans le fichier
    @echo on
    echo !proxy_list!> "%proxy_file%"
    @echo off
)

echo [INFO] Liste des proxys enregistree dans le fichier proxy_list.txt

:: Nettoyer les fichiers temporaires
del "%temp_json%" 2>nul
del "%temp_proxies%" 2>nul

echo [INFO] Terminé