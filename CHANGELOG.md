# ZeroPanel 更新日志

## v2.1.0

### 重要变更

- **仓库统一为普通 Linux 版，移除 Termux 版**
  - 删除原 `zeropanel/`（Termux 轻量版）目录与 `zeropanel_v2.zip` 分发包
  - 原 `zeropanel-proot/`（Proot 高级版）移植为普通 Linux 版并更名为 `zeropanel/`
  - 仓库现只保留一个面向 Ubuntu / Debian 等 Linux 服务器的版本，不再区分 Termux / Proot
  - 不再使用独立的 `zeropanel_v2.zip` 分发包，安装与云更新改为从 GitHub 仓库
    `qinfei12/ZeroPanel` 的 `trae/agent-zipvKL` 分支下载 archive 并提取 `zeropanel/` 目录

- **服务管理适配普通 Linux（支持 systemd）**
  - 新增 systemd 检测：启动 / 停止服务时优先使用 `systemctl`，其次 `service`，最后回退直接启动守护进程
  - 兼容带 systemd 的常规 Linux 服务器、sysvinit 环境，以及无 systemd 的容器环境
  - 影响范围：`app.py` 的 `api_start_services`、`api_restart_php_fpm`，以及安装脚本与 `zeropanel` 快捷命令的服务启停逻辑

- **云更新地址与解压路径更新**
  - 云更新读取 `zeropanel/VERSION` 与 `zeropanel/CHANGELOG.md`，下载包改为 GitHub archive
  - 安装脚本与 `_safe_extract_update` 改为处理 `zeropanel/` 顶层目录或 GitHub archive 嵌套布局

- **统一安装入口简化**
  - 根目录 `install.sh` 不再区分 Termux / Proot，仅检测 Ubuntu / Debian Linux 后调用面板安装脚本

### 其他

- 移除代码与文档中所有 Termux / Proot / ZeroTermux 相关措辞，统一为「Linux 版」
- 系统信息中 `os` 默认值由 `Linux (proot)` 改为 `Linux`

---

## v2.0.7

### 新增功能

- **一键卸载**
  - 安装脚本新增 `--uninstall` / `uninstall` / `-u` 参数
  - 快捷命令 `zeropanel uninstall` 支持直接卸载
  - 卸载前自动备份 `data` 目录到带时间戳的备份文件夹
  - 卸载时先停止相关服务，避免残留进程

## v2.0.6

### 问题修复

- **安装部署路径错误**
  - 修复安装完成后面板无法启动的问题
  - 修复：解压到临时目录后，将面板目录移动到 `/var/lib/zeropanel`

## v2.0.5

### 问题修复

- **安装脚本环境检测**
  - 依据 `/etc/os-release` 的 `ID` 判断：Debian/Ubuntu 直接视为受支持环境

## v2.0.4

### 问题修复

- **系统监控**
  - 修复 CPU 使用率始终显示 0% 的问题（优先读取 `/proc/stat` 总 `cpu` 行）
  - 修复磁盘使用率始终显示 100% 的问题（改用 `os.statvfs('/')`）

## v2.0.3

### 问题修复

- **云更新自动备份**
  - 修复自动备份压缩包为空的问题，使用 `os.walk()` 重新实现目录遍历
  - 新增备份文件数量校验
- **面板重启**
  - 使用独立子进程执行两步重启：先结束旧进程释放端口，再启动新进程
- **版本与更新地址**
  - 版本号统一升级为 `2.0.3`，修正云更新分发包地址

## v2.0.2

### 新增功能

- **文件管理升级**
  - 新增文件在线解压：支持 zip、tar.gz、tar.bz2、tar.xz、tar
  - 新增文件在线压缩：支持 zip、tar.gz
- **数据库管理升级**
  - 创建网站时可勾选同时创建独立数据库
  - 删除网站时同步删除对应数据库
  - 新增重置网站数据库密码功能

## v2.0.0

### 新增功能

- **网站管理**：创建、编辑、删除网站，可指定端口号，支持 PHP 版本选择，自动生成 Nginx 配置
- **数据库管理**：创建、删除数据库，支持设置字符集，数据库备份与恢复，导入 .sql 文件
- **文件管理**：文件列表查看、上传与下载、目录创建、文件删除
- **系统监控**：CPU 使用率、内存使用情况、磁盘空间监控、系统负载、网络流量统计
- **云更新**：自动检查新版本、一键更新、自动备份、更新日志展示
- **安全特性**：用户登录认证、密码修改功能、会话管理

### 技术改进

- 使用 Flask Web 框架
- SQLite 数据库存储配置
- 响应式设计，支持移动端访问
- 现代化 UI 界面

### 兼容性

- 面向 Linux (Ubuntu / Debian) 服务器
- 支持 Nginx、MariaDB、PHP-FPM 服务管理
