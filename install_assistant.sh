#!/bin/bash

# Проверка на запуск от имени root (нужно для управления ufw и установки)
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт через sudo"
  exit
fi

echo "--- Отключение UFW ---"
ufw disable

echo "--- Отключение ЗПС ---"
astra-digsig-control disable

echo "--- Замена на сетевые репозитории ---"
bash -c 'cat << EOF > /etc/apt/sources.list
deb https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-main/ 1.7_x86-64 main contrib non-free
deb https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-update/ 1.7_x86-64 main contrib non-free
deb https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-base/ 1.7_x86-64 main contrib non-free
deb https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-extended/ 1.7_x86-64 main contrib non-free
EOF'

echo "--- Получение списка пакетов ---"
apt update

echo "--- Скачивание ассистента ---"
# Используем -O для сохранения файла под понятным именем
wget -O assistant.deb https://lk2.мойассистент.рф/WebApi/Platforms/Download/1375

echo "--- Установка пакета ---"
# Установка через apt позволяет автоматически подтянуть недостающие зависимости
apt install ./assistant.deb -y

echo "--- Готово! ---"

#seconds=10
#echo "Внимание! Компьютер перезагрузится через $seconds секунд."

#while [ $seconds -gt 0 ]; do
#    echo -ne "Осталось: $seconds сек. \r"
#    sleep 1
#    : $((seconds--))
#done

#echo -e "\nВыполняю перезагрузку..."
#reboot now
