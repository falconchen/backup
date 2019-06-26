# Server Backup Scripts

自用备份脚本 ,支持全量备份,增量备份,将备份内容存储到[mega网盘](https://mega.nz)

- `daily.sh` : 每日增量备份特定目录
- `daily.mega.sh` 每日增量备份特定目录并上传到 mega网盘. 请先安装 [mega-cmd](https://mega.nz/cmd) ,文档见 <https://github.com/meganz/MEGAcmd> ，并且登录帐户。
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

### mega初始化登录，使用命令行，登陆 `mega.nz`。可以选择交互模式与非交互方式。这里使用非交互方式，执行：
```
mega-login  your-email your-password
```

### mega列出备份任务

``` 
mega-backup -l
```
输出
```
TAG   LOCALPATH                                                    REMOTEPARENTPATH                                                     STATUS
5     /backups/mysql/2019-06-21                                    /sites/txhost/mysql
```
### mega取消备份任务```mega-backup -d TAG```

按上面的输出任务tag是 `5`, 因此取消上述任务为：
```
mega-backup -d 5
```
成功取消
```
Backup removed succesffuly: 5
```

### 安装 `mega-cmd` 部分库文件缺失的问题,以 `centos7` 为例
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

