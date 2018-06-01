#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

APPDIR = %A_ScriptDir%\matrix
If 1 in /S,/s ; this is window's command for starting the actual screensaver
{
  RunWait java -Djna.nosys=true "-Djava.ext.dirs=%APPDIR%\java\lib\ext" "-Djava.library.path=%APPDIR%\lib" -classpath "%APPDIR%\lib\Matrix.jar;%APPDIR%\lib\core.jar;%APPDIR%\lib\jogl-all.jar;%APPDIR%\lib\gluegen-rt.jar;%APPDIR%\lib\jogl-all-natives-windows-amd64.jar;%APPDIR%\lib\gluegen-rt-natives-windows-amd64.jar" Matrix
} Else If 1 in /p,/P ; this is for the preview in the screensaver dialogue box. It's pretty hard to implement, so just do nothing
{
} Else { ; The command for configuring the screensaver is somewhat inconsistent, it can be /c or nothing
  Run notepad.exe "%APPDIR%\data\config.txt"
}
