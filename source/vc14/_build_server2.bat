@echo off
cd /d "D:\dbo\source\source\vc14"
call "D:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -arch=x64
"D:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\amd64\MSBuild.exe" theforgottenserver.vcxproj /p:Configuration=Release /p:Platform=x64 /m /clp:Summary;Verbosity=normal /fl /flp:logfile=build_server2.log;verbosity=normal
echo BUILD_EXIT_CODE=%ERRORLEVEL%
