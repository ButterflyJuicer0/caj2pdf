@echo off
setlocal enabledelayedexpansion

if "%1"=="" (
    echo Usage: batch_caj2pdf.bat [directory]
    echo Example: batch_caj2pdf.bat .
    exit /b 1
)

set "input_dir=%1"
set "success_count=0"
set "total_count=0"

echo Activating virtual environment...
call .venv\Scripts\activate.bat

echo.
echo Converting CAJ files to PDF in: %input_dir%
echo.

for %%f in ("%input_dir%\*.caj") do (
    set /a total_count+=1
    echo Converting: %%~nxf
    
    python caj2pdf convert "%%f" -o "%%~dpnf.pdf" >nul 2>&1
    if !errorlevel! equ 0 (
        set /a success_count+=1
        echo   SUCCESS: %%~nxf -^> %%~nxf.pdf
    ) else (
        echo   FAILED: %%~nxf
    )
    echo.
)

echo.
echo Conversion completed: !success_count!/!total_count! files successful
pause