@echo off
start /b javaw -Xmx768m -cp %~dp0/basicv2.jar;basicv2.jar;dist/basicv2.jar com.sixtyfour.runner.VisualMospeed %*
