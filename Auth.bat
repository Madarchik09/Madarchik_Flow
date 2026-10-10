@echo off
chcp 65001 >nul
title Madarchik_Flow - Авторизация аккаунтов
cd /d "%~dp0"

if not exist ".venv\Scripts\activate.bat" (
    echo [ОШИБКА] Виртуальное окружение не найдено!
    echo Сначала запустите Install.bat для установки всех компонентов.
    echo.
    pause
    exit /b 1
)

call .venv\Scripts\activate.bat

:menu
cls
echo ========================================================
echo        Madarchik_Flow - Менеджер профилей Flow
echo ========================================================
echo.
echo Список текущих профилей:
call gflow auth list
echo.
echo [1] Войти в профиль через Chrome (gflow auth login)
echo [2] Показать статус сессий (gflow auth status)
echo [3] Выбрать активный профиль по умолчанию (gflow auth use)
echo [4] Выход
echo.

set "choice="
set /p choice="Выберите действие [1-4]: "

if "%choice%"=="1" goto do_login
if "%choice%"=="2" goto do_status
if "%choice%"=="3" goto do_use
if "%choice%"=="4" goto do_exit
goto menu

:do_login
echo.
set "prof_name="
set /p prof_name="Введите имя профиля [например: user1, user2 или пусто для дефолта]: "
if defined prof_name (
    call gflow auth login --browser chrome --profile "%prof_name%"
) else (
    call gflow auth login --browser chrome
)
echo.
pause
goto menu

:do_status
echo.
call gflow auth status
echo.
pause
goto menu

:do_use
echo.
set "prof_use="
set /p prof_use="Введите имя профиля: "
if defined prof_use (
    call gflow auth use "%prof_use%"
)
echo.
pause
goto menu

:do_exit
exit /b 0
