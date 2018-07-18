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
-- Table structure for table `sourcechapter`
--

DROP TABLE IF EXISTS `sourcechapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sourcechapter` (
  `idsourcechapter` int(11) NOT NULL AUTO_INCREMENT,
  `sourcechaptername` varchar(45) DEFAULT NULL,
  `sourcechapterindex` int(11) DEFAULT NULL,
  `sourceid` int(11) DEFAULT NULL,
  PRIMARY KEY (`idsourcechapter`),
  KEY `sourceid_idx` (`sourceid`),
  CONSTRAINT `sourceid` FOREIGN KEY (`sourceid`) REFERENCES `source` (`idsource`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sourcechapter`
--

LOCK TABLES `sourcechapter` WRITE;
/*!40000 ALTER TABLE `sourcechapter` DISABLE KEYS */;
INSERT INTO `sourcechapter` VALUES (1,'质数与合数',1,4),(2,'统筹与最优',2,4),(3,'加乘原理进阶',3,4),(4,'流水行船',4,4),(5,'抽屉原理初步',5,4),(7,'tests',1,10000),(8,'最值原理进阶',6,4),(9,'进位制初步',7,4),(10,'分解质因数',8,4),(11,'相遇与追及综合',9,4),(12,'整数与数列',10,4),(13,'平移旋转与对称',11,4),(14,'定义新运算',1,2),(15,'体育比赛中的数学',2,2),(16,'图形计数进阶',3,2),(17,'大数计算',4,2),(18,'等积变形',5,2),(19,'等高模型',6,2),(20,'一半模型',7,2),(21,'最值初步',8,2),(22,'幻方',9,2),(23,'平均数进阶',10,2),(24,'乘除法竖式',11,2),(25,'方程组',12,2),(26,'解应用题',13,2),(27,'环形跑道',14,2),(28,'火车过桥',15,2),(29,'图形的分割与剪拼',12,4),(30,'破译横式',13,4),(31,'牛吃草',14,4),(32,'数阵图中的奥秘',15,4),(33,'多位数计算',1,5),(34,'整数巧算',2,5),(35,'小数计算',3,5),(36,'数列',4,5),(37,'数表',5,5),(38,'加法原理',6,5),(39,'乘法原理',7,5),(40,'加乘综合',8,5),(41,'应用题综合一',9,5),(42,'应用题综合二',10,5),(43,'基本行程',11,5),(44,'相遇问题',12,5),(45,'追及问题',13,5),(46,'基本法求面积',14,5),(47,'分割法求面积',15,5),(48,'其他求面积',16,5),(49,'数字谜',17,5),(50,'幻方数阵图',18,5),(51,'抽屉原理',19,5),(52,'图形最值',20,5),(53,'应用最值',21,5),(54,'数字最值',22,5),(55,'统筹',23,5),(56,'计算综合',1,8),(57,'数阵图初步',2,8),(58,'竖式问题',3,8),(59,'几何图形剪拼',4,8),(60,'行程问题1',5,8),(61,'抽屉原理1',6,8),(62,'直线型计算1',7,8),(63,'和差倍3',8,8),(64,'还原与年龄',9,8),(65,'数列与数表',10,8),(66,'加乘原理',11,8),(67,'统筹与对策',12,8),(68,'多位数与小数',13,8),(69,'平均数',14,8),(70,'复杂竖式',15,8),(71,'横式问题',16,8),(72,'格点与割补',17,8),(73,'行程问题2',18,8),(74,'行程问题3',19,8),(75,'数阵图扩展',20,8),(76,'排列组合',21,8),(77,'计数综合',22,8),(78,'最值问题',23,8),(79,'逻辑推理1',24,8),(80,'小数巧算',1,3),(81,'格点与割补',2,3),(82,'数表',3,3),(83,'必胜策略',4,3),(84,'整除特征二',5,3),(85,'包含与排除',6,3),(86,'智趣巧题',7,3),(87,'比较与估算',1,6),(88,'四则运算',2,6),(89,'裂项',3,6),(90,'数列',4,6),(91,'数表',5,6),(92,'定义新运算',6,6),(93,'枚举法',7,6),(94,'加乘原理',8,6),(95,'包含与排除',9,6),(96,'排列与组合',10,6),(97,'几何计数',11,6),(98,'分数应用题',12,6),(99,'牛吃草问题',13,6),(100,'工程问题',14,6),(101,'火车过桥与流水行船',15,6),(102,'环形跑道与钟面行程',16,6),(103,'相遇与追及',17,6),(104,'等积变形',18,6),(105,'图形变换',19,6),(106,'弦图勾股定理',20,6),(107,'立体几何',21,6),(108,'进位位值原理',22,6),(109,'数的整除',23,6),(110,'质数合数',24,6),(111,'因数倍数',25,6),(112,'带余除法',26,6),(113,'完全平方数',27,6),(114,'数字迷综合',28,6),(115,'数独',29,6),(116,'逻辑推理',30,6),(117,'操作类问题',31,6),(118,'计算综合',1,7),(119,'应用题综合',2,7),(120,'行程问题',3,7),(121,'曲线几何',4,7),(122,'直线型几何1',5,7),(123,'直线型几何2',6,7),(124,'立体几何',7,7),(125,'数论综合1',8,7),(126,'数论综合2',9,7),(127,'计数综合1',10,7),(128,'计数综合2',11,7),(129,'最值问题综合',12,7),(130,'构造与论证',13,7),(131,'逻辑推理',14,7),(132,'数学谜题',15,7),(133,'古诗词',1,100),(134,'计数第1节——枚举法',1,11),(135,'计数第2节——树形图之传球表格',2,11),(136,'计数第3节——树形图之路线问题',3,11),(137,'计算小花园1',16,4),(138,'计算小花园2',17,4),(139,'计算小花园3',18,4);
/*!40000 ALTER TABLE `sourcechapter` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-18 12:22:52
