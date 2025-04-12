set VSVARS_PATH="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\vcvars32.bat"
set QMAKE_PATH="C:\Qt5.6.3\5.6.3\msvc2013\bin\qmake.exe"
set SEVENZIP_PATH="C:\Program Files\7-Zip\7z.exe"

set X_SOURCE_PATH=%~dp0
set X_BUILD_NAME=pdbripper
set X_BUILD_PREFIX=win32

if not exist %X_SOURCE_PATH%\release_version.txt (
    echo "0.1.0" > %X_SOURCE_PATH%\release_version.txt
)
set /p X_RELEASE_VERSION=<%X_SOURCE_PATH%\release_version.txt

call %X_SOURCE_PATH%\build_tools\windows.cmd check_file %VSVARS_PATH%
IF [%X_ERROR%] == [] (echo Missing file: %VSVARS_PATH%) >> debug.log

call %X_SOURCE_PATH%\build_tools\windows.cmd check_file %QMAKE_PATH%
IF [%X_ERROR%] == [] (echo Missing file: %QMAKE_PATH%) >> debug.log

call %X_SOURCE_PATH%\build_tools\windows.cmd check_file %SEVENZIP_PATH%
IF [%X_ERROR%] == [] (echo Missing file: %SEVENZIP_PATH%) >> debug.log

IF NOT [%X_ERROR%] == [] goto exit

call %X_SOURCE_PATH%\build_tools\windows.cmd make_init
call %X_SOURCE_PATH%\build_tools\windows.cmd make_build %X_SOURCE_PATH%\pdbripper_source.pro

cd %X_SOURCE_PATH%\gui_source
call %X_SOURCE_PATH%\build_tools\windows.cmd make_translate gui_source_tr.pro 
cd %X_SOURCE_PATH%

call %X_SOURCE_PATH%\build_tools\windows.cmd check_file %X_SOURCE_PATH%\build\release\pdbripper.exe
IF [%X_ERROR%] == [] (echo Missing file: pdbripper.exe) >> debug.log

IF NOT [%X_ERROR%] == [] goto exit

call %X_SOURCE_PATH%\build_tools\windows.cmd check_file %X_SOURCE_PATH%\build\release\pdbripperc.exe
IF [%X_ERROR%] == [] (echo Missing file: pdbripperc.exe) >> debug.log

IF NOT [%X_ERROR%] == [] goto exit

copy %X_SOURCE_PATH%\build\release\pdbripper.exe %X_SOURCE_PATH%\release\%X_BUILD_NAME%\
copy %X_SOURCE_PATH%\build\release\pdbripperc.exe %X_SOURCE_PATH%\release\%X_BUILD_NAME%\
xcopy %X_SOURCE_PATH%\XStyles\qss %X_SOURCE_PATH%\release\%X_BUILD_NAME%\qss /E /I /Y
xcopy %X_SOURCE_PATH%\signatures\crypto.db %X_SOURCE_PATH%\release\%X_BUILD_NAME%\signatures\ /Y
copy %X_SOURCE_PATH%\files\msdia140.dll %X_SOURCE_PATH%\release\%X_BUILD_NAME%\

call %X_SOURCE_PATH%\build_tools\windows.cmd deploy_qt_library Qt5Widgets
call %X_SOURCE_PATH%\build_tools\windows.cmd deploy_qt_library Qt5Gui
call %X_SOURCE_PATH%\build_tools\windows.cmd deploy_qt_library Qt5Core
call %X_SOURCE_PATH%\build_tools\windows.cmd deploy_qt_plugin platforms qwindows
call %X_SOURCE_PATH%\build_tools\windows.cmd deploy_vc_redist

call %X_SOURCE_PATH%\build_tools\windows.cmd make_release

:exit
call %X_SOURCE_PATH%\build_tools\windows.cmd make_clear
