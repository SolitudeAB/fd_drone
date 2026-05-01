/*
 Navicat Premium Data Transfer

 Source Server         : jiax
 Source Server Type    : MySQL
 Source Server Version : 90200 (9.2.0)
 Source Host           : localhost:3306
 Source Schema         : ruoair

 Target Server Type    : MySQL
 Target Server Version : 90200 (9.2.0)
 File Encoding         : 65001

 Date: 29/04/2026 15:56:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int NULL DEFAULT 1 COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'sys_uav_equipment', '无人机设备表', NULL, NULL, 'SysUavEquipment', 'crud', 'element-ui', 'com.ruoair.uav', 'uav', 'equipment', '无人机设备', 'ruoyi', 1, '0', '/', '{\"genView\":\"0\",\"parentMenuId\":0}', 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13', NULL);
INSERT INTO `gen_table` VALUES (2, 'sys_uav_result', '巡航结果表', NULL, NULL, 'SysUavResult', 'crud', 'element-ui', 'com.ruoair.uav', 'uav', 'result', '巡航结果', 'jiax', 1, '0', '/', '{\"genView\":\"0\",\"parentMenuId\":0}', 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09', NULL);
INSERT INTO `gen_table` VALUES (3, 'sys_uav_route', '巡航航线表', NULL, NULL, 'SysUavRoute', 'crud', 'element-ui', 'com.ruoair.uav', 'uav', 'route', '巡航航线', 'jaix', 1, '0', '/', '{\"genView\":\"0\",\"parentMenuId\":0}', 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05', NULL);
INSERT INTO `gen_table` VALUES (4, 'sys_uav_task', '巡航任务表', NULL, NULL, 'SysUavTask', 'crud', 'element-ui', 'com.ruoair.uav', 'uav', 'task', '巡航任务', 'jiax', 1, '0', '/', '{\"genView\":\"0\",\"parentMenuId\":0}', 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'equipment_id', '设备ID', 'bigint', 'Long', 'equipmentId', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (2, 1, 'equipment_code', '设备编号', 'varchar(64)', 'String', 'equipmentCode', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (3, 1, 'equipment_name', '设备名称', 'varchar(100)', 'String', 'equipmentName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (4, 1, 'equipment_model', '设备型号', 'varchar(100)', 'String', 'equipmentModel', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (5, 1, 'flight_duration', '续航时长', 'int', 'Long', 'flightDuration', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (6, 1, 'status', '设备状态', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_uav_status', 6, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (7, 1, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (8, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (9, 1, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (10, 1, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (11, 1, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '0', NULL, 'EQ', 'textarea', '', 11, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:28:13');
INSERT INTO `gen_table_column` VALUES (12, 2, 'result_id', '结果ID', 'bigint', 'Long', 'resultId', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (13, 2, 'result_code', '结果编号', 'varchar(64)', 'String', 'resultCode', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (14, 2, 'task_id', '任务ID', 'bigint', 'Long', 'taskId', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (15, 2, 'overview', '巡航概述', 'varchar(500)', 'String', 'overview', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'textarea', '', 4, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (16, 2, 'findings', '发现情况', 'text', 'String', 'findings', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'textarea', '', 5, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (17, 2, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (18, 2, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (19, 2, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (20, 2, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (21, 2, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '0', NULL, 'EQ', 'textarea', '', 10, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:34:09');
INSERT INTO `gen_table_column` VALUES (22, 3, 'route_id', '航线ID', 'bigint', 'Long', 'routeId', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (23, 3, 'route_name', '航线名称', 'varchar(100)', 'String', 'routeName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (24, 3, 'estimated_time', '预计时长', 'int', 'Long', 'estimatedTime', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 3, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (25, 3, 'flight_altitude', '飞行高度', 'decimal(10,2)', 'BigDecimal', 'flightAltitude', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (26, 3, 'route_points', '航线点位', 'text', 'String', 'routePoints', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'textarea', '', 5, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (27, 3, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (28, 3, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (29, 3, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (30, 3, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (31, 3, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '0', NULL, 'EQ', 'textarea', '', 10, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:36:05');
INSERT INTO `gen_table_column` VALUES (32, 4, 'task_id', '任务ID', 'bigint', 'Long', 'taskId', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (33, 4, 'task_name', '任务名称', 'varchar(100)', 'String', 'taskName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (34, 4, 'equipment_id', '设备ID', 'bigint', 'Long', 'equipmentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (35, 4, 'route_id', '航线ID', 'bigint', 'Long', 'routeId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (36, 4, 'task_status', '任务状态', 'char(1)', 'String', 'taskStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_uav_task_status', 5, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (37, 4, 'start_time', '开始时间', 'datetime', 'Date', 'startTime', '0', '0', '0', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 6, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (38, 4, 'end_time', '结束时间', 'datetime', 'Date', 'endTime', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 7, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (39, 4, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (40, 4, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (41, 4, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (42, 4, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');
INSERT INTO `gen_table_column` VALUES (43, 4, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '0', NULL, 'EQ', 'textarea', '', 12, 'admin', '2026-04-25 10:52:16', '', '2026-04-25 11:38:21');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-04-24 23:33:24', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-04-24 23:33:24', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-04-24 23:33:24', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-04-24 23:33:24', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-04-24 23:33:24', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-04-24 23:33:24', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-04-24 23:33:24', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-04-24 23:33:24', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (9, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2026-04-24 23:33:24', '', NULL, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '正常', '0', 'sys_uav_status', NULL, 'success', 'N', '0', 'admin', '2026-04-25 10:56:43', 'admin', '2026-04-25 19:30:54', NULL);
INSERT INTO `sys_dict_data` VALUES (101, 1, '维修中', '1', 'sys_uav_status', NULL, 'warning', 'N', '0', 'admin', '2026-04-25 10:56:55', 'admin', '2026-04-25 19:31:03', NULL);
INSERT INTO `sys_dict_data` VALUES (102, 2, '已报废', '2', 'sys_uav_status', NULL, 'danger', 'N', '0', 'admin', '2026-04-25 10:57:17', 'admin', '2026-04-25 19:31:18', NULL);
INSERT INTO `sys_dict_data` VALUES (103, 0, '待执行', '0', 'sys_uav_task_status', NULL, 'default', 'N', '0', 'admin', '2026-04-25 10:57:38', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 1, '执行中', '1', 'sys_uav_task_status', NULL, 'default', 'N', '0', 'admin', '2026-04-25 10:57:50', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 2, '已完成', '2', 'sys_uav_task_status', NULL, 'default', 'N', '0', 'admin', '2026-04-25 10:57:58', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 3, '已取消', '3', 'sys_uav_task_status', NULL, 'default', 'N', '0', 'admin', '2026-04-25 10:58:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 3, '任务中', '3', 'sys_uav_status', NULL, 'primary', 'N', '0', 'admin', '2026-04-25 18:22:54', 'admin', '2026-04-25 19:31:13', NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-04-24 23:33:24', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '设备状态', 'sys_uav_status', '0', 'admin', '2026-04-25 10:55:52', 'admin', '2026-04-25 18:22:42', '0-正常, 1-维修中, 2-已报废, 3-任务中');
INSERT INTO `sys_dict_type` VALUES (101, '任务状态', 'sys_uav_task_status', '0', 'admin', '2026-04-25 10:56:06', '', NULL, '0-待执行, 1-执行中, 2-已完成, 3-已取消');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-04-24 23:33:24', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-04-24 23:33:24', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-04-24 23:33:24', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 127 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-24 23:39:48');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 00:20:44');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 10:52:02');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '10.133.61.222', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 13:16:08');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '10.133.61.222', '内网IP', 'Edge 147', 'Windows >=10', '0', '退出成功', '2026-04-25 14:02:56');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '10.133.61.222', '内网IP', 'Edge 147', 'Windows >=10', '1', '用户不存在/密码错误', '2026-04-25 14:03:02');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '10.133.61.222', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 14:03:10');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 14:08:57');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 16:31:13');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 18:07:57');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 19:14:00');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-04-25 21:12:23');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-04-25 21:12:23');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-04-25 21:12:24');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 21:12:27');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 22:15:05');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-25 22:30:36');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-26 10:04:24');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-04-26 10:19:01');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-26 10:19:03');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-26 15:42:44');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码错误', '2026-04-26 15:42:44');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-26 17:00:45');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '1', '验证码已失效', '2026-04-26 17:04:54');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-26 17:04:54');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-26 19:16:33');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Edge 147', 'Windows >=10', '0', '登录成功', '2026-04-26 21:48:36');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2024 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 5, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-04-24 23:33:23', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 6, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-04-24 23:33:23', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 7, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-04-24 23:33:23', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-04-24 23:33:23', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-04-24 23:33:23', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-04-24 23:33:23', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-04-24 23:33:23', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-04-24 23:33:23', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-04-24 23:33:23', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-04-24 23:33:23', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-04-24 23:33:23', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-04-24 23:33:23', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-04-24 23:33:23', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-04-24 23:33:23', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-04-24 23:33:23', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-04-24 23:33:23', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-04-24 23:33:23', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-04-24 23:33:23', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-04-24 23:33:23', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-04-24 23:33:23', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-04-24 23:33:23', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '无人机设备', 0, 1, 'equipment', 'uav/equipment/index', NULL, '', 1, 0, 'C', '0', '0', 'uav:equipment:list', '#', 'admin', '2026-04-25 11:48:53', '', NULL, '无人机设备菜单');
INSERT INTO `sys_menu` VALUES (2001, '无人机设备查询', 2000, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:equipment:query', '#', 'admin', '2026-04-25 11:48:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '无人机设备新增', 2000, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:equipment:add', '#', 'admin', '2026-04-25 11:48:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '无人机设备修改', 2000, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:equipment:edit', '#', 'admin', '2026-04-25 11:48:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '无人机设备删除', 2000, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:equipment:remove', '#', 'admin', '2026-04-25 11:48:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '无人机设备导出', 2000, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:equipment:export', '#', 'admin', '2026-04-25 11:48:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '巡航结果', 0, 4, 'result', 'uav/result/index', NULL, '', 1, 0, 'C', '0', '0', 'uav:result:list', '#', 'admin', '2026-04-25 11:49:00', '', NULL, '巡航结果菜单');
INSERT INTO `sys_menu` VALUES (2007, '巡航结果查询', 2006, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:result:query', '#', 'admin', '2026-04-25 11:49:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '巡航结果新增', 2006, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:result:add', '#', 'admin', '2026-04-25 11:49:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '巡航结果修改', 2006, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:result:edit', '#', 'admin', '2026-04-25 11:49:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '巡航结果删除', 2006, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:result:remove', '#', 'admin', '2026-04-25 11:49:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '巡航结果导出', 2006, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:result:export', '#', 'admin', '2026-04-25 11:49:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '巡航航线', 0, 2, 'route', 'uav/route/index', NULL, '', 1, 0, 'C', '0', '0', 'uav:route:list', '#', 'admin', '2026-04-25 11:49:08', '', NULL, '巡航航线菜单');
INSERT INTO `sys_menu` VALUES (2013, '巡航航线查询', 2012, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:route:query', '#', 'admin', '2026-04-25 11:49:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '巡航航线新增', 2012, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:route:add', '#', 'admin', '2026-04-25 11:49:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '巡航航线修改', 2012, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:route:edit', '#', 'admin', '2026-04-25 11:49:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '巡航航线删除', 2012, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:route:remove', '#', 'admin', '2026-04-25 11:49:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '巡航航线导出', 2012, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:route:export', '#', 'admin', '2026-04-25 11:49:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '巡航任务', 0, 3, 'task', 'uav/task/index', NULL, '', 1, 0, 'C', '0', '0', 'uav:task:list', '#', 'admin', '2026-04-25 11:49:15', '', NULL, '巡航任务菜单');
INSERT INTO `sys_menu` VALUES (2019, '巡航任务查询', 2018, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:task:query', '#', 'admin', '2026-04-25 11:49:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '巡航任务新增', 2018, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:task:add', '#', 'admin', '2026-04-25 11:49:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '巡航任务修改', 2018, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:task:edit', '#', 'admin', '2026-04-25 11:49:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '巡航任务删除', 2018, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:task:remove', '#', 'admin', '2026-04-25 11:49:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '巡航任务导出', 2018, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'uav:task:export', '#', 'admin', '2026-04-25 11:49:15', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-04-24 23:33:24', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-04-24 23:33:24', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (3, '若依开源框架介绍', '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C666F6E7420636F6C6F723D2223333333333333223E52756F5969E5BC80E6BA90E9A1B9E79BAEE698AFE4B8BAE4BC81E4B89AE794A8E688B7E5AE9AE588B6E79A84E5908EE58FB0E8849AE6898BE69EB6E6A186E69EB6EFBC8CE4B8BAE4BC81E4B89AE68993E980A0E79A84E4B880E7AB99E5BC8FE8A7A3E586B3E696B9E6A188EFBC8CE9998DE4BD8EE4BC81E4B89AE5BC80E58F91E68890E69CACEFBC8CE68F90E58D87E5BC80E58F91E69588E78E87E38082E4B8BBE8A681E58C85E68BACE794A8E688B7E7AEA1E79086E38081E8A792E889B2E7AEA1E79086E38081E983A8E997A8E7AEA1E79086E38081E88F9CE58D95E7AEA1E79086E38081E58F82E695B0E7AEA1E79086E38081E5AD97E585B8E7AEA1E79086E380813C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE5B297E4BD8DE7AEA1E790863C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E5AE9AE697B6E4BBBBE58AA13C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE380813C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE69C8DE58AA1E79B91E68EA7E38081E799BBE5BD95E697A5E5BF97E38081E6938DE4BD9CE697A5E5BF97E38081E4BBA3E7A081E7949FE68890E7AD89E58A9FE883BDE38082E585B6E4B8ADEFBC8CE8BF98E694AFE68C81E5A49AE695B0E68DAEE6BA90E38081E695B0E68DAEE69D83E99990E38081E59BBDE99985E58C96E380815265646973E7BC93E5AD98E38081446F636B6572E983A8E7BDB2E38081E6BB91E58AA8E9AA8CE8AF81E7A081E38081E7ACACE4B889E696B9E8AEA4E8AF81E799BBE5BD95E38081E58886E5B883E5BC8FE4BA8BE58AA1E380813C2F7370616E3E3C666F6E7420636F6C6F723D2223333333333333223EE58886E5B883E5BC8FE69687E4BBB6E5AD98E582A83C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E58886E5BA93E58886E8A1A8E5A484E79086E7AD89E68A80E69CAFE789B9E782B9E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D2268747470733A2F2F666F727564612E67697465652E636F6D2F696D616765732F313737333933313834383334323433393033322F61346432323331335F313831353039352E706E6722207374796C653D2277696474683A20363470783B223E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE5AE98E7BD91E58F8AE6BC94E7A4BA3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE5AE98E7BD91E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F72756F79692E7669703C2F613E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E3C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE69687E6A1A3E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F646F632E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F646F632E72756F79692E7669703C2F613E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E4B88DE58886E7A6BBE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F64656D6F2E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F64656D6F2E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E58886E7A6BBE78988E69CACE38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F7675652E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F7675652E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E5BEAEE69C8DE58AA1E78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F636C6F75642E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F636C6F75642E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E7A7BBE58AA8E7ABAFE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F68352E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F68352E72756F79692E7669703C2F613E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-04-24 23:33:24', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告已读记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 385 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-04-25 00:22:55', 28);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-04-25 00:23:04', 8);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-04-25 00:24:23', 9);
INSERT INTO `sys_oper_log` VALUES (103, '角色管理', 2, 'com.ruoair.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-04-24 23:33:23\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:27:00', 73);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:27:08', 16);
INSERT INTO `sys_oper_log` VALUES (105, '角色管理', 2, 'com.ruoair.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-04-24 23:33:23\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:27:52', 32);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/103', '127.0.0.1', '内网IP', '103 ', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2026-04-25 00:28:04', 4);
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1016', '127.0.0.1', '内网IP', '1016 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:09', 13);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1017', '127.0.0.1', '内网IP', '1017 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:11', 14);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1018', '127.0.0.1', '内网IP', '1018 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:13', 13);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1019', '127.0.0.1', '内网IP', '1019 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:15', 14);
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/103', '127.0.0.1', '内网IP', '103 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:18', 16);
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1020', '127.0.0.1', '内网IP', '1020 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:21', 11);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1021', '127.0.0.1', '内网IP', '1021 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:23', 11);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1022', '127.0.0.1', '内网IP', '1022 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:24', 16);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1023', '127.0.0.1', '内网IP', '1023 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:26', 12);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1024', '127.0.0.1', '内网IP', '1024 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:28', 14);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 3, 'com.ruoair.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/104', '127.0.0.1', '内网IP', '104 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:28:29', 13);
INSERT INTO `sys_oper_log` VALUES (118, '用户管理', 1, 'com.ruoair.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"NPC1\",\"params\":{},\"roleIds\":[2],\"status\":\"正常\",\"userName\":\"NPC1\"} ', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\r\n### The error may exist in file [E:\\FZU\\fd_drone\\20260423161654\\RuoAir\\ruoair-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoair.system.mapper.SysUserMapper.insertUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user(                  user_name,       nick_name,                               password,       status,             create_by,            create_time    )values(                  ?,       ?,                               ?,       ?,             ?,            sysdate()    )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\n; Data truncation: Data too long for column \'status\' at row 1', '2026-04-25 00:33:31', 979);
INSERT INTO `sys_oper_log` VALUES (119, '用户管理', 1, 'com.ruoair.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"NPC1\",\"params\":{},\"roleIds\":[],\"status\":\"正常\",\"userName\":\"NPC1\"} ', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\r\n### The error may exist in file [E:\\FZU\\fd_drone\\20260423161654\\RuoAir\\ruoair-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoair.system.mapper.SysUserMapper.insertUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user(                  user_name,       nick_name,                               password,       status,             create_by,            create_time    )values(                  ?,       ?,                               ?,       ?,             ?,            sysdate()    )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\n; Data truncation: Data too long for column \'status\' at row 1', '2026-04-25 00:33:52', 143);
INSERT INTO `sys_oper_log` VALUES (120, '用户管理', 1, 'com.ruoair.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"NPC1\",\"params\":{},\"roleIds\":[2],\"status\":\"0\",\"userId\":100,\"userName\":\"NPC1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:36:28', 159);
INSERT INTO `sys_oper_log` VALUES (121, '用户管理', 1, 'com.ruoair.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"NPC2\",\"params\":{},\"roleIds\":[],\"status\":\"正常\",\"userName\":\"NPC2\"} ', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\r\n### The error may exist in file [E:\\FZU\\fd_drone\\20260423161654\\RuoAir\\ruoair-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoair.system.mapper.SysUserMapper.insertUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user(                  user_name,       nick_name,                               password,       status,             create_by,            create_time    )values(                  ?,       ?,                               ?,       ?,             ?,            sysdate()    )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\n; Data truncation: Data too long for column \'status\' at row 1', '2026-04-25 00:37:22', 142);
INSERT INTO `sys_oper_log` VALUES (122, '用户管理', 1, 'com.ruoair.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"NPC2\",\"params\":{},\"roleIds\":[2],\"status\":\"0\",\"userId\":101,\"userName\":\"NPC2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:37:30', 157);
INSERT INTO `sys_oper_log` VALUES (123, '用户管理', 1, 'com.ruoair.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"NPC3\",\"params\":{},\"roleIds\":[],\"status\":\"0\",\"userId\":102,\"userName\":\"NPC3\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 00:41:56', 147);
INSERT INTO `sys_oper_log` VALUES (124, '代码生成', 6, 'com.ruoair.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"sys_uav_equipment,sys_uav_result,sys_uav_route,sys_uav_task\",\"tplWebType\":\"element-ui\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:52:16', 275);
INSERT INTO `sys_oper_log` VALUES (125, '字典类型', 1, 'com.ruoair.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"设备状态\",\"dictType\":\"sys_uav_status\",\"params\":{},\"remark\":\"0-正常, 1-维修, 2-停用\",\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:55:52', 19);
INSERT INTO `sys_oper_log` VALUES (126, '字典类型', 1, 'com.ruoair.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"任务状态\",\"dictType\":\"sys_uav_task_status\",\"params\":{},\"remark\":\"0-待执行, 1-执行中, 2-已完成, 3-已取消\",\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:56:06', 16);
INSERT INTO `sys_oper_log` VALUES (127, '字典数据', 1, 'com.ruoair.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"正常\",\"dictSort\":0,\"dictType\":\"sys_uav_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:56:43', 16);
INSERT INTO `sys_oper_log` VALUES (128, '字典数据', 1, 'com.ruoair.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"维修\",\"dictSort\":1,\"dictType\":\"sys_uav_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:56:55', 17);
INSERT INTO `sys_oper_log` VALUES (129, '字典数据', 1, 'com.ruoair.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"停用\",\"dictSort\":2,\"dictType\":\"sys_uav_status\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:57:17', 17);
INSERT INTO `sys_oper_log` VALUES (130, '字典数据', 1, 'com.ruoair.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"待执行\",\"dictSort\":0,\"dictType\":\"sys_uav_task_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:57:38', 11);
INSERT INTO `sys_oper_log` VALUES (131, '字典数据', 1, 'com.ruoair.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"执行中\",\"dictSort\":1,\"dictType\":\"sys_uav_task_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:57:50', 12);
INSERT INTO `sys_oper_log` VALUES (132, '字典数据', 1, 'com.ruoair.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已完成\",\"dictSort\":2,\"dictType\":\"sys_uav_task_status\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:57:58', 16);
INSERT INTO `sys_oper_log` VALUES (133, '字典数据', 1, 'com.ruoair.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已取消\",\"dictSort\":3,\"dictType\":\"sys_uav_task_status\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 10:58:08', 18);
INSERT INTO `sys_oper_log` VALUES (134, '代码生成', 2, 'com.ruoair.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"equipment\",\"className\":\"SysUavEquipment\",\"columns\":[{\"capJavaField\":\"EquipmentId\",\"columnComment\":\"设备ID\",\"columnId\":1,\"columnName\":\"equipment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"equipmentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentCode\",\"columnComment\":\"设备编号\",\"columnId\":2,\"columnName\":\"equipment_code\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentName\",\"columnComment\":\"设备名称\",\"columnId\":3,\"columnName\":\"equipment_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentModel\",\"columnComment\":\"设备型号\",\"columnId\":4,\"columnName\":\"equipment_model\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 11:06:21', 94);
INSERT INTO `sys_oper_log` VALUES (135, '代码生成', 2, 'com.ruoair.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"equipment\",\"className\":\"SysUavEquipment\",\"columns\":[{\"capJavaField\":\"EquipmentId\",\"columnComment\":\"设备ID\",\"columnId\":1,\"columnName\":\"equipment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"equipmentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:06:21\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentCode\",\"columnComment\":\"设备编号\",\"columnId\":2,\"columnName\":\"equipment_code\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:06:21\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentName\",\"columnComment\":\"设备名称\",\"columnId\":3,\"columnName\":\"equipment_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:06:21\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentModel\",\"columnComment\":\"设备型号\",\"columnId\":4,\"columnName\":\"equipment_model\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 11:26:53', 142);
INSERT INTO `sys_oper_log` VALUES (136, '代码生成', 8, 'com.ruoair.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"sys_uav_equipment\"}', NULL, 0, NULL, '2026-04-25 11:26:56', 557);
INSERT INTO `sys_oper_log` VALUES (137, '代码生成', 2, 'com.ruoair.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"equipment\",\"className\":\"SysUavEquipment\",\"columns\":[{\"capJavaField\":\"EquipmentId\",\"columnComment\":\"设备ID\",\"columnId\":1,\"columnName\":\"equipment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"equipmentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:26:53\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentCode\",\"columnComment\":\"设备编号\",\"columnId\":2,\"columnName\":\"equipment_code\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:26:53\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentName\",\"columnComment\":\"设备名称\",\"columnId\":3,\"columnName\":\"equipment_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:26:53\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentModel\",\"columnComment\":\"设备型号\",\"columnId\":4,\"columnName\":\"equipment_model\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 11:28:13', 61);
INSERT INTO `sys_oper_log` VALUES (138, '代码生成', 2, 'com.ruoair.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"result\",\"className\":\"SysUavResult\",\"columns\":[{\"capJavaField\":\"ResultId\",\"columnComment\":\"结果ID\",\"columnId\":12,\"columnName\":\"result_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"resultId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ResultCode\",\"columnComment\":\"结果编号\",\"columnId\":13,\"columnName\":\"result_code\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resultCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TaskId\",\"columnComment\":\"关联任务ID\",\"columnId\":14,\"columnName\":\"task_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"taskId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Overview\",\"columnComment\":\"巡航概述\",\"columnId\":15,\"columnName\":\"overview\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isReq', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 11:28:22', 41);
INSERT INTO `sys_oper_log` VALUES (139, '代码生成', 2, 'com.ruoair.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"route\",\"className\":\"SysUavRoute\",\"columns\":[{\"capJavaField\":\"RouteId\",\"columnComment\":\"航线ID\",\"columnId\":22,\"columnName\":\"route_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"routeId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RouteName\",\"columnComment\":\"航线名称\",\"columnId\":23,\"columnName\":\"route_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"routeName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EstimatedTime\",\"columnComment\":\"预计时长(分钟)\",\"columnId\":24,\"columnName\":\"estimated_time\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"estimatedTime\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FlightAltitude\",\"columnComment\":\"飞行高度(米)\",\"columnId\":25,\"columnName\":\"flight_altitude\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 11:28:33', 54);
INSERT INTO `sys_oper_log` VALUES (140, '代码生成', 2, 'com.ruoair.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"task\",\"className\":\"SysUavTask\",\"columns\":[{\"capJavaField\":\"TaskId\",\"columnComment\":\"任务ID\",\"columnId\":32,\"columnName\":\"task_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"taskId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TaskName\",\"columnComment\":\"任务名称\",\"columnId\":33,\"columnName\":\"task_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"taskName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentId\",\"columnComment\":\"关联设备ID\",\"columnId\":34,\"columnName\":\"equipment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RouteId\",\"columnComment\":\"关联航线ID\",\"columnId\":35,\"columnName\":\"route_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 11:28:41', 51);
INSERT INTO `sys_oper_log` VALUES (141, '代码生成', 2, 'com.ruoair.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"result\",\"className\":\"SysUavResult\",\"columns\":[{\"capJavaField\":\"ResultId\",\"columnComment\":\"结果ID\",\"columnId\":12,\"columnName\":\"result_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"resultId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:28:22\",\"usableColumn\":false},{\"capJavaField\":\"ResultCode\",\"columnComment\":\"结果编号\",\"columnId\":13,\"columnName\":\"result_code\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"resultCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:28:22\",\"usableColumn\":false},{\"capJavaField\":\"TaskId\",\"columnComment\":\"任务ID\",\"columnId\":14,\"columnName\":\"task_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"taskId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:28:22\",\"usableColumn\":false},{\"capJavaField\":\"Overview\",\"columnComment\":\"巡航概述\",\"columnId\":15,\"columnName\":\"overview\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":fals', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 11:34:09', 46);
INSERT INTO `sys_oper_log` VALUES (142, '代码生成', 2, 'com.ruoair.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"route\",\"className\":\"SysUavRoute\",\"columns\":[{\"capJavaField\":\"RouteId\",\"columnComment\":\"航线ID\",\"columnId\":22,\"columnName\":\"route_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"routeId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:28:33\",\"usableColumn\":false},{\"capJavaField\":\"RouteName\",\"columnComment\":\"航线名称\",\"columnId\":23,\"columnName\":\"route_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"routeName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:28:33\",\"usableColumn\":false},{\"capJavaField\":\"EstimatedTime\",\"columnComment\":\"预计时长\",\"columnId\":24,\"columnName\":\"estimated_time\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"estimatedTime\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:28:33\",\"usableColumn\":false},{\"capJavaField\":\"FlightAltitude\",\"columnComment\":\"飞行高度\",\"columnId\":25,\"columnName\":\"flight_altitude\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 11:36:05', 38);
INSERT INTO `sys_oper_log` VALUES (143, '代码生成', 2, 'com.ruoair.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"task\",\"className\":\"SysUavTask\",\"columns\":[{\"capJavaField\":\"TaskId\",\"columnComment\":\"任务ID\",\"columnId\":32,\"columnName\":\"task_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"taskId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:28:41\",\"usableColumn\":false},{\"capJavaField\":\"TaskName\",\"columnComment\":\"任务名称\",\"columnId\":33,\"columnName\":\"task_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"taskName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:28:41\",\"usableColumn\":false},{\"capJavaField\":\"EquipmentId\",\"columnComment\":\"设备ID\",\"columnId\":34,\"columnName\":\"equipment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"equipmentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-04-25 11:28:41\",\"usableColumn\":false},{\"capJavaField\":\"RouteId\",\"columnComment\":\"航线ID\",\"columnId\":35,\"columnName\":\"route_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:52:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 11:38:21', 47);
INSERT INTO `sys_oper_log` VALUES (144, '代码生成', 8, 'com.ruoair.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"sys_uav_equipment\"}', NULL, 0, NULL, '2026-04-25 11:38:24', 62);
INSERT INTO `sys_oper_log` VALUES (145, '代码生成', 8, 'com.ruoair.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"sys_uav_result\"}', NULL, 0, NULL, '2026-04-25 11:38:26', 55);
INSERT INTO `sys_oper_log` VALUES (146, '代码生成', 8, 'com.ruoair.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"sys_uav_route\"}', NULL, 0, NULL, '2026-04-25 11:38:27', 52);
INSERT INTO `sys_oper_log` VALUES (147, '代码生成', 8, 'com.ruoair.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"sys_uav_task\"}', NULL, 0, NULL, '2026-04-25 11:38:28', 65);
INSERT INTO `sys_oper_log` VALUES (148, '无人机设备', 5, 'com.ruoair.uav.controller.SysUavEquipmentController.export()', 'POST', 1, 'admin', '研发部门', '/uav/equipment/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\",\"status\":\"0\"}', NULL, 0, NULL, '2026-04-25 12:03:46', 1309);
INSERT INTO `sys_oper_log` VALUES (149, '保存菜单排序', 2, 'com.ruoair.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1,2000,2018,2012,2,3\",\"orderNums\":\"5,2,3,4,6,7\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 12:28:03', 61);
INSERT INTO `sys_oper_log` VALUES (150, '巡航航线', 1, 'com.ruoair.uav.controller.SysUavRouteController.add()', 'POST', 1, 'admin', '研发部门', '/uav/route', '10.133.61.222', '内网IP', '{\"createTime\":\"2026-04-25 13:16:48\",\"estimatedTime\":1,\"flightAltitude\":10,\"params\":{},\"routeId\":120,\"routeName\":\"test1\",\"routePoints\":\"[[116.391042,39.922081],[116.533125,39.922865],[116.535169,39.841289],[116.385931,39.840505],[116.38542,39.922081],[116.399219,39.922081]]\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 13:16:48', 73);
INSERT INTO `sys_oper_log` VALUES (151, '个人信息', 2, 'com.ruoair.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile/updatePwd', '10.133.61.222', '内网IP', '{} ', '{\"msg\":\"新密码不能与旧密码相同\",\"code\":500}', 0, NULL, '2026-04-25 14:05:32', 279);
INSERT INTO `sys_oper_log` VALUES (152, '巡航任务', 1, 'com.ruoair.uav.controller.SysUavTaskController.add()', 'POST', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-04-25 14:33:15\",\"equipmentId\":100,\"params\":{},\"routeId\":120,\"startTime\":\"2026-04-25\",\"taskId\":120,\"taskName\":\"test\",\"taskStatus\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 14:33:15', 87);
INSERT INTO `sys_oper_log` VALUES (153, '巡航结果', 1, 'com.ruoair.uav.controller.SysUavResultController.add()', 'POST', 1, 'admin', '研发部门', '/uav/result', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-04-25 15:01:55\",\"overview\":\"test\",\"params\":{},\"resultCode\":\"test007\",\"resultId\":131,\"taskId\":120} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 15:01:55', 42);
INSERT INTO `sys_oper_log` VALUES (154, '保存菜单排序', 2, 'com.ruoair.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', '研发部门', '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2006,2000,2012\",\"orderNums\":\"4,1,2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 15:23:10', 45);
INSERT INTO `sys_oper_log` VALUES (155, '无人机设备', 1, 'com.ruoair.uav.controller.SysUavEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/uav/equipment', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-04-25 16:33:37\",\"equipmentCode\":\"UAV-001\",\"equipmentId\":21,\"equipmentName\":\"111\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 16:33:37', 39);
INSERT INTO `sys_oper_log` VALUES (156, '无人机设备', 3, 'com.ruoair.uav.controller.SysUavEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/uav/equipment/21', '127.0.0.1', '内网IP', '[21] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 16:33:45', 23);
INSERT INTO `sys_oper_log` VALUES (157, '无人机设备', 1, 'com.ruoair.uav.controller.SysUavEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/uav/equipment', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-04-25 16:37:32\",\"equipmentCode\":\"UAV-001\",\"equipmentName\":\"111\",\"params\":{},\"status\":\"0\"} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'UAV-001\' for key \'sys_uav_equipment.uk_equipment_code\'\r\n### The error may exist in file [E:\\FZU\\fd_drone\\20260423161654\\RuoAir\\ruoair-uav\\target\\classes\\mapper\\uav\\SysUavEquipmentMapper.xml]\r\n### The error may involve com.ruoair.uav.mapper.SysUavEquipmentMapper.insertSysUavEquipment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_uav_equipment          ( equipment_code,             equipment_name,                                       status,                          create_time )           values ( ?,             ?,                                       ?,                          ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'UAV-001\' for key \'sys_uav_equipment.uk_equipment_code\'\n; Duplicate entry \'UAV-001\' for key \'sys_uav_equipment.uk_equipment_code\'', '2026-04-25 16:37:33', 890);
INSERT INTO `sys_oper_log` VALUES (158, '无人机设备', 1, 'com.ruoair.uav.controller.SysUavEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/uav/equipment', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-04-25 16:37:33\",\"equipmentCode\":\"UAV-001\",\"equipmentName\":\"111\",\"params\":{},\"status\":\"0\"} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'UAV-001\' for key \'sys_uav_equipment.uk_equipment_code\'\r\n### The error may exist in file [E:\\FZU\\fd_drone\\20260423161654\\RuoAir\\ruoair-uav\\target\\classes\\mapper\\uav\\SysUavEquipmentMapper.xml]\r\n### The error may involve com.ruoair.uav.mapper.SysUavEquipmentMapper.insertSysUavEquipment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_uav_equipment          ( equipment_code,             equipment_name,                                       status,                          create_time )           values ( ?,             ?,                                       ?,                          ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'UAV-001\' for key \'sys_uav_equipment.uk_equipment_code\'\n; Duplicate entry \'UAV-001\' for key \'sys_uav_equipment.uk_equipment_code\'', '2026-04-25 16:37:33', 11);
INSERT INTO `sys_oper_log` VALUES (159, '无人机设备', 1, 'com.ruoair.uav.controller.SysUavEquipmentController.add()', 'POST', 1, 'admin', '研发部门', '/uav/equipment', '127.0.0.1', '内网IP', '{\"equipmentCode\":\"UAV-011\",\"equipmentName\":\"11\",\"params\":{},\"status\":\"0\"} ', NULL, 1, '新增设备失败，设备编号 \'UAV-011\' 已存在，请重新输入！', '2026-04-25 16:46:05', 50);
INSERT INTO `sys_oper_log` VALUES (160, '无人机设备', 3, 'com.ruoair.uav.controller.SysUavEquipmentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/uav/equipment/1', '127.0.0.1', '内网IP', '[1] ', NULL, 1, '删除失败：设备【大疆经纬M300】已绑定巡防任务，请先删除关联的任务！', '2026-04-25 18:08:20', 26);
INSERT INTO `sys_oper_log` VALUES (161, '字典类型', 2, 'com.ruoair.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:55:52\",\"dictId\":100,\"dictName\":\"设备状态\",\"dictType\":\"sys_uav_status\",\"params\":{},\"remark\":\"0-正常, 1-维修, 2-停用，3任务中\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 18:22:42', 45);
INSERT INTO `sys_oper_log` VALUES (162, '字典数据', 1, 'com.ruoair.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"任务中\",\"dictSort\":3,\"dictType\":\"sys_uav_status\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 18:22:54', 19);
INSERT INTO `sys_oper_log` VALUES (163, '字典类型', 9, 'com.ruoair.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 19:29:50', 44);
INSERT INTO `sys_oper_log` VALUES (164, '字典数据', 2, 'com.ruoair.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:56:43\",\"default\":false,\"dictCode\":100,\"dictLabel\":\"正常\",\"dictSort\":0,\"dictType\":\"sys_uav_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"success\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 19:30:54', 24);
INSERT INTO `sys_oper_log` VALUES (165, '字典数据', 2, 'com.ruoair.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:56:55\",\"default\":false,\"dictCode\":101,\"dictLabel\":\"维修\",\"dictSort\":1,\"dictType\":\"sys_uav_status\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 19:31:03', 10);
INSERT INTO `sys_oper_log` VALUES (166, '字典数据', 2, 'com.ruoair.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-25 18:22:54\",\"default\":false,\"dictCode\":107,\"dictLabel\":\"任务中\",\"dictSort\":3,\"dictType\":\"sys_uav_status\",\"dictValue\":\"3\",\"isDefault\":\"N\",\"listClass\":\"primary\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 19:31:13', 10);
INSERT INTO `sys_oper_log` VALUES (167, '字典数据', 2, 'com.ruoair.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-25 10:57:17\",\"default\":false,\"dictCode\":102,\"dictLabel\":\"停用\",\"dictSort\":2,\"dictType\":\"sys_uav_status\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"danger\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 19:31:19', 17);
INSERT INTO `sys_oper_log` VALUES (168, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/6', '127.0.0.1', '内网IP', '6 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 21:23:20', 74);
INSERT INTO `sys_oper_log` VALUES (169, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.cancelTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/cancel/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 21:26:52', 75);
INSERT INTO `sys_oper_log` VALUES (170, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/14', '127.0.0.1', '内网IP', '14 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 21:27:01', 32);
INSERT INTO `sys_oper_log` VALUES (171, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/15', '127.0.0.1', '内网IP', '15 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 21:27:29', 29);
INSERT INTO `sys_oper_log` VALUES (172, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/19', '127.0.0.1', '内网IP', '19 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 21:27:33', 21);
INSERT INTO `sys_oper_log` VALUES (173, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.completeTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/complete/17', '127.0.0.1', '内网IP', '17 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 21:32:17', 51);
INSERT INTO `sys_oper_log` VALUES (174, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.completeTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/complete/15', '127.0.0.1', '内网IP', '15 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 21:32:26', 41);
INSERT INTO `sys_oper_log` VALUES (175, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.completeTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/complete/9', '127.0.0.1', '内网IP', '9 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 21:32:35', 39);
INSERT INTO `sys_oper_log` VALUES (176, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:16:28', 63);
INSERT INTO `sys_oper_log` VALUES (177, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.cancelTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/cancel/2', '127.0.0.1', '内网IP', '2 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:16:52', 28);
INSERT INTO `sys_oper_log` VALUES (178, '巡航航线', 2, 'com.ruoair.uav.controller.SysUavRouteController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/route', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-05 10:00:00\",\"estimatedTime\":1,\"flightAltitude\":120,\"params\":{},\"remark\":\"湖泊巡检，6个航点\",\"routeId\":1,\"routeName\":\"环湖1号航线\",\"routePoints\":\"[[116.391042,39.922081],[116.533125,39.922865],[116.535169,39.841289],[116.385931,39.840505],[116.38542,39.922081],[116.399219,39.922081]]\",\"updateBy\":\"admin\",\"updateTime\":\"2026-04-25 22:17:13\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:17:13', 22);
INSERT INTO `sys_oper_log` VALUES (179, '巡航任务', 1, 'com.ruoair.uav.controller.SysUavTaskController.add()', 'POST', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"equipmentId\":1,\"params\":{},\"progress\":0,\"routeId\":1,\"startTime\":\"2026-04-25 00:00:00\",\"taskName\":\"test\",\"taskStatus\":\"0\"} ', NULL, 1, '任务开始时间不能早于当前时间！', '2026-04-25 22:17:33', 14);
INSERT INTO `sys_oper_log` VALUES (180, '巡航任务', 1, 'com.ruoair.uav.controller.SysUavTaskController.add()', 'POST', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"equipmentId\":1,\"params\":{},\"progress\":0,\"routeId\":1,\"startTime\":\"2026-04-26 00:00:00\",\"taskName\":\"test\",\"taskStatus\":\"0\"} ', NULL, 1, '设备【精灵4RTK】当前状态为【任务中】，无法执行任务！', '2026-04-25 22:17:40', 7);
INSERT INTO `sys_oper_log` VALUES (181, '巡航任务', 1, 'com.ruoair.uav.controller.SysUavTaskController.add()', 'POST', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"equipmentId\":100,\"params\":{},\"progress\":0,\"routeId\":1,\"startTime\":\"2026-04-26 00:00:00\",\"taskName\":\"test\",\"taskStatus\":\"0\"} ', NULL, 1, '设备不存在！', '2026-04-25 22:17:48', 4);
INSERT INTO `sys_oper_log` VALUES (182, '巡航任务', 1, 'com.ruoair.uav.controller.SysUavTaskController.add()', 'POST', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"equipmentId\":19,\"params\":{},\"progress\":0,\"routeId\":1,\"startTime\":\"2026-04-26 00:00:00\",\"taskName\":\"test\",\"taskStatus\":\"0\"} ', NULL, 1, '当前航线已被未完成任务占用，请更换航线！', '2026-04-25 22:17:53', 9);
INSERT INTO `sys_oper_log` VALUES (183, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.completeTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/complete/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:17:58', 38);
INSERT INTO `sys_oper_log` VALUES (184, '巡航任务', 1, 'com.ruoair.uav.controller.SysUavTaskController.add()', 'POST', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-04-25 22:18:08\",\"equipmentId\":1,\"params\":{},\"progress\":0,\"routeId\":1,\"startTime\":\"2026-04-26 00:00:00\",\"taskId\":21,\"taskName\":\"test\",\"taskStatus\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:18:08', 23);
INSERT INTO `sys_oper_log` VALUES (185, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/21', '127.0.0.1', '内网IP', '21 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:18:13', 24);
INSERT INTO `sys_oper_log` VALUES (186, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/3', '127.0.0.1', '内网IP', '3 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:30:45', 67);
INSERT INTO `sys_oper_log` VALUES (187, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/4', '127.0.0.1', '内网IP', '4 ', NULL, 1, '设备【Mavic 3E】当前状态为【任务中】，无法执行任务！', '2026-04-25 22:31:46', 19);
INSERT INTO `sys_oper_log` VALUES (188, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/5', '127.0.0.1', '内网IP', '5 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:31:48', 25);
INSERT INTO `sys_oper_log` VALUES (189, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.completeTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/complete/21', '127.0.0.1', '内网IP', '21 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:33:23', 57);
INSERT INTO `sys_oper_log` VALUES (190, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":52,\"taskId\":3,\"updateTime\":\"2026-04-25 22:46:21\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:46:22', 56);
INSERT INTO `sys_oper_log` VALUES (191, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":52,\"taskId\":3,\"updateTime\":\"2026-04-25 22:46:36\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:46:36', 20);
INSERT INTO `sys_oper_log` VALUES (192, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":57,\"taskId\":3,\"updateTime\":\"2026-04-25 22:47:53\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:47:53', 12);
INSERT INTO `sys_oper_log` VALUES (193, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":58,\"taskId\":3,\"updateTime\":\"2026-04-25 22:48:19\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:48:19', 17);
INSERT INTO `sys_oper_log` VALUES (194, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":62,\"taskId\":3,\"updateTime\":\"2026-04-25 22:49:32\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:49:32', 19);
INSERT INTO `sys_oper_log` VALUES (195, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":63,\"taskId\":3,\"updateTime\":\"2026-04-25 22:49:39\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:49:39', 23);
INSERT INTO `sys_oper_log` VALUES (196, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":68,\"taskId\":3,\"updateTime\":\"2026-04-25 22:51:09\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:51:09', 13);
INSERT INTO `sys_oper_log` VALUES (197, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":69,\"taskId\":3,\"updateTime\":\"2026-04-25 22:51:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:51:31', 17);
INSERT INTO `sys_oper_log` VALUES (198, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":73,\"taskId\":3,\"updateTime\":\"2026-04-25 22:52:39\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:52:39', 18);
INSERT INTO `sys_oper_log` VALUES (199, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":75,\"taskId\":3,\"updateTime\":\"2026-04-25 22:53:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:53:31', 17);
INSERT INTO `sys_oper_log` VALUES (200, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":78,\"taskId\":3,\"updateTime\":\"2026-04-25 22:54:09\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:54:09', 11);
INSERT INTO `sys_oper_log` VALUES (201, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":82,\"taskId\":3,\"updateTime\":\"2026-04-25 22:55:32\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:55:32', 23);
INSERT INTO `sys_oper_log` VALUES (202, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":83,\"taskId\":3,\"updateTime\":\"2026-04-25 22:55:39\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:55:39', 16);
INSERT INTO `sys_oper_log` VALUES (203, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":88,\"taskId\":3,\"updateTime\":\"2026-04-25 22:57:09\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:57:09', 23);
INSERT INTO `sys_oper_log` VALUES (204, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":89,\"taskId\":3,\"updateTime\":\"2026-04-25 22:57:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:57:31', 16);
INSERT INTO `sys_oper_log` VALUES (205, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":93,\"taskId\":3,\"updateTime\":\"2026-04-25 22:58:39\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:58:39', 14);
INSERT INTO `sys_oper_log` VALUES (206, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":95,\"taskId\":3,\"updateTime\":\"2026-04-25 22:59:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 22:59:31', 16);
INSERT INTO `sys_oper_log` VALUES (207, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":98,\"taskId\":3,\"updateTime\":\"2026-04-25 23:00:09\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:00:09', 19);
INSERT INTO `sys_oper_log` VALUES (208, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":98,\"taskId\":3,\"updateTime\":\"2026-04-25 23:03:53\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:03:53', 17);
INSERT INTO `sys_oper_log` VALUES (209, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":98,\"taskId\":3,\"updateTime\":\"2026-04-25 23:03:58\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:03:58', 15);
INSERT INTO `sys_oper_log` VALUES (210, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":98,\"taskId\":3,\"updateTime\":\"2026-04-25 23:03:59\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:03:59', 10);
INSERT INTO `sys_oper_log` VALUES (211, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":3,\"updateTime\":\"2026-04-25 23:04:17\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:04:17', 21);
INSERT INTO `sys_oper_log` VALUES (212, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":3,\"updateTime\":\"2026-04-25 23:04:20\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:04:20', 13);
INSERT INTO `sys_oper_log` VALUES (213, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":100,\"taskId\":3,\"updateTime\":\"2026-04-25 23:04:38\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:04:38', 16);
INSERT INTO `sys_oper_log` VALUES (214, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":100,\"taskId\":3,\"updateTime\":\"2026-04-25 23:05:38\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:05:38', 11);
INSERT INTO `sys_oper_log` VALUES (215, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/4', '127.0.0.1', '内网IP', '4 ', NULL, 1, '设备【Mavic 3E】当前状态为【任务中】，无法执行任务！', '2026-04-25 23:05:40', 37);
INSERT INTO `sys_oper_log` VALUES (216, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":5,\"updateTime\":\"2026-04-25 23:05:44\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:05:44', 11);
INSERT INTO `sys_oper_log` VALUES (217, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":2,\"taskId\":5,\"updateTime\":\"2026-04-25 23:06:10\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:06:11', 17);
INSERT INTO `sys_oper_log` VALUES (218, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":4,\"taskId\":5,\"updateTime\":\"2026-04-25 23:06:38\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:06:38', 8);
INSERT INTO `sys_oper_log` VALUES (219, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":6,\"taskId\":5,\"updateTime\":\"2026-04-25 23:07:04\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:07:05', 10);
INSERT INTO `sys_oper_log` VALUES (220, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":8,\"taskId\":5,\"updateTime\":\"2026-04-25 23:07:32\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:07:32', 16);
INSERT INTO `sys_oper_log` VALUES (221, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":10,\"taskId\":5,\"updateTime\":\"2026-04-25 23:07:58\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:07:59', 17);
INSERT INTO `sys_oper_log` VALUES (222, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":12,\"taskId\":5,\"updateTime\":\"2026-04-25 23:08:26\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:08:26', 15);
INSERT INTO `sys_oper_log` VALUES (223, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":14,\"taskId\":5,\"updateTime\":\"2026-04-25 23:08:52\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:08:53', 13);
INSERT INTO `sys_oper_log` VALUES (224, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":5,\"updateTime\":\"2026-04-25 23:09:19\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:09:20', 19);
INSERT INTO `sys_oper_log` VALUES (225, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":18,\"taskId\":5,\"updateTime\":\"2026-04-25 23:09:47\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:09:47', 17);
INSERT INTO `sys_oper_log` VALUES (226, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":20,\"taskId\":5,\"updateTime\":\"2026-04-25 23:10:14\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:10:14', 15);
INSERT INTO `sys_oper_log` VALUES (227, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":22,\"taskId\":5,\"updateTime\":\"2026-04-25 23:10:40\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:10:41', 20);
INSERT INTO `sys_oper_log` VALUES (228, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":24,\"taskId\":5,\"updateTime\":\"2026-04-25 23:11:08\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:11:08', 9);
INSERT INTO `sys_oper_log` VALUES (229, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":26,\"taskId\":5,\"updateTime\":\"2026-04-25 23:11:34\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:11:35', 13);
INSERT INTO `sys_oper_log` VALUES (230, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":28,\"taskId\":5,\"updateTime\":\"2026-04-25 23:12:02\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:12:02', 14);
INSERT INTO `sys_oper_log` VALUES (231, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":30,\"taskId\":5,\"updateTime\":\"2026-04-25 23:12:28\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:12:29', 14);
INSERT INTO `sys_oper_log` VALUES (232, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":32,\"taskId\":5,\"updateTime\":\"2026-04-25 23:12:56\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:12:56', 16);
INSERT INTO `sys_oper_log` VALUES (233, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":34,\"taskId\":5,\"updateTime\":\"2026-04-25 23:13:22\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:13:23', 13);
INSERT INTO `sys_oper_log` VALUES (234, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":36,\"taskId\":5,\"updateTime\":\"2026-04-25 23:13:49\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:13:50', 17);
INSERT INTO `sys_oper_log` VALUES (235, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":38,\"taskId\":5,\"updateTime\":\"2026-04-25 23:14:17\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:14:17', 17);
INSERT INTO `sys_oper_log` VALUES (236, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":40,\"taskId\":5,\"updateTime\":\"2026-04-25 23:14:44\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:14:44', 11);
INSERT INTO `sys_oper_log` VALUES (237, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":42,\"taskId\":5,\"updateTime\":\"2026-04-25 23:15:11\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:15:11', 19);
INSERT INTO `sys_oper_log` VALUES (238, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":45,\"taskId\":5,\"updateTime\":\"2026-04-25 23:15:38\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:15:38', 15);
INSERT INTO `sys_oper_log` VALUES (239, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":47,\"taskId\":5,\"updateTime\":\"2026-04-25 23:16:05\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:16:05', 14);
INSERT INTO `sys_oper_log` VALUES (240, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":49,\"taskId\":5,\"updateTime\":\"2026-04-25 23:16:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:16:32', 16);
INSERT INTO `sys_oper_log` VALUES (241, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":51,\"taskId\":5,\"updateTime\":\"2026-04-25 23:16:59\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:16:59', 13);
INSERT INTO `sys_oper_log` VALUES (242, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":53,\"taskId\":5,\"updateTime\":\"2026-04-25 23:17:25\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:17:26', 21);
INSERT INTO `sys_oper_log` VALUES (243, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":55,\"taskId\":5,\"updateTime\":\"2026-04-25 23:17:53\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:17:53', 18);
INSERT INTO `sys_oper_log` VALUES (244, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":57,\"taskId\":5,\"updateTime\":\"2026-04-25 23:18:19\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:18:20', 9);
INSERT INTO `sys_oper_log` VALUES (245, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":59,\"taskId\":5,\"updateTime\":\"2026-04-25 23:18:47\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:18:47', 14);
INSERT INTO `sys_oper_log` VALUES (246, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":61,\"taskId\":5,\"updateTime\":\"2026-04-25 23:19:13\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:19:14', 13);
INSERT INTO `sys_oper_log` VALUES (247, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":63,\"taskId\":5,\"updateTime\":\"2026-04-25 23:19:41\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:19:41', 9);
INSERT INTO `sys_oper_log` VALUES (248, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":65,\"taskId\":5,\"updateTime\":\"2026-04-25 23:20:07\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:20:08', 14);
INSERT INTO `sys_oper_log` VALUES (249, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":67,\"taskId\":5,\"updateTime\":\"2026-04-25 23:20:35\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:20:35', 13);
INSERT INTO `sys_oper_log` VALUES (250, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":69,\"taskId\":5,\"updateTime\":\"2026-04-25 23:21:01\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:21:02', 14);
INSERT INTO `sys_oper_log` VALUES (251, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":71,\"taskId\":5,\"updateTime\":\"2026-04-25 23:21:29\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:21:29', 12);
INSERT INTO `sys_oper_log` VALUES (252, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":73,\"taskId\":5,\"updateTime\":\"2026-04-25 23:21:55\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:21:56', 33);
INSERT INTO `sys_oper_log` VALUES (253, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":75,\"taskId\":5,\"updateTime\":\"2026-04-25 23:22:23\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:22:23', 37);
INSERT INTO `sys_oper_log` VALUES (254, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":77,\"taskId\":5,\"updateTime\":\"2026-04-25 23:22:49\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:22:50', 15);
INSERT INTO `sys_oper_log` VALUES (255, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":79,\"taskId\":5,\"updateTime\":\"2026-04-25 23:23:17\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:23:17', 37);
INSERT INTO `sys_oper_log` VALUES (256, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":81,\"taskId\":5,\"updateTime\":\"2026-04-25 23:23:44\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:23:44', 40);
INSERT INTO `sys_oper_log` VALUES (257, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":83,\"taskId\":5,\"updateTime\":\"2026-04-25 23:24:11\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:24:11', 59);
INSERT INTO `sys_oper_log` VALUES (258, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":85,\"taskId\":5,\"updateTime\":\"2026-04-25 23:24:37\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:24:38', 10);
INSERT INTO `sys_oper_log` VALUES (259, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":87,\"taskId\":5,\"updateTime\":\"2026-04-25 23:25:05\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:25:05', 15);
INSERT INTO `sys_oper_log` VALUES (260, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":90,\"taskId\":5,\"updateTime\":\"2026-04-25 23:25:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:25:32', 10);
INSERT INTO `sys_oper_log` VALUES (261, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":92,\"taskId\":5,\"updateTime\":\"2026-04-25 23:25:59\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:25:59', 8);
INSERT INTO `sys_oper_log` VALUES (262, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":94,\"taskId\":5,\"updateTime\":\"2026-04-25 23:26:25\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:26:26', 17);
INSERT INTO `sys_oper_log` VALUES (263, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":96,\"taskId\":5,\"updateTime\":\"2026-04-25 23:26:53\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:26:53', 10);
INSERT INTO `sys_oper_log` VALUES (264, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":98,\"taskId\":5,\"updateTime\":\"2026-04-25 23:27:19\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:27:20', 13);
INSERT INTO `sys_oper_log` VALUES (265, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":100,\"taskId\":5,\"updateTime\":\"2026-04-25 23:27:44\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:27:44', 9);
INSERT INTO `sys_oper_log` VALUES (266, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/4', '127.0.0.1', '内网IP', '4 ', NULL, 1, '设备【Mavic 3E】当前状态为【任务中】，无法执行任务！', '2026-04-25 23:35:58', 12);
INSERT INTO `sys_oper_log` VALUES (267, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":6,\"updateTime\":\"2026-04-25 23:36:00\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:36:00', 12);
INSERT INTO `sys_oper_log` VALUES (268, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":2,\"taskId\":6,\"updateTime\":\"2026-04-25 23:36:32\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:36:32', 15);
INSERT INTO `sys_oper_log` VALUES (269, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":4,\"taskId\":6,\"updateTime\":\"2026-04-25 23:37:14\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:37:14', 9);
INSERT INTO `sys_oper_log` VALUES (270, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":5,\"taskId\":6,\"updateTime\":\"2026-04-25 23:37:47\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:37:47', 22);
INSERT INTO `sys_oper_log` VALUES (271, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":5,\"taskId\":6,\"updateTime\":\"2026-04-25 23:37:57\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:37:57', 10);
INSERT INTO `sys_oper_log` VALUES (272, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-25 23:38:03\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:38:03', 7);
INSERT INTO `sys_oper_log` VALUES (273, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-25 23:38:13\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:38:13', 14);
INSERT INTO `sys_oper_log` VALUES (274, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":100,\"taskId\":3,\"updateTime\":\"2026-04-25 23:38:45\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:38:45', 14);
INSERT INTO `sys_oper_log` VALUES (275, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":100,\"taskId\":3,\"updateTime\":\"2026-04-25 23:38:47\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:38:47', 9);
INSERT INTO `sys_oper_log` VALUES (276, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/4', '127.0.0.1', '内网IP', '4 ', NULL, 1, '设备【Mavic 3E】当前状态为【任务中】，无法执行任务！', '2026-04-25 23:38:54', 9);
INSERT INTO `sys_oper_log` VALUES (277, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":5,\"taskId\":6,\"updateTime\":\"2026-04-25 23:38:56\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:38:56', 13);
INSERT INTO `sys_oper_log` VALUES (278, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":5,\"taskId\":6,\"updateTime\":\"2026-04-25 23:38:58\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:38:59', 14);
INSERT INTO `sys_oper_log` VALUES (279, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":5,\"taskId\":6,\"updateTime\":\"2026-04-25 23:39:02\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:39:02', 13);
INSERT INTO `sys_oper_log` VALUES (280, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":5,\"taskId\":6,\"updateTime\":\"2026-04-25 23:39:04\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:39:04', 11);
INSERT INTO `sys_oper_log` VALUES (281, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":5,\"taskId\":6,\"updateTime\":\"2026-04-25 23:39:16\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:39:16', 9);
INSERT INTO `sys_oper_log` VALUES (282, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":5,\"taskId\":6,\"updateTime\":\"2026-04-25 23:39:21\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-25 23:39:21', 15);
INSERT INTO `sys_oper_log` VALUES (283, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:04:39\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:04:39', 57);
INSERT INTO `sys_oper_log` VALUES (284, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:04:47\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:04:47', 12);
INSERT INTO `sys_oper_log` VALUES (285, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":30,\"taskId\":17,\"updateTime\":\"2026-04-26 10:04:53\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:04:53', 11);
INSERT INTO `sys_oper_log` VALUES (286, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":30,\"taskId\":17,\"updateTime\":\"2026-04-26 10:04:57\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:04:57', 13);
INSERT INTO `sys_oper_log` VALUES (287, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":30,\"taskId\":17,\"updateTime\":\"2026-04-26 10:05:10\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:05:10', 10);
INSERT INTO `sys_oper_log` VALUES (288, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":30,\"taskId\":17,\"updateTime\":\"2026-04-26 10:05:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:05:31', 13);
INSERT INTO `sys_oper_log` VALUES (289, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":60,\"taskId\":12,\"updateTime\":\"2026-04-26 10:06:49\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:06:49', 13);
INSERT INTO `sys_oper_log` VALUES (290, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":30,\"taskId\":17,\"updateTime\":\"2026-04-26 10:10:40\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:10:40', 12);
INSERT INTO `sys_oper_log` VALUES (291, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":30,\"taskId\":17,\"updateTime\":\"2026-04-26 10:10:42\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:10:42', 10);
INSERT INTO `sys_oper_log` VALUES (292, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":30,\"taskId\":17,\"updateTime\":\"2026-04-26 10:10:46\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:10:46', 14);
INSERT INTO `sys_oper_log` VALUES (293, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":30,\"taskId\":17,\"updateTime\":\"2026-04-26 10:10:58\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:10:58', 11);
INSERT INTO `sys_oper_log` VALUES (294, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:11:07\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:11:07', 12);
INSERT INTO `sys_oper_log` VALUES (295, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:11:09\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:11:09', 11);
INSERT INTO `sys_oper_log` VALUES (296, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:11:12\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:11:12', 10);
INSERT INTO `sys_oper_log` VALUES (297, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:11:18\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:11:18', 10);
INSERT INTO `sys_oper_log` VALUES (298, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:11:23\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:11:23', 9);
INSERT INTO `sys_oper_log` VALUES (299, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/19', '127.0.0.1', '内网IP', '19 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:19:18', 55);
INSERT INTO `sys_oper_log` VALUES (300, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":19,\"updateTime\":\"2026-04-26 10:19:22\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:19:22', 29);
INSERT INTO `sys_oper_log` VALUES (301, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":19,\"updateTime\":\"2026-04-26 10:19:31\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:19:31', 11);
INSERT INTO `sys_oper_log` VALUES (302, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/15', '127.0.0.1', '内网IP', '15 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:19:42', 25);
INSERT INTO `sys_oper_log` VALUES (303, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:19:43\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:19:43', 12);
INSERT INTO `sys_oper_log` VALUES (304, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:19:51\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:19:51', 11);
INSERT INTO `sys_oper_log` VALUES (305, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:19:55\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:19:55', 11);
INSERT INTO `sys_oper_log` VALUES (306, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:19:57\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:19:57', 13);
INSERT INTO `sys_oper_log` VALUES (307, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:20:00\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:00', 7);
INSERT INTO `sys_oper_log` VALUES (308, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:20:04\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:04', 12);
INSERT INTO `sys_oper_log` VALUES (309, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:20:05\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:05', 13);
INSERT INTO `sys_oper_log` VALUES (310, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:20:07\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:07', 15);
INSERT INTO `sys_oper_log` VALUES (311, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:20:13\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:13', 10);
INSERT INTO `sys_oper_log` VALUES (312, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:20:18\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:18', 11);
INSERT INTO `sys_oper_log` VALUES (313, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":19,\"updateTime\":\"2026-04-26 10:20:21\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:21', 16);
INSERT INTO `sys_oper_log` VALUES (314, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":19,\"updateTime\":\"2026-04-26 10:20:23\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:23', 11);
INSERT INTO `sys_oper_log` VALUES (315, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:20:29\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:29', 11);
INSERT INTO `sys_oper_log` VALUES (316, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:20:30\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:31', 16);
INSERT INTO `sys_oper_log` VALUES (317, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":15,\"updateTime\":\"2026-04-26 10:20:32\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:20:32', 10);
INSERT INTO `sys_oper_log` VALUES (318, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:28:44\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:28:44', 61);
INSERT INTO `sys_oper_log` VALUES (319, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:28:48\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:28:48', 13);
INSERT INTO `sys_oper_log` VALUES (320, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:29:08\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:29:08', 12);
INSERT INTO `sys_oper_log` VALUES (321, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":15,\"taskId\":20,\"updateTime\":\"2026-04-26 10:29:13\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:29:13', 14);
INSERT INTO `sys_oper_log` VALUES (322, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:29:41\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:29:41', 17);
INSERT INTO `sys_oper_log` VALUES (323, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:31:52\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:31:53', 53);
INSERT INTO `sys_oper_log` VALUES (324, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:31:54\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:31:54', 13);
INSERT INTO `sys_oper_log` VALUES (325, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:32:00\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:32:00', 11);
INSERT INTO `sys_oper_log` VALUES (326, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:32:23\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:32:23', 14);
INSERT INTO `sys_oper_log` VALUES (327, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:32:27\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:32:28', 12);
INSERT INTO `sys_oper_log` VALUES (328, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:32:30\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:32:30', 15);
INSERT INTO `sys_oper_log` VALUES (329, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:33:39\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:33:39', 12);
INSERT INTO `sys_oper_log` VALUES (330, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:33:47\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:33:47', 15);
INSERT INTO `sys_oper_log` VALUES (331, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":19,\"updateTime\":\"2026-04-26 10:33:49\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:33:49', 16);
INSERT INTO `sys_oper_log` VALUES (332, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":19,\"updateTime\":\"2026-04-26 10:33:56\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:33:56', 17);
INSERT INTO `sys_oper_log` VALUES (333, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":19,\"updateTime\":\"2026-04-26 10:33:57\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:33:57', 13);
INSERT INTO `sys_oper_log` VALUES (334, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:00\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:00', 55);
INSERT INTO `sys_oper_log` VALUES (335, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:01\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:01', 17);
INSERT INTO `sys_oper_log` VALUES (336, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:12\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:12', 12);
INSERT INTO `sys_oper_log` VALUES (337, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:14\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:14', 14);
INSERT INTO `sys_oper_log` VALUES (338, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:16\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:16', 12);
INSERT INTO `sys_oper_log` VALUES (339, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:22\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:22', 12);
INSERT INTO `sys_oper_log` VALUES (340, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:25\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:25', 12);
INSERT INTO `sys_oper_log` VALUES (341, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:26\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:26', 14);
INSERT INTO `sys_oper_log` VALUES (342, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:30\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:30', 10);
INSERT INTO `sys_oper_log` VALUES (343, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":16,\"taskId\":20,\"updateTime\":\"2026-04-26 10:36:36\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:36', 16);
INSERT INTO `sys_oper_log` VALUES (344, '巡航任务', 1, 'com.ruoair.uav.controller.SysUavTaskController.add()', 'POST', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-04-26 10:36:54\",\"equipmentId\":1,\"executor\":\"1\",\"params\":{},\"progress\":0,\"routeId\":3,\"startTime\":\"2026-04-27 00:00:00\",\"statusHistory\":\"2026-04-26 10:36:54|待执行|创建任务\",\"taskId\":21,\"taskName\":\"11\",\"taskStatus\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:36:54', 17);
INSERT INTO `sys_oper_log` VALUES (345, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/21', '127.0.0.1', '内网IP', '21 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:37:00', 39);
INSERT INTO `sys_oper_log` VALUES (346, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":21,\"updateTime\":\"2026-04-26 10:37:00\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:37:00', 12);
INSERT INTO `sys_oper_log` VALUES (347, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":21,\"updateTime\":\"2026-04-26 10:37:03\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:37:03', 12);
INSERT INTO `sys_oper_log` VALUES (348, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":21,\"updateTime\":\"2026-04-26 10:37:05\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:37:05', 10);
INSERT INTO `sys_oper_log` VALUES (349, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":21,\"updateTime\":\"2026-04-26 10:37:07\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:37:07', 16);
INSERT INTO `sys_oper_log` VALUES (350, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":21,\"updateTime\":\"2026-04-26 10:37:08\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:37:08', 12);
INSERT INTO `sys_oper_log` VALUES (351, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.cancelTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/cancel/21', '127.0.0.1', '内网IP', '21 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:37:10', 15);
INSERT INTO `sys_oper_log` VALUES (352, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":0,\"taskId\":21,\"updateTime\":\"2026-04-26 10:37:10\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 10:37:10', 17);
INSERT INTO `sys_oper_log` VALUES (353, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 18:02:02\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:02', 93);
INSERT INTO `sys_oper_log` VALUES (354, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 18:02:05\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:05', 14);
INSERT INTO `sys_oper_log` VALUES (355, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 18:02:06\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:06', 12);
INSERT INTO `sys_oper_log` VALUES (356, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 18:02:07\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:07', 13);
INSERT INTO `sys_oper_log` VALUES (357, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 18:02:09\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:09', 14);
INSERT INTO `sys_oper_log` VALUES (358, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 18:02:10\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:10', 13);
INSERT INTO `sys_oper_log` VALUES (359, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":20,\"updateTime\":\"2026-04-26 18:02:12\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:12', 12);
INSERT INTO `sys_oper_log` VALUES (360, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":20,\"updateTime\":\"2026-04-26 18:02:13\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:13', 15);
INSERT INTO `sys_oper_log` VALUES (361, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 18:02:14\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:14', 19);
INSERT INTO `sys_oper_log` VALUES (362, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 18:02:16\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:16', 22);
INSERT INTO `sys_oper_log` VALUES (363, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":17,\"updateTime\":\"2026-04-26 18:02:19\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:19', 13);
INSERT INTO `sys_oper_log` VALUES (364, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":17,\"updateTime\":\"2026-04-26 18:02:20\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:20', 17);
INSERT INTO `sys_oper_log` VALUES (365, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":17,\"updateTime\":\"2026-04-26 18:02:23\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 18:02:23', 11);
INSERT INTO `sys_oper_log` VALUES (366, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":20,\"updateTime\":\"2026-04-26 19:16:42\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:16:42', 54);
INSERT INTO `sys_oper_log` VALUES (367, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":20,\"updateTime\":\"2026-04-26 19:16:44\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:16:44', 18);
INSERT INTO `sys_oper_log` VALUES (368, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.pauseTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/pause/20', '127.0.0.1', '内网IP', '20 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:16:44', 51);
INSERT INTO `sys_oper_log` VALUES (369, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":20,\"updateTime\":\"2026-04-26 19:16:46\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:16:46', 12);
INSERT INTO `sys_oper_log` VALUES (370, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 19:16:48\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:16:48', 19);
INSERT INTO `sys_oper_log` VALUES (371, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 19:16:49\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:16:49', 12);
INSERT INTO `sys_oper_log` VALUES (372, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.pauseTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/pause/19', '127.0.0.1', '内网IP', '19 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:16:49', 24);
INSERT INTO `sys_oper_log` VALUES (373, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 19:16:50\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:16:50', 12);
INSERT INTO `sys_oper_log` VALUES (374, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/20', '127.0.0.1', '内网IP', '20 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:16:59', 23);
INSERT INTO `sys_oper_log` VALUES (375, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":20,\"updateTime\":\"2026-04-26 19:17:00\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:17:00', 13);
INSERT INTO `sys_oper_log` VALUES (376, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":100,\"taskId\":20,\"updateTime\":\"2026-04-26 19:17:10\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:17:10', 12);
INSERT INTO `sys_oper_log` VALUES (377, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":100,\"taskId\":20,\"updateTime\":\"2026-04-26 19:17:16\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:17:16', 23);
INSERT INTO `sys_oper_log` VALUES (378, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.startTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/start/19', '127.0.0.1', '内网IP', '19 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:17:21', 20);
INSERT INTO `sys_oper_log` VALUES (379, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":99,\"taskId\":19,\"updateTime\":\"2026-04-26 19:17:21\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:17:21', 13);
INSERT INTO `sys_oper_log` VALUES (380, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":100,\"taskId\":19,\"updateTime\":\"2026-04-26 19:17:30\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:17:30', 17);
INSERT INTO `sys_oper_log` VALUES (381, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/task', '127.0.0.1', '内网IP', '{\"params\":{},\"progress\":100,\"taskId\":19,\"updateTime\":\"2026-04-26 19:17:35\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:17:35', 10);
INSERT INTO `sys_oper_log` VALUES (382, '巡航任务', 2, 'com.ruoair.uav.controller.SysUavTaskController.completeTask()', 'PUT', 1, 'admin', '研发部门', '/uav/task/complete/20', '127.0.0.1', '内网IP', '20 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 19:17:38', 36);
INSERT INTO `sys_oper_log` VALUES (383, '巡航结果', 2, 'com.ruoair.uav.controller.SysUavResultController.edit()', 'PUT', 1, 'admin', '研发部门', '/uav/result', '127.0.0.1', '内网IP', '{\"aiImageUrl\":\"http://localhost:8081/profile/upload/result/2026/04/26/R-C_20260426205526A004.jpg\",\"completedTime\":\"2026-04-26 19:17:38\",\"createBy\":\"\",\"createTime\":\"2026-04-26 19:17:38\",\"equipmentName\":\"Matrice 350\",\"executor\":\"郭峰\",\"handlingInfo\":\"\",\"overview\":\"本次巡防任务正常完成，无异常情况\",\"params\":{},\"patrolDuration\":1,\"resultCode\":\"RES-1777202258116\",\"resultId\":21,\"routeName\":\"夜航测试线\",\"routePoints\":\"[[116.395000,39.915000],[116.415000,39.920000],[116.435000,39.917000],[116.445000,39.925000],[116.425000,39.930000],[116.405000,39.923000]]\",\"taskId\":20,\"taskName\":\"夜航测试\",\"taskStatus\":\"2\",\"updateBy\":\"\",\"updateTime\":\"2026-04-26 20:55:29\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 20:55:29', 90);
INSERT INTO `sys_oper_log` VALUES (384, '巡航结果', 1, 'com.ruoair.uav.controller.SysUavResultController.add()', 'POST', 1, 'admin', '研发部门', '/uav/result', '127.0.0.1', '内网IP', '{\"aiImageUrl\":\"http://localhost:8081/profile/upload/result/2026/04/26/R-C_20260426223900A002.jpg\",\"completedTime\":\"2026-04-26 22:38:51\",\"createTime\":\"2026-04-26 22:39:06\",\"equipmentName\":\"精灵4多光谱\",\"executor\":\"吴迪\",\"findings\":\"图像显示一处交通检查站，车辆密集排队，存在拥堵现象。部分车辆停放在非指定区域，可能影响通行效率。\",\"handlingInfo\":\"建议通知相关部门加强现场指挥调度，引导车辆有序通行。同时安排人工复核，确保检查流程高效安全。\",\"overview\":\"图像显示一处交通检查站，车辆密集排队，存在拥堵现象。部分车辆停放在非指定区域，可能影响通行效率。\",\"params\":{},\"patrolDuration\":0,\"remark\":\"天气晴朗，光照充足，图像清晰度较高，能够清晰识别车辆及人员分布情况。\",\"resultCode\":\"11\",\"resultId\":22,\"routeName\":\"高铁沿线J线\",\"taskId\":17,\"taskName\":\"高铁沿线排查\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-26 22:39:06', 141);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-04-24 23:33:23', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-04-24 23:33:23', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-04-24 23:33:23', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-04-24 23:33:23', 'admin', '2026-04-25 00:27:52', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_uav_equipment
-- ----------------------------
DROP TABLE IF EXISTS `sys_uav_equipment`;
CREATE TABLE `sys_uav_equipment`  (
  `equipment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `equipment_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备编号',
  `equipment_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备名称',
  `equipment_model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '设备型号',
  `flight_duration` int NULL DEFAULT 0 COMMENT '续航时长(分钟)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '设备状态（0正常 1维修 2已报废 3任务中）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `camera_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '摄像头参数',
  `owner` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '归属人',
  PRIMARY KEY (`equipment_id`) USING BTREE,
  UNIQUE INDEX `idx_equipment_code`(`equipment_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '无人机设备表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_uav_equipment
-- ----------------------------
INSERT INTO `sys_uav_equipment` VALUES (1, 'UAV001', '精灵4RTK', 'DJI Phantom 4 RTK', 38, '0', 'admin', '2026-01-10 10:00:00', 'admin', '2026-04-26 10:37:10', '高精度测绘无人机', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (2, 'UAV002', '经纬M300', 'DJI Matrice 300', 55, '3', 'admin', '2026-01-15 11:00:00', 'admin', '2026-04-20 08:30:00', '工业级旗舰机', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (3, 'UAV003', '御2行业版', 'DJI Mavic 2 Enterprise', 31, '0', 'admin', '2026-01-20 09:30:00', 'admin', '2026-04-19 14:20:00', '便携式巡检', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (4, 'UAV004', 'Mavic 3E', 'DJI Mavic 3 Enterprise', 45, '0', 'admin', '2026-02-01 10:15:00', 'admin', '2026-04-21 11:00:00', '机械快门版', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (5, 'UAV005', '大疆机场', 'DJI Dock', 28, '1', 'admin', '2026-02-10 14:00:00', 'admin', '2026-04-15 09:00:00', '需维修电池', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (6, 'UAV006', 'Autel Evo II', 'Autel Evo II Pro', 40, '3', 'admin', '2026-02-18 15:30:00', 'admin', '2026-04-26 10:19:42', '6K高清', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (7, 'UAV007', '道通EVO Lite', 'Autel EVO Lite+', 40, '2', 'admin', '2026-02-20 08:45:00', 'admin', '2026-03-10 10:00:00', '已报废', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (8, 'UAV008', 'FlyCart 30', 'DJI FlyCart 30', 20, '0', 'admin', '2026-03-01 09:20:00', 'admin', '2026-04-23 13:40:00', '运载机', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (9, 'UAV009', '精灵4多光谱', 'DJI Phantom 4 Multispectral', 27, '0', 'admin', '2026-03-05 11:10:00', 'admin', '2026-04-20 15:10:00', '农业监测', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (10, 'UAV010', 'Avata 2', 'DJI Avata 2', 18, '0', 'admin', '2026-03-12 13:50:00', 'admin', '2026-04-24 09:50:00', '穿越机', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (11, 'UAV011', 'Mini 4 Pro', 'DJI Mini 4 Pro', 34, '0', 'admin', '2026-03-18 10:00:00', 'admin', '2026-04-19 11:30:00', '轻小便携', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (12, 'UAV012', 'Inspire 3', 'DJI Inspire 3', 28, '1', 'admin', '2026-03-20 14:20:00', 'admin', '2026-04-10 08:00:00', '云台故障', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (13, 'UAV013', 'M30T', 'DJI M30T', 41, '3', 'admin', '2026-03-25 16:30:00', 'admin', '2026-04-26 19:17:21', '热成像版', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (14, 'UAV014', 'Mavic 2 Zoom', 'DJI Mavic 2 Zoom', 31, '0', 'admin', '2026-03-28 09:00:00', 'admin', '2026-04-18 17:00:00', '变焦相机', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (15, 'UAV015', 'H20T挂载', 'DJI H20T', 50, '3', 'admin', '2026-04-01 11:45:00', 'admin', '2026-04-22 14:30:00', '任务执行中', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (16, 'UAV016', 'Matrice 350', 'DJI Matrice 350 RTK', 55, '0', 'admin', '2026-04-02 13:00:00', 'admin', '2026-04-26 19:17:38', '新一代旗舰', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (17, 'UAV017', 'Mini 3', 'DJI Mini 3', 38, '0', 'admin', '2026-04-05 08:20:00', 'admin', '2026-04-21 16:40:00', '入门级', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (18, 'UAV018', 'Air 2S', 'DJI Air 2S', 31, '2', 'admin', '2026-04-08 15:50:00', 'admin', '2026-04-12 10:00:00', '已报废', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (19, 'UAV019', 'FPV', 'DJI FPV', 20, '0', 'admin', '2026-04-10 09:35:00', 'admin', '2026-04-24 11:10:00', '竞速机', NULL, NULL);
INSERT INTO `sys_uav_equipment` VALUES (20, 'UAV020', 'Neo', 'DJI Neo', 15, '0', 'admin', '2026-04-12 14:15:00', 'admin', '2026-04-25 08:50:00', '自拍无人机', NULL, NULL);

-- ----------------------------
-- Table structure for sys_uav_result
-- ----------------------------
DROP TABLE IF EXISTS `sys_uav_result`;
CREATE TABLE `sys_uav_result`  (
  `result_id` bigint NOT NULL AUTO_INCREMENT COMMENT '结果ID',
  `result_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '结果编号',
  `task_id` bigint NOT NULL COMMENT '关联任务ID',
  `task_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '任务名称(数据快照)',
  `equipment_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '设备名称(数据快照)',
  `route_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '航线名称(数据快照)',
  `executor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '执行人(数据快照)',
  `overview` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '巡航概述',
  `findings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '发现情况',
  `handling_info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '处理情况',
  `ai_image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'AI识别抓拍图片路径',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `patrol_duration` bigint NULL DEFAULT NULL COMMENT '巡防时长(分钟)',
  `completed_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  `route_points` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '航线点位快照',
  PRIMARY KEY (`result_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '巡航结果表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_uav_result
-- ----------------------------
INSERT INTO `sys_uav_result` VALUES (1, 'RES20260420001', 1, '环湖巡检任务', '精灵4RTK', '环湖1号航线', '张明', '环湖一周，湖面清洁无异常', '发现一处非法钓鱼', '已劝离并记录', '/ai/20260420/lake_fishing.jpg', 'admin', '2026-04-20 09:00:00', 'admin', '2026-04-20 09:00:00', '正常完成', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (2, 'RES20260420002', 2, '东区高压线巡检', '经纬M300', '东区高压线A线', '李芳', '高压线塔外观正常无飘挂物', '绝缘子轻微污秽', '计划下次清洗', '/ai/20260420/insulator.jpg', 'admin', '2026-04-20 11:30:00', 'admin', '2026-04-20 11:30:00', '完成', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (3, 'RES20260420003', 3, '西区农田监测', '御2行业版', '西区农田B线', '王强', '小麦长势良好墒情正常', '局部有病虫害迹象', '已通知农户', '/ai/20260420/pests.jpg', 'admin', '2026-04-20 15:30:00', 'admin', '2026-04-20 15:30:00', '完成', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (4, 'RES20260421001', 5, '南区建筑群', 'Autel Evo II', '南区建筑群D线', '孙阳', '无新增违建工地覆盖达标', '一处围挡破损', '已上报城管', '/ai/20260421/broken_fence.jpg', 'admin', '2026-04-21 14:30:00', 'admin', '2026-04-21 14:30:00', '完成', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (5, 'RES20260422001', 8, '水库大坝线', 'Mini 4 Pro', '水库大坝线', '郑爽', '坝体无裂缝水位正常', '泄洪道有少量垃圾', '已通知清理', '/ai/20260422/dam_trash.jpg', 'admin', '2026-04-22 11:00:00', 'admin', '2026-04-22 11:00:00', '完成', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (6, 'RES20260423001', 10, '野生动物走廊', 'H20T挂载', '野生动物走廊', '郭峰', '发现鹿群活动栖息地良好', '无盗猎痕迹', '持续观察', '/ai/20260423/deer.jpg', 'admin', '2026-04-23 09:30:00', 'admin', '2026-04-23 09:30:00', '完成', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (7, 'RES20260423002', 11, '城市风貌航拍', 'Matrice 350', '城市风貌线', '唐雅', '城市景观美丽交通秩序良好', '部分路段拥堵', '已同步交通部门', '/ai/20260423/traffic.jpg', 'admin', '2026-04-23 12:00:00', 'admin', '2026-04-23 12:00:00', '完成', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (8, 'RES20260424001', 13, '应急通道测试', '御2行业版', '应急通道线', '王强', '应急通道畅通标识清晰', '无占用情况', '无需处理', '/ai/20260424/emergency.jpg', 'admin', '2026-04-24 09:00:00', 'admin', '2026-04-24 09:00:00', '完成', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (9, 'RES20260424002', 16, '油气管线', 'FlyCart 30', '油气管线I线', '周梅', '管线区域无泄漏安全阀正常', '一处警示牌歪斜', '已扶正固定', '/ai/20260424/pipeline.jpg', 'admin', '2026-04-24 16:30:00', 'admin', '2026-04-24 16:30:00', '完成', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (10, 'RES20260425001', 4, '北区海岸巡查', 'Mavic 3E', '北区海岸线C线', '赵丽', '海岸线巡查中未完成', '发现部分垃圾带', '已记录位置待清理', '/ai/20260425/coast_garbage.jpg', 'admin', '2026-04-21 10:00:00', 'admin', '2026-04-21 10:00:00', '执行中', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (11, 'RES20260425002', 9, '工业园区监测', 'M30T', '工业园区E线', '林晨', '监测未完成实时数据已传', '一处疑似烟雾排放', '已通知环保部门', '/ai/20260425/smoke.jpg', 'admin', '2026-04-22 15:00:00', 'admin', '2026-04-22 15:00:00', '执行中', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (12, 'RES20260425003', 12, '港口物流区', '精灵4RTK', '港口物流区F线', '张明', '执行中未结束车辆识别正常', '多辆货车违停', '已上报交警', '/ai/20260425/truck.jpg', 'admin', '2026-04-23 16:30:00', 'admin', '2026-04-23 16:30:00', '执行中', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (13, 'RES20260425004', 17, '高铁沿线排查', '大疆机场', '高铁沿线J线', '吴迪', '排查未完成已发现异物', '接触网上有塑料膜', '紧急调度清理', '/ai/20260425/plastic.jpg', 'admin', '2026-04-25 10:00:00', 'admin', '2026-04-25 10:00:00', '执行中', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (14, 'RES20260425005', 20, '夜航测试', 'Matrice 350', '夜航测试线', '郭峰', '测试中图像清晰照明良好', '无特殊发现', '继续测试', '/ai/20260425/night.jpg', 'admin', '2026-04-25 19:30:00', 'admin', '2026-04-25 19:30:00', '执行中', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (15, 'RES20260420004', 6, '河道排污排查', 'FlyCart 30', '河道巡检A线', '周梅', '任务未执行', NULL, NULL, NULL, 'admin', '2026-04-21 16:00:00', 'admin', '2026-04-21 16:00:00', '待执行', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (16, 'RES20260420005', 7, '山林防火', '精灵4多光谱', '山林防火1号', '吴迪', '任务已取消', NULL, NULL, NULL, 'admin', '2026-04-22 08:30:00', 'admin', '2026-04-22 08:30:00', '已取消', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (17, 'RES20260425006', 14, '考古遗址巡查', 'Mavic 3E', '考古遗址区G线', '赵丽', '未开始', NULL, NULL, NULL, 'admin', '2026-04-24 10:00:00', 'admin', '2026-04-24 10:00:00', '待执行', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (18, 'RES20260425007', 15, '风电叶片检查', 'Autel Evo II', '风电巡检H线', '孙阳', '未开始', NULL, NULL, NULL, 'admin', '2026-04-24 14:00:00', 'admin', '2026-04-24 14:00:00', '待执行', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (19, 'RES20260425008', 18, '自然保护区禁飞', 'Mini 4 Pro', '自然保护区K线', '郑爽', '已取消', NULL, NULL, NULL, 'admin', '2026-04-25 10:30:00', 'admin', '2026-04-25 10:30:00', '因天气取消', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (20, 'RES20260425009', 19, '城区早高峰', 'M30T', '城区早高峰L线', '林晨', '待执行', NULL, NULL, NULL, 'admin', '2026-04-25 07:30:00', 'admin', '2026-04-25 07:30:00', '未开始', NULL, NULL, NULL);
INSERT INTO `sys_uav_result` VALUES (21, 'RES-1777202258116', 20, '夜航测试', 'Matrice 350', '夜航测试线', '郭峰', '本次巡防任务正常完成，无异常情况', NULL, '', 'http://localhost:8081/profile/upload/result/2026/04/26/R-C_20260426205526A004.jpg', '', '2026-04-26 19:17:38', '', '2026-04-26 20:55:29', NULL, 1, '2026-04-26 19:17:38', '[[116.395000,39.915000],[116.415000,39.920000],[116.435000,39.917000],[116.445000,39.925000],[116.425000,39.930000],[116.405000,39.923000]]');
INSERT INTO `sys_uav_result` VALUES (22, '11', 17, '高铁沿线排查', '精灵4多光谱', '高铁沿线J线', '吴迪', '图像显示一处交通检查站，车辆密集排队，存在拥堵现象。部分车辆停放在非指定区域，可能影响通行效率。', '图像显示一处交通检查站，车辆密集排队，存在拥堵现象。部分车辆停放在非指定区域，可能影响通行效率。', '建议通知相关部门加强现场指挥调度，引导车辆有序通行。同时安排人工复核，确保检查流程高效安全。', 'http://localhost:8081/profile/upload/result/2026/04/26/R-C_20260426223900A002.jpg', '', '2026-04-26 22:39:06', '', NULL, '天气晴朗，光照充足，图像清晰度较高，能够清晰识别车辆及人员分布情况。', 0, '2026-04-26 22:38:51', NULL);

-- ----------------------------
-- Table structure for sys_uav_route
-- ----------------------------
DROP TABLE IF EXISTS `sys_uav_route`;
CREATE TABLE `sys_uav_route`  (
  `route_id` bigint NOT NULL AUTO_INCREMENT COMMENT '航线ID',
  `route_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '航线名称',
  `estimated_time` int NULL DEFAULT 0 COMMENT '预计时长(分钟)',
  `flight_altitude` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '飞行高度(米)',
  `route_points` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '航线点位(JSON格式)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`route_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '巡航航线表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_uav_route
-- ----------------------------
INSERT INTO `sys_uav_route` VALUES (1, '环湖1号航线', 25, 120.00, '[[116.391042,39.922081],[116.533125,39.922865],[116.535169,39.841289],[116.385931,39.840505],[116.38542,39.922081],[116.399219,39.922081]]', 'admin', '2026-01-05 10:00:00', 'admin', '2026-03-01 09:00:00', '湖泊巡检，6个航点');
INSERT INTO `sys_uav_route` VALUES (2, '东区高压线A线', 40, 80.00, '[[116.400000,39.910000],[116.420000,39.915000],[116.440000,39.912000],[116.450000,39.920000],[116.430000,39.925000],[116.410000,39.918000]]', 'admin', '2026-01-12 11:30:00', 'admin', '2026-03-05 10:20:00', '电力巡检，6个航点');
INSERT INTO `sys_uav_route` VALUES (3, '西区农田B线', 30, 100.00, '[[116.350000,39.880000],[116.370000,39.885000],[116.390000,39.882000],[116.400000,39.890000],[116.380000,39.895000],[116.360000,39.888000]]', 'admin', '2026-01-18 09:15:00', 'admin', '2026-03-10 14:00:00', '农业监测，6个航点');
INSERT INTO `sys_uav_route` VALUES (4, '北区海岸线C线', 50, 150.00, '[[116.500000,39.950000],[116.520000,39.955000],[116.540000,39.952000],[116.550000,39.960000],[116.530000,39.965000],[116.510000,39.958000]]', 'admin', '2026-02-01 14:00:00', 'admin', '2026-03-12 11:30:00', '海岸巡查，6个航点');
INSERT INTO `sys_uav_route` VALUES (5, '南区建筑群D线', 22, 130.00, '[[116.380000,39.830000],[116.400000,39.835000],[116.420000,39.832000],[116.430000,39.840000],[116.410000,39.845000],[116.390000,39.838000]]', 'admin', '2026-02-10 10:45:00', 'admin', '2026-03-15 09:50:00', '违建监测，6个航点');
INSERT INTO `sys_uav_route` VALUES (6, '河道巡检A线', 35, 60.00, '[[116.420000,39.900000],[116.440000,39.905000],[116.460000,39.902000],[116.470000,39.910000],[116.450000,39.915000],[116.430000,39.908000]]', 'admin', '2026-02-15 13:20:00', 'admin', '2026-03-18 15:10:00', '排污口排查，6个航点');
INSERT INTO `sys_uav_route` VALUES (7, '山林防火1号', 45, 200.00, '[[116.550000,39.980000],[116.570000,39.985000],[116.590000,39.982000],[116.600000,39.990000],[116.580000,39.995000],[116.560000,39.988000]]', 'admin', '2026-02-20 16:00:00', 'admin', '2026-03-20 08:40:00', '热成像识别，6个航点');
INSERT INTO `sys_uav_route` VALUES (8, '水库大坝线', 28, 90.00, '[[116.450000,39.860000],[116.470000,39.865000],[116.490000,39.862000],[116.500000,39.870000],[116.480000,39.875000],[116.460000,39.868000]]', 'admin', '2026-02-25 09:30:00', 'admin', '2026-03-22 10:10:00', '坝体巡检，6个航点');
INSERT INTO `sys_uav_route` VALUES (9, '工业园区E线', 38, 110.00, '[[116.410000,39.850000],[116.430000,39.855000],[116.450000,39.852000],[116.460000,39.860000],[116.440000,39.865000],[116.420000,39.858000]]', 'admin', '2026-03-01 11:00:00', 'admin', '2026-03-25 13:30:00', '废气排放监测，6个航点');
INSERT INTO `sys_uav_route` VALUES (10, '野生动物走廊', 60, 180.00, '[[116.600000,40.000000],[116.620000,40.005000],[116.640000,40.002000],[116.650000,40.010000],[116.630000,40.015000],[116.610000,40.008000]]', 'admin', '2026-03-05 14:50:00', 'admin', '2026-03-28 09:00:00', '生态监测，6个航点');
INSERT INTO `sys_uav_route` VALUES (11, '城市风貌线', 33, 140.00, '[[116.390000,39.920000],[116.410000,39.925000],[116.430000,39.922000],[116.440000,39.930000],[116.420000,39.935000],[116.400000,39.928000]]', 'admin', '2026-03-10 08:10:00', 'admin', '2026-03-30 16:20:00', '宣传拍摄，6个航点');
INSERT INTO `sys_uav_route` VALUES (12, '港口物流区F线', 42, 70.00, '[[116.470000,39.930000],[116.490000,39.935000],[116.510000,39.932000],[116.520000,39.940000],[116.500000,39.945000],[116.480000,39.938000]]', 'admin', '2026-03-12 10:40:00', 'admin', '2026-04-01 14:10:00', '车辆监管，6个航点');
INSERT INTO `sys_uav_route` VALUES (13, '应急通道线', 20, 50.00, '[[116.370000,39.890000],[116.390000,39.895000],[116.410000,39.892000],[116.420000,39.900000],[116.400000,39.905000],[116.380000,39.898000]]', 'admin', '2026-03-15 13:15:00', 'admin', '2026-04-02 11:30:00', '快速响应，6个航点');
INSERT INTO `sys_uav_route` VALUES (14, '考古遗址区G线', 48, 85.00, '[[116.340000,39.870000],[116.360000,39.875000],[116.380000,39.872000],[116.390000,39.880000],[116.370000,39.885000],[116.350000,39.878000]]', 'admin', '2026-03-18 15:45:00', 'admin', '2026-04-05 09:45:00', '遗址保护，6个航点');
INSERT INTO `sys_uav_route` VALUES (15, '风电巡检H线', 55, 250.00, '[[116.650000,40.020000],[116.670000,40.025000],[116.690000,40.022000],[116.700000,40.030000],[116.680000,40.035000],[116.660000,40.028000]]', 'admin', '2026-03-20 09:25:00', 'admin', '2026-04-06 10:20:00', '叶片检查，6个航点');
INSERT INTO `sys_uav_route` VALUES (16, '油气管线I线', 44, 65.00, '[[116.440000,39.940000],[116.460000,39.945000],[116.480000,39.942000],[116.490000,39.950000],[116.470000,39.955000],[116.450000,39.948000]]', 'admin', '2026-03-22 11:50:00', 'admin', '2026-04-08 08:30:00', '泄漏巡查，6个航点');
INSERT INTO `sys_uav_route` VALUES (17, '高铁沿线J线', 52, 120.00, '[[116.480000,39.960000],[116.500000,39.965000],[116.520000,39.962000],[116.530000,39.970000],[116.510000,39.975000],[116.490000,39.968000]]', 'admin', '2026-03-25 14:20:00', 'admin', '2026-04-09 13:00:00', '异物排查，6个航点');
INSERT INTO `sys_uav_route` VALUES (18, '自然保护区K线', 58, 160.00, '[[116.580000,39.990000],[116.600000,39.995000],[116.620000,39.992000],[116.630000,40.000000],[116.610000,40.005000],[116.590000,39.998000]]', 'admin', '2026-03-28 16:10:00', 'admin', '2026-04-10 15:15:00', '禁止飞行区，6个航点');
INSERT INTO `sys_uav_route` VALUES (19, '城区早高峰L线', 27, 95.00, '[[116.400000,39.910000],[116.420000,39.915000],[116.440000,39.912000],[116.450000,39.920000],[116.430000,39.925000],[116.410000,39.918000]]', 'admin', '2026-04-01 07:30:00', 'admin', '2026-04-11 08:00:00', '交通监测，6个航点');
INSERT INTO `sys_uav_route` VALUES (20, '夜航测试线', 32, 110.00, '[[116.395000,39.915000],[116.415000,39.920000],[116.435000,39.917000],[116.445000,39.925000],[116.425000,39.930000],[116.405000,39.923000]]', 'admin', '2026-04-03 19:00:00', 'admin', '2026-04-12 20:30:00', '夜间照明测试，6个航点');

-- ----------------------------
-- Table structure for sys_uav_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_uav_task`;
CREATE TABLE `sys_uav_task`  (
  `task_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `equipment_id` bigint NOT NULL COMMENT '关联设备ID',
  `route_id` bigint NOT NULL COMMENT '关联航线ID',
  `executor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '执行人',
  `task_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '任务状态（0待执行 1执行中 2已完成 3已取消）',
  `progress` int NULL DEFAULT 0 COMMENT '任务进度(0-100)',
  `start_time` datetime NULL DEFAULT NULL COMMENT '实际开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '实际结束时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `task_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务描述',
  `status_history` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '状态变更记录',
  PRIMARY KEY (`task_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '巡航任务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_uav_task
-- ----------------------------
INSERT INTO `sys_uav_task` VALUES (1, '环湖巡检任务', 1, 1, '张明', '2', 100, '2026-04-20 08:00:00', '2026-04-20 08:35:00', 'admin', '2026-04-19 09:00:00', 'admin', '2026-04-20 08:40:00', '完成', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (2, '东区高压线巡检', 2, 2, '李芳', '2', 100, '2026-04-20 10:15:00', '2026-04-20 11:05:00', 'admin', '2026-04-20 08:30:00', 'admin', '2026-04-20 11:10:00', '完成', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (3, '西区农田监测', 3, 3, '王强', '2', 100, '2026-04-20 14:30:00', '2026-04-20 15:10:00', 'admin', '2026-04-20 10:00:00', 'admin', '2026-04-20 15:15:00', '完成', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (4, '北区海岸巡查', 4, 4, '赵丽', '1', 99, '2026-04-21 09:00:00', NULL, 'admin', '2026-04-20 14:00:00', 'admin', '2026-04-21 09:30:00', '执行中', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (5, '南区建筑群', 6, 5, '孙阳', '2', 100, '2026-04-21 13:20:00', '2026-04-21 13:55:00', 'admin', '2026-04-21 08:00:00', 'admin', '2026-04-21 14:00:00', '完成', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (6, '河道排污排查', 8, 6, '周梅', '0', 0, NULL, NULL, 'admin', '2026-04-21 15:30:00', 'admin', '2026-04-21 15:30:00', '待执行', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (7, '山林防火', 9, 7, '吴迪', '3', 0, NULL, NULL, 'admin', '2026-04-22 07:00:00', 'admin', '2026-04-22 08:00:00', '已取消', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (8, '水库大坝线', 11, 8, '郑爽', '2', 100, '2026-04-22 10:00:00', '2026-04-22 10:40:00', 'admin', '2026-04-21 16:00:00', 'admin', '2026-04-22 10:45:00', '完成', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (9, '工业园区监测', 13, 9, '林晨', '1', 99, '2026-04-22 14:15:00', NULL, 'admin', '2026-04-22 09:20:00', 'admin', '2026-04-22 14:30:00', '执行中', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (10, '野生动物走廊', 15, 10, '郭峰', '2', 100, '2026-04-23 07:30:00', '2026-04-23 08:50:00', 'admin', '2026-04-22 10:00:00', 'admin', '2026-04-23 09:00:00', '完成', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (11, '城市风貌航拍', 16, 11, '唐雅', '2', 100, '2026-04-23 11:00:00', '2026-04-23 11:45:00', 'admin', '2026-04-22 14:00:00', 'admin', '2026-04-23 11:50:00', '完成', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (12, '港口物流区', 1, 12, '张明', '1', 99, '2026-04-23 15:40:00', NULL, 'admin', '2026-04-23 08:00:00', 'admin', '2026-04-26 10:06:50', '执行中', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (13, '应急通道测试', 3, 13, '王强', '2', 100, '2026-04-24 08:20:00', '2026-04-24 08:45:00', 'admin', '2026-04-23 11:00:00', 'admin', '2026-04-24 08:50:00', '完成', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (14, '考古遗址巡查', 4, 14, '赵丽', '0', 0, NULL, NULL, 'admin', '2026-04-24 09:30:00', 'admin', '2026-04-24 09:30:00', '待执行', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (15, '风电叶片检查', 6, 15, '孙阳', '1', 99, '2026-04-26 10:19:42', NULL, 'admin', '2026-04-24 13:00:00', 'admin', '2026-04-26 10:20:32', '待执行', NULL, '2026-04-26 10:19:42|执行中|开始任务');
INSERT INTO `sys_uav_task` VALUES (16, '油气管线', 8, 16, '周梅', '2', 100, '2026-04-24 15:00:00', '2026-04-24 15:55:00', 'admin', '2026-04-24 10:00:00', 'admin', '2026-04-24 16:00:00', '完成', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (17, '高铁沿线排查', 9, 17, '吴迪', '1', 99, '2026-04-25 09:10:00', NULL, 'admin', '2026-04-24 14:00:00', 'admin', '2026-04-26 18:02:24', '执行中', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (18, '自然保护区禁飞', 11, 18, '郑爽', '3', 0, NULL, NULL, 'admin', '2026-04-25 11:30:00', 'admin', '2026-04-25 10:00:00', '因天气取消', NULL, NULL);
INSERT INTO `sys_uav_task` VALUES (19, '城区早高峰', 13, 19, '林晨', '1', 100, '2026-04-26 19:17:21', NULL, 'admin', '2026-04-25 07:00:00', 'admin', '2026-04-26 19:17:36', '待执行', NULL, '2026-04-26 10:19:18|执行中|开始任务\n2026-04-26 19:16:49|待执行|暂停任务并释放设备\n2026-04-26 19:17:21|执行中|开始任务');
INSERT INTO `sys_uav_task` VALUES (20, '夜航测试', 16, 20, '郭峰', '2', 100, '2026-04-26 19:17:00', '2026-04-26 19:17:38', 'admin', '2026-04-25 15:00:00', 'admin', '2026-04-26 19:17:38', '执行中', NULL, '2026-04-26 19:16:44|待执行|暂停任务并释放设备\n2026-04-26 19:16:59|执行中|开始任务\n2026-04-26 19:17:38|已完成|完成任务');
INSERT INTO `sys_uav_task` VALUES (21, '11', 1, 3, '1', '3', 0, '2026-04-26 10:37:00', '2026-04-26 10:37:10', '', '2026-04-26 10:36:55', '', '2026-04-26 10:37:11', NULL, NULL, '2026-04-26 10:36:54|待执行|创建任务\n2026-04-26 10:37:00|执行中|开始任务\n2026-04-26 10:37:10|已取消|取消任务');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-04-26 21:48:32', '2026-04-24 23:33:23', 'admin', '2026-04-24 23:33:23', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-04-24 23:33:23', '2026-04-24 23:33:23', 'admin', '2026-04-24 23:33:23', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, NULL, 'NPC1', 'NPC1', '00', '', '', '0', '', '$2a$10$D5UupaCSQmUQWNQLhwgMhuU0DmgkvSa2h4MEL9FtQ0/wIqT6PfGom', '0', '0', '', NULL, NULL, 'admin', '2026-04-25 00:36:28', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (101, NULL, 'NPC2', 'NPC2', '00', '', '', '0', '', '$2a$10$f5G353wGt.C5mYhHIBBPve3ksj4/0iAxpvrxgrhviuddBwYWBRONa', '0', '0', '', NULL, NULL, 'admin', '2026-04-25 00:37:30', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (102, NULL, 'NPC3', 'NPC3', '00', '', '', '0', '', '$2a$10$Sy8FYXhvQEWeGyxwca6meOhRoH8AJWifT/XjzdQ/q2KamSMN4jdC.', '0', '0', '', NULL, NULL, 'admin', '2026-04-25 00:41:56', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 2);
INSERT INTO `sys_user_role` VALUES (101, 2);

SET FOREIGN_KEY_CHECKS = 1;
