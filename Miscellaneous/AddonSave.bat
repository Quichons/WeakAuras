@echo off
REM Script de sauvegarde de dossier Addon by Kutikuti
REM A combiner idéalement avec une tache planifiée pour une sauvegarde auto toutes les semaines

REM ###### CONFIGURATION DU SCRIPT ###### 
REM Chemin vers le répertoire World of Warcraft, par exemple C:\Program Files (x86)\World of Warcraft
SET CHEMIN_WOW=D:\World of Warcraft

REM Chemin vers le répertoire backup (idéalement un dropbox-like, un emplacement réseau, ou à minima un autre disque...)
SET CHEMIN_REP_BACKUP=F:\SVG\wow

REM Combien de jours doit on garder les sauvegardes d'interface ?
SET RETENTION=30
REM ######################################


REM ###### APRES ON TOUCHE PLUS ! #########
for /F "tokens=1,2,3 delims=/ " %%A in ('date /t') do set JOUR=%%C-%%B-%%A
SET FIC_ZIP=%CHEMIN_REP_BACKUP%\interface-%JOUR%.zip
if exist "%FIC_ZIP%" del /Q /F "%FIC_ZIP%"
zip -r "%FIC_ZIP%" "%CHEMIN_WOW%\WTF" "%CHEMIN_WOW%\Interface"
ForFiles /P "%CHEMIN_REP_BACKUP%" /m "interface-*.zip" /D -%RETENTION% /C "cmd /c DEL /Q /F @PATH"
REM ######################################
