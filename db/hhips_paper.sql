-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: hhips
-- ------------------------------------------------------
-- Server version	5.7.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `paper`
--

DROP TABLE IF EXISTS `paper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paper` (
  `idpaper` int(11) NOT NULL AUTO_INCREMENT,
  `papername` varchar(45) DEFAULT NULL,
  `paperdate` datetime DEFAULT NULL,
  `isactive` int(11) DEFAULT '1' COMMENT '1=in edit\n2=active, cannot edit\n3=finished, no edit, no work anymore\n4=on hold, no edit, no work\n5=archive',
  PRIMARY KEY (`idpaper`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paper`
--

LOCK TABLES `paper` WRITE;
/*!40000 ALTER TABLE `paper` DISABLE KEYS */;
INSERT INTO `paper` VALUES (1,'四春期末复习行程问题一','2018-06-10 00:00:00',5),(2,'四春期末复习加乘一','2018-06-12 00:00:00',5),(3,'四春期末复习几何一','2018-06-20 00:00:00',5),(4,'四春期末复习行程问题二','2018-06-16 20:00:00',5),(5,'mytestpaper','2018-06-18 00:00:00',5),(6,'四春牛吃草课后巩固','2018-06-17 00:00:00',5),(7,'四春期末复习数论一','2018-06-20 00:00:00',5),(8,'四春期末复习最值一','2018-06-21 00:00:00',5),(9,'四春数阵图课后巩固','2018-06-24 00:00:00',5),(10,'四春期末复习数论二','2018-06-24 00:00:00',5),(11,'四春期末复习计算+逻辑','2018-06-25 00:00:00',5),(12,'四春期末复习综合一','2018-06-26 06:21:31',5),(13,'四春期末复习综合Last Time','2018-06-28 20:50:16',5),(14,'四春期末复习综合一波波','2018-07-01 21:45:27',5),(15,'四升五行程专项练习一','2018-07-02 22:05:04',5),(16,'四升五数列数表专项练习一','2018-07-03 06:52:14',5),(17,'四升五书写练习','2018-07-05 21:09:59',5),(18,'四升五计算练习','2018-07-06 06:22:37',5),(19,'四升五数论整除特征复习巩固','2018-07-06 06:24:14',5),(20,'四升五数论包含与排除综合复习','2018-07-06 06:34:18',5),(21,'四升五开心逻推','2018-07-08 09:50:36',5),(22,'孙佳俊模块课学习','2018-07-15 09:03:28',4),(23,'五暑几何复习综合','2018-07-15 12:02:58',5),(24,'五暑行程巩固练习','2018-07-17 06:49:28',5),(25,'五暑几何复习学学卷','2018-07-18 21:51:53',5),(26,'五暑数论复习哈哈卷','2018-07-19 06:46:43',5),(27,'五暑行程臊子面卷','2018-07-20 18:31:20',5),(28,'五暑几何access卷','2018-07-23 19:56:36',5),(29,'五暑数论article卷','2018-07-30 19:01:46',5),(30,'五暑应用题attention卷','2018-07-31 16:38:59',5),(31,'五暑应用题bloom卷','2018-08-06 18:28:51',5),(32,'五暑计数appear卷','2018-08-06 20:22:40',2),(33,'五暑因数倍数课后练习','2018-08-17 22:00:07',5),(34,'五暑标数法课后练习','2018-08-18 17:39:02',5),(35,'五暑找规律课后练习','2018-08-19 18:21:44',5),(36,'五暑棋盘中的奥秘课后练习','2018-08-20 20:57:05',5),(37,'五暑分数加减课后练习','2018-08-22 18:36:29',5),(38,'五暑预习','2018-08-24 20:44:34',5),(39,'五暑站七坐五蹲三课后作业','2018-08-25 17:08:29',5),(40,'五暑鸟头课后作业','2018-08-26 16:40:54',5),(41,'五暑计算练习','2018-08-26 17:42:23',2),(42,'五暑容斥原理作业','2018-08-27 17:31:36',5),(43,'五暑排列分组课后作业','2018-08-28 17:28:25',5),(44,'五暑扶梯课后作业','2018-08-29 18:16:31',5),(45,'五暑行程方程作业','2018-08-30 17:19:22',4),(46,'五暑分久必合质因数课后作业','2018-09-03 18:31:21',4),(47,'五秋应用题control卷','2018-09-05 21:49:12',4),(48,'五秋余数的性质','2018-09-09 09:22:33',2),(49,'五秋优才一分数计算作业','2018-09-09 20:07:47',4),(50,'五秋几何design卷','2018-09-10 06:44:19',4),(51,'五秋xes2分数计算课后','2018-09-12 18:10:32',4);
/*!40000 ALTER TABLE `paper` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-15 18:03:07
