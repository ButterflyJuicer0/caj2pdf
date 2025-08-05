@echo off
setlocal enabledelayedexpansion

if "%1"=="" (
    echo Usage: batch_caj2txt.bat [directory]
    echo Example: batch_caj2txt.bat .
    exit /b 1
)

set "input_dir=%1"
set "success_count=0"
set "total_count=0"

echo Activating virtual environment...
call .venv\Scripts\activate.bat

echo.
echo Converting CAJ files in: %input_dir%
echo.

for %%f in ("%input_dir%\*.caj") do (
    set /a total_count+=1
    echo Converting: %%~nxf
    
    REM Step 1: CAJ to PDF
    python caj2pdf convert "%%f" -o "%%~dpnf.pdf" >nul 2>&1
    if !errorlevel! equ 0 (
        REM Step 2: PDF to TXT
        python pdf2txt.py "%%~dpnf.pdf" -o "%%~dpnf.txt" >nul 2>&1
        if !errorlevel! equ 0 (
            set /a success_count+=1
            echo   SUCCESS: %%~nxf -^> %%~nxf.txt
        ) else (
            echo   FAILED: PDF to TXT conversion failed
        )
    ) else (
        echo   FAILED: CAJ to PDF conversion failed
    )
    echo.
)

echo.
echo Conversion completed: !success_count!/!total_count! files successful
pause