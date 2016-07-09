#!/bin/bash

func_usage() {
  echo "Usage: `basename $0` {log_dir}"
  return 0
}

if [ $# -lt 1 ]; then
  func_usage
  exit 1
fi

DIR_LOG="$1"

cd ${DIR_LOG}
for FILE in mysql-*; do
  if [ ${FILE##*.} != "log" ]; then
    mv -f ${FILE} ${FILE%.*}.`date -r ${FILE} +'%Y%m%d_%H%M%S'`
  fi
done
