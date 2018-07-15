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
-- Table structure for table `work`
--

DROP TABLE IF EXISTS `work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work` (
  `idwork` int(11) NOT NULL AUTO_INCREMENT,
  `workdate` datetime DEFAULT NULL,
  `idproblem` int(11) DEFAULT NULL,
  `usedtime` int(11) DEFAULT NULL,
  `workdetail` varchar(100) DEFAULT NULL,
  `workmark` int(11) DEFAULT NULL,
  `reason` int(11) DEFAULT NULL,
  PRIMARY KEY (`idwork`),
  KEY `problemid_idx` (`idproblem`),
  CONSTRAINT `problemid` FOREIGN KEY (`idproblem`) REFERENCES `problem` (`idproblem`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=516 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work`
--

LOCK TABLES `work` WRITE;
/*!40000 ALTER TABLE `work` DISABLE KEYS */;
INSERT INTO `work` VALUES (1,'2018-04-16 12:20:23',85,42,'201806\\20180611_w1.png',NULL,NULL),(2,'2018-04-16 12:20:23',85,42,'201806\\20180611_w2.png',NULL,NULL),(3,'2018-04-16 12:20:23',85,42,'201806\\20180611_w3.png',NULL,NULL),(4,'2018-04-16 12:20:23',85,42,'201806\\20180611_w4.png',NULL,NULL),(5,'2018-04-16 12:20:23',85,42,'201806\\20180611_w5.png',NULL,NULL),(6,'2018-04-16 12:20:23',85,42,'201806\\20180611_w6.png',NULL,NULL),(7,'2018-04-16 12:20:23',85,42,'201806\\20180611_w7.png',NULL,NULL),(8,'2018-04-16 12:20:23',85,42,'201806\\20180611_w8.png',NULL,NULL),(9,'2018-04-16 12:20:23',85,42,'201806\\20180611_w9.png',NULL,NULL),(10,'2018-04-16 12:20:23',85,42,'201806\\20180611_w10.png',NULL,NULL),(11,'2018-04-16 12:20:23',85,42,'201806\\20180611_w11.png',NULL,NULL),(12,'2018-04-16 12:20:23',85,42,'201806\\20180611_w12.png',NULL,NULL),(13,'2018-04-16 12:20:23',85,42,'201806\\20180611_w13.png',NULL,NULL),(14,'2018-04-16 12:20:23',85,42,'201806\\20180611_w14.png',NULL,NULL),(15,'2018-04-16 12:20:23',85,42,'201806\\20180611_w15.png',NULL,NULL),(16,'2018-04-16 12:20:23',85,42,'201806\\20180611_w16.png',NULL,NULL),(17,'2018-04-16 12:20:23',85,42,'201806\\20180611_w17.png',NULL,NULL),(18,'2018-04-16 12:20:23',85,42,'201806\\20180611_w18.png',NULL,NULL),(19,'2018-04-16 12:20:23',85,42,'201806\\20180611_w19.png',NULL,NULL),(20,'2018-04-16 12:20:23',89,42,'201804\\t.png',NULL,NULL),(21,'2018-04-16 12:20:23',85,42,'201806\\20180611_w21.png',NULL,NULL),(22,'2018-04-16 12:20:23',89,42,'201804\\t.png',1,NULL),(23,'2018-06-12 17:31:22',85,11,'201806\\20180612_w23.png',NULL,NULL),(24,'2018-06-12 18:16:46',89,18,'201806\\20180612_w24.png',NULL,NULL),(25,'2018-06-12 18:25:47',85,2,'201806\\20180612_w25.png',NULL,NULL),(26,'2018-06-12 18:25:58',89,1,'201806\\20180612_w26.png',NULL,NULL),(27,'2018-06-12 19:34:34',94,64,'201806\\20180612_w27.png',NULL,NULL),(28,'2018-06-12 21:15:42',85,23,'201804\\t.png',1,NULL),(29,'2018-06-12 21:16:00',89,6,'201804\\t.png',1,NULL),(30,'2018-06-12 21:20:51',94,170,'201806\\20180612_w30.png',NULL,NULL),(31,'2018-06-12 21:20:53',94,170,'201806\\20180612_w31.png',NULL,NULL),(32,'2018-06-13 17:08:08',105,282,'201806\\20180613_w32.png',0,NULL),(33,'2018-06-13 17:18:21',112,582,'201806\\20180613_w33.png',1,NULL),(34,'2018-06-13 17:22:56',116,241,'201806\\20180613_w34.png',0,NULL),(35,'2018-06-13 17:31:25',141,490,'201806\\20180613_w35.png',0,NULL),(36,'2018-06-13 17:35:20',143,204,'201806\\20180613_w36.png',0,NULL),(37,'2018-06-13 17:42:43',144,414,'201806\\20180613_w37.png',1,NULL),(38,'2018-06-13 17:48:38',160,334,'201806\\20180613_w38.png',0,NULL),(39,'2018-06-13 17:53:20',161,261,'201806\\20180613_w39.png',1,NULL),(40,'2018-06-13 18:47:32',85,36,'201806\\20180613_w40.png',0,NULL),(41,'2018-06-13 18:49:59',89,113,'201806\\20180613_w41.png',0,NULL),(42,'2018-06-13 18:50:55',94,43,'201806\\20180613_w42.png',0,NULL),(43,'2018-06-15 17:18:43',201,185,'201806\\20180615_w43.png',1,NULL),(44,'2018-06-15 17:22:53',202,224,'201806\\20180615_w44.png',1,NULL),(45,'2018-06-15 17:36:29',203,782,'201806\\20180615_w45.png',0,NULL),(46,'2018-06-15 17:44:15',204,454,'201806\\20180615_w46.png',1,NULL),(47,'2018-06-15 18:00:01',205,909,'201806\\20180615_w47.png',1,NULL),(48,'2018-06-15 18:05:39',206,324,'201806\\20180615_w48.png',1,NULL),(49,'2018-06-15 18:13:11',207,442,'201806\\20180615_w49.png',1,NULL),(50,'2018-06-15 20:35:39',208,235,'201806\\20180615_w50.png',0,NULL),(51,'2018-06-15 20:38:02',209,124,'201806\\20180615_w51.png',0,NULL),(52,'2018-06-16 08:22:42',210,413,'201806\\20180616_w52.png',0,NULL),(53,'2018-06-16 08:35:43',211,761,'201806\\20180616_w53.png',0,NULL),(54,'2018-06-16 08:42:56',212,345,'201806\\20180616_w54.png',0,NULL),(55,'2018-06-16 08:50:56',213,464,'201806\\20180616_w55.png',1,NULL),(56,'2018-06-16 08:53:21',214,125,'201806\\20180616_w56.png',0,NULL),(57,'2018-06-16 09:02:45',215,360,'201806\\20180616_w57.png',1,NULL),(63,'2018-06-17 09:23:59',337,162,'201806\\20180617_w63.png',0,NULL),(64,'2018-06-17 09:30:14',345,351,'201806\\20180617_w64.png',NULL,NULL),(65,'2018-06-17 09:45:23',345,1,'201806\\20180617_w65.png',0,NULL),(66,'2018-06-17 10:15:45',346,39,'201806\\20180617_w66.png',0,NULL),(67,'2018-06-17 10:17:02',347,58,'201806\\20180617_w67.png',0,NULL),(68,'2018-06-17 10:17:43',348,2,'201806\\20180617_w68.png',0,NULL),(69,'2018-06-17 10:24:47',349,35,'201806\\20180617_w69.png',0,NULL),(70,'2018-06-17 10:26:17',350,62,'201806\\20180617_w70.png',0,NULL),(71,'2018-06-17 10:26:47',351,15,'201806\\20180617_w71.png',0,NULL),(72,'2018-06-17 10:33:06',352,355,'201806\\20180617_w72.png',0,NULL),(73,'2018-06-17 10:35:59',353,41,'201806\\20180617_w73.png',0,NULL),(74,'2018-06-17 10:37:12',354,62,'201806\\20180617_w74.png',NULL,NULL),(75,'2018-06-17 10:39:05',354,7,'201806\\20180617_w75.png',0,NULL),(76,'2018-06-17 10:45:10',355,273,'201806\\20180617_w76.png',0,NULL),(77,'2018-06-17 10:54:24',356,311,'201806\\20180617_w77.png',0,NULL),(78,'2018-06-17 11:00:03',357,298,'201806\\20180617_w78.png',0,NULL),(79,'2018-06-17 11:08:47',358,13,'201806\\20180617_w79.png',0,NULL),(80,'2018-06-17 11:13:48',359,176,'201806\\20180617_w80.png',NULL,NULL),(81,'2018-06-17 14:07:42',359,641,'201806\\20180617_w81.png',0,NULL),(82,'2018-06-17 14:08:06',360,2,'201806\\20180617_w82.png',NULL,NULL),(83,'2018-06-17 14:27:24',361,1131,'201806\\20180617_w83.png',0,NULL),(84,'2018-06-17 14:30:46',362,182,'201806\\20180617_w84.png',0,NULL),(85,'2018-06-17 14:42:19',360,221,'201806\\20180617_w85.png',NULL,NULL),(86,'2018-06-17 14:44:43',360,3,'201806\\20180617_w86.png',0,NULL),(87,'2018-06-17 14:57:39',363,392,'201806\\20180617_w87.png',0,NULL),(88,'2018-06-18 09:40:24',364,340,'201806\\20180618_w88.png',1,NULL),(89,'2018-06-18 10:07:34',216,584,'201806\\20180618_w89.png',0,NULL),(90,'2018-06-18 10:50:15',217,401,'201806\\20180618_w90.png',0,NULL),(91,'2018-06-18 11:01:08',218,587,'201806\\20180618_w91.png',0,NULL),(92,'2018-06-18 11:06:36',219,262,'201806\\20180618_w92.png',0,NULL),(93,'2018-06-18 11:15:32',220,521,'201806\\20180618_w93.png',0,NULL),(94,'2018-06-18 11:21:37',221,278,'201806\\20180618_w94.png',NULL,NULL),(95,'2018-06-18 11:21:39',221,278,'201806\\20180618_w95.png',0,NULL),(96,'2018-06-18 11:31:40',222,160,'201806\\20180618_w96.png',0,NULL),(97,'2018-06-18 17:08:18',223,432,'201806\\20180618_w97.png',1,NULL),(98,'2018-06-18 17:12:51',224,180,'201806\\20180618_w98.png',0,NULL),(99,'2018-06-18 17:26:39',225,553,'201806\\20180618_w99.png',1,NULL),(100,'2018-06-18 17:40:45',226,413,'201806\\20180618_w100.png',1,NULL),(101,'2018-06-19 16:55:28',201,61,'201806\\20180619_w101.png',0,NULL),(102,'2018-06-19 16:58:29',202,157,'201806\\20180619_w102.png',0,NULL),(103,'2018-06-19 17:04:55',204,130,'201806\\20180619_w103.png',1,NULL),(104,'2018-06-19 17:05:15',205,9,'201806\\20180619_w104.png',0,NULL),(105,'2018-06-19 17:05:28',206,2,'201806\\20180619_w105.png',0,NULL),(106,'2018-06-19 17:05:39',207,1,'201806\\20180619_w106.png',0,NULL),(107,'2018-06-19 17:14:23',213,154,'201806\\20180619_w107.png',0,NULL),(108,'2018-06-19 17:20:13',215,234,'201806\\20180619_w108.png',0,NULL),(109,'2018-06-19 17:43:46',223,810,'201806\\20180619_w109.png',1,NULL),(110,'2018-06-19 17:46:02',225,125,'201806\\20180619_w110.png',0,NULL),(111,'2018-06-19 18:09:54',204,154,'201806\\20180619_w111.png',0,NULL),(112,'2018-06-19 18:13:06',223,38,'201806\\20180619_w112.png',0,NULL),(113,'2018-06-19 18:23:34',226,467,'201806\\20180619_w113.png',0,NULL),(114,'2018-06-19 18:24:07',227,4,'201806\\20180619_w114.png',0,NULL),(115,'2018-06-19 18:45:38',228,1078,'201806\\20180619_w115.png',1,NULL),(116,'2018-06-19 18:47:48',229,115,'201806\\20180619_w116.png',0,NULL),(117,'2018-06-19 18:49:50',230,58,'201806\\20180619_w117.png',0,NULL),(118,'2018-06-19 20:23:08',228,380,'201806\\20180619_w118.png',0,NULL),(119,'2018-06-19 20:28:29',231,130,'201806\\20180619_w119.png',0,NULL),(120,'2018-06-19 20:34:00',232,144,'201806\\20180619_w120.png',0,NULL),(121,'2018-06-19 20:38:21',233,128,'201806\\20180619_w121.png',1,NULL),(122,'2018-06-19 20:47:55',233,19,'201806\\20180619_w122.png',0,NULL),(123,'2018-06-20 17:12:02',190,65,'201806\\20180620_w123.png',0,NULL),(124,'2018-06-20 17:17:45',191,101,'201806\\20180620_w124.png',0,NULL),(125,'2018-06-20 17:24:51',192,162,'201804\\t.png',1,NULL),(126,'2018-06-20 17:30:58',193,176,'201806\\20180620_w126.png',0,NULL),(127,'2018-06-20 17:38:45',194,17,'201806\\20180620_w127.png',NULL,NULL),(128,'2018-06-20 17:45:05',195,39,'201806\\20180620_w128.png',0,NULL),(129,'2018-06-20 17:49:21',196,168,'201806\\20180620_w129.png',NULL,NULL),(130,'2018-06-20 17:51:28',196,3,'201806\\20180620_w130.png',0,NULL),(131,'2018-06-20 17:56:54',197,178,'201806\\20180620_w131.png',0,NULL),(132,'2018-06-20 18:03:15',198,370,'201806\\20180620_w132.png',NULL,NULL),(133,'2018-06-20 18:20:03',199,979,'201806\\20180620_w133.png',0,NULL),(134,'2018-06-20 18:28:24',200,470,'201806\\20180620_w134.png',0,NULL),(135,'2018-06-20 18:45:16',192,62,'201806\\20180620_w135.png',0,NULL),(136,'2018-06-20 18:58:33',194,38,'201806\\20180620_w136.png',0,NULL),(137,'2018-06-20 20:24:22',198,39,'201806\\20180620_w137.png',0,NULL),(138,'2018-06-20 21:33:08',234,155,'201806\\20180620_w138.png',0,NULL),(139,'2018-06-20 21:35:36',235,131,'201806\\20180620_w139.png',0,NULL),(140,'2018-06-20 21:42:35',236,282,'201806\\20180620_w140.png',1,NULL),(141,'2018-06-20 21:44:52',237,74,'201806\\20180620_w141.png',0,NULL),(142,'2018-06-20 21:47:07',238,121,'201806\\20180620_w142.png',0,NULL),(143,'2018-06-20 21:52:25',239,2,'201806\\20180620_w143.png',0,NULL),(150,'2018-06-22 16:33:19',236,120,'201806\\20180622_w150.png',0,NULL),(151,'2018-06-22 16:44:11',240,197,'201806\\20180622_w151.png',0,NULL),(152,'2018-06-22 16:45:14',241,32,'201806\\20180622_w152.png',0,NULL),(153,'2018-06-22 16:51:20',242,344,'201806\\20180622_w153.png',0,NULL),(154,'2018-06-22 16:56:36',243,147,'201806\\20180622_w154.png',0,NULL),(155,'2018-06-22 17:01:06',244,120,'201806\\20180622_w155.png',0,NULL),(156,'2018-06-22 17:03:45',245,143,'201806\\20180622_w156.png',0,NULL),(157,'2018-06-22 17:10:12',246,134,'201806\\20180622_w157.png',0,NULL),(158,'2018-06-22 17:12:32',247,125,'201806\\20180622_w158.png',0,NULL),(159,'2018-06-22 17:22:22',248,121,'201806\\20180622_w159.png',0,NULL),(160,'2018-06-22 18:04:00',249,849,'201806\\20180622_w160.png',1,NULL),(161,'2018-06-22 18:10:02',250,282,'201806\\20180622_w161.png',0,NULL),(162,'2018-06-22 20:33:59',364,783,'201806\\20180622_w162.png',0,NULL),(163,'2018-06-22 20:34:15',365,4,'201806\\20180622_w163.png',0,NULL),(164,'2018-06-22 20:34:26',366,2,'201806\\20180622_w164.png',0,NULL),(165,'2018-06-24 08:57:30',404,113,'201806\\20180624_w165.png',0,NULL),(166,'2018-06-24 09:08:31',406,138,'201806\\20180624_w166.png',0,NULL),(167,'2018-06-24 09:16:36',408,398,'201806\\20180624_w167.png',0,NULL),(168,'2018-06-24 09:42:34',409,518,'201806\\20180624_w168.png',1,NULL),(169,'2018-06-24 09:47:43',414,186,'201804\\t.png',1,NULL),(170,'2018-06-24 09:56:41',416,182,'201806\\20180624_w170.png',1,NULL),(171,'2018-06-24 10:05:52',417,157,'201806\\20180624_w171.png',0,NULL),(172,'2018-06-24 10:09:05',418,70,'201806\\20180624_w172.png',0,NULL),(173,'2018-06-24 11:21:11',409,2384,'201806\\20180624_w173.png',0,NULL),(174,'2018-06-24 11:35:44',414,822,'201806\\20180624_w174.png',0,NULL),(175,'2018-06-24 11:38:21',416,146,'201806\\20180624_w175.png',0,NULL),(176,'2018-06-24 11:41:35',419,68,'201806\\20180624_w176.png',0,NULL),(177,'2018-06-24 11:47:22',420,259,'201806\\20180624_w177.png',0,NULL),(178,'2018-06-24 11:51:04',421,123,'201806\\20180624_w178.png',0,NULL),(179,'2018-06-24 11:58:05',422,247,'201806\\20180624_w179.png',0,NULL),(180,'2018-06-24 12:02:20',423,241,'201806\\20180624_w180.png',0,NULL),(181,'2018-06-24 13:52:40',424,4,'201806\\20180624_w181.png',0,NULL),(182,'2018-06-24 14:05:34',425,86,'201806\\20180624_w182.png',0,NULL),(183,'2018-06-24 14:16:47',426,222,'201806\\20180624_w183.png',0,NULL),(184,'2018-06-24 14:22:26',427,119,'201806\\20180624_w184.png',0,NULL),(185,'2018-06-24 14:29:52',428,335,'201806\\20180624_w185.png',0,NULL),(186,'2018-06-24 14:58:10',429,1416,'201806\\20180624_w186.png',0,NULL),(187,'2018-06-24 16:10:40',430,1170,'201806\\20180624_w187.png',0,NULL),(188,'2018-06-24 16:32:57',431,510,'201806\\20180624_w188.png',0,NULL),(189,'2018-06-24 16:37:49',432,3,'201806\\20180624_w189.png',0,NULL),(190,'2018-06-24 17:07:21',433,610,'201806\\20180624_w190.png',0,NULL),(191,'2018-06-24 21:08:47',16,145,'201806\\20180624_w191.png',0,NULL),(192,'2018-06-24 21:30:50',18,1298,'201806\\20180624_w192.png',0,NULL),(193,'2018-06-24 21:32:12',19,69,'201806\\20180624_w193.png',0,NULL),(194,'2018-06-24 21:33:34',21,61,'201806\\20180624_w194.png',0,NULL),(195,'2018-06-25 17:03:13',22,468,'201804\\t.png',1,NULL),(196,'2018-06-25 17:15:12',23,630,'201806\\20180625_w196.png',0,NULL),(197,'2018-06-25 17:18:38',28,154,'201806\\20180625_w197.png',0,NULL),(198,'2018-06-25 17:22:16',29,201,'201806\\20180625_w198.png',0,NULL),(199,'2018-06-25 17:24:19',32,96,'201806\\20180625_w199.png',0,NULL),(200,'2018-06-25 17:31:54',34,107,'201806\\20180625_w200.png',0,NULL),(201,'2018-06-25 17:35:15',35,101,'201806\\20180625_w201.png',0,NULL),(202,'2018-06-25 17:39:14',36,216,'201806\\20180625_w202.png',0,NULL),(203,'2018-06-25 17:40:38',42,67,'201806\\20180625_w203.png',0,NULL),(204,'2018-06-25 17:44:47',43,223,'201806\\20180625_w204.png',0,NULL),(205,'2018-06-25 17:48:44',45,198,'201806\\20180625_w205.png',1,NULL),(206,'2018-06-25 17:55:37',46,399,'201806\\20180625_w206.png',1,NULL),(207,'2018-06-25 18:20:49',22,261,'201806\\20180625_w207.png',1,NULL),(208,'2018-06-25 18:27:19',45,375,'201806\\20180625_w208.png',0,NULL),(209,'2018-06-25 18:32:37',46,305,'201806\\20180625_w209.png',0,NULL),(210,'2018-06-25 18:34:51',22,119,'201806\\20180625_w210.png',0,NULL),(211,'2018-06-25 20:28:32',142,180,'201806\\20180625_w211.png',0,NULL),(212,'2018-06-25 20:36:10',144,270,'201806\\20180625_w212.png',1,NULL),(213,'2018-06-25 20:37:13',144,35,'201806\\20180625_w213.png',NULL,NULL),(214,'2018-06-25 20:37:48',144,18,'201806\\20180625_w214.png',NULL,NULL),(215,'2018-06-25 20:38:25',144,17,'201806\\20180625_w215.png',NULL,NULL),(216,'2018-06-25 20:53:57',151,717,'201806\\20180625_w216.png',1,NULL),(217,'2018-06-25 21:00:21',161,368,'201806\\20180625_w217.png',NULL,NULL),(218,'2018-06-25 21:06:51',161,377,'201806\\20180625_w218.png',1,NULL),(219,'2018-06-25 21:16:16',151,41,'201806\\20180625_w219.png',1,NULL),(220,'2018-06-25 21:24:31',162,486,'201806\\20180625_w220.png',0,NULL),(221,'2018-06-25 21:26:20',151,10,'201806\\20180625_w221.png',1,NULL),(222,'2018-06-25 21:31:34',164,298,'201806\\20180625_w222.png',0,NULL),(223,'2018-06-25 21:46:31',168,867,'201806\\20180625_w223.png',0,NULL),(224,'2018-06-26 17:14:45',151,64,'201806\\20180626_w224.png',0,NULL),(225,'2018-06-26 17:23:18',169,485,'201806\\20180626_w225.png',1,NULL),(226,'2018-06-26 17:30:53',177,415,'201806\\20180626_w226.png',0,NULL),(227,'2018-06-26 17:39:30',170,491,'201806\\20180626_w227.png',0,NULL),(228,'2018-06-26 17:46:14',144,179,'201806\\20180626_w228.png',0,NULL),(229,'2018-06-26 17:56:27',169,528,'201806\\20180626_w229.png',1,NULL),(230,'2018-06-26 18:19:51',171,1346,'201806\\20180626_w230.png',0,NULL),(231,'2018-06-26 20:01:15',161,295,'201806\\20180626_w231.png',0,NULL),(232,'2018-06-26 20:03:41',169,142,'201804\\t.png',1,NULL),(233,'2018-06-26 20:08:41',172,220,'201806\\20180626_w233.png',0,NULL),(234,'2018-06-26 20:16:15',174,406,'201806\\20180626_w234.png',0,NULL),(235,'2018-06-26 20:24:38',176,488,'201806\\20180626_w235.png',0,NULL),(236,'2018-06-26 20:28:48',179,227,'201806\\20180626_w236.png',0,NULL),(237,'2018-06-26 20:36:09',182,307,'201806\\20180626_w237.png',0,NULL),(238,'2018-06-26 20:49:13',184,670,'201806\\20180626_w238.png',1,NULL),(239,'2018-06-27 16:57:41',169,44,'201806\\20180627_w239.png',1,NULL),(240,'2018-06-27 17:15:11',188,763,'201806\\20180627_w240.png',1,NULL),(241,'2018-06-27 17:27:28',189,392,'201806\\20180627_w241.png',1,NULL),(242,'2018-06-27 17:38:16',379,199,'201806\\20180627_w242.png',0,NULL),(243,'2018-06-27 17:41:14',382,162,'201806\\20180627_w243.png',1,NULL),(244,'2018-06-27 17:56:42',384,832,'201804\\t.png',1,NULL),(245,'2018-06-27 17:59:57',385,177,'201806\\20180627_w245.png',0,NULL),(246,'2018-06-27 18:03:34',386,191,'201806\\20180627_w246.png',0,NULL),(247,'2018-06-27 18:07:40',400,148,'201806\\20180627_w247.png',0,NULL),(248,'2018-06-27 18:10:44',401,89,'201806\\20180627_w248.png',0,NULL),(249,'2018-06-27 18:38:29',382,1,'201806\\20180627_w249.png',0,NULL),(250,'2018-06-27 20:08:04',402,404,'201806\\20180627_w250.png',0,NULL),(251,'2018-06-27 20:12:23',403,144,'201806\\20180627_w251.png',1,NULL),(252,'2018-06-27 20:16:11',314,123,'201806\\20180627_w252.png',0,NULL),(253,'2018-06-27 20:19:17',315,155,'201806\\20180627_w253.png',0,NULL),(254,'2018-06-27 20:38:02',322,103,'201806\\20180627_w254.png',0,NULL),(255,'2018-06-27 20:45:51',323,107,'201806\\20180627_w255.png',0,NULL),(256,'2018-06-27 20:55:33',333,247,'201806\\20180627_w256.png',0,NULL),(257,'2018-06-27 21:04:33',441,140,'201806\\20180627_w257.png',0,NULL),(258,'2018-06-27 21:10:12',450,94,'201806\\20180627_w258.png',1,NULL),(259,'2018-06-27 21:14:17',451,66,'201806\\20180627_w259.png',0,NULL),(260,'2018-06-28 16:54:58',384,33,'201804\\t.png',1,NULL),(261,'2018-06-28 17:01:43',403,87,'201806\\20180628_w261.png',0,NULL),(262,'2018-06-28 17:04:27',450,151,'201806\\20180628_w262.png',0,NULL),(263,'2018-06-28 17:20:48',461,405,'201806\\20180628_w263.png',1,NULL),(264,'2018-06-28 18:21:24',462,1874,'201804\\t.png',1,NULL),(265,'2018-06-28 18:39:26',461,543,'201806\\20180628_w265.png',0,NULL),(266,'2018-06-28 19:13:51',462,2034,'201806\\20180628_w266.png',1,NULL),(267,'2018-06-28 20:22:18',384,3117,'201806\\20180628_w267.png',1,NULL),(268,'2018-06-28 20:25:25',384,84,'201806\\20180628_w268.png',0,NULL),(269,'2018-06-28 20:31:04',462,30,'201806\\20180628_w269.png',0,NULL),(270,'2018-06-28 20:36:57',169,1,'201804\\t.png',1,NULL),(271,'2018-06-28 20:41:48',184,271,'201806\\20180628_w271.png',0,NULL),(272,'2018-06-28 20:55:44',188,532,'201806\\20180628_w272.png',0,NULL),(273,'2018-06-28 21:03:26',189,458,'201804\\t.png',1,NULL),(274,'2018-06-28 21:09:19',475,128,'201806\\20180628_w274.png',0,NULL),(275,'2018-06-28 21:20:15',482,473,'201806\\20180628_w275.png',1,NULL),(276,'2018-06-28 21:35:19',482,84,'201806\\20180628_w276.png',0,NULL),(277,'2018-06-28 21:41:46',483,356,'201806\\20180628_w277.png',0,NULL),(278,'2018-06-29 16:43:29',745,1244,'201806\\20180629_w278.png',1,NULL),(279,'2018-06-29 16:59:40',746,817,'201804\\t.png',1,NULL),(280,'2018-06-29 17:08:50',747,404,'201804\\t.png',1,NULL),(281,'2018-06-29 17:19:03',745,1,'201806\\20180629_w281.png',0,NULL),(282,'2018-06-29 18:01:23',746,2446,'201806\\20180629_w282.png',0,NULL),(283,'2018-06-29 19:22:40',484,491,'201806\\20180629_w283.png',0,NULL),(284,'2018-06-29 19:28:17',485,334,'201804\\t.png',1,NULL),(285,'2018-06-29 19:38:27',492,592,'201806\\20180629_w285.png',0,NULL),(286,'2018-06-29 19:41:38',494,165,'201806\\20180629_w286.png',0,NULL),(287,'2018-06-29 19:44:32',498,157,'201806\\20180629_w287.png',0,NULL),(288,'2018-06-29 19:51:53',499,437,'201804\\t.png',1,NULL),(289,'2018-06-29 19:56:20',502,254,'201806\\20180629_w289.png',0,NULL),(290,'2018-06-29 20:00:36',501,235,'201806\\20180629_w290.png',1,NULL),(291,'2018-06-29 20:03:13',516,140,'201806\\20180629_w291.png',0,NULL),(292,'2018-06-29 20:05:08',525,76,'201806\\20180629_w292.png',0,NULL),(293,'2018-06-29 20:07:14',527,90,'201806\\20180629_w293.png',1,NULL),(294,'2018-06-29 20:44:39',485,692,'201806\\20180629_w294.png',0,NULL),(295,'2018-06-29 20:51:36',499,399,'201806\\20180629_w295.png',0,NULL),(296,'2018-06-29 20:54:26',501,125,'201806\\20180629_w296.png',0,NULL),(297,'2018-06-29 21:03:39',527,538,'201806\\20180629_w297.png',0,NULL),(298,'2018-06-29 21:26:09',299,195,'201806\\20180629_w298.png',0,NULL),(299,'2018-06-29 21:32:18',46,343,'201806\\20180629_w299.png',0,NULL),(300,'2018-06-29 21:34:35',202,122,'201806\\20180629_w300.png',0,NULL),(301,'2018-06-29 21:39:40',203,284,'201806\\20180629_w301.png',0,NULL),(302,'2018-06-29 21:43:52',204,139,'201806\\20180629_w302.png',0,NULL),(303,'2018-06-30 08:18:36',205,805,'201806\\20180630_w303.png',0,NULL),(304,'2018-06-30 08:23:08',213,228,'201806\\20180630_w304.png',0,NULL),(305,'2018-06-30 08:32:34',223,515,'201806\\20180630_w305.png',0,NULL),(306,'2018-06-30 08:38:07',225,299,'201806\\20180630_w306.png',1,NULL),(307,'2018-06-30 08:42:12',194,199,'201806\\20180630_w307.png',0,NULL),(308,'2018-06-30 08:46:40',198,224,'201806\\20180630_w308.png',0,NULL),(309,'2018-06-30 08:49:47',236,118,'201806\\20180630_w309.png',0,NULL),(310,'2018-06-30 08:53:54',249,232,'201806\\20180630_w310.png',1,NULL),(311,'2018-06-30 08:55:51',249,13,'201806\\20180630_w311.png',0,NULL),(312,'2018-06-30 08:58:40',274,146,'201806\\20180630_w312.png',0,NULL),(313,'2018-06-30 09:03:22',275,119,'201806\\20180630_w313.png',0,NULL),(314,'2018-06-30 09:03:37',276,3,'201806\\20180630_w314.png',0,NULL),(315,'2018-07-01 09:03:16',298,1136,'201807\\20180701_w315.png',1,NULL),(316,'2018-07-01 09:20:53',301,1039,'201807\\20180701_w316.png',0,NULL),(317,'2018-07-01 09:33:46',211,725,'201807\\20180701_w317.png',0,NULL),(318,'2018-07-01 09:35:42',303,81,'201807\\20180701_w318.png',0,NULL),(319,'2018-07-01 09:38:11',304,124,'201807\\20180701_w319.png',0,NULL),(320,'2018-07-01 09:40:02',330,94,'201807\\20180701_w320.png',0,NULL),(321,'2018-07-01 09:43:20',74,174,'201807\\20180701_w321.png',0,NULL),(322,'2018-07-01 09:50:16',72,397,'201807\\20180701_w322.png',1,NULL),(323,'2018-07-01 09:57:15',471,331,'201807\\20180701_w323.png',0,NULL),(324,'2018-07-01 10:25:17',298,117,'201807\\20180701_w324.png',0,NULL),(325,'2018-07-01 10:30:28',72,259,'201807\\20180701_w325.png',0,NULL),(326,'2018-07-01 10:40:23',169,437,'201807\\20180701_w326.png',1,NULL),(327,'2018-07-01 10:47:36',504,407,'201807\\20180701_w327.png',0,NULL),(328,'2018-07-01 10:53:29',293,337,'201807\\20180701_w328.png',0,NULL),(329,'2018-07-01 11:01:17',537,449,'201807\\20180701_w329.png',1,NULL),(330,'2018-07-01 11:11:45',361,422,'201807\\20180701_w330.png',0,NULL),(331,'2018-07-01 11:25:56',747,604,'201807\\20180701_w331.png',0,NULL),(332,'2018-07-02 17:10:16',537,393,'201807\\20180702_w332.png',1,NULL),(333,'2018-07-02 17:22:56',616,719,'201807\\20180702_w333.png',1,NULL),(334,'2018-07-02 17:27:52',300,170,'201807\\20180702_w334.png',0,NULL),(335,'2018-07-02 17:31:08',218,162,'201807\\20180702_w335.png',0,NULL),(336,'2018-07-02 17:36:15',305,276,'201807\\20180702_w336.png',0,NULL),(337,'2018-07-02 17:41:06',306,266,'201807\\20180702_w337.png',0,NULL),(338,'2018-07-02 17:43:45',316,136,'201807\\20180702_w338.png',0,NULL),(339,'2018-07-02 17:47:22',73,198,'201807\\20180702_w339.png',1,NULL),(340,'2018-07-02 17:48:02',461,28,'201807\\20180702_w340.png',0,NULL),(341,'2018-07-02 17:54:38',472,336,'201807\\20180702_w341.png',1,NULL),(342,'2018-07-02 18:51:35',169,849,'201807\\20180702_w342.png',0,NULL),(343,'2018-07-02 20:04:59',537,460,'201807\\20180702_w343.png',0,NULL),(344,'2018-07-02 20:20:52',616,636,'201804\\t.png',1,NULL),(345,'2018-07-02 20:33:17',616,511,'201807\\20180702_w345.png',0,NULL),(346,'2018-07-03 17:09:01',73,397,'201807\\20180703_w346.png',1,NULL),(347,'2018-07-03 17:14:31',472,285,'201807\\20180703_w347.png',0,NULL),(348,'2018-07-03 17:26:48',189,557,'201807\\20180703_w348.png',1,NULL),(349,'2018-07-03 17:30:48',553,213,'201807\\20180703_w349.png',0,NULL),(350,'2018-07-03 17:43:20',296,748,'201804\\t.png',1,NULL),(351,'2018-07-03 17:51:45',536,465,'201807\\20180703_w351.png',0,NULL),(352,'2018-07-03 18:00:56',364,531,'201807\\20180703_w352.png',0,NULL),(353,'2018-07-03 18:04:35',73,203,'201807\\20180703_w353.png',1,NULL),(354,'2018-07-03 18:56:21',189,2954,'201807\\20180703_w354.png',0,NULL),(355,'2018-07-03 21:31:00',73,182,'201807\\20180703_w355.png',0,NULL),(356,'2018-07-04 14:24:57',429,667,'201807\\20180704_w356.png',0,NULL),(357,'2018-07-04 14:33:21',584,220,'201807\\20180704_w357.png',0,NULL),(358,'2018-07-04 14:45:22',585,708,'201804\\t.png',1,NULL),(359,'2018-07-04 14:48:33',603,189,'201804\\t.png',1,NULL),(360,'2018-07-04 14:51:44',603,3,'201807\\20180704_w360.png',0,NULL),(361,'2018-07-04 14:56:36',602,180,'201807\\20180704_w361.png',0,NULL),(362,'2018-07-04 15:00:32',599,162,'201807\\20180704_w362.png',1,NULL),(363,'2018-07-04 15:06:00',598,271,'201804\\t.png',1,NULL),(364,'2018-07-04 15:20:17',597,298,'201804\\t.png',1,NULL),(365,'2018-07-04 15:25:14',596,217,'201807\\20180704_w365.png',1,NULL),(366,'2018-07-04 16:19:58',595,211,'201807\\20180704_w366.png',0,NULL),(367,'2018-07-04 16:26:19',594,190,'201807\\20180704_w367.png',0,NULL),(368,'2018-07-04 16:37:02',592,109,'201807\\20180704_w368.png',0,NULL),(369,'2018-07-04 16:58:23',590,350,'201807\\20180704_w369.png',0,NULL),(370,'2018-07-04 17:32:23',826,120,'201807\\20180704_w370.png',1,NULL),(371,'2018-07-04 17:40:43',827,136,'201807\\20180704_w371.png',1,NULL),(372,'2018-07-04 17:44:15',828,193,'201804\\t.png',1,NULL),(373,'2018-07-04 17:53:43',829,558,'201807\\20180704_w373.png',1,NULL),(374,'2018-07-04 17:56:15',830,140,'201807\\20180704_w374.png',0,NULL),(375,'2018-07-04 18:07:53',831,681,'201807\\20180704_w375.png',1,NULL),(376,'2018-07-04 19:08:21',585,2333,'201807\\20180704_w376.png',0,NULL),(377,'2018-07-05 09:53:11',599,362,'201807\\20180705_w377.png',0,NULL),(378,'2018-07-05 10:05:54',598,440,'201807\\20180705_w378.png',0,NULL),(379,'2018-07-05 10:15:43',597,418,'201807\\20180705_w379.png',0,NULL),(380,'2018-07-05 10:32:42',596,1016,'201804\\t.png',1,NULL),(381,'2018-07-05 10:47:19',296,706,'201807\\20180705_w381.png',0,NULL),(382,'2018-07-05 11:14:57',826,345,'201807\\20180705_w382.png',0,NULL),(383,'2018-07-05 11:31:29',827,353,'201807\\20180705_w383.png',0,NULL),(384,'2018-07-05 13:05:30',829,1467,'201807\\20180705_w384.png',1,NULL),(385,'2018-07-05 13:24:29',831,952,'201807\\20180705_w385.png',0,NULL),(386,'2018-07-05 13:44:28',836,735,'201807\\20180705_w386.png',0,NULL),(387,'2018-07-05 13:53:34',837,257,'201807\\20180705_w387.png',0,NULL),(388,'2018-07-05 14:02:30',838,343,'201807\\20180705_w388.png',0,NULL),(389,'2018-07-05 17:03:56',840,693,'201807\\20180705_w389.png',1,NULL),(390,'2018-07-05 17:14:29',841,507,'201807\\20180705_w390.png',0,NULL),(391,'2018-07-05 17:21:48',842,363,'201807\\20180705_w391.png',1,NULL),(392,'2018-07-05 17:27:38',844,333,'201807\\20180705_w392.png',1,NULL),(393,'2018-07-05 18:53:00',596,2846,'201804\\t.png',1,NULL),(394,'2018-07-05 21:28:36',596,321,'201807\\20180705_w394.png',0,NULL),(395,'2018-07-06 09:51:25',829,301,'201807\\20180706_w395.png',0,NULL),(396,'2018-07-06 09:55:22',828,170,'201807\\20180706_w396.png',0,NULL),(397,'2018-07-06 09:57:02',840,48,'201807\\20180706_w397.png',0,NULL),(398,'2018-07-06 10:11:19',842,745,'201807\\20180706_w398.png',0,NULL),(399,'2018-07-06 10:21:26',844,552,'201807\\20180706_w399.png',0,NULL),(400,'2018-07-06 10:27:40',845,233,'201807\\20180706_w400.png',0,NULL),(401,'2018-07-06 10:31:42',846,47,'201807\\20180706_w401.png',0,NULL),(402,'2018-07-06 10:40:13',847,305,'201807\\20180706_w402.png',1,NULL),(403,'2018-07-06 11:02:08',848,1093,'201807\\20180706_w403.png',1,NULL),(404,'2018-07-06 11:27:34',697,212,'201807\\20180706_w404.png',0,NULL),(405,'2018-07-06 11:31:52',698,216,'201807\\20180706_w405.png',0,NULL),(406,'2018-07-06 11:35:50',699,199,'201807\\20180706_w406.png',0,NULL),(407,'2018-07-06 11:37:56',700,106,'201807\\20180706_w407.png',0,NULL),(408,'2018-07-06 11:39:24',701,54,'201807\\20180706_w408.png',0,NULL),(409,'2018-07-06 11:43:41',702,154,'201807\\20180706_w409.png',0,NULL),(410,'2018-07-06 11:45:02',703,61,'201807\\20180706_w410.png',0,NULL),(411,'2018-07-06 11:45:42',704,22,'201807\\20180706_w411.png',0,NULL),(412,'2018-07-06 11:51:28',705,328,'201807\\20180706_w412.png',0,NULL),(413,'2018-07-06 11:55:24',706,102,'201807\\20180706_w413.png',1,NULL),(414,'2018-07-06 11:57:16',707,76,'201807\\20180706_w414.png',0,NULL),(415,'2018-07-06 11:58:53',708,21,'201807\\20180706_w415.png',0,NULL),(416,'2018-07-06 12:00:49',709,75,'201807\\20180706_w416.png',0,NULL),(417,'2018-07-06 12:05:09',706,118,'201807\\20180706_w417.png',0,NULL),(418,'2018-07-06 14:41:49',847,378,'201807\\20180706_w418.png',0,NULL),(419,'2018-07-06 14:58:01',848,839,'201807\\20180706_w419.png',0,NULL),(420,'2018-07-06 15:14:38',710,599,'201804\\t.png',1,NULL),(421,'2018-07-06 15:19:28',711,163,'201807\\20180706_w421.png',1,NULL),(422,'2018-07-06 15:26:49',712,367,'201807\\20180706_w422.png',0,NULL),(423,'2018-07-06 15:35:32',713,314,'201807\\20180706_w423.png',1,NULL),(424,'2018-07-06 15:56:45',904,739,'201807\\20180706_w424.png',NULL,NULL),(425,'2018-07-06 16:11:01',714,58,'201807\\20180706_w425.png',0,NULL),(426,'2018-07-06 16:13:59',715,62,'201804\\t.png',1,NULL),(427,'2018-07-06 16:16:31',715,1,'201807\\20180706_w427.png',0,NULL),(428,'2018-07-06 16:19:20',716,84,'201807\\20180706_w428.png',0,NULL),(429,'2018-07-06 16:22:21',717,84,'201807\\20180706_w429.png',0,NULL),(430,'2018-07-06 16:25:19',718,162,'201807\\20180706_w430.png',1,NULL),(431,'2018-07-06 16:28:05',719,106,'201807\\20180706_w431.png',0,NULL),(432,'2018-07-06 18:33:15',710,780,'201807\\20180706_w432.png',0,NULL),(433,'2018-07-06 18:34:40',711,62,'201807\\20180706_w433.png',0,NULL),(434,'2018-07-06 18:40:16',713,260,'201807\\20180706_w434.png',0,NULL),(435,'2018-07-06 22:10:48',25,1,'201807\\20180706_w435.png',1,NULL),(436,'2018-07-06 22:12:41',25,1,'201807\\20180706_w436.png',NULL,NULL),(437,'2018-07-07 08:36:53',718,543,'201807\\20180707_w437.png',0,NULL),(438,'2018-07-07 08:40:03',720,169,'201807\\20180707_w438.png',0,NULL),(439,'2018-07-07 08:42:09',721,96,'201807\\20180707_w439.png',0,NULL),(440,'2018-07-07 08:46:56',722,253,'201807\\20180707_w440.png',0,NULL),(441,'2018-07-07 08:50:50',723,208,'201807\\20180707_w441.png',1,NULL),(442,'2018-07-07 08:53:33',724,137,'201807\\20180707_w442.png',1,NULL),(443,'2018-07-07 08:54:54',725,67,'201807\\20180707_w443.png',0,NULL),(444,'2018-07-07 08:58:12',726,186,'201807\\20180707_w444.png',0,NULL),(445,'2018-07-07 20:57:35',905,876,'201807\\20180707_w445.png',0,NULL),(446,'2018-07-08 08:34:45',723,837,'201807\\20180708_w446.png',0,NULL),(447,'2018-07-08 08:39:23',724,257,'201807\\20180708_w447.png',1,NULL),(448,'2018-07-08 08:45:54',727,69,'201807\\20180708_w448.png',1,NULL),(449,'2018-07-08 09:18:32',728,1769,'201807\\20180708_w449.png',0,NULL),(450,'2018-07-08 09:28:56',729,610,'201807\\20180708_w450.png',0,NULL),(451,'2018-07-08 10:03:04',724,600,'201807\\20180708_w451.png',0,NULL),(452,'2018-07-08 10:05:31',727,64,'201807\\20180708_w452.png',0,NULL),(453,'2018-07-08 10:11:56',939,319,'201807\\20180708_w453.png',0,NULL),(454,'2018-07-08 10:18:30',853,378,'201807\\20180708_w454.png',0,NULL),(455,'2018-07-08 10:27:23',1065,508,'201807\\20180708_w455.png',0,NULL),(456,'2018-07-08 10:32:26',1064,292,'201807\\20180708_w456.png',0,NULL),(457,'2018-07-08 11:10:39',1067,1775,'201804\\t.png',1,NULL),(458,'2018-07-08 16:00:21',878,287,'201807\\20180708_w458.png',0,NULL),(459,'2018-07-08 16:03:44',879,186,'201807\\20180708_w459.png',1,NULL),(460,'2018-07-08 16:10:33',879,105,'201807\\20180708_w460.png',0,NULL),(461,'2018-07-08 16:13:58',880,64,'201807\\20180708_w461.png',0,NULL),(462,'2018-07-08 16:20:01',881,145,'201807\\20180708_w462.png',1,NULL),(463,'2018-07-08 16:24:35',882,247,'201807\\20180708_w463.png',1,NULL),(464,'2018-07-08 16:52:27',883,1470,'201807\\20180708_w464.png',0,NULL),(465,'2018-07-08 16:58:11',884,321,'201807\\20180708_w465.png',0,NULL),(466,'2018-07-13 13:15:46',881,331,'201807\\20180713_w466.png',1,NULL),(467,'2018-07-13 13:25:19',882,418,'201807\\20180713_w467.png',0,NULL),(468,'2018-07-13 13:31:44',885,271,'201807\\20180713_w468.png',0,NULL),(469,'2018-07-13 13:33:16',886,76,'201807\\20180713_w469.png',0,NULL),(470,'2018-07-13 13:36:53',887,108,'201807\\20180713_w470.png',0,NULL),(471,'2018-07-13 13:41:33',890,133,'201807\\20180713_w471.png',1,NULL),(472,'2018-07-13 13:47:21',893,288,'201807\\20180713_w472.png',0,NULL),(473,'2018-07-13 13:52:57',897,231,'201807\\20180713_w473.png',1,NULL),(474,'2018-07-13 14:00:23',898,129,'201807\\20180713_w474.png',0,NULL),(475,'2018-07-13 14:06:32',899,344,'201807\\20180713_w475.png',0,NULL),(476,'2018-07-13 14:11:40',900,129,'201807\\20180713_w476.png',1,NULL),(477,'2018-07-13 14:17:41',901,256,'201807\\20180713_w477.png',0,NULL),(478,'2018-07-13 15:25:13',902,2667,'201807\\20180713_w478.png',0,NULL),(479,'2018-07-13 16:54:28',881,177,'201807\\20180713_w479.png',0,NULL),(480,'2018-07-13 16:58:31',890,85,'201807\\20180713_w480.png',0,NULL),(481,'2018-07-13 17:03:40',897,103,'201807\\20180713_w481.png',0,NULL),(482,'2018-07-13 17:11:11',900,141,'201807\\20180713_w482.png',0,NULL),(483,'2018-07-13 17:32:26',903,720,'201807\\20180713_w483.png',1,NULL),(484,'2018-07-13 18:01:23',903,225,'201807\\20180713_w484.png',0,NULL),(485,'2018-07-13 18:13:24',1069,357,'201804\\t.png',1,NULL),(486,'2018-07-13 18:16:19',1074,138,'201807\\20180713_w486.png',0,NULL),(487,'2018-07-13 18:19:01',1075,118,'201807\\20180713_w487.png',0,NULL),(488,'2018-07-13 18:22:03',1076,153,'201807\\20180713_w488.png',0,NULL),(489,'2018-07-13 18:26:52',1077,231,'201807\\20180713_w489.png',0,NULL),(490,'2018-07-13 18:53:25',1078,1488,'201807\\20180713_w490.png',0,NULL),(491,'2018-07-14 09:02:22',1083,282,'201807\\20180714_w491.png',0,NULL),(492,'2018-07-14 16:31:02',908,691,'201807\\20180714_w492.png',0,NULL),(493,'2018-07-14 16:36:42',909,267,'201807\\20180714_w493.png',0,NULL),(494,'2018-07-14 16:44:51',910,390,'201807\\20180714_w494.png',0,NULL),(495,'2018-07-14 16:48:27',911,200,'201807\\20180714_w495.png',0,NULL),(496,'2018-07-14 16:54:34',912,271,'201807\\20180714_w496.png',0,NULL),(497,'2018-07-14 16:57:18',913,150,'201807\\20180714_w497.png',0,NULL),(498,'2018-07-14 17:00:23',914,146,'201807\\20180714_w498.png',0,NULL),(499,'2018-07-14 17:07:33',915,370,'201807\\20180714_w499.png',0,NULL),(500,'2018-07-14 17:09:21',916,89,'201807\\20180714_w500.png',0,NULL),(501,'2018-07-14 17:34:40',917,1268,'201807\\20180714_w501.png',0,NULL),(502,'2018-07-14 18:04:09',918,1720,'201807\\20180714_w502.png',0,NULL),(503,'2018-07-14 18:33:03',920,124,'201807\\20180714_w503.png',0,NULL),(504,'2018-07-14 18:50:18',904,953,'201807\\20180714_w504.png',0,NULL),(505,'2018-07-15 09:16:51',1332,489,'201807\\20180715_w505.png',0,NULL),(506,'2018-07-15 09:41:13',1333,1427,'201807\\20180715_w506.png',1,NULL),(507,'2018-07-15 09:58:37',1333,134,'201807\\20180715_w507.png',0,NULL),(508,'2018-07-15 13:30:22',921,105,'201807\\20180715_w508.png',0,NULL),(509,'2018-07-15 13:33:14',922,132,'201807\\20180715_w509.png',1,NULL),(510,'2018-07-15 13:37:29',923,109,'201807\\20180715_w510.png',0,NULL),(511,'2018-07-15 13:51:16',924,676,'201807\\20180715_w511.png',0,NULL),(512,'2018-07-15 13:54:10',925,145,'201807\\20180715_w512.png',0,NULL),(513,'2018-07-15 14:03:11',927,510,'201807\\20180715_w513.png',0,NULL),(514,'2018-07-15 14:06:02',928,123,'201807\\20180715_w514.png',0,NULL),(515,'2018-07-15 14:10:52',929,271,'201807\\20180715_w515.png',0,NULL);
/*!40000 ALTER TABLE `work` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-15 14:24:34
