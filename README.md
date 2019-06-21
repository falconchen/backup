# Server Backup Scripts

自用备份脚本 ,支持全量备份,增量备份,将备份内容存储到[mega网盘](https://mega.nz)

- `daily.sh` : 每日增量备份特定目录
- `daily.mega.sh` 每日增量备份特定目录并上传到 mega网盘. 请先安装 [mega-cmd](https://mega.nz/cmd) ,文档见 <https://github.com/meganz/MEGAcmd>
- `full.sh` 全量备份
-  `mysql.mega.once.sh` 定时备份mysql导出的SQL文件至mega网盘, 只需运行一次.

## 用法:

1. 将`config.sample.sh` 复制一份并重命为`config.sh`,填写相关配置信息.

2. 加入crontab ,例如：

    ```
    58 23 * * * /web/cmd/backup/mysql.sh >/dev/null 2>&1
    59 23 * * * /web/cmd/backup/daily.mega.sh >/dev/null 2>&1
    ```

## 其他:
安装 `mega-cmd` 部分库文件缺失的问题,以 `centos7` 为例
```
error: Failed dependencies:
	libcares.so.2()(64bit) is needed by megacmd-1.1.0-1.2.x86_64
	libcrypto.so.10(OPENSSL_1.0.2)(64bit) is needed by megacmd-1.1.0-1.2.x86_64
```

缺少 `libcares.so.2` :
```
yum install -y c-ares
```

缺少 `libcrypto.so.10`

```
yum install openssl-libs

```

