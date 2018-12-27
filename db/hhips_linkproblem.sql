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
-- Table structure for table `linkproblem`
--

DROP TABLE IF EXISTS `linkproblem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `linkproblem` (
  `idlinkproblem` int(11) NOT NULL AUTO_INCREMENT,
  `sourceidproblem` int(11) DEFAULT NULL,
  `targetidproblem` int(11) DEFAULT NULL,
  PRIMARY KEY (`idlinkproblem`),
  KEY `sourceidproblem_idx` (`sourceidproblem`),
  KEY `targetidproblem_idx` (`targetidproblem`),
  CONSTRAINT `sourceidproblem` FOREIGN KEY (`sourceidproblem`) REFERENCES `problem` (`idproblem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `targetidproblem` FOREIGN KEY (`targetidproblem`) REFERENCES `problem` (`idproblem`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linkproblem`
--

LOCK TABLES `linkproblem` WRITE;
/*!40000 ALTER TABLE `linkproblem` DISABLE KEYS */;
INSERT INTO `linkproblem` VALUES (1,554,1764),(2,1764,554),(3,554,168),(4,168,554),(5,554,177),(6,177,554),(7,554,182),(8,182,554);
/*!40000 ALTER TABLE `linkproblem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-27 15:26:20
