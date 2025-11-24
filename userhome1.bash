#!/bin/bash

anr_file="/etc/passwd"
Username=""

helpmessage="userhome [-f file] username
-f file = выбрать другой файл
--help = список доступных команд
--usage = список доступных команд"

if [[ "$1" == "--help" || "$1" == "--usage" ]]; then
    echo -e "$helpmessage"
    exit 0
fi

if [[ "$1" == "-f" ]]; then
    if [[ -z "$2" ]]; then
        echo "Нужен файл после -f" >&2
        echo -e "$helpmessage" >&2
        exit 1
    fi
    anr_file="$2"
    Username="$3"
else
    Username="$1"
fi

if [[ -z "$Username" ]]; then
    Username=$(whoami)
fi

if [[ ! -f "$anr_file" ]]; then
    echo "Error: File '$anr_file' not found" >&2
    exit 2
fi

home_dir=$(grep "^$Username:" "$anr_file" | cut -d: -f6)

if [[ -z "$home_dir" ]]; then
    echo "Error: User '$Username' not found" >&2
    exit 1
fi

echo "$home_dir"
exit 0
