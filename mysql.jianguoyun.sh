#!/usr/bin/env bash

# Author: falcon
# 对Mysql数据库备份

#获取当前目录
SCRIPT_DIR=$(dirname "$0")
#echo "$SCRIPT_DIR"
CONFIG=$SCRIPT_DIR/config.sh

if [ ! -f $CONFIG ];then
    echo ${CONFIG} not exist!
    exit 2
fi
source $CONFIG

if [ ! -d $BACKUP_MYSQL_DATE_DIR ];
then
    mkdir -p $BACKUP_MYSQL_DATE_DIR
fi

echo "Start backup to jgy Time : `date +%F" "%H:%M:%S`" >> $BACKUP_MYSQL_LOG

cp -r $BACKUP_MYSQL_DATE_DIR $JGY_MYSQL_DIR


echo "Stop jgy backup Time : `date +%F" "%H:%M:%S`" >> $BACKUP_MYSQL_LOG



#Delete old data
echo "###############################################################" >> $BACKUP_MYSQL_LOG
echo "Delete jgy expire data." >> $BACKUP_MYSQL_LOG
find ${JGY_MYSQL_DIR} -mtime +${EXPIRE_DB_DAYS} | xargs rm -rf
