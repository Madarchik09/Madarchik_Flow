@echo off
chcp 65001 >nul
title Madarchik_Flow - Быстрая установка (Windows)
cd /d "%~dp0"

echo ========================================================
echo       Madarchik_Flow - Установка в 1 клик
echo ========================================================
echo.

where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ОШИБКА] Python не найден в системе!
    echo Установите Python 3.11 или выше с сайта python.org (обязательно отметьте "Add python.exe to PATH").
    echo.
    pause
    exit /b 1
)

echo [1/4] Проверка виртуального окружения (.venv)...
if not exist ".venv" (
    echo Создание локального виртуального окружения...
    python -m venv .venv
    if %errorlevel% neq 0 (
        echo [ОШИБКА] Не удалось создать .venv!
        pause
        exit /b 1
    )
) else (
    echo Виртуальное окружение уже существует.
)

echo.
echo [2/4] Активация окружения...
call .venv\Scripts\activate.bat

echo.
echo [3/4] Установка пакета Madarchik_Flow и зависимостей...
python -m pip install --upgrade pip
pip install -e .
if %errorlevel% neq 0 (
    echo [ОШИБКА] Сбой при установке зависимостей!
    pause
    exit /b 1
)

echo.
echo [4/4] Инициализация компонентов браузера Playwright...
playwright install chromium

echo.
echo ========================================================
echo      Установка успешно завершена!
echo ========================================================
echo.
echo Теперь вам нужно авторизовать хотя бы один Google-аккаунт.
echo.
set /p run_auth="Запустить Auth.bat прямо сейчас? [Y/N]: "
if /i "%run_auth%"=="Y" (
    call "%~dp0Auth.bat"
) else (
    echo Вы можете запустить Auth.bat в любой момент вручную.
    pause
)
