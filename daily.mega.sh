#!/usr/bin/env bash

# Author: falcon
# 对特定文件夹每日增量备份后上传到mega.nz


#获取当前目录
SCRIPT_DIR=$(dirname "$0")

DAILY=$SCRIPT_DIR/daily.sh
if [ ! -f $DAILY ];then
    echo ${DAILY} not exist! >> $BACKUP_DAILY_LOG
    exit 2
fi
source $DAILY

#mega-cmd check
if command -v mega-put >/dev/null 2>&1; then 
  echo 'mega-put exists' >> $BACKUP_DAILY_LOG
else 
  echo 'mega-put not exists' >> $BACKUP_DAILY_LOG
  exit 2
fi

if [ ! -d $BACKUP_TODAY_DIR ];
then
  echo "Start Time : `date +%F" "%H:%M:%S`" >> $BACKUP_DAILY_LOG
  echo $BACKUP_TODAY_DIR not exists! 
  exit 2
else    
    #mega
    mega-put -c $BACKUP_TODAY_DIR/*.tgz $MEGA_DAILY_DIR 
fi
echo "Stop Time : `date +%F" "%H:%M:%S`" >> $BACKUP_DAILY_LOG