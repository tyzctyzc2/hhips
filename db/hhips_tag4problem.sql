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
-- Table structure for table `tag4problem`
--

DROP TABLE IF EXISTS `tag4problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag4problem` (
  `idtag4problem` int(11) NOT NULL AUTO_INCREMENT,
  `idtag` int(11) DEFAULT NULL,
  `idproblem` int(11) DEFAULT NULL,
  PRIMARY KEY (`idtag4problem`),
  KEY `idproblem_idx` (`idproblem`),
  KEY `idtag_idx` (`idtag`),
  CONSTRAINT `idproblem` FOREIGN KEY (`idproblem`) REFERENCES `problem` (`idproblem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idtag` FOREIGN KEY (`idtag`) REFERENCES `tag` (`idtag`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag4problem`
--

LOCK TABLES `tag4problem` WRITE;
/*!40000 ALTER TABLE `tag4problem` DISABLE KEYS */;
INSERT INTO `tag4problem` VALUES (2,2,554),(3,2,1764),(4,2,168),(5,2,177),(6,2,182),(7,3,364),(8,4,112),(9,1,112),(10,7,1222),(11,13,1274),(12,13,847),(14,14,585),(15,10,2083),(16,10,1825),(17,10,2073),(18,10,2088),(19,15,1032),(20,15,1034),(21,7,2284),(22,7,2281),(23,7,2282),(24,7,2300),(25,7,2301),(26,7,2303),(27,7,2305),(28,6,902),(29,16,2462),(30,16,2463),(31,16,2464),(32,16,2548),(33,17,2558),(34,3,2540),(35,17,2299),(37,17,2306),(38,15,2564),(39,11,1237),(40,18,2919),(41,18,713),(42,18,723),(43,18,724),(44,19,1238),(45,11,188),(46,12,188),(47,17,2910),(48,20,3186),(49,21,3186),(50,20,3187),(51,20,3190),(52,20,3192),(53,20,3193),(54,22,3094),(55,15,3471),(56,23,223),(57,23,228),(58,23,225),(59,15,1736),(60,11,141),(61,10,1052),(62,22,1653),(63,22,4302),(64,16,3227),(65,6,3524),(66,6,3275),(67,6,3277),(68,10,3277),(69,24,3287),(70,24,3277);
/*!40000 ALTER TABLE `tag4problem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-22 19:20:25
