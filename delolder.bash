#!/bin/bash


days=''
drrun=0
verb=0
helpmsg="delolder [-v|-d] N [--] dirs\n
-h | --help    = список доступных команд\n
-v | --verbose = список удаляемых файлов\n
-d | --dryrun  = список файлов, попадающих под удаление"
dirs=()


if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo -e "$helpmessage"
    exit 0
fi
if [[ "$1" == "-v" || "$1" == "--verbose" ]]; then
    verb=1
    shift
elif [[ "$1" == "-d" || "$1" == "--dryrun" ]]; then
    dry_run=1
    shift
fi
if [[ -z "$days" ]] && [[ "$1" =~ ^[0-9]+$ ]]; then
    days="$1"
    shift
else
    echo "Ошибка: ожидалось количество дней" >&2
    exit 1
fi
dirs=("$@")
if [ -z "$days" ]; then
    echo "Ошибка: не указано количество дней" >&2
    exit 1
fi
if [ ${#dirs[@]} -eq 0 ]; then
    echo "Ошибка: не указаны каталоги" >&2
    exit 1
fi
if ! [[ "$days" =~ ^[0-9]+$ ]] || [ "$days" -lt 0 ]; then
    echo "Ошибка: количество дней должно быть неотрицательным числом" >&2
    exit 1
fi
argforfind=()
[ $drrun -eq 1 ] || [ $verb -eq 1 ] && argforfind+=(-print)
[ $drr -eq 0 ] && argforfind+=(-exec rm -f {} +)
find "${dirs[@]}" -type f -mtime "+$days" "${argforfind[@]}"