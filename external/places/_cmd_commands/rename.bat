@echo off
Setlocal enabledelayedexpansion

Set "Pattern=page"
Set "Replace="

For %%a in (page*.js) Do (
    Set "File=%%~a"
    Ren "%%a" "!File:%Pattern%=%Replace%!"
)

for %%A in (*.js) do (
    for /f "tokens=1-6 delims=. " %%F in ("%%A") do (
       set /a a=%%F
       set zeros=
       if !a! LSS 1000000 set zeros=0
       if !a! LSS 100000 set zeros=00
       if !a! LSS 10000 set zeros=000
       if !a! LSS 1000 set zeros=0000
       if !a! LSS 100 set zeros=00000
       if !a! LSS 10 set zeros=000000
       set "name=!zeros!!a!.js"
       ren "%%A" "!name!"
    )
)

endlocal
pause