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
-- Table structure for table `daysummary`
--

DROP TABLE IF EXISTS `daysummary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daysummary` (
  `iddaysummary` int(11) NOT NULL AUTO_INCREMENT,
  `onday` datetime DEFAULT NULL,
  `totalminutes` int(11) DEFAULT NULL,
  `totalproblem` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddaysummary`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daysummary`
--

LOCK TABLES `daysummary` WRITE;
/*!40000 ALTER TABLE `daysummary` DISABLE KEYS */;
INSERT INTO `daysummary` VALUES (1,'2018-06-13 00:00:00',51,11,88),(2,'2018-06-15 00:00:00',61,9,23),(3,'2018-06-16 00:00:00',42,6,27),(4,'2018-06-17 00:00:00',83,25,114),(5,'2018-06-18 00:00:00',85,13,62),(6,'2018-06-19 00:00:00',74,18,151),(7,'2018-06-20 00:00:00',62,20,89),(8,'2018-06-22 00:00:00',56,15,123),(9,'2018-06-24 00:00:00',203,27,159),(10,'2018-06-25 00:00:00',128,24,134),(11,'2018-06-26 00:00:00',104,13,98),(12,'2018-06-27 00:00:00',77,20,119),(13,'2018-06-28 00:00:00',179,12,73),(14,'2018-06-29 00:00:00',181,19,136),(15,'2018-06-30 00:00:00',48,11,71),(16,'2018-07-01 00:00:00',119,15,124),(17,'2018-07-02 00:00:00',87,11,91),(18,'2018-07-03 00:00:00',109,7,80),(19,'2018-07-04 00:00:00',133,19,110),(20,'2018-07-05 00:00:00',207,16,80),(21,'2018-07-06 00:00:00',170,36,191),(22,'2018-07-07 00:00:00',42,9,62),(23,'2018-07-08 00:00:00',170,17,94),(24,'2018-07-13 00:00:00',156,20,143),(25,'2018-07-14 00:00:00',116,14,46),(26,'2018-07-15 00:00:00',89,11,57),(27,'2018-07-16 00:00:00',170,16,100),(28,'2018-07-17 00:00:00',149,27,152),(29,'2018-07-18 00:00:00',207,36,233),(30,'2018-07-19 00:00:00',208,16,112),(31,'2018-07-20 00:00:00',188,14,110),(32,'2018-07-21 00:00:00',97,9,43),(33,'2018-07-22 00:00:00',105,17,116),(34,'2018-07-23 00:00:00',327,12,100),(35,'2018-07-24 00:00:00',319,13,149),(36,'2018-07-25 00:00:00',390,15,76),(37,'2018-07-26 00:00:00',127,6,53),(38,'2018-08-01 00:00:00',183,7,82),(39,'2018-08-02 00:00:00',154,4,38),(40,'2018-08-03 00:00:00',126,9,70),(41,'2018-08-04 00:00:00',83,3,33),(42,'2018-07-31 00:00:00',206,13,147),(43,'2018-07-30 00:00:00',148,12,106),(44,'2018-07-29 00:00:00',119,3,27),(45,'2018-07-28 00:00:00',130,8,56),(46,'2018-07-27 00:00:00',51,3,9),(47,'2018-08-05 00:00:00',168,6,31),(48,'2018-08-06 00:00:00',356,16,115),(49,'2018-08-07 00:00:00',280,14,86),(50,'2018-08-08 00:00:00',295,17,130),(51,'2018-08-09 00:00:00',0,0,0),(52,'2018-08-15 00:00:00',410,18,145),(53,'2018-08-16 00:00:00',110,7,26),(54,'2018-08-17 00:00:00',38,4,3),(55,'2018-08-17 00:00:00',0,0,0),(56,'2018-08-18 00:00:00',180,24,172),(57,'2018-08-19 00:00:00',132,12,82),(58,'2018-08-20 00:00:00',160,9,14),(59,'2018-08-21 00:00:00',114,8,19),(60,'2018-08-22 00:00:00',27,6,43),(61,'2018-08-23 00:00:00',93,10,53),(62,'2018-08-24 00:00:00',97,8,15),(63,'2018-08-25 00:00:00',52,12,17),(64,'2018-08-26 00:00:00',231,20,152),(65,'2018-08-27 00:00:00',178,17,128),(66,'2018-08-28 00:00:00',98,8,32),(67,'2018-08-29 00:00:00',208,25,137),(68,'2018-08-30 00:00:00',112,8,71),(69,'2018-08-31 00:00:00',74,5,14),(70,'2018-09-01 00:00:00',162,17,139),(71,'2018-09-02 00:00:00',146,9,55),(72,'2018-09-03 00:00:00',81,4,38),(73,'2018-09-04 00:00:00',16,6,0),(74,'2018-09-05 00:00:00',124,14,128),(75,'2018-09-06 00:00:00',109,14,132),(76,'2018-09-07 00:00:00',5,2,5),(77,'2018-09-08 00:00:00',0,0,0),(78,'2018-09-09 00:00:00',136,21,116),(79,'2018-09-10 00:00:00',173,9,24),(80,'2018-09-11 00:00:00',92,8,81),(81,'2018-09-12 00:00:00',82,11,34),(82,'2018-09-13 00:00:00',88,7,43),(83,'2018-09-15 00:00:00',87,6,41),(84,'2018-09-16 00:00:00',118,19,125),(85,'2018-09-17 00:00:00',111,13,68),(86,'2018-09-18 00:00:00',97,25,89),(87,'2018-09-19 00:00:00',95,9,36),(88,'2018-09-20 00:00:00',55,8,52),(89,'2018-09-21 00:00:00',0,0,0),(90,'2018-09-22 00:00:00',104,11,29),(91,'2018-09-23 00:00:00',116,22,88),(92,'2018-09-24 00:00:00',156,17,118),(93,'2018-09-25 00:00:00',136,26,137),(94,'2018-09-26 00:00:00',101,18,150),(95,'2018-09-27 00:00:00',109,16,115),(96,'2018-09-28 00:00:00',85,14,110),(97,'2018-09-29 00:00:00',145,13,102),(98,'2018-09-30 00:00:00',97,8,61),(99,'2018-10-01 00:00:00',94,12,105),(100,'2018-10-02 00:00:00',0,0,0),(101,'2018-10-03 00:00:00',75,9,74),(102,'2018-10-05 00:00:00',126,10,46);
/*!40000 ALTER TABLE `daysummary` ENABLE KEYS */;
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
