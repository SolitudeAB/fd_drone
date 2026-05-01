-- 2026-04-26
-- Purpose:
-- 1) Grant role=2 (common) read-only access to UAV modules (menu + list/query buttons).
-- 2) Align UAV equipment status dict with DB comment, and add "离线" status for requirements.
--
-- Notes:
-- - This script is safe to run multiple times (uses INSERT IGNORE where possible).
-- - If your MySQL version does not support INSERT IGNORE for the target table, remove IGNORE and run once.

/* -----------------------------
 * 1) Role=2 read-only UAV menus
 * -----------------------------
 * Menus in sql/ruoair.sql:
 * - 2000 设备(C)   2001 查询(F) 2002新增 2003改 2004删 2005导出
 * - 2012 航线(C)   2013 查询(F) 2014新增 2015改 2016删 2017导出
 * - 2018 任务(C)   2019 查询(F) 2020新增 2021改 2022删 2023导出
 * - 2006 结果(C)   2007 查询(F) 2008新增 2009改 2010删 2011导出
 *
 * Read-only for common:
 * - Grant C menu + query(F) only
 */
INSERT IGNORE INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
  (2, 2000),
  (2, 2001),
  (2, 2012),
  (2, 2013),
  (2, 2018),
  (2, 2019),
  (2, 2006),
  (2, 2007);

/* ------------------------------------------
 * 2) UAV equipment status dict improvements
 * ------------------------------------------
 * Requirement mentions: 正常 / 维修中 / 离线 / 任务中
 * Current DB comment: 0正常 1维修 2已报废 3任务中
 *
 * Strategy:
 * - Keep existing codes 0/1/2/3.
 * - Rename dict label for value=1 to "维修中" (was "维修") to match requirement wording.
 * - Rename dict label for value=2 to "已报废" (was "停用") to match DB comment.
 * - Add new value=4 "离线" for simulation usage (optional).
 */

-- Rename value=1 label to 维修中
UPDATE `sys_dict_data`
SET `dict_label` = '维修中', `update_by` = 'admin', `update_time` = NOW()
WHERE `dict_type` = 'sys_uav_status' AND `dict_value` = '1';

-- Rename value=2 label to �ѱ���
UPDATE `sys_dict_data`
SET `dict_label` = '已报废', `update_by` = 'admin', `update_time` = NOW()
WHERE `dict_type` = 'sys_uav_status' AND `dict_value` = '2';

-- Add 离线(4) if not exists
INSERT IGNORE INTO `sys_dict_data`
(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `remark`)
VALUES
(108, 4, '离线', '4', 'sys_uav_status', NULL, 'info', 'N', '0', 'admin', NOW(), '需求补齐：离线(模拟)');

-- Update dict type remark to include 4=离线
UPDATE `sys_dict_type`
SET `remark` = '0-正常, 1-维修中, 2-已报废, 3-任务中, 4-离线'
WHERE `dict_type` = 'sys_uav_status';

