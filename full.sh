#!/usr/bin/env bash

# Author: falcon
# 对特定文件夹完整备份

#获取当前目录
SCRIPT_DIR=$(dirname "$0")
#echo "$SCRIPT_DIR"
CONFIG=$SCRIPT_DIR/config.sh

if [ ! -f $CONFIG ];then
    echo ${CONFIG} not exist!
    exit 2
fi
source $CONFIG


if [ ! -d $BACKUP_FULL_DATE_DIR ];
then
    mkdir -p $BACKUP_FULL_DATE_DIR
fi

echo "Start Time : `date +%F" "%H:%M:%S`" > $BACKUP_FULL_LOG

#backup files 
for name in ${!BACKUP_FROM_DIRS[@]}; do 
#printf "%s: %s\n" $name ${BACKUP_FROM_DIRS[$name]}; 
cd ${BACKUP_FROM_DIRS[$name]}
tar czvf $BACKUP_FULL_DATE_DIR/$name.tgz -C ${BACKUP_FROM_DIRS[$name]} `find *  -type f -print` 1 >>$BACKUP_DAILY_LOG 2>>$BACKUP_FULL_LOG
echo "finishing backup directory ${BACKUP_FROM_DIRS[$name]} to ${name}.tgz" >> $BACKUP_FULL_LOG
done

echo "Stop Time : `date +%F" "%H:%M:%S`" >> $BACKUP_FULL_LOG
