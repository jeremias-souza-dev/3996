@echo off
set "MSBUILD_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
if not exist "%MSBUILD_PATH%" (
    for /f "usebackq tokens=*" %%i in (`"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`) do (
        set "MSBUILD_PATH=%%i"
    )
)

if not exist "%MSBUILD_PATH%" (
    echo MSBuild not found. Please install Visual Studio with C++ development workload.
    pause
    exit /b 1
)

echo Found MSBuild at: %MSBUILD_PATH%

echo Building Release x64...
"%MSBUILD_PATH%" theforgottenserver.sln /p:Configuration=Release /p:Platform=x64 /t:Rebuild
if %ERRORLEVEL% neq 0 (
    echo Build failed for Release x64. Trying Release Win32...
    "%MSBUILD_PATH%" theforgottenserver.sln /p:Configuration=Release /p:Platform=Win32 /t:Rebuild
    if %ERRORLEVEL% neq 0 (
        echo Both builds failed.
        pause
        exit /b 1
    ) else (
        set "PLATFORM=Win32"
    )
) else (
    set "PLATFORM=x64"
)

echo Build Succeeded!

rem Copy the built executable to the server folder
if "%PLATFORM%"=="x64" (
    if exist "x64\Release\theforgottenserver-x64.exe" (
        copy /y "x64\Release\theforgottenserver-x64.exe" "..\..\..\Servidor Dragon Ball Z\TheForgottenServer.exe"
    ) else if exist "x64\Release\theforgottenserver.exe" (
        copy /y "x64\Release\theforgottenserver.exe" "..\..\..\Servidor Dragon Ball Z\TheForgottenServer.exe"
    ) else (
        echo Built executable not found in x64\Release!
    )
) else (
    if exist "Release\theforgottenserver-Win32.exe" (
        copy /y "Release\theforgottenserver-Win32.exe" "..\..\..\Servidor Dragon Ball Z\TheForgottenServer.exe"
    ) else if exist "Release\theforgottenserver.exe" (
        copy /y "Release\theforgottenserver.exe" "..\..\..\Servidor Dragon Ball Z\TheForgottenServer.exe"
    ) else (
        echo Built executable not found in Release!
    )
)

echo Copy completed successfully to Servidor Dragon Ball Z!
pause
