@echo off
:menu
cls
chcp 65001
title Multi-Tools Natyx
color D

echo ███╗   ███╗██╗   ██╗██╗  ████████╗██╗    ████████╗ ██████╗  ██████╗ ██╗     
echo ████╗ ████║██║   ██║██║  ╚══██╔══╝██║    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     
echo ██╔████╔██║██║   ██║██║     ██║   ██║       ██║   ██║   ██║██║   ██║██║     
echo ██║╚██╔╝██║██║   ██║██║     ██║   ██║       ██║   ██║   ██║██║   ██║██║     
echo ██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║       ██║   ╚██████╔╝╚██████╔╝███████╗
echo ╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝ 

echo 1. Rechercher une adresse IP
echo 2. Spam de Webhooks
echo 3. Recherche d'email
set /p choice=Entrez votre choix :  

if %choice%==1 goto iplookup
if %choice%==2 goto webhooks_spam
if %choice%==3 goto emaillookup

goto end

:iplookup
cls
echo ███████╗███╗   ██╗████████╗███████╗██████╗     ██╗██████╗ 
echo ██╔════╝████╗  ██║╚══██╔══╝██╔════╝██╔══██╗    ██║██╔══██╗
echo █████╗  ██╔██╗ ██║   ██║   █████╗  ██████╔╝    ██║██████╔╝
echo ██╔══╝  ██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗    ██║██╔═══╝ 
echo ███████╗██║ ╚████║   ██║   ███████╗██║  ██║    ██║██║     
echo ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝╚═╝
echo. ================================================

echo Entrez l'adresse IP ou tapez BACK pour retourner au menu. :
set /p ip=
if "%ip%"=="back" goto menu

curl "https://ipinfo.io/%ip%/json" -o geolocation.json
echo ==================================
echo Géolocalisation IP pour %ip% :
type geolocation.json
del geolocation.json
echo =================================
pause
goto menu

:emaillookup
cls
echo ███╗   ███╗ █████╗ ██╗██╗                   ████████╗ ██████╗  ██████╗ ██╗
echo ████╗ ████║██╔══██╗██║██║                   ╚══██╔══╝██╔═══██╗██╔═══██╗██║
echo ██╔████╔██║███████║██║██║         █████╗       ██║   ██║   ██║██║   ██║██║
echo ██║╚██╔╝██║██╔══██║██║██║         ╚════╝       ██║   ██║   ██║██║   ██║██║
echo ██║ ╚═╝ ██║██║  ██║██║███████╗                 ██║   ╚██████╔╝╚██████╔╝███████╗
echo ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚══════╝                 ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝

set /p email="Entrez l'adresse email : "
for /f "tokens=1,2 delims=@" %%a in ("%email%") do (
    set username=%%a
    set domain=%%b
)
echo Adresse email : %email%
echo Nom d'utilisateur : %username%
echo Domaine : %domain%
pause
goto menu

:webhooks_spam
cls

echo ██╗    ██╗███████╗██████╗ ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗        
echo ██║    ██║██╔════╝██╔══██╗██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝    
echo ██║ █╗ ██║█████╗  ██████╔╝███████║██║   ██║██║   ██║█████╔╝        
echo ██║███╗██║██╔══╝  ██╔══██╗██╔══██║██║   ██║██║   ██║██╔═██╗      
echo ╚███╔███╔╝███████╗██████╔╝██║  ██║╚██████╔╝╚██████╔╝██║  ██╗
echo  ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
echo ┌────────────────────────────────┐
echo │            SPAMMEUR            │
echo ├────────────────────────────────┤
echo │ 1. Quitter                     │
echo │ 2. Spammer webhook Discord     │
echo └────────────────────────────────┘
set /p choice=Entrez votre choix : 

if "%choice%"=="1" goto :eof
if "%choice%"=="2" goto messagesender
goto menu

:messagesender
cls
echo ┌────────────────────────────────┐
echo │     Spammer webhook Discord    │
echo ├────────────────────────────────┤
set /p "webhook=│ Entrez l'URL du webhook Discord pour envoyer le message : "
set /p "message=│ Entrez le message à envoyer : "
set /p "num_times=│ Entrez le nombre de fois à envoyer le message : "

for /l %%n in (1,1,%num_times%) do (
    :: Envoyer le message au webhook Discord
    curl -X POST -H "Content-Type: application/json" -d "{\"content\": \"%message%\"}" %webhook%
)
echo Messages envoyés avec succès.
pause
goto menu
