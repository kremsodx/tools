#!/bin/bash

# Проверка на запуск от имени root (нужно для управления ufw и установки)
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт через sudo"
  exit
fi

echo "--- Отключение UFW ---"
ufw disable

echo "--- Скачивание ассистента ---"
# Используем -O для сохранения файла под понятным именем
wget -O assistant.deb https://lk2.мойассистент.рф/WebApi/Platforms/Download/1375

echo "--- Установка пакета ---"
# Установка через apt позволяет автоматически подтянуть недостающие зависимости
apt install ./assistant.deb -y

echo "--- Готово! ---"
