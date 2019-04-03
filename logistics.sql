/*
Navicat MySQL Data Transfer

Source Server         : 前端测试服务器
Source Server Version : 50635
Source Host           : 192.168.1.222:3306
Source Database       : logistics

Target Server Type    : MYSQL
Target Server Version : 50635
File Encoding         : 65001

Date: 2019-04-03 10:32:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth` (
  `authid` varchar(30) NOT NULL,
  `authname` varchar(50) NOT NULL,
  `authtype` char(1) NOT NULL,
  `authicon` varchar(250) NOT NULL,
  `parentid` varchar(30) NOT NULL,
  `authcomment` varchar(250) NOT NULL,
  `authurl` varchar(250) NOT NULL,
  `status` char(1) NOT NULL,
  `sortid` char(4) NOT NULL,
  `authflag` char(1) NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`authid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES ('cfdzQxDc', '内容管理', 'M', '', 'ROOT', '内容管理', '内容管理', '1', '2', '1', '2019-03-19 11:28:44');
INSERT INTO `auth` VALUES ('d7ZBnTFW', '权限管理', 'M', '', 'sc2ATAwx', '权限管理', '/auth', '1', '3', '1', '2019-04-01 11:00:13');
INSERT INTO `auth` VALUES ('dJdTEzYA', '栏目查询', 'F', '', 'Hm7AQstQ', '栏目查询', '/cat/getcatlist', '1', '1', '1', '2018-08-28 14:45:08');
INSERT INTO `auth` VALUES ('e6px22rs', '会员管理', 'M', '', 'sc2ATAwx', '会员管理', '/vip', '1', '4', '1', '2019-04-01 11:00:17');
INSERT INTO `auth` VALUES ('EBpZdM4D', '修改用户', 'F', '', 'T4MRD3jw', '修改用户', '/user/edit', '1', '2', '1', '2019-04-01 11:00:20');
INSERT INTO `auth` VALUES ('HdxDckri', '新增角色', 'F', '', 'MhaCpZiQ', '新增角色', '/role/add', '1', '2', '1', '2018-11-15 11:07:46');
INSERT INTO `auth` VALUES ('HdYyYsGn', '删除用户', 'F', '', 'T4MRD3jw', '删除用户', '/user/del', '1', '3', '1', '2019-04-01 11:00:23');
INSERT INTO `auth` VALUES ('Hm7AQstQ', '栏目管理', 'M', '', 'cfdzQxDc', '栏目管理', '/category', '1', '1', '1', '2019-04-01 11:00:25');
INSERT INTO `auth` VALUES ('j8DyfQB4', '添加新用户', 'F', '', 'T4MRD3jw', '添加新用户', '/users/add', '1', '1', '1', '2019-04-02 09:36:13');
INSERT INTO `auth` VALUES ('JaDpHEiS', '查询角色', 'F', '', 'MhaCpZiQ', '查询角色', '/role/getrolelist', '1', '3', '1', '2018-11-15 11:08:03');
INSERT INTO `auth` VALUES ('Kbk25Hzc', '用户模糊查询', 'F', '', 'T4MRD3jw', '用户模糊查询', '/user/sys_getuserbylike', '1', '5', '1', '2019-04-01 11:00:33');
INSERT INTO `auth` VALUES ('MhaCpZiQ', '角色管理', 'M', '', 'sc2ATAwx', '角色管理', '/role', '1', '1', '1', '2019-04-01 11:00:36');
INSERT INTO `auth` VALUES ('MzpZye55', '查询会员', 'F', '', 'e6px22rs', '查询会员', '/vip/getvipbyfilter', '1', '1', '1', '2019-04-01 11:00:39');
INSERT INTO `auth` VALUES ('pd6Cb4ET', '查询所有用户', 'F', '', 'T4MRD3jw', '查询所有用户', '/user/getuserlist_all', '1', '4', '1', '2019-04-01 11:00:42');
INSERT INTO `auth` VALUES ('px2aNr6R', '修改角色', 'F', '', 'MhaCpZiQ', '修改角色', '/role/edit', '1', '1', '1', '2019-04-01 11:00:45');
INSERT INTO `auth` VALUES ('RDnQDXJR', '栏目删除', 'F', '', 'Hm7AQstQ', '栏目删除', '/cat/del', '1', '4', '1', '2018-08-28 14:47:11');
INSERT INTO `auth` VALUES ('sc2ATAwx', '系统管理', 'M', '', 'ROOT', '系统管理', '系统管理', '1', '1', '1', '2019-04-01 11:00:49');
INSERT INTO `auth` VALUES ('sHT3er2n', '测试', 'M', '', 'cfdzQxDc', '测试管理', '/testing', '1', '1', '1', '2019-04-02 05:50:18');
INSERT INTO `auth` VALUES ('T4MRD3jw', '用户管理', 'M', '', 'sc2ATAwx', '用户管理', '/users', '1', '2', '1', '2019-04-02 02:04:07');
INSERT INTO `auth` VALUES ('WcRZ3jwc', '编辑会员', 'F', '', 'e6px22rs', '编辑会员', '/vip/update', '1', '2', '1', '2019-04-01 11:00:55');
INSERT INTO `auth` VALUES ('wR44zC4F', '删除角色', 'F', '', 'MhaCpZiQ', '删除角色', '/role/del', '1', '1', '1', '2019-04-01 11:00:59');
INSERT INTO `auth` VALUES ('xPfNMCjY', '栏目新增', 'F', '', 'Hm7AQstQ', '栏目新增', '/cat/add', '1', '2', '1', '2018-08-28 14:46:12');
INSERT INTO `auth` VALUES ('yRz8MzBT', '栏目修改', 'F', '', 'Hm7AQstQ', '栏目修改', '/cat/edit', '1', '3', '1', '2018-08-28 14:46:40');
INSERT INTO `auth` VALUES ('ZfJ3M3m6', '批量审核', 'F', '', 'e6px22rs', '批量审核', '/vip/batchaudit', '1', '3', '1', '2019-04-01 11:01:03');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `roleid` varchar(30) NOT NULL,
  `rolename` varchar(50) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `creattime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`rolename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('EexPke', 'lisa', '9999', '2019-03-29 05:43:39', '2019-04-02 02:45:16');
INSERT INTO `role` VALUES ('YdTt6Y', 'test132', '啦啦啦', '2018-12-28 09:46:51', '2018-12-28 09:47:06');
INSERT INTO `role` VALUES ('WG5xej', '专业委员会管理员', '专业委员会管理员', '2018-07-24 17:36:32', '2019-04-01 11:03:00');
INSERT INTO `role` VALUES ('3Q6zfr', '临床心理专业委员会', '临床心理专业委员会', '2018-07-24 17:36:33', '2019-04-01 11:03:05');
INSERT INTO `role` VALUES ('EZDG7i', '儿童、青少年心理援助专业委员会', '儿童、青少年心理援助专业委员会', '2018-07-24 17:36:34', '2019-04-01 11:03:08');
INSERT INTO `role` VALUES ('54JnKD', '初级管理员', '初级管理员1', '2019-04-02 06:50:37', '2019-04-03 02:24:26');
INSERT INTO `role` VALUES ('pshyFb', '员工心理援助专业委员会', '员工心理援助专业委员会', '2018-07-24 17:36:35', '2019-04-01 11:03:11');
INSERT INTO `role` VALUES ('7yhd4H', '婴幼儿心理与学前教育专业委员会', '婴幼儿心理与学前教育专业委员会', '2018-07-24 17:36:36', '2019-04-01 11:03:13');
INSERT INTO `role` VALUES ('EMrkh5', '心理健康专业委员会', '心理健康专业委员会', '2018-07-24 17:36:38', '2018-09-05 02:26:27');
INSERT INTO `role` VALUES ('aZxWzk', '心理咨询与治疗专业委员会', '心理咨询与治疗专业委员会', '2018-07-24 17:36:37', '2019-04-01 11:03:16');
INSERT INTO `role` VALUES ('skDtB7', '沙盘心理技术专业委员会', '沙盘心理技术专业委员会', '2018-07-24 17:36:39', '2019-04-01 11:03:18');
INSERT INTO `role` VALUES ('R3_A', '省学会管理员', '省学会管理员', '2018-07-24 17:38:32', '2019-04-01 11:03:23');
INSERT INTO `role` VALUES ('Xe74Q4', '精神分析专业委员会', '精神分析专业委员会', '2018-07-24 17:38:33', '2019-04-01 11:03:25');
INSERT INTO `role` VALUES ('R2_T', '系统管理员', '系统管理员', '2018-07-24 17:39:34', '2019-04-01 11:03:27');

-- ----------------------------
-- Table structure for roleauth
-- ----------------------------
DROP TABLE IF EXISTS `roleauth`;
CREATE TABLE `roleauth` (
  `roleid` varchar(30) NOT NULL,
  `authid` varchar(30) NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`roleid`,`authid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roleauth
-- ----------------------------
INSERT INTO `roleauth` VALUES ('2GcxGy', 'AM_FF_R2_SM_SM', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('2GcxGy', 'AM_FF_R2_SM_SM_01', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('2GcxGy', 'AM_FF_R2_SM_SM_02', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('2GcxGy', 'AM_FF_R2_SM_SM_03', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('2GcxGy', 'dBdffj5N', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('2GcxGy', 'iJem7bxT', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('2GcxGy', 'NPXQbc4B', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'dJdTEzYA', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'eNQGka7z', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'MzpZye55', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'PantmNyi', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'RDnQDXJR', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'WcRZ3jwc', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'WFjarhGh', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'xkjFXb7D', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'xPfNMCjY', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'yRz8MzBT', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'ZfJ3M3m6', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('3Q6zfr', 'zZNJ2SGa', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('445ahN', 'AM_FF_R2_SM_BD_09', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('445ahN', 'AM_FF_R2_SM_UM', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('445ahN', 'AM_FF_R2_SM_UM_01', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('445ahN', 'AM_FF_R2_SM_UM_02', '2018-09-05 10:32:25');
INSERT INTO `roleauth` VALUES ('54JnKD', 'dJdTEzYA', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'EBpZdM4D', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'HdxDckri', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'HdYyYsGn', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'j8DyfQB4', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'JaDpHEiS', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'Kbk25Hzc', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'pd6Cb4ET', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'px2aNr6R', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'RDnQDXJR', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'sHT3er2n', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'wR44zC4F', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'xPfNMCjY', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('54JnKD', 'yRz8MzBT', '2019-04-03 02:29:50');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'dJdTEzYA', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'eNQGka7z', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'MzpZye55', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'PantmNyi', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'RDnQDXJR', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'WcRZ3jwc', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'WFjarhGh', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'xkjFXb7D', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'xPfNMCjY', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'yRz8MzBT', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'ZfJ3M3m6', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('7yhd4H', 'zZNJ2SGa', '2018-09-05 10:31:49');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'd7ZBnTFW', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'dJdTEzYA', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'eNQGka7z', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'MzpZye55', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'PantmNyi', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'RDnQDXJR', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'WcRZ3jwc', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'WFjarhGh', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'xkjFXb7D', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'xPfNMCjY', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'yRz8MzBT', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'ZfJ3M3m6', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('aZxWzk', 'zZNJ2SGa', '2018-09-05 10:31:37');
INSERT INTO `roleauth` VALUES ('b8ZdpG', 'HdxDckri', '2018-08-30 14:25:46');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'dJdTEzYA', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'eNQGka7z', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'MzpZye55', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'PantmNyi', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'RDnQDXJR', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'WcRZ3jwc', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'WFjarhGh', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'xkjFXb7D', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'xPfNMCjY', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'yRz8MzBT', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'ZfJ3M3m6', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EMrkh5', 'zZNJ2SGa', '2018-09-05 10:31:08');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'dJdTEzYA', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'eNQGka7z', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'MzpZye55', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'PantmNyi', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'RDnQDXJR', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'WcRZ3jwc', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'WFjarhGh', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'xkjFXb7D', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'xPfNMCjY', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'yRz8MzBT', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'ZfJ3M3m6', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('EZDG7i', 'zZNJ2SGa', '2018-09-05 10:32:15');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'd7ZBnTFW', '2019-04-01 11:46:32');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'EBpZdM4D', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'HdxDckri', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'HdYyYsGn', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'j8DyfQB4', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'JaDpHEiS', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'Kbk25Hzc', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'MzpZye55', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'pd6Cb4ET', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'px2aNr6R', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'WcRZ3jwc', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'wR44zC4F', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('FSQDa8', 'ZfJ3M3m6', '2019-04-01 11:47:01');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'dJdTEzYA', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'eNQGka7z', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'PantmNyi', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'RDnQDXJR', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'srBHitMY', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'WFjarhGh', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'xkjFXb7D', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'xPfNMCjY', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'yRz8MzBT', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('GjkzHf', 'zZNJ2SGa', '2018-11-01 17:42:57');
INSERT INTO `roleauth` VALUES ('pshyFb', 'dJdTEzYA', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'eNQGka7z', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'MzpZye55', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'PantmNyi', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'RDnQDXJR', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'WcRZ3jwc', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'WFjarhGh', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'xkjFXb7D', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'xPfNMCjY', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'yRz8MzBT', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'ZfJ3M3m6', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('pshyFb', 'zZNJ2SGa', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_MS', 'AA_FF_WEB_MAIN_0_MS', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_MS', 'AM_FF_R0_MS', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_MS', 'AM_FF_R0_MS_MS', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_MS', 'AM_FF_R0_MS_MS_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_MS', 'AM_FF_R0_MS_MS_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_OM', 'AA_FF_WEB_MAIN_0_OM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_OM', 'AM_FF_R0_OM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_OM', 'AM_FF_R0_OM_OM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_OM', 'AM_FF_R0_OM_OM_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_OM', 'AM_FF_R0_OM_OM_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AA_FF_WEB_MAIN_0_SM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_BC', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_BC_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_BC_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SF', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SF_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SF_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SF_03', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SF_04', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SF_05', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SF_99', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SP', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SP_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SP_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R0_SM', 'AM_FF_R0_SM_SP_03', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R1_OM', 'AM_FF_R2_SM_BD_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_CS_M', 'AM_FF_R2_SM_SM_03', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_CS_M', 'dBdffj5N', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_CT', 'AA_FF_WEB_MAIN_2_CT', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_CT', 'AM_FF_R2_CT', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_CT', 'AM_FF_R2_CT_CM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_CT', 'AM_FF_R2_CT_CM_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_CT', 'AM_FF_R2_CT_CM_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_S', 'AA_FF_WEB_MAIN_2_S', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_S', 'AM_FF_R2_S', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_S', 'AM_FF_R2_S_CS', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_S', 'AM_FF_R2_S_CS_CA_VIEW', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_S', 'AM_FF_R2_S_CS_CC', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_S', 'AM_FF_R2_S_CS_CC_VIEW', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_S', 'AM_FF_R2_S_CS_VIEW', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AA_FF_WEB_MAIN_2_SM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_BD', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_BD_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_BD_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_BD_03', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_BD_04', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_BD_05', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_BD_06', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_BD_07', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_BD_08', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_SM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_SM_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_SM_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_SM_03', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_UM', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_UM_01', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SM', 'AM_FF_R2_SM_UM_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SP', 'AM_FF_R2_SM_BD_02', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SSM', 'JaDpHEiS', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SSM', 'MzpZye55', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SSM', 'pd6Cb4ET', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_SSM', 'xkjFXb7D', '2018-09-05 10:32:02');
INSERT INTO `roleauth` VALUES ('R2_T', 'd7ZBnTFW', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'dJdTEzYA', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'EBpZdM4D', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'HdxDckri', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'HdYyYsGn', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'j8DyfQB4', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'JaDpHEiS', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'Kbk25Hzc', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'pd6Cb4ET', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'px2aNr6R', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'RDnQDXJR', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'sHT3er2n', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'T4MRD3jw', '2019-04-02 14:53:41');
INSERT INTO `roleauth` VALUES ('R2_T', 'xPfNMCjY', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R2_T', 'yRz8MzBT', '2019-04-02 05:50:37');
INSERT INTO `roleauth` VALUES ('R3_A', 'd7ZBnTFW', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'dJdTEzYA', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'EBpZdM4D', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'eNQGka7z', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'HdxDckri', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'HdYyYsGn', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'j8DyfQB4', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'JaDpHEiS', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'Kbk25Hzc', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'MzpZye55', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'PantmNyi', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'pd6Cb4ET', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'px2aNr6R', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'RDnQDXJR', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'srBHitMY', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'TjDJzKtj', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'WcRZ3jwc', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'WFjarhGh', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'wR44zC4F', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'xkjFXb7D', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'xPfNMCjY', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'yRz8MzBT', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'ZfJ3M3m6', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('R3_A', 'zZNJ2SGa', '2018-08-28 14:56:15');
INSERT INTO `roleauth` VALUES ('skDtB7', 'dJdTEzYA', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'eNQGka7z', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'MzpZye55', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'PantmNyi', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'RDnQDXJR', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'WcRZ3jwc', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'WFjarhGh', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'xkjFXb7D', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'xPfNMCjY', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'yRz8MzBT', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'ZfJ3M3m6', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('skDtB7', 'zZNJ2SGa', '2018-09-05 10:30:53');
INSERT INTO `roleauth` VALUES ('WG5xej', 'dJdTEzYA', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'eNQGka7z', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'MzpZye55', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'PantmNyi', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'RDnQDXJR', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'WcRZ3jwc', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'WFjarhGh', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'xkjFXb7D', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'xPfNMCjY', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'yRz8MzBT', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'ZfJ3M3m6', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('WG5xej', 'zZNJ2SGa', '2018-09-05 10:32:33');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'dJdTEzYA', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'eNQGka7z', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'MzpZye55', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'PantmNyi', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'RDnQDXJR', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'WcRZ3jwc', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'WFjarhGh', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'xkjFXb7D', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'xPfNMCjY', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'yRz8MzBT', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'ZfJ3M3m6', '2018-09-05 10:30:40');
INSERT INTO `roleauth` VALUES ('Xe74Q4', 'zZNJ2SGa', '2018-09-05 10:30:40');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uuid` varchar(40) NOT NULL,
  `uname` varchar(30) NOT NULL,
  `utype` varchar(30) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `unickname` varchar(30) DEFAULT NULL,
  `valid` char(1) DEFAULT NULL,
  `upwd` varchar(50) NOT NULL,
  `ucomment` varchar(100) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `uicon` varchar(60) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `creattime` datetime NOT NULL,
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('0daf80e0-5524-11e9-ba2e-ad1961a9f596', 'admin6', 'R2_T', '', 'admin6', '', 'ZDcHmj385f7f48a880965d7f1f51cd036589007f', '', '1', '', '', '13509853638', '2019-04-02 08:48:14', '2019-04-03 01:50:52');
INSERT INTO `user` VALUES ('4f0c11a0-5526-11e9-a2aa-ad96ad5a5935', 'admin7', '54JnKD', '', 'admin7', '', 'kHC72Hy35c087c3a7c60580d9e7b6b276b0c1048', '', '1', '', '', '189', '2019-04-02 09:04:23', '2019-04-02 09:04:23');
INSERT INTO `user` VALUES ('5fc183e1-5cd4-11e8-8079-175e7557dfab', 'admin', 'R2_T', 'admin', 'admin', '1', 'j3KhH8AB91b95e5a4b638c972318f388e85e4705', null, '1', null, null, '709999', '2019-04-02 16:00:13', '2019-04-03 02:24:37');
INSERT INTO `user` VALUES ('6d1b50b0-551d-11e9-8baa-a9f220ff0602', 'admin2', '54JnKD', '', 'admin2', '', 'HSFsME2G0adffa714807b504a211c32c8853d5d4', '', '1', '', '', '999', '2019-04-02 08:00:48', '2019-04-02 08:24:16');
INSERT INTO `user` VALUES ('d1e25c40-5523-11e9-bfce-f517dba6f8cf', 'admin3', '54JnKD', '', 'admin3', '', 'pKkxBGf536a618ca374f192adbca30196832de14', '', '1', '', '', '13509853638', '2019-04-02 08:46:34', '2019-04-02 08:46:34');
