@echo off
set oldDir=%CD%
cd /D "%~dp0"
call java -Xmx768m -cp basicv2.jar;dist/basicv2.jar com.sixtyfour.cbmnative.shell.MoSpeedCL %*
cd /D %oldDir%