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
-- Table structure for table `paperwork`
--

DROP TABLE IF EXISTS `paperwork`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paperwork` (
  `idpaperwork` int(11) NOT NULL AUTO_INCREMENT,
  `idpaper` int(11) DEFAULT NULL,
  `idwork` int(11) DEFAULT NULL,
  `idproblem` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpaperwork`),
  KEY `idpaper_idx` (`idpaper`),
  KEY `fk_idwork_idx` (`idwork`),
  KEY `fk_idproblem_idx` (`idproblem`),
  CONSTRAINT `fk_idpaper` FOREIGN KEY (`idpaper`) REFERENCES `paper` (`idpaper`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_idproblem` FOREIGN KEY (`idproblem`) REFERENCES `problem` (`idproblem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_idwork` FOREIGN KEY (`idwork`) REFERENCES `work` (`idwork`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1531 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paperwork`
--

LOCK TABLES `paperwork` WRITE;
/*!40000 ALTER TABLE `paperwork` DISABLE KEYS */;
INSERT INTO `paperwork` VALUES (3,6,63,337),(4,1,40,85),(5,1,41,89),(6,1,42,94),(7,1,32,105),(8,1,33,112),(9,1,34,116),(10,1,35,141),(11,1,36,143),(12,1,37,144),(13,1,38,160),(14,1,39,161),(15,6,64,345),(16,2,43,201),(17,2,44,202),(18,2,45,203),(19,2,46,204),(20,2,47,205),(21,2,48,206),(22,2,49,207),(23,2,50,208),(24,2,51,209),(25,2,52,210),(26,2,53,211),(27,2,54,212),(28,2,55,213),(29,2,56,214),(30,2,57,215),(31,6,65,345),(32,6,66,346),(33,6,67,347),(34,6,68,348),(35,6,69,349),(36,6,70,350),(37,6,71,351),(38,6,72,352),(39,6,73,353),(40,6,74,354),(41,6,75,354),(42,6,76,355),(43,6,77,356),(44,6,78,357),(45,6,79,358),(46,6,80,359),(47,6,81,359),(48,6,82,360),(49,6,83,361),(50,6,84,362),(51,6,85,360),(52,6,86,360),(53,6,87,363),(54,6,88,364),(55,2,89,216),(56,2,90,217),(57,2,91,218),(58,2,92,219),(59,2,93,220),(60,2,94,221),(61,2,95,221),(62,2,96,222),(63,2,97,223),(64,2,98,224),(65,2,99,225),(66,2,100,226),(67,2,101,201),(68,2,102,202),(69,2,103,204),(70,2,104,205),(71,2,105,206),(72,2,106,207),(73,2,107,213),(74,2,108,215),(75,2,109,223),(76,2,110,225),(77,2,111,204),(78,2,112,223),(79,2,113,226),(80,2,114,227),(81,2,115,228),(82,2,116,229),(83,2,117,230),(84,2,118,228),(85,2,119,231),(86,2,120,232),(87,2,121,233),(88,2,122,233),(89,3,123,190),(90,3,124,191),(91,3,125,192),(92,3,126,193),(93,3,127,194),(94,3,128,195),(95,3,129,196),(96,3,130,196),(97,3,131,197),(98,3,132,198),(99,3,133,199),(100,3,134,200),(101,3,135,192),(102,3,136,194),(103,3,137,198),(104,3,138,234),(105,3,139,235),(106,3,140,236),(107,3,141,237),(108,3,142,238),(109,3,143,239),(113,3,150,236),(114,3,151,240),(115,3,152,241),(116,3,153,242),(117,3,154,243),(118,3,155,244),(119,3,156,245),(120,3,157,246),(121,3,158,247),(122,3,159,248),(123,3,160,249),(124,3,161,250),(125,6,162,364),(126,6,163,365),(127,6,164,366),(128,9,165,404),(129,9,166,406),(130,9,167,408),(131,9,168,409),(132,9,169,414),(133,9,170,416),(134,9,171,417),(135,9,172,418),(136,9,173,409),(137,9,174,414),(138,9,175,416),(139,9,176,419),(140,9,177,420),(141,9,178,421),(142,9,179,422),(143,9,180,423),(144,9,181,424),(145,9,182,425),(146,9,183,426),(147,9,184,427),(148,9,185,428),(149,9,186,429),(150,9,187,430),(151,9,188,431),(152,9,189,432),(153,9,190,433),(154,7,191,16),(155,7,192,18),(156,7,193,19),(157,7,194,21),(158,7,195,22),(159,7,196,23),(160,7,197,28),(161,7,198,29),(162,7,199,32),(163,7,200,34),(164,7,201,35),(165,7,202,36),(166,7,203,42),(167,7,204,43),(168,7,205,45),(169,7,206,46),(170,7,207,22),(171,7,208,45),(172,7,209,46),(173,7,210,22),(174,4,211,142),(175,1,212,144),(176,1,213,144),(177,1,214,144),(178,1,215,144),(179,4,216,151),(180,1,217,161),(181,4,218,161),(182,4,219,151),(183,4,220,162),(184,4,221,151),(185,4,222,164),(186,4,223,168),(187,4,224,151),(188,4,225,169),(189,4,226,177),(190,4,227,170),(191,4,228,144),(192,4,229,169),(193,4,230,171),(194,4,231,161),(195,4,232,169),(196,4,233,172),(197,4,234,174),(198,4,235,176),(199,4,236,179),(200,4,237,182),(201,4,238,184),(202,4,239,169),(203,4,240,188),(204,4,241,189),(205,10,242,379),(206,10,243,382),(207,10,244,384),(208,10,245,385),(209,10,246,386),(210,10,247,400),(211,10,248,401),(212,10,249,382),(213,10,250,402),(214,10,251,403),(215,10,252,314),(216,10,253,315),(217,10,254,322),(218,10,255,323),(219,10,256,333),(220,10,257,441),(221,10,258,450),(222,10,259,451),(223,10,260,384),(224,10,261,403),(225,10,262,450),(226,10,263,461),(227,10,264,462),(228,10,265,461),(229,10,266,462),(230,10,267,384),(231,10,268,384),(232,10,269,462),(233,4,270,169),(234,4,271,184),(235,4,272,188),(236,4,273,189),(237,11,274,475),(238,11,275,482),(239,11,276,482),(240,11,277,483),(241,9,278,745),(242,9,279,746),(243,9,280,747),(244,9,281,745),(245,9,282,746),(246,11,283,484),(247,11,284,485),(248,11,285,492),(249,11,286,494),(250,11,287,498),(251,11,288,499),(252,11,289,502),(253,11,290,501),(254,11,291,516),(255,11,292,525),(256,11,293,527),(257,11,294,485),(258,11,295,499),(259,11,296,501),(260,11,297,527),(261,12,298,299),(262,12,299,46),(263,12,300,202),(264,12,301,203),(265,12,302,204),(266,12,303,205),(267,12,304,213),(268,12,305,223),(269,12,306,225),(270,12,307,194),(271,12,308,198),(272,12,309,236),(273,12,310,249),(274,12,311,249),(275,12,312,274),(276,12,313,275),(277,12,314,276),(278,13,315,298),(279,13,316,301),(280,13,317,211),(281,13,318,303),(282,13,319,304),(283,13,320,330),(284,13,321,74),(285,13,322,72),(286,13,323,471),(287,13,324,298),(288,13,325,72),(289,13,326,169),(290,13,327,504),(291,13,328,293),(292,13,329,537),(293,13,330,361),(294,13,331,747),(295,13,332,537),(296,13,333,616),(297,14,334,300),(298,14,335,218),(299,14,336,305),(300,14,337,306),(301,14,338,316),(302,14,339,73),(303,14,340,461),(304,14,341,472),(305,13,342,169),(306,13,343,537),(307,13,344,616),(308,13,345,616),(309,14,346,73),(310,14,347,472),(311,14,348,189),(312,14,349,553),(313,14,350,296),(314,14,351,536),(315,14,352,364),(316,14,353,73),(317,14,354,189),(318,14,355,73),(319,14,356,429),(320,15,357,584),(321,15,358,585),(322,15,359,603),(323,15,360,603),(324,15,361,602),(325,15,362,599),(326,15,363,598),(327,15,364,597),(328,15,365,596),(329,15,366,595),(330,15,367,594),(331,15,368,592),(332,15,369,590),(333,16,370,826),(334,16,371,827),(335,16,372,828),(336,16,373,829),(337,16,374,830),(338,16,375,831),(339,15,376,585),(340,15,377,599),(341,15,378,598),(342,15,379,597),(343,15,380,596),(344,14,381,296),(345,16,382,826),(346,16,383,827),(347,16,384,829),(348,16,385,831),(349,16,386,836),(350,16,387,837),(351,16,388,838),(352,16,389,840),(353,16,390,841),(354,16,391,842),(355,16,392,844),(356,15,393,596),(357,15,394,596),(358,16,395,829),(359,16,396,828),(360,16,397,840),(361,16,398,842),(362,16,399,844),(363,16,400,845),(364,16,401,846),(365,16,402,847),(366,16,403,848),(367,16,404,697),(368,16,405,698),(369,16,406,699),(370,16,407,700),(371,16,408,701),(372,16,409,702),(373,16,410,703),(374,16,411,704),(375,16,412,705),(376,16,413,706),(377,16,414,707),(378,16,415,708),(379,16,416,709),(380,16,417,706),(381,16,418,847),(382,16,419,848),(383,16,420,710),(384,16,421,711),(385,16,422,712),(386,16,423,713),(387,17,424,904),(388,16,425,714),(389,16,426,715),(390,16,427,715),(391,16,428,716),(392,16,429,717),(393,16,430,718),(394,16,431,719),(395,16,432,710),(396,16,433,711),(397,16,434,713),(398,5,436,25),(399,16,437,718),(400,16,438,720),(401,16,439,721),(402,16,440,722),(403,16,441,723),(404,16,442,724),(405,16,443,725),(406,16,444,726),(407,17,445,905),(408,16,446,723),(409,16,447,724),(410,16,448,727),(411,16,449,728),(412,16,450,729),(413,16,451,724),(414,16,452,727),(415,21,453,939),(416,21,454,853),(417,21,455,1065),(418,21,456,1064),(419,21,457,1067),(420,20,458,878),(421,20,459,879),(422,20,460,879),(423,20,461,880),(424,20,462,881),(425,20,463,882),(426,20,464,883),(427,20,465,884),(428,20,466,881),(429,20,467,882),(430,20,468,885),(431,20,469,886),(432,20,470,887),(433,20,471,890),(434,20,472,893),(435,20,473,897),(436,20,474,898),(437,20,475,899),(438,20,476,900),(439,20,477,901),(440,20,478,902),(441,20,479,881),(442,20,480,890),(443,20,481,897),(444,20,482,900),(445,20,483,903),(446,20,484,903),(447,21,485,1069),(448,21,486,1074),(449,21,487,1075),(450,21,488,1076),(451,21,489,1077),(452,21,490,1078),(453,21,491,1083),(454,19,492,908),(455,19,493,909),(456,19,494,910),(457,19,495,911),(458,19,496,912),(459,19,497,913),(460,19,498,914),(461,19,499,915),(462,19,500,916),(463,19,501,917),(464,19,502,918),(465,19,503,920),(466,17,504,904),(467,22,505,1332),(468,22,506,1333),(469,22,507,1333),(470,19,508,921),(471,19,509,922),(472,19,510,923),(473,19,511,924),(474,19,512,925),(475,19,513,927),(476,19,514,928),(477,19,515,929),(478,21,516,1089),(479,19,517,922),(480,19,518,930),(481,19,519,932),(482,19,520,931),(483,19,521,933),(484,19,522,934),(485,19,523,932),(486,19,524,933),(487,19,525,932),(488,19,526,934),(489,8,527,50),(490,8,528,51),(491,8,529,53),(492,17,530,906),(493,8,531,56),(494,8,532,61),(495,8,533,67),(496,8,534,69),(497,8,535,56),(498,8,536,61),(499,8,537,70),(500,8,538,71),(501,8,539,72),(502,8,540,73),(503,8,541,74),(504,23,542,795),(505,23,543,796),(506,23,544,797),(507,23,545,798),(508,23,546,800),(509,23,547,801),(510,23,548,802),(511,23,549,807),(512,23,550,808),(513,23,551,810),(514,23,552,814),(515,23,553,815),(516,23,554,816),(517,23,555,817),(518,23,556,818),(519,23,557,819),(520,23,558,820),(521,23,559,1345),(522,23,560,1346),(523,23,561,1349),(524,23,562,1350),(525,23,563,1352),(526,23,564,1355),(527,18,565,1426),(528,23,566,1357),(529,23,567,1358),(530,23,568,1359),(531,23,569,1363),(532,23,570,1366),(533,23,571,1368),(534,23,572,1372),(535,23,573,1374),(536,23,574,1376),(537,23,575,1378),(538,23,576,1379),(539,23,577,1379),(540,23,578,1380),(541,23,579,1385),(542,23,580,1387),(543,23,581,1391),(544,23,582,1393),(545,23,583,1394),(546,23,584,1395),(547,23,585,1403),(548,23,586,1404),(549,23,587,1405),(550,23,588,1406),(551,23,589,1407),(552,23,590,1408),(553,23,591,1413),(554,23,592,1414),(555,23,593,1415),(556,23,594,1418),(557,23,595,1419),(558,23,596,1420),(559,23,597,1421),(560,23,598,1423),(561,23,599,1424),(562,17,600,907),(563,23,601,1408),(564,18,602,1427),(565,24,603,106),(566,24,604,112),(567,24,605,134),(568,24,606,144),(569,24,607,150),(570,24,608,151),(571,24,609,161),(572,24,610,305),(573,24,611,159),(574,24,612,169),(575,24,613,168),(576,24,614,171),(577,19,615,935),(578,17,616,1305),(579,19,617,935),(580,18,618,1428),(581,19,619,935),(582,19,620,935),(583,24,621,171),(584,24,622,189),(585,24,623,184),(586,24,624,188),(587,24,625,187),(588,24,626,555),(589,24,627,582),(590,24,628,596),(591,24,629,597),(592,24,630,603),(593,24,631,614),(594,17,632,1306),(595,18,633,1429),(596,24,634,189),(597,18,635,1430),(598,25,636,626),(599,25,637,633),(600,25,638,639),(601,25,639,640),(602,25,640,626),(603,25,641,640),(604,25,642,641),(605,25,643,642),(606,18,644,1431),(607,22,645,1577),(608,22,646,1578),(609,22,647,1578),(610,22,648,1579),(611,22,649,1580),(612,22,650,1580),(613,18,651,1432),(614,22,652,1581),(615,22,653,1581),(616,22,654,1582),(617,22,655,1583),(618,25,656,642),(619,25,657,643),(620,25,658,644),(621,25,659,645),(622,25,660,1036),(623,25,661,1040),(624,25,662,1041),(625,25,663,1042),(626,25,664,1043),(627,25,665,1042),(628,25,666,1047),(629,25,667,1048),(630,25,668,1050),(631,25,669,1051),(632,25,670,1052),(633,25,671,1251),(634,25,672,1252),(635,25,673,1253),(636,26,674,932),(637,26,675,933),(638,26,676,934),(639,26,677,933),(640,25,678,1047),(641,25,679,1050),(642,26,680,933),(643,26,681,934),(644,25,682,1052),(645,25,683,1254),(646,25,684,1255),(647,25,685,1256),(648,25,686,1257),(649,25,687,1052),(650,25,688,1258),(651,25,689,1259),(652,26,690,935),(653,26,691,881),(654,26,692,902),(655,26,693,897),(656,26,694,900),(657,26,695,935),(658,26,696,881),(659,26,697,881),(660,26,698,902),(661,26,699,897),(662,18,700,1433),(663,26,701,903),(664,26,702,22),(665,26,703,41),(666,26,704,45),(667,26,705,41),(668,26,706,46),(669,26,707,297),(670,26,708,298),(671,26,709,46),(672,26,710,301),(673,26,711,384),(674,26,712,398),(675,26,713,301),(676,26,714,384),(677,26,715,331),(678,26,716,384),(679,26,717,331),(680,26,718,324),(681,26,719,301),(682,26,720,324),(683,18,721,1434),(684,18,722,1435),(685,26,723,56),(686,26,724,62),(687,26,725,73),(688,26,726,462),(689,26,727,462),(690,26,728,450),(691,26,729,472),(692,26,730,56),(693,26,731,259),(694,26,732,260),(695,26,733,261),(696,26,734,260),(697,26,735,261),(698,26,736,268),(699,18,737,1434),(700,18,738,1436),(701,26,739,470),(702,26,740,470),(703,26,741,1102),(704,26,742,1103),(705,26,743,1103),(706,26,744,1105),(707,26,745,1106),(708,26,746,1107),(709,26,747,1106),(710,26,748,1107),(711,26,749,1106),(712,26,750,1106),(713,26,751,1106),(714,26,752,1107),(715,28,753,1364),(716,28,754,1365),(717,28,755,1366),(718,28,756,1710),(719,28,757,1712),(720,28,758,1365),(721,28,759,1711),(722,28,760,1712),(723,28,761,1396),(724,28,762,1713),(725,28,763,1714),(726,28,764,1712),(727,28,765,1711),(728,28,766,1711),(729,28,767,1715),(730,28,768,1716),(731,28,769,1717),(732,28,770,1718),(733,28,771,1720),(734,28,772,1721),(735,28,773,196),(736,28,774,249),(737,28,775,250),(738,28,776,296),(739,28,777,295),(740,28,778,293),(741,28,779,292),(742,28,780,646),(743,28,781,1716),(744,28,782,295),(745,28,783,1716),(746,27,784,1231),(747,27,785,1232),(748,27,786,1233),(749,27,787,1234),(750,27,788,1235),(751,27,789,1236),(752,18,790,1437),(753,27,791,1231),(754,27,792,1231),(755,27,793,1235),(756,27,794,1236),(757,27,795,1237),(758,27,796,1238),(759,27,797,112),(760,27,798,117),(761,27,799,1237),(762,27,800,1238),(763,27,801,112),(764,27,802,117),(765,27,803,151),(766,27,804,306),(767,27,805,573),(768,27,806,582),(769,27,807,598),(770,27,808,599),(771,27,809,598),(772,27,810,599),(773,27,811,603),(774,27,812,604),(775,27,813,616),(776,27,814,604),(777,27,815,616),(778,27,816,616),(779,27,817,617),(780,27,818,617),(781,18,819,1438),(782,18,820,1439),(783,30,821,1705),(784,30,822,112),(785,30,823,1764),(786,30,824,961),(787,30,825,1764),(788,30,826,112),(789,30,827,1764),(790,30,828,960),(791,30,829,144),(792,30,830,144),(793,30,831,151),(794,30,832,161),(795,30,833,169),(796,30,834,188),(797,30,835,554),(798,30,836,555),(799,30,837,345),(800,30,838,359),(801,30,839,364),(802,30,840,361),(803,30,841,366),(804,30,842,554),(805,30,843,1003),(806,30,844,1004),(807,30,845,1006),(808,30,846,1008),(809,30,847,1013),(810,30,848,169),(811,30,849,345),(812,30,850,169),(813,30,851,345),(814,30,852,364),(815,30,853,345),(816,30,854,1003),(817,30,855,1008),(818,30,856,1014),(819,30,857,1015),(820,30,858,1020),(821,30,859,1021),(822,30,860,1022),(823,30,861,1024),(824,30,862,1026),(825,30,863,1027),(826,30,864,1028),(827,30,865,1029),(828,30,866,1030),(829,30,867,1014),(830,30,868,1031),(831,30,869,596),(832,30,870,1014),(833,30,871,1029),(834,30,872,1030),(835,30,873,1031),(836,30,874,596),(837,29,875,1523),(838,29,876,1533),(839,29,877,1535),(840,29,878,1537),(841,29,879,1538),(842,29,880,1539),(843,29,881,1539),(844,29,882,1533),(845,29,883,1535),(846,29,884,1538),(847,29,885,1543),(848,29,886,829),(849,29,887,844),(850,29,888,847),(851,29,889,932),(852,29,890,933),(853,29,891,934),(854,29,892,935),(855,29,893,934),(856,29,894,902),(857,29,895,934),(858,29,896,847),(859,29,897,902),(860,29,898,1538),(861,18,899,1440),(862,29,900,897),(863,29,901,903),(864,29,902,301),(865,29,903,22),(866,29,904,298),(867,29,905,332),(868,29,906,56),(869,29,907,73),(870,18,908,1441),(871,29,909,56),(872,29,910,1742),(873,29,911,462),(874,29,912,1748),(875,29,913,1750),(876,29,914,261),(877,29,915,462),(878,29,916,1748),(879,29,917,897),(880,29,918,301),(881,29,919,1742),(882,29,920,332),(883,29,921,934),(884,29,922,1538),(885,29,923,847),(886,29,924,847),(887,18,925,1442),(888,18,926,1442),(889,29,927,1543),(890,29,928,469),(891,29,929,1735),(892,29,930,1736),(893,29,931,499),(894,29,932,1736),(895,29,933,1106),(896,29,934,1104),(897,33,935,2229),(898,33,936,2230),(899,33,937,2231),(900,33,938,2232),(901,33,939,2233),(902,33,940,2234),(903,33,941,2235),(904,33,942,2236),(905,33,943,2237),(906,33,944,2237),(907,33,945,2238),(908,33,946,2230),(909,33,947,2232),(910,33,948,2233),(911,33,949,2232),(912,33,950,2233),(913,34,951,2254),(914,34,952,2255),(915,34,953,2256),(916,34,954,2257),(917,34,955,2258),(918,34,956,2259),(919,34,957,2260),(920,34,958,2261),(921,34,959,2262),(922,34,960,2263),(923,34,961,2264),(924,34,962,2265),(925,34,963,2266),(926,34,964,2267),(927,34,965,2268),(928,34,966,2269),(929,34,967,2270),(930,34,968,2271),(931,34,969,2272),(932,34,970,2273),(933,34,971,2274),(934,34,972,2275),(935,34,973,2276),(936,35,974,2279),(937,35,975,2281),(938,35,976,2282),(939,35,977,2283),(940,35,978,2284),(941,35,979,2285),(942,35,980,2286),(943,35,981,2291),(944,35,982,2292),(945,35,983,2293),(946,35,984,2294),(947,35,985,2295),(948,35,986,2296),(949,35,987,2297),(950,35,988,2298),(951,35,989,2292),(952,35,990,2293),(953,35,991,2295),(954,35,992,2296),(955,36,993,2311),(956,36,994,2313),(957,36,995,2315),(958,36,996,2321),(959,36,997,2330),(960,36,998,2331),(961,36,999,2332),(962,36,1000,2333),(963,36,1001,2334),(964,36,1002,2335),(965,37,1003,2386),(966,37,1004,2387),(967,37,1005,2388),(968,37,1006,2389),(969,37,1007,2390),(970,37,1008,2391),(971,37,1009,2392),(972,37,1010,2393),(973,37,1011,2394),(974,37,1012,2395),(975,17,1013,1307),(976,17,1014,1308),(977,17,1015,1309),(978,37,1016,2083),(979,37,1017,585),(980,37,1018,1627),(981,37,1019,1628),(982,37,1020,1629),(983,37,1021,1630),(984,35,1022,2284),(985,17,1023,1618),(986,39,1024,2437),(987,39,1025,2438),(988,39,1026,2439),(989,39,1027,2440),(990,39,1028,2441),(991,39,1029,2442),(992,39,1030,2443),(993,39,1031,2444),(994,39,1032,2445),(995,39,1033,2446),(996,39,1034,2447),(997,39,1035,2448),(998,39,1036,2449),(999,39,1037,2450),(1000,39,1038,2451),(1001,39,1039,2452),(1002,38,1040,1372),(1003,38,1041,1376),(1004,38,1042,197),(1005,40,1043,2461),(1006,40,1044,2462),(1007,38,1045,2459),(1008,40,1046,2463),(1009,40,1047,2464),(1010,40,1048,2464),(1011,40,1049,2465),(1012,40,1050,2466),(1013,40,1051,2467),(1014,40,1052,2468),(1015,40,1053,2469),(1016,40,1054,2470),(1017,40,1055,2471),(1018,40,1056,2541),(1019,40,1057,2542),(1020,40,1058,2543),(1021,40,1059,2544),(1022,40,1060,2545),(1023,40,1061,2546),(1024,40,1062,2547),(1025,40,1063,2548),(1026,42,1064,2482),(1027,42,1065,2483),(1028,42,1066,2484),(1029,42,1067,2485),(1030,42,1068,2486),(1031,42,1069,2487),(1032,42,1070,2488),(1033,42,1071,2489),(1034,42,1072,2490),(1035,42,1073,2551),(1036,42,1074,2552),(1037,42,1075,2553),(1038,42,1076,2554),(1039,42,1077,2555),(1040,42,1078,2556),(1041,42,1079,2557),(1042,43,1080,2498),(1043,43,1081,2499),(1044,43,1082,2496),(1045,43,1083,2500),(1046,43,1084,2501),(1047,43,1085,2502),(1048,43,1086,2503),(1049,43,1087,2504),(1050,43,1088,2505),(1051,43,1089,2506),(1052,43,1090,2501),(1053,43,1091,2506),(1054,43,1092,2561),(1055,44,1093,2517),(1056,44,1094,2518),(1057,44,1095,2519),(1058,44,1096,2520),(1059,44,1097,2521),(1060,44,1098,2522),(1061,44,1099,2523),(1062,44,1100,2524),(1063,44,1101,2571),(1064,44,1102,2572),(1065,44,1103,2573),(1066,44,1104,2574),(1067,44,1105,2575),(1068,38,1106,2241),(1069,38,1107,2242),(1070,38,1108,2220),(1071,38,1109,2230),(1072,38,1110,2232),(1073,38,1111,2254),(1074,44,1112,2576),(1075,44,1113,2577),(1076,44,1114,2578),(1077,44,1115,2579),(1078,44,1116,2580),(1079,38,1117,2284),(1080,38,1118,2284),(1081,38,1119,2285),(1082,38,1120,2295),(1083,38,1121,2285),(1084,38,1122,2311),(1085,38,1123,2448),(1086,38,1124,2428),(1087,38,1125,2464),(1088,38,1126,2292),(1089,35,1127,2285),(1090,35,1128,2298),(1091,35,1129,2299),(1092,35,1130,2300),(1093,35,1131,2301),(1094,35,1132,2302),(1095,35,1133,2303),(1096,35,1134,2304),(1097,35,1135,2305),(1098,35,1136,2299),(1099,35,1137,2306),(1100,35,1138,2307),(1101,41,1139,2340),(1102,41,1140,2341),(1103,36,1141,2336),(1104,36,1142,2337),(1105,43,1143,2562),(1106,43,1144,2564),(1107,43,1145,2565),(1108,43,1146,2566),(1109,43,1147,2567),(1110,43,1148,2565),(1111,42,1149,2558),(1112,42,1150,2559),(1113,43,1151,2568),(1114,43,1152,2567),(1115,43,1153,2569),(1116,43,1154,2570),(1117,42,1155,2560),(1118,45,1156,2531),(1119,45,1157,2532),(1120,45,1158,2531),(1121,45,1159,2533),(1122,46,1160,2711),(1123,45,1161,2540),(1124,45,1162,2581),(1125,31,1163,185),(1126,31,1164,344),(1127,31,1165,1557),(1128,46,1166,2712),(1129,46,1167,2711),(1130,46,1168,2712),(1131,46,1169,2712),(1132,31,1170,596),(1133,31,1171,599),(1134,31,1172,604),(1135,31,1173,600),(1136,46,1174,2713),(1137,46,1175,2714),(1138,45,1176,2582),(1139,45,1177,2583),(1140,45,1178,2584),(1141,45,1179,2585),(1142,45,1180,2584),(1143,45,1181,2586),(1144,45,1182,2588),(1145,41,1183,2342),(1146,45,1184,2587),(1147,39,1185,2453),(1148,31,1186,593),(1149,31,1187,615),(1150,31,1188,618),(1151,31,1189,613),(1152,31,1190,1558),(1153,31,1191,1559),(1154,31,1192,1560),(1155,31,1193,613),(1156,31,1194,1565),(1157,31,1195,1566),(1158,31,1196,1568),(1159,41,1197,2343),(1160,41,1198,2344),(1161,45,1199,2587),(1162,41,1200,2345),(1163,41,1201,2346),(1164,48,1202,2890),(1165,48,1203,2891),(1166,48,1204,2892),(1167,48,1205,2893),(1168,48,1206,2894),(1169,48,1207,2895),(1170,48,1208,2896),(1171,48,1209,2897),(1172,48,1210,2898),(1173,48,1211,2899),(1174,48,1212,2900),(1175,48,1213,2901),(1176,48,1214,2902),(1177,48,1215,2903),(1178,48,1216,2904),(1179,48,1217,2905),(1180,48,1218,2906),(1181,48,1219,2907),(1182,48,1220,2908),(1183,48,1221,2907),(1184,48,1222,2909),(1185,48,1223,2910),(1186,49,1224,2913),(1187,49,1225,2916),(1188,49,1226,2918),(1189,48,1227,2910),(1190,48,1228,2911),(1191,49,1229,2921),(1192,49,1230,2922),(1193,49,1231,2923),(1194,49,1232,2924),(1195,49,1233,2925),(1196,49,1234,2918),(1197,49,1235,2919),(1198,31,1236,1231),(1199,31,1237,1237),(1200,31,1238,1238),(1201,49,1239,2919),(1202,49,1240,2920),(1203,41,1241,2347),(1204,41,1242,2348),(1205,41,1243,2349),(1206,31,1244,1235),(1207,31,1245,171),(1208,31,1246,171),(1209,31,1247,188),(1210,51,1248,3046),(1211,51,1249,3047),(1212,51,1250,3048),(1213,51,1251,3049),(1214,32,1252,1795),(1215,32,1253,1797),(1216,32,1254,1799),(1217,32,1255,1803),(1218,32,1256,204),(1219,32,1257,205),(1220,46,1258,2715),(1221,32,1259,1803),(1222,32,1260,1803),(1223,41,1261,2350),(1224,41,1262,2351),(1225,41,1263,2352),(1226,41,1264,2353),(1227,22,1265,1333),(1228,22,1266,1987),(1229,22,1267,1988),(1230,22,1268,1333),(1231,22,1269,1990),(1232,22,1270,1991),(1233,22,1271,1991),(1234,51,1272,3053),(1235,51,1273,3055),(1236,51,1274,3056),(1237,51,1275,3057),(1238,51,1276,3058),(1239,51,1277,3059),(1240,51,1278,3060),(1241,51,1279,3061),(1242,51,1280,3062),(1243,51,1281,3057),(1244,51,1282,3061),(1245,51,1283,3063),(1246,51,1284,3064),(1247,51,1285,3065),(1248,51,1286,3066),(1249,51,1287,3067),(1250,51,1288,3068),(1251,51,1289,3069),(1252,51,1290,3070),(1253,51,1291,3071),(1254,48,1292,3073),(1255,51,1293,3072),(1256,51,1294,3079),(1257,51,1295,3080),(1258,52,1296,2943),(1259,52,1297,2942),(1260,51,1298,3071),(1261,52,1299,2944),(1262,49,1300,2926),(1263,49,1301,2927),(1264,49,1302,2927),(1265,49,1303,2928),(1266,49,1304,2929),(1267,49,1305,2938),(1268,49,1306,2939),(1269,51,1307,3180),(1270,51,1308,3181),(1271,51,1309,3182),(1272,51,1310,3183),(1273,51,1311,3184),(1274,51,1312,3186),(1275,51,1313,3188),(1276,51,1314,3184),(1277,51,1315,3185),(1278,51,1316,3187),(1279,51,1317,3189),(1280,51,1318,3190),(1281,51,1319,3191),(1282,51,1320,3192),(1283,48,1321,3074),(1284,48,1322,3075),(1285,49,1323,2940),(1286,52,1324,2945),(1287,52,1325,2957),(1288,52,1326,2958),(1289,52,1327,2959),(1290,52,1328,2960),(1291,52,1329,2946),(1292,52,1330,2947),(1293,52,1331,2955),(1294,52,1332,2956),(1295,52,1333,2961),(1296,52,1334,2962),(1297,52,1335,3172),(1298,52,1336,3174),(1299,52,1337,3175),(1300,52,1338,2946),(1301,53,1339,2452),(1302,53,1340,1562),(1303,52,1341,2947),(1304,52,1342,2961),(1305,52,1343,3179),(1306,49,1344,2930),(1307,41,1345,2354),(1308,41,1346,2355),(1309,51,1347,3193),(1310,51,1348,3194),(1311,51,1349,3195),(1312,51,1350,3196),(1313,51,1351,3197),(1314,51,1352,3198),(1315,48,1353,3076),(1316,48,1354,3077),(1317,48,1355,3078),(1318,49,1356,2931),(1319,48,1357,3078),(1320,48,1358,3076),(1321,51,1359,3196),(1322,53,1360,3090),(1323,53,1361,3094),(1324,53,1362,3095),(1325,53,1363,3096),(1326,53,1364,3097),(1327,53,1365,3098),(1328,53,1366,3099),(1329,53,1367,3100),(1330,53,1368,3101),(1331,53,1369,3199),(1332,53,1370,3200),(1333,53,1371,3201),(1334,53,1372,3202),(1335,53,1373,3203),(1336,53,1374,3204),(1337,53,1375,3205),(1338,49,1376,2931),(1339,49,1377,2932),(1340,52,1378,2951),(1341,53,1379,3203),(1342,53,1380,3206),(1343,53,1381,3207),(1344,53,1382,3208),(1345,49,1383,2932),(1346,55,1384,3467),(1347,55,1385,3469),(1348,55,1386,3473),(1349,55,1387,2966),(1350,55,1388,2967),(1351,55,1389,2968),(1352,55,1390,2969),(1353,55,1391,2970),(1354,55,1392,2971),(1355,55,1393,2972),(1356,53,1394,1562),(1357,53,1395,3203),(1358,55,1396,2973),(1359,55,1397,2976),(1360,55,1398,2977),(1361,55,1399,2978),(1362,55,1400,2979),(1363,55,1401,2980),(1364,55,1402,2981),(1365,55,1403,2982),(1366,55,1404,2983),(1367,51,1405,3081),(1368,51,1406,3082),(1369,51,1407,3083),(1370,47,1408,1003),(1371,47,1409,1014),(1372,47,1410,1029),(1373,47,1411,1032),(1374,32,1412,206),(1375,32,1413,207),(1376,32,1414,223),(1377,32,1415,223),(1378,32,1416,233),(1379,32,1417,228),(1380,32,1418,983),(1381,32,1419,985),(1382,32,1420,228),(1383,47,1421,1003),(1384,47,1422,1033),(1385,47,1423,585),(1386,47,1424,603),(1387,47,1425,1003),(1388,47,1426,601),(1389,47,1427,603),(1390,47,1428,593),(1391,47,1429,601),(1392,47,1430,616),(1393,47,1431,1104),(1394,47,1432,1104),(1395,47,1433,1107),(1396,47,1434,1154),(1397,47,1435,1155),(1398,47,1436,1156),(1399,47,1437,1157),(1400,47,1438,1158),(1401,47,1439,1164),(1402,47,1440,710),(1403,47,1441,1262),(1404,54,1442,3426),(1405,32,1443,986),(1406,32,1444,987),(1407,32,1445,988),(1408,32,1446,989),(1409,32,1447,987),(1410,56,1448,2233),(1411,56,1449,2237),(1412,56,1450,2232),(1413,56,1451,261),(1414,57,1452,1171),(1415,57,1453,1173),(1416,57,1454,1184),(1417,57,1455,711),(1418,57,1456,974),(1419,57,1457,982),(1420,57,1458,1042),(1421,57,1459,1029),(1422,57,1460,1173),(1423,57,1461,711),(1424,57,1462,1042),(1425,57,1463,1173),(1426,57,1464,1042),(1427,57,1465,1029),(1428,58,1466,667),(1429,58,1467,675),(1430,58,1468,724),(1431,58,1469,603),(1432,58,1470,1107),(1433,58,1471,1142),(1434,58,1472,1447),(1435,58,1473,1647),(1436,58,1474,724),(1437,58,1475,1107),(1438,56,1476,1736),(1439,56,1477,470),(1440,56,1478,1738),(1441,56,1479,260),(1442,47,1480,141),(1443,56,1481,472),(1444,56,1482,2234),(1445,56,1483,2235),(1446,56,1484,2238),(1447,56,1485,2238),(1448,47,1486,141),(1449,54,1487,3431),(1450,59,1488,766),(1451,59,1489,1175),(1452,59,1490,1185),(1453,59,1491,710),(1454,59,1492,1711),(1455,59,1493,1716),(1456,59,1494,1706),(1457,59,1495,1273),(1458,59,1496,766),(1459,59,1497,1716),(1460,59,1498,766),(1461,59,1499,1711),(1462,50,1500,1720),(1463,50,1501,626),(1464,50,1502,1047),(1465,50,1503,1042),(1466,50,1504,1052),(1467,22,1505,1333),(1468,22,1506,1987),(1469,22,1507,1339),(1470,22,1508,1987),(1471,22,1509,1991),(1472,22,1510,1993),(1473,22,1511,1994),(1474,22,1512,1995),(1475,22,1513,1996),(1476,54,1514,3436),(1477,54,1515,3441),(1478,22,1516,1987),(1479,22,1517,1991),(1480,22,1518,1994),(1481,22,1519,1997),(1482,22,1520,1998),(1483,22,1521,1999),(1484,22,1522,2000),(1485,22,1523,3902),(1486,22,1524,3903),(1487,22,1525,3904),(1488,22,1526,3904),(1489,22,1527,3905),(1490,22,1528,3905),(1491,22,1529,3906),(1492,54,1530,3427),(1493,54,1531,3427),(1494,22,1532,3907),(1495,22,1533,3908),(1496,22,1534,3909),(1497,22,1535,3910),(1498,22,1536,3911),(1499,22,1537,3916),(1500,22,1538,3917),(1501,22,1539,3918),(1502,5,1540,25),(1503,60,1541,1274),(1504,60,1542,556),(1505,60,1543,1918),(1506,60,1544,1920),(1507,60,1545,1176),(1508,60,1546,1177),(1509,60,1547,2020),(1510,60,1548,2021),(1511,60,1549,1274),(1512,60,1550,1918),(1513,60,1551,1920),(1514,60,1552,1176),(1515,60,1553,1920),(1516,41,1554,2356),(1517,41,1555,2357),(1518,5,1556,25),(1519,61,1557,1332),(1520,61,1558,1581),(1521,61,1559,3740),(1522,61,1560,3779),(1523,61,1561,3799),(1524,61,1562,3786),(1525,61,1563,724),(1526,61,1564,681),(1527,61,1565,1332),(1528,61,1566,3786),(1529,61,1567,681),(1530,61,1568,1581);
/*!40000 ALTER TABLE `paperwork` ENABLE KEYS */;
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
