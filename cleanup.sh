#!/bin/bash

# Проверяем, передан ли путь к директории
if [ -z "$1" ]; then
    echo "Ошибка: путь к директории не указан."
    exit 1
fi

DIR="$1"

# Проверяем, существует ли директория
if [ -d "$DIR" ]; then
    # Удаляем файлы с расширениями .bak, .tmp, .backup
    find "$DIR" -type f \( -name "*.bak" -o -name "*.tmp" -o -name "*.backup" \) -exec rm -f {} +
    echo "Очистка директории '$DIR' выполнена."
else
    echo "Ошибка: директория '$DIR' не существует."
    exit 1
fi
