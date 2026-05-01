# 若飞无人机巡防管控系统

基于 SpringBoot + Vue 前后端分离架构的无人机巡防信息化管理平台，实现设备管理、航线规划、任务模拟、结果归档的全流程业务闭环，集成 AI 大模型实现巡防图像智能识别与目标框选。

## 技术栈

| 层级 | 技术 |
|------|------|
| 后端框架 | SpringBoot 3.x + MyBatis |
| 前端框架 | Vue 2 + Element UI |
| 数据库 | MySQL 8.0+ |
| 认证 | JWT + RBAC 权限模型 |
| 地图 | 高德地图 JSAPI 2.0 |
| AI 识别 | 阿里千问 VL (Qwen2.5-VL-Max) |
| PDF 报告 | iText 7 |
| 构建工具 | Maven + Vue CLI |

## 功能模块

### 系统管理
- 用户登录 / JWT 令牌认证
- 角色权限控制（管理员 / 普通用户）
- 操作日志自动记录

### 无人机设备管理
- 设备信息 CRUD，设备编号唯一校验
- 设备状态管理（正常 / 维修中 / 已报废 / 任务中 / 离线）
- 设备-任务绑定保护，关联历史任务查询

### 巡防航线管理
- 高德地图可视化绘制航线，多点连线
- 航线库管理（保存、编辑、删除）
- 地图回显航线 + 点位拖拽微调
- 未完成任务绑定保护

### 巡防任务管理
- 任务创建（绑定设备 + 航线）、多维度校验
- 任务状态机：待执行 → 执行中 → 已完成 / 已取消
- 监控界面：无人机沿航线移动动画 + 实时进度 + 剩余时间
- 支持暂停 / 继续飞行，后端定时调度自动递增进度
- 状态变更记录时间线

### 结果管理与 AI 识别
- 任务完成自动生成结果记录（数据快照归档）
- 上传图片 → AI 自动分析识别 + 目标框选标注
- 服务端像素级绘制标注框
- 识别结果自动填充表单（概述 / 发现 / 处理 / 备注）
- PDF 报告导出 + Excel 批量导出
- 航线轨迹地图回显

### 首页数据大盘
- 设备 / 航线 / 任务 / 结果总数统计
- 设备状态分布饼图 + 近 7 天任务趋势折线图
- 今日待执行任务 + 本周完成任务
- 快捷入口跳转

## 项目结构

```
RuoAir/
├── ruoair-admin/          # 后端主模块（Controller + 配置）
├── ruoair-common/         # 公共模块（工具类、注解、基础类）
├── ruoair-framework/      # 框架模块（安全、数据源、配置）
├── ruoair-system/         # 系统业务模块
├── ruoair-uav/            # 无人机业务模块 ★
│   └── src/main/java/com/ruoair/uav/
│       ├── controller/    # 设备/航线/任务/结果/大盘接口
│       ├── service/       # 业务逻辑 + AI识别 + PDF导出 + 进度调度
│       ├── mapper/        # MyBatis 数据访问
│       └── domain/        # 实体类
├── ruoair-ui/             # 前端模块
│   └── src/
│       ├── views/uav/     # 无人机业务页面
│       │   ├── equipment/ # 设备管理
│       │   ├── route/     # 航线规划
│       │   ├── task/      # 任务管理+监控
│       │   └── result/    # 结果管理+AI识别
│       ├── views/dashboard/ # 首页大盘
│       └── api/uav/       # 接口封装
├── sql/
│   ├── ruoair.sql         # 数据库初始化脚本
│   └── patches/           # 增量补丁
└── doc/                   # 文档
```

## 快速开始

### 环境要求

| 软件 | 版本 |
|------|------|
| JDK | 17+ |
| Node.js | 14+ |
| MySQL | 8.0+ |
| Maven | 3.6+ |
| 高德地图 Key | [申请地址](https://console.amap.com) |
| 千问 API Key | [申请地址](https://dashscope.console.aliyun.com) |

### 1. 初始化数据库

```bash
mysql -u root -p < sql/ruoair.sql
```

### 2. 配置后端

复制配置模板并填入实际值：

```bash
cp ruoair-admin/src/main/resources/application.yml.template \
   ruoair-admin/src/main/resources/application.yml
```

编辑 `application.yml`，修改以下必填项：
- 数据库连接（`spring.datasource.url` / `username` / `password`）
- 文件上传路径（`ruoyi.profile`）
- AI 识别 API Key（`ai.qwen.api-key`）

### 3. 配置前端

```bash
cd ruoair-ui
cp .env.development.template .env.development
```

编辑 `.env.development`，填入高德地图 Key 和安全密钥。

### 4. 启动后端

```bash
# 在项目根目录
mvn clean install -DskipTests
cd ruoair-admin
mvn spring-boot:run
```

后端启动后访问：http://localhost:8081

### 5. 启动前端

```bash
cd ruoair-ui
npm install
npm run dev
```

前端启动后访问：http://localhost:80

默认管理员账号：`admin` / `admin123`

### 6. 初始化演示数据（可选）

```bash
mysql -u root -p ruoair < sql/patches/demo_data_reset.sql
```

导入 25 条设备 / 25 条航线 / 25 条任务 / 25 条结果记录，覆盖所有状态。

## 配置说明

### 必须配置项

| 配置项 | 位置 | 说明 |
|--------|------|------|
| 数据库连接 | `application.yml` → `spring.datasource` | MySQL 连接信息 |
| 文件上传路径 | `application.yml` → `ruoyi.profile` | 图片等文件存储目录 |
| 高德地图 Key | `ruoair-ui/.env.development` → `VUE_APP_AMAP_KEY` | 地图加载必需 |
| 千问 API Key | `application.yml` → `ai.qwen.api-key` | AI 识别功能必需 |

### 可选配置项

| 配置项 | 说明 |
|--------|------|
| `ai.qwen.enabled` | 是否启用 AI 识别（默认 false） |
| `ai.qwen.model` | AI 模型（推荐 qwen-vl-max） |
| JWT 密钥 | `application.yml` → `token.secret` |

## 数据库表

| 表名 | 说明 |
|------|------|
| `sys_uav_equipment` | 无人机设备表 |
| `sys_uav_route` | 巡防航线表（含坐标 JSON） |
| `sys_uav_task` | 巡防任务表（含状态变更记录） |
| `sys_uav_result` | 巡防结果表（含数据快照 + AI 图片） |
