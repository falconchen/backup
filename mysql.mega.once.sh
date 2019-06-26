#!/usr/bin/env bash

# Author: falcon
# 同步mysql备份目录到mega


#获取当前目录
SCRIPT_DIR=$(dirname "$0")
#echo "$SCRIPT_DIR"
CONFIG=$SCRIPT_DIR/config.sh

if [ ! -f $CONFIG ];then
    echo ${CONFIG} not exist!
    exit 2
fi
source $CONFIG

BACKUP_DB_TODAY_DIR=$BACKUP_MYSQL_BASE_DIR/today
if [ ! -d $BACKUP_DB_TODAY_DIR ];
then  
  mkdir -p $BACKUP_DB_TODAY_DIR
fi


#mega-cmd check
if command -v mega-backup >/dev/null 2>&1; then 
  echo 'mega-backup exists' 
else 
  echo 'mega-backup not exists'
  exit 2
fi

mega-backup $BACKUP_DB_TODAY_DIR ${MEGA_MYSQL_DIR}  --period="59 59 15 * * *" --num-backups=${EXPIRE_DB_DAYS}
