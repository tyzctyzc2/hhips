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
-- Table structure for table `timecounterlookup`
--

DROP TABLE IF EXISTS `timecounterlookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timecounterlookup` (
  `idtimecounterlookup` int(11) NOT NULL AUTO_INCREMENT,
  `timecounterdescription` varchar(45) DEFAULT NULL,
  `timecounterimage` varchar(45) DEFAULT NULL,
  `timecountertype` int(11) DEFAULT '1' COMMENT '1=time based counter\n2=value based counter',
  `maxtime` int(11) DEFAULT NULL,
  `besttime` int(11) DEFAULT '0',
  `bestcount` int(11) DEFAULT '500',
  PRIMARY KEY (`idtimecounterlookup`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timecounterlookup`
--

LOCK TABLES `timecounterlookup` WRITE;
/*!40000 ALTER TABLE `timecounterlookup` DISABLE KEYS */;
INSERT INTO `timecounterlookup` VALUES (1,'早膳','201809\\20180908_t1.jpg',1,600,300,500),(2,'晚膳','201809\\20180908_t2.jpg',1,1800,1200,500),(3,'刷牙','201809\\20180908_t3.jpg',1,300,200,500),(4,'仰卧起坐','201809\\20180908_t4.jpg',2,60,0,35),(5,'跳绳','201809\\20180908_t5.jpg',2,60,0,180),(6,'吃水果','201809\\20180908_t6.jpg',1,900,600,0);
/*!40000 ALTER TABLE `timecounterlookup` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-07  7:41:46
