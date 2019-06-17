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
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `idtag` int(11) NOT NULL AUTO_INCREMENT,
  `tagname` varchar(45) DEFAULT NULL,
  `idsubject` int(11) DEFAULT '1',
  `parentid` int(11) DEFAULT '0',
  PRIMARY KEY (`idtag`),
  KEY `fkidsubject_idx` (`idsubject`),
  CONSTRAINT `fkidsubject` FOREIGN KEY (`idsubject`) REFERENCES `tagsubject` (`idtagsubject`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'单位换算',1,36),(2,'遇了再遇',1,27),(3,'设而不求',1,26),(4,'火车过桥',1,27),(5,'几何',1,0),(7,'探索规律',1,36),(11,'中转传递',1,27),(12,'水中拾物',1,27),(13,'易错周期',1,36),(14,'扶梯问题',1,27),(15,'不定方程',1,36),(16,'六边形',1,5),(17,'周期附体',1,36),(18,'数列数表',1,36),(19,'以追当遇',1,27),(20,'巧算',1,36),(21,'换元法',1,36),(22,'方程技巧',1,36),(23,'图形染色',1,37),(24,'上山下山',1,27),(25,'空间想象',1,5),(26,'应用题',1,0),(27,'行程问题',1,26),(28,'走走停停',1,27),(29,'间隔发车',1,27),(30,'流水行船',1,27),(31,'变速问题',1,27),(32,'反复相遇',1,27),(33,'环形跑道',1,27),(34,'钟表问题',1,27),(35,'比例问题',1,27),(36,'计算',1,0),(37,'计数',1,0);
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-17 20:16:34
