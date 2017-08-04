# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.24)
# Database: spark_jobs
# Generation Time: 2017-07-18 09:43:08 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table t_params_conf
# ------------------------------------------------------------

CREATE TABLE `t_params_conf` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `params` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_spark_application
# ------------------------------------------------------------

CREATE TABLE `t_spark_application` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `applicationId` text,
  `parentApplicationId` text,
  `url` text,
  `source` text,
  `beforeShell` text,
  `afterShell` text,
  `keepRunning` int(11) DEFAULT NULL,
  `watchInterval` int(11) DEFAULT NULL,
  `startTime` bigint(20) DEFAULT NULL,
  `endTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_spark_application_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `t_spark_application_log`;

CREATE TABLE `t_spark_application_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `appId` int(11) unsigned NOT NULL,
  `applicationId` text,
  `url` text,
  `source` text,
  `parentApplicationId` text,
  `failReason` text,
  `startTime` bigint(20) NOT NULL,
  `endTime` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_spark_jar
# ------------------------------------------------------------

CREATE TABLE `t_spark_jar` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(512) DEFAULT NULL,
  `path` text,
  `createTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_test_conf
# ------------------------------------------------------------

CREATE TABLE `t_test_conf` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` text,
  `user` text,
  `url` text,
  `host` text,
  `insert_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table t_spark_job_parameter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `t_spark_job_parameter`;

CREATE TABLE `t_spark_job_parameter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` text,
  `priority` int(11) DEFAULT NULL,
  `description` text,
  `label` text,
  `parameterType` text,
  `actionType` text,
  `parentName` text,
  `comment` text,
  `app` text,
  `formType` text,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `t_spark_job_parameter` WRITE;
/*!40000 ALTER TABLE `t_spark_job_parameter` DISABLE KEYS */;

INSERT INTO `t_spark_job_parameter` (`id`, `name`, `priority`, `description`, `label`, `parameterType`, `actionType`, `parentName`, `comment`, `app`, `formType`, `value`)
VALUES
  (1,'mmspark.name',1,'','Yarn上显示名','string','normal',NULL,'','spark','normal',''),
  (2,'mmspark.streaming.name',1,'','SparkUI显示名称','string','normal',NULL,'','spark','normal',''),
  (3,'mmspark.main_jar',1,'','jar包选择','string','select',NULL,'','jar','select',''),
  (4,'mmspark.streaming.job.file.path',1,'','配置文件','string','normal',NULL,'','spark','normal',''),
  (5,'mmspark.streaming.kafka.offsetPath',1,'','Kafka offset 保存目录','string','normal','mmspark.streaming.platform','','spark','normal',''),
  (6,'mmspark.streaming.platform',1,'','平台','string','select',NULL,'','spark','select',''),
  (7,'mmspark.streaming.rest',1,'','打开http接口','string','select',NULL,'','spark','select',''),
  (8,'mmspark.streaming.spark.service',1,'','后台服务','string','select',NULL,'','spark','select',''),
  (9,'mmspark.streaming.driver.port',1,'','http端口','string','normal','mmspark.streaming.rest','','spark','normal','9003'),
  (10,'mmspark.streaming.enableHiveSupport',1,'','启用Hive支持','string','select',NULL,'','spark','select',''),
  (11,'mmspark.streaming.job.cancel',1,'','启用查询超时功能','string','select',NULL,'','spark','select',''),
  (12,'mmspark.master',2,'','master','string','select',NULL,'','spark','select',''),
  (13,'mmspark.deploy-mode',2,'','deploy-mode','string','select',NULL,'','spark','select',''),
  (14,'mmspark.spark.shuffle.manager',2,'','shuffle管理器','string','select',NULL,'','spark','select',''),
  (15,'mmspark.spark.storage.memoryFraction',2,'','存储内存比例','string','select',NULL,'','spark','select',''),
  (16,'mmspark.executor-cores',2,'','单Executor 核数','string','select',NULL,'','spark','select',''),
  (17,'mmspark.spark.locality.wait',2,'','本地性','string','select',NULL,'','spark','select',''),
  (18,'mmspark.spark.speculation',2,'','speculation','string','select',NULL,'','spark','select',''),
  (19,'mmspark.spark.speculation.quantile',2,'','speculation.quantile','string','normal','mmspark.spark.speculation','','spark','normal',''),
  (20,'mmspark.spark.speculation.interval',2,'','speculation.interval','string','normal','mmspark.spark.speculation','','spark','normal',''),
  (21,'mmspark.spark.speculation.multiplier',2,'','speculation.multiplier','string','normal','mmspark.spark.speculation','','spark','normal',''),
  (22,'mmspark.spark.dynamicAllocation.enabled',2,'','dynamicAllocation','string','select',NULL,'','spark','select',''),
  (23,'mmspark.spark.sql.shuffle.partitions',2,'','shuffle分区数','string','normal',NULL,'','spark','normal','9'),
  (24,'mmspark.spark.kryoserializer.buffer.max',2,'','kryoserializer buffer','string','normal',NULL,'','spark','normal','1024m'),
  (25,'mmspark.spark.serializer',2,'kyro更快，但通用性略差','序列化','string','select',NULL,'','spark','select',''),
  (26,'mmspark.spark.io.compression.codec',2,'','压缩方式','string','select',NULL,'','spark','select',''),
  (27,'mmspark.spark.executor.extraJavaOptions',2,'','Executor JVM配置','string','normal',NULL,'','-','normal','-XX:MaxPermSize=512m -XX:PermSize=128m'),
  (28,'mmspark.spark.driver.extraJavaOptions',2,'','Driver JVM配置','string','normal',NULL,'','-','normal','-XX:MaxPermSize=512m -XX:PermSize=128m'),
  (29,'AppType',2,'','应用类型','string','select',NULL,'','spark','select',''),
  (30,'mmspark.class',3,'','启动类','string','normal',NULL,'','-','normal','streaming.core.StreamingApp'),
  (31,'mmspark.num-executors',3,'','Executor数','string','normal',NULL,'','-','normal','1'),
  (32,'mmspark.executor-memory',3,'','Executor内存','string','normal',NULL,'','-','normal','3g'),
  (33,'mmspark.driver-memory',3,'','Driver内存','string','normal',NULL,'','-','normal','4g'),
  (34,'mmspark.args',3,'应用的额外参数，譬如如果需要升级等需要加-upgrade参数等','应用参数','string','normal',NULL,'','-','normal','');

/*!40000 ALTER TABLE `t_spark_job_parameter` ENABLE KEYS */;
UNLOCK TABLES;

# Dump of table t_spark_job_parameter_values
# ------------------------------------------------------------

DROP TABLE IF EXISTS `t_spark_job_parameter_values`;

CREATE TABLE `t_spark_job_parameter_values` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` text,
  `formType` text,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
