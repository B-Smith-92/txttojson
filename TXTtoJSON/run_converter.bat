@echo off
title TXT to JSON Converter Runner

echo TXT to JSON Converter Runner
echo ===========================
echo.

:: Check if Python is installed
where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Error: Python is not installed or not in PATH
    echo Please install Python and try again.
    pause
    exit /b 1
)

:: Create directories if they don't exist
if not exist input mkdir input
if not exist output mkdir output
if not exist completed mkdir completed

:: Check if there are any .txt files in the input directory
dir /b input\*.txt >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo No .txt files found in the input directory.
    echo Please place your .txt files in the 'input' directory and run this script again.
    pause
    exit /b 0
)

:: Run the Python script
echo Running converter script...
python txt_to_json.py

:: Check if the script ran successfully
if %ERRORLEVEL% equ 0 (
    echo.
    echo Conversion completed successfully!
    echo JSON files are in the 'output' directory.
    echo Processed text files are in the 'completed' directory.
) else (
    echo.
    echo Error: Conversion failed. Please check the error messages above.
)

pause 