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

echo "Start Time : `date +%F" "%H:%M:%S`" > $BACKUP_MYSQL_LOG


cd $BACKUP_MYSQL_DATE_DIR
#Backup Mysql DB
echo "###############################################################" > $BACKUP_MYSQL_LOG
echo "Backup Mysql DB." >> $BACKUP_MYSQL_LOG
echo "Start Time : `date +%F" "%H:%M:%S`" >> $BACKUP_MYSQL_LOG
for db in ${MYSQL_DB[@]};do
/bin/mysqldump -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS --add-drop-table --databases $db > ${TODAY}_${db}_full_back.sql --log-error=$BACKUP_MYSQL_LOG
tar zcf ${TODAY}_${db}_full_back.sql.tar.gz ${TODAY}_${db}_full_back.sql
rm -rf ${TODAY}_${db}_full_back.sql
done

#copy to backup dir
BACKUP_DB_TODAY_DIR=$BACKUP_MYSQL_BASE_DIR/today
if [ ! -d $BACKUP_DB_TODAY_DIR ];
then  
  mkdir -p $BACKUP_DB_TODAY_DIR
else    
  rm -rf $BACKUP_DB_TODAY_DIR/*  
fi

cp $BACKUP_MYSQL_DATE_DIR/* $BACKUP_DB_TODAY_DIR

echo "Stop Time : `date +%F" "%H:%M:%S`" >> $BACKUP_MYSQL_LOG



#Delete old data
echo "###############################################################" >> $BACKUP_MYSQL_LOG
echo "Delete expire data." >> $BACKUP_MYSQL_LOG
echo "Start Time : `date +%F" "%H:%M:%S`" >> $BACKUP_MYSQL_LOG
find ${BACKUP_MYSQL_BASE_DIR} -mtime +${EXPIRE_DB_DAYS} | xargs rm -rf