#!/usr/bin/env bash
#配置文件


TODAY=`date -I` # 获取当前日期
#EXPIRE_DAYS=`date -d -7day +"%Y-%m-%d"` # 获取7天前的日期
EXPIRE_DAYS=7 #保留备份数
BACKUP_DAILY_BASE_DIR=/home/backups/daily # 每日备份基本目录
BACKUP_TODAY_DIR=$BACKUP_DAILY_BASE_DIR/today # 当天备份存放的目录
BACKUP_DAILY_LOG=$BACKUP_DAILY_BASE_DIR/daily_${TODAY}.log # 每日备份日志,存放于备份目录下

declare -A BACKUP_FROM_DIRS
BACKUP_FROM_DIRS=([a_uploads]='/var/www/html/a/uploads' [b_uploads]='/var/www/html/b/uploads/' [db_backups]='/var/www/dbbackup')


BACKUP_FULL_BASE_DIR=/home/backups/full #完整备份存放文件夹
BACKUP_FULL_DATE_DIR=$BACKUP_FULL_BASE_DIR/$TODAY # 完整备份存放的按日期存放目录
BACKUP_FULL_LOG=$BACKUP_FULL_BASE_DIR/full_${TODAY}.log # 每日备份日志,存放于备份目录下
