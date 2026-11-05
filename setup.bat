@echo off
REM One-time setup for Windows: generates the android\ and ios\ host projects
REM with your local Flutter 3.44.8 SDK. Existing files (lib\, assets\,
REM pubspec.yaml, test\) are kept - "flutter create" only adds missing files.
REM Note: iOS builds need a Mac; the ios\ folder is generated so the repo is complete.
cd /d "%~dp0"

call flutter --version || goto :error
call flutter create . --org com.quranpro --project-name quran_pro --platforms android,ios || goto :error
call flutter pub get || goto :error
call flutter analyze
echo.
echo Done. Run:  flutter run
goto :eof

:error
echo.
echo Setup failed. Check that Flutter is installed and on your PATH (run "flutter doctor").
exit /b 1
