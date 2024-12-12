#!/bin/bash

# Проверяем, передан ли путь к папке
if [ -z "$1" ]; then
    echo "Ошибка: укажите путь к директории."
    exit 1
fi

DIR="$1"

# Создаем папки для сортировки
TODAY_DIR="$DIR/Today"
WEEK_DIR="$DIR/This_Week"
OLDER_DIR="$DIR/Older"

mkdir -p "$TODAY_DIR" "$WEEK_DIR" "$OLDER_DIR"

# Проходим по всем файлам в папке
find "$DIR" -maxdepth 1 -type f | while read FILE; do
    CREATION_DATE=$(stat -f %B "$FILE") # Для macOS, используйте %Y для Linux
    CURRENT_DATE=$(date +%s)
    AGE=$(( (CURRENT_DATE - CREATION_DATE) / 86400 ))

    if [ $AGE -eq 0 ]; then
        mv "$FILE" "$TODAY_DIR/"
    elif [ $AGE -le 7 ]; then
        mv "$FILE" "$WEEK_DIR/"
    else
        mv "$FILE" "$OLDER_DIR/"
    fi
done

echo "Сортировка завершена."
