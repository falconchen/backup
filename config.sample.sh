#!/usr/bin/env bash
#配置文件


TODAY=`date -I` # 获取当前日期
#EXPIRE_DAYS=`date -d -7day +"%Y-%m-%d"` # 获取7天前的日期
EXPIRE_DAYS=7 #保留备份数
BACK_BASE_DIR=/home/backups/daily # 每日备份基本目录
BACK_TODAY_DIR=$BACK_BASE_DIR/today # 当天备份存放的目录
BACKUP_LOG=$BACK_BASE_DIR/daily_${TODAY}.log # 备份日志,存放于备份目录下

declare -A BACKUP_FROM_DIRS
BACKUP_FROM_DIRS=([a_uploads]='/var/www/html/a/uploads' [b_uploads]='/var/www/html/b/uploads/' [db_backups]='/var/www/dbbackup')
