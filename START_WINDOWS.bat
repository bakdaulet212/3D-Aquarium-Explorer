@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title 3D Aquarium Explorer

echo.
echo 3D Aquarium Explorer
echo ====================
echo.
set "CMAKE_BIN="
where cmake >nul 2>&1
if not errorlevel 1 set "CMAKE_BIN=cmake"
if not defined CMAKE_BIN if exist "%ProgramFiles%\CMake\bin\cmake.exe" set "CMAKE_BIN=%ProgramFiles%\CMake\bin\cmake.exe"
if not defined CMAKE_BIN if exist "%ProgramFiles(x86)%\CMake\bin\cmake.exe" set "CMAKE_BIN=%ProgramFiles(x86)%\CMake\bin\cmake.exe"
if not defined CMAKE_BIN goto :NO_CMAKE

set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" set "VSWHERE=%ProgramFiles%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" goto :NO_VS

set "VS_PATH="
set "GENERATOR="
set "BUILD_DIR="
set "VS_FILE=%TEMP%\aquarium_vs_%RANDOM%_%RANDOM%.txt"
"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -version "[18.0,19.0)" -property installationPath > "%VS_FILE%" 2>nul
for %%F in ("%VS_FILE%") do if %%~zF GTR 0 set /p "VS_PATH=" < "%VS_FILE%"
if defined VS_PATH set "GENERATOR=Visual Studio 18 2026"
if defined VS_PATH set "BUILD_DIR=build_vs2026"
if not defined VS_PATH (
  "%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -version "[17.0,18.0)" -property installationPath > "%VS_FILE%" 2>nul
  for %%F in ("%VS_FILE%") do if %%~zF GTR 0 set /p "VS_PATH=" < "%VS_FILE%"
  if defined VS_PATH set "GENERATOR=Visual Studio 17 2022"
  if defined VS_PATH set "BUILD_DIR=build_vs2022"
)
del "%VS_FILE%" >nul 2>&1
if not defined VS_PATH goto :NO_VS

echo Found Visual Studio C++: %VS_PATH%
echo Generator: %GENERATOR%
echo.
echo [1/2] Configuring...
"%CMAKE_BIN%" -S . -B "%BUILD_DIR%" -G "%GENERATOR%" -A x64
if errorlevel 1 goto :BUILD_FAILED

echo.
echo [2/2] Compiling...
"%CMAKE_BIN%" --build "%BUILD_DIR%" --config Release --parallel 4
if errorlevel 1 goto :BUILD_FAILED

if not exist "%BUILD_DIR%\Release\AquariumExplorer.exe" goto :EXECUTABLE_MISSING
echo.
echo Starting aquarium...
"%BUILD_DIR%\Release\AquariumExplorer.exe"
echo.
echo Program finished.
goto :END

:NO_CMAKE
echo ERROR: CMake is missing. Install CMake or Visual Studio CMake tools.
goto :END

:NO_VS
echo ERROR: A Visual Studio installation with MSVC C++ tools was not found.
echo Open Visual Studio Installer and install Desktop development with C++.
echo Include MSVC x64/x86 build tools and a Windows SDK.
echo Visual Studio 2022 and Visual Studio 2026 are supported.
goto :END

:BUILD_FAILED
echo ERROR: Compilation failed. Copy the first error shown above.
goto :END

:EXECUTABLE_MISSING
echo ERROR: Build finished without AquariumExplorer.exe.
goto :END

:END
echo.
echo Press any key to close this window.
pause >nul
endlocal
