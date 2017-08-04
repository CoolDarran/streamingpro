CREATE USER 'streamingpro'@'%' IDENTIFIED BY 'Streaming#123';
DROP DATABASE IF EXISTS `db.streamingpro`;
CREATE DATABASE `db_streamingpro` CHARSET=utf8mb4;
GRANT ALL ON db_streamingpro.* TO 'streamingpro'@'localhost' IDENTIFIED BY 'Streaming#123';
GRANT ALL ON db_streamingpro.* TO 'streamingpro'@'%' IDENTIFIED BY 'Streaming#123';
FLUSH privileges;