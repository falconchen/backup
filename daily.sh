#!/usr/bin/env bash

# Author: falcon
# 对特定文件夹每日增量备份

#获取当前目录
BASEDIR=$(dirname "$0")
#echo "$BASEDIR"
CONFIG=$BASEDIR/config.sh

if [ ! -f $CONFIG ];then
    echo ${CONFIG} not exist!
    exit 2
fi
source $CONFIG


#Create Today BackupDirectory
if [ ! -d $BACK_BASE_DIR ];then
    mkdir -p $BACK_BASE_DIR
fi


#Rename Yestodaybackup DIR
if [ ! -d $BACK_TODAY_DIR ];
then
    mkdir -p $BACK_TODAY_DIR
else
    mv $BACK_TODAY_DIR $BACK_BASE_DIR/`date -r $BACK_TODAY_DIR "+%Y-%m-%d_%H%M%S"`
    mkdir -p $BACK_TODAY_DIR
fi
echo "Start Time : `date +%F" "%H:%M:%S`" >> $BACKUP_LOG

#backup files 
for name in ${!BACKUP_FROM_DIRS[@]}; do 
#printf "%s: %s\n" $name ${BACKUP_FROM_DIRS[$name]}; 
cd ${BACKUP_FROM_DIRS[$name]}
tar czvf $BACK_TODAY_DIR/$name.tgz -C ${BACKUP_FROM_DIRS[$name]} `find * -mtime -1 -type f -print` 1 >>$BACKUP_LOG 2>>$BACKUP_LOG
echo "finishing backup directory ${BACKUP_FROM_DIRS[$name]} to ${name}.tgz" >> $BACKUP_LOG
done

echo "Stop Time : `date +%F" "%H:%M:%S`" >> $BACKUP_LOG


#Delete old data
echo "###############################################################" >> $BACKUP_LOG
echo "Delete expire data." >> $BACKUP_LOG
echo "Start Time : `date +%F" "%H:%M:%S`" >> $BACKUP_LOG
find ${BACK_BASE_DIR} -mtime +${EXPIRE_DAYS} | xargs rm -rf
echo "Stop Time : `date +%F" "%H:%M:%S`" >> $BACKUP_LOG
