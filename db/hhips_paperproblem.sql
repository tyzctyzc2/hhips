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
-- Table structure for table `paperproblem`
--

DROP TABLE IF EXISTS `paperproblem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paperproblem` (
  `paperid` int(11) NOT NULL,
  `problemid` int(11) NOT NULL,
  `paperproblemid` int(11) NOT NULL AUTO_INCREMENT,
  `problemstatus` int(11) DEFAULT '1' COMMENT '1=active but no work\n2=finish but not check\n3=checked',
  `idwork` int(11) DEFAULT NULL,
  PRIMARY KEY (`paperproblemid`),
  KEY `idwork_idx` (`idwork`),
  CONSTRAINT `idwork` FOREIGN KEY (`idwork`) REFERENCES `work` (`idwork`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=758 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paperproblem`
--

LOCK TABLES `paperproblem` WRITE;
/*!40000 ALTER TABLE `paperproblem` DISABLE KEYS */;
INSERT INTO `paperproblem` VALUES (1,85,5,2,40),(1,89,6,2,41),(1,94,7,2,42),(1,105,8,2,32),(1,112,9,1,33),(1,116,10,2,34),(1,141,11,2,35),(1,143,12,2,36),(1,144,13,1,37),(1,160,14,2,38),(1,161,15,1,39),(2,201,16,3,101),(2,202,17,2,102),(2,203,18,2,45),(2,204,19,3,111),(2,205,20,2,104),(2,206,21,2,105),(2,207,22,2,106),(2,208,23,2,50),(2,209,24,2,51),(2,210,25,2,52),(2,211,26,2,53),(2,212,27,2,54),(2,213,28,2,107),(2,214,29,2,56),(2,215,30,2,108),(2,216,31,2,89),(2,217,32,2,90),(2,218,33,2,91),(2,219,34,2,92),(2,220,35,2,93),(2,221,36,2,95),(2,222,37,2,96),(2,223,38,3,112),(2,224,39,2,98),(2,225,40,2,110),(2,226,41,3,113),(2,227,42,3,114),(2,228,43,3,118),(2,229,44,3,116),(2,230,45,3,117),(2,231,46,3,119),(2,232,47,2,120),(2,233,48,3,122),(3,190,49,3,123),(3,191,50,3,124),(3,192,51,3,135),(3,193,52,3,126),(3,194,53,3,136),(3,195,54,3,128),(3,196,55,3,130),(3,197,56,3,131),(3,198,57,3,137),(3,199,58,3,133),(3,200,59,3,134),(3,234,60,3,138),(3,235,61,3,139),(3,236,62,3,150),(3,237,63,3,141),(3,238,64,3,142),(3,239,65,3,143),(3,240,66,3,151),(3,241,67,3,152),(3,242,68,3,153),(3,243,69,3,154),(3,244,70,3,155),(3,245,71,3,156),(3,246,72,3,157),(3,247,73,3,158),(3,248,74,3,159),(3,249,75,1,160),(3,250,76,3,161),(4,142,77,3,211),(4,144,78,3,228),(4,151,79,3,224),(4,161,80,3,231),(4,162,82,3,220),(4,164,83,3,222),(4,168,84,3,223),(4,169,85,1,270),(4,177,86,3,226),(6,337,88,2,63),(6,345,89,2,65),(6,346,90,2,66),(6,347,91,2,67),(6,348,92,2,68),(6,349,93,2,69),(6,350,94,2,70),(6,351,95,2,71),(6,352,96,3,72),(6,353,97,3,73),(6,354,98,3,75),(6,355,99,3,76),(6,356,100,3,77),(6,357,101,3,78),(6,358,102,3,79),(6,359,103,3,81),(6,360,104,3,86),(6,361,105,3,83),(6,362,106,3,84),(6,363,107,3,87),(6,364,108,3,162),(6,365,109,3,163),(6,366,110,3,164),(4,170,111,3,227),(4,171,112,3,230),(4,172,113,3,233),(4,174,114,3,234),(4,176,115,3,235),(4,179,116,3,236),(4,182,117,3,237),(4,184,118,3,271),(4,188,119,3,272),(4,189,120,1,273),(7,16,121,3,191),(7,18,122,3,192),(7,19,123,3,193),(7,21,124,3,194),(7,22,125,3,210),(7,23,126,3,196),(7,28,127,3,197),(7,29,128,3,198),(7,32,129,3,199),(7,34,130,3,200),(7,35,131,3,201),(7,36,132,3,202),(7,42,133,3,203),(7,43,134,3,204),(7,45,135,3,208),(7,46,136,3,209),(9,404,137,3,165),(9,406,138,3,166),(9,408,139,3,167),(9,409,140,3,173),(9,414,141,3,174),(9,416,142,3,175),(9,417,143,3,171),(9,418,144,3,172),(9,419,145,3,176),(9,420,146,3,177),(9,421,147,3,178),(9,422,148,3,179),(9,423,149,3,180),(9,424,150,3,181),(9,425,151,3,182),(9,426,152,3,183),(9,427,153,3,184),(9,428,154,3,185),(9,429,155,3,186),(9,430,156,3,187),(9,431,157,3,188),(9,432,158,3,189),(9,433,159,3,190),(10,379,160,3,242),(10,382,161,3,249),(10,384,162,3,268),(10,385,163,3,245),(10,386,164,3,246),(10,400,165,3,247),(10,401,166,3,248),(10,402,167,3,250),(10,403,168,3,261),(10,314,169,3,252),(10,315,170,3,253),(10,322,171,3,254),(10,323,172,3,255),(10,333,173,3,256),(8,50,174,3,527),(8,51,175,3,528),(8,53,176,3,529),(8,56,177,3,535),(8,61,178,3,536),(8,67,179,3,533),(8,69,180,3,534),(8,70,181,3,537),(8,71,182,3,538),(8,72,183,3,539),(8,73,184,3,540),(8,74,185,3,541),(10,441,186,3,257),(10,450,187,3,262),(10,451,188,3,259),(10,461,189,3,265),(10,462,190,3,269),(11,475,191,3,274),(11,482,192,3,276),(11,483,193,3,277),(11,484,194,3,283),(11,485,195,3,294),(11,492,196,3,285),(11,494,197,3,286),(11,498,198,3,287),(11,499,199,3,295),(11,502,200,3,289),(11,501,201,3,296),(11,516,203,3,291),(11,525,204,3,292),(11,527,206,3,297),(11,532,207,1,NULL),(11,535,208,1,NULL),(11,536,209,1,NULL),(12,299,210,3,298),(12,46,213,3,299),(12,202,214,3,300),(12,203,215,3,301),(12,204,216,3,302),(12,205,217,3,303),(12,213,218,3,304),(12,223,219,3,305),(12,225,220,1,306),(12,194,221,3,307),(12,198,222,3,308),(12,236,223,3,309),(12,249,224,3,311),(12,274,225,3,312),(12,275,226,3,313),(12,276,227,3,314),(12,283,228,1,NULL),(12,284,229,1,NULL),(12,292,230,1,NULL),(12,293,231,1,NULL),(12,296,232,1,NULL),(9,745,233,3,281),(9,746,234,3,282),(9,747,235,1,280),(9,748,236,1,NULL),(13,298,256,3,324),(13,301,257,3,316),(13,211,258,3,317),(13,303,259,3,318),(13,304,260,3,319),(13,330,261,3,320),(13,74,262,3,321),(13,72,263,3,325),(13,471,264,3,323),(13,169,265,3,342),(13,504,266,3,327),(13,293,267,3,328),(13,537,268,3,343),(13,361,269,3,330),(13,747,270,3,331),(13,616,271,3,345),(14,300,272,3,334),(14,218,273,3,335),(14,305,274,3,336),(14,306,275,3,337),(14,316,276,3,338),(14,73,277,3,355),(14,461,278,3,340),(14,472,279,3,347),(14,189,280,3,354),(14,553,281,3,349),(14,296,282,3,381),(14,536,283,3,351),(14,364,284,3,352),(14,429,285,3,356),(15,584,286,3,357),(15,585,287,3,376),(15,603,288,3,360),(15,602,289,3,361),(15,599,290,3,377),(15,598,291,3,378),(15,597,292,3,379),(15,596,293,3,394),(15,595,294,3,366),(15,594,295,3,367),(15,592,296,3,368),(15,590,297,3,369),(16,826,298,3,382),(16,827,299,3,383),(16,828,300,3,396),(16,829,301,3,395),(16,830,302,3,374),(16,831,303,3,385),(16,836,304,3,386),(16,837,305,3,387),(16,838,306,3,388),(16,840,307,3,397),(16,841,308,3,390),(16,842,309,3,398),(16,844,310,3,399),(16,845,311,3,400),(16,846,312,3,401),(16,847,313,3,418),(16,848,314,3,419),(16,697,315,3,404),(16,698,316,3,405),(16,699,317,3,406),(16,700,318,3,407),(16,701,319,3,408),(16,702,320,3,409),(16,703,321,3,410),(16,704,322,3,411),(16,705,323,3,412),(16,706,324,3,417),(16,707,325,3,414),(16,708,326,3,415),(16,709,327,3,416),(16,710,328,3,432),(16,711,329,3,433),(16,712,330,3,422),(16,713,331,3,434),(16,714,332,3,425),(16,715,333,3,427),(16,716,334,3,428),(16,717,335,3,429),(16,718,336,3,437),(16,719,337,3,431),(16,720,338,3,438),(16,721,339,3,439),(16,722,340,3,440),(16,723,341,3,446),(16,724,342,3,451),(16,725,343,3,443),(16,726,344,3,444),(16,727,345,3,452),(16,728,346,3,449),(16,729,347,3,450),(17,904,348,3,504),(5,25,350,1,436),(17,905,351,3,445),(19,908,352,3,492),(19,909,353,3,493),(19,910,354,3,494),(19,911,355,3,495),(19,912,356,3,496),(19,913,357,3,497),(19,914,358,3,498),(19,915,359,3,499),(19,916,360,3,500),(19,917,361,3,501),(19,918,362,3,502),(19,920,363,3,503),(19,921,364,3,508),(19,922,365,3,517),(19,923,366,3,510),(19,924,367,3,511),(19,925,368,3,512),(19,927,369,3,513),(19,928,370,3,514),(19,929,371,3,515),(19,930,372,3,518),(19,932,373,3,525),(19,931,374,3,520),(19,933,375,3,524),(19,934,376,3,526),(19,935,377,3,620),(20,878,378,3,458),(20,879,379,3,460),(20,880,380,3,461),(20,881,381,3,479),(20,882,382,3,467),(20,883,383,3,464),(20,884,384,3,465),(20,885,385,3,468),(20,886,386,3,469),(20,887,387,3,470),(20,890,388,3,480),(20,893,389,3,472),(20,897,390,3,481),(20,898,391,3,474),(20,899,392,3,475),(20,900,393,3,482),(20,901,394,3,477),(20,902,395,3,478),(20,903,396,3,484),(21,939,397,3,453),(21,853,398,3,454),(21,1065,400,2,455),(21,1064,401,2,456),(21,1067,402,2,457),(21,1069,403,2,485),(21,1074,404,3,486),(21,1075,405,3,487),(21,1076,406,3,488),(21,1077,407,3,489),(21,1078,408,3,490),(21,1,409,1,NULL),(21,1083,410,3,491),(21,1089,411,3,516),(17,906,412,3,530),(17,907,413,2,600),(17,1305,414,2,616),(17,1306,415,2,632),(17,1307,416,1,NULL),(17,1308,417,1,NULL),(17,1309,418,1,NULL),(22,1332,419,3,505),(22,1333,420,3,507),(21,1057,421,1,NULL),(21,1059,422,1,NULL),(21,1060,423,1,NULL),(21,1066,424,1,NULL),(21,1068,425,1,NULL),(23,795,426,3,542),(23,796,427,3,543),(23,797,428,3,544),(23,798,429,3,545),(23,800,430,3,546),(23,801,431,3,547),(23,802,432,3,548),(23,807,433,3,549),(23,808,434,3,550),(23,810,435,3,551),(23,814,436,3,552),(23,815,437,3,553),(23,816,438,3,554),(23,817,439,3,555),(23,818,440,3,556),(23,819,441,3,557),(23,820,442,3,558),(23,1345,443,3,559),(23,1346,444,3,560),(23,1349,445,3,561),(23,1350,446,3,562),(23,1352,447,3,563),(23,1355,448,3,564),(23,1357,449,3,566),(23,1358,450,3,567),(23,1359,451,3,568),(23,1363,452,3,569),(23,1366,453,3,570),(23,1368,454,3,571),(23,1372,455,3,572),(23,1374,456,3,573),(23,1376,457,3,574),(23,1378,458,3,575),(23,1379,459,3,577),(23,1380,460,3,578),(23,1385,461,3,579),(23,1387,462,3,580),(23,1391,463,3,581),(23,1393,464,3,582),(23,1394,465,3,583),(23,1395,466,3,584),(23,1403,467,3,585),(23,1404,468,3,586),(23,1405,469,3,587),(23,1406,470,3,588),(23,1407,471,3,589),(23,1408,472,3,601),(23,1413,473,3,591),(23,1414,474,3,592),(23,1415,475,3,593),(23,1418,476,3,594),(23,1419,477,3,595),(23,1420,478,3,596),(23,1421,479,3,597),(23,1423,480,3,598),(23,1424,481,3,599),(18,1426,482,3,565),(18,1427,483,3,602),(18,1428,484,3,618),(18,1429,485,3,633),(18,1430,486,2,635),(18,1431,487,2,644),(18,1432,488,3,651),(18,1433,489,3,700),(24,106,490,3,603),(24,112,491,3,604),(24,134,492,3,605),(24,144,493,3,606),(24,150,494,3,607),(24,151,495,3,608),(24,161,496,3,609),(24,305,497,3,610),(24,159,498,3,611),(24,169,499,3,612),(24,168,500,3,613),(24,171,501,3,621),(24,189,502,3,634),(24,184,503,3,623),(24,188,504,3,624),(24,187,505,3,625),(24,555,506,3,626),(24,582,507,3,627),(24,596,508,3,628),(24,597,509,3,629),(24,603,510,3,630),(24,614,511,3,631),(25,626,512,3,640),(25,633,513,3,637),(25,639,514,3,638),(25,640,515,3,641),(25,641,516,3,642),(25,642,517,3,656),(25,643,518,3,657),(25,644,519,3,658),(25,645,520,3,659),(25,1036,521,3,660),(25,1040,522,3,661),(25,1041,523,3,662),(25,1042,524,3,665),(25,1043,525,3,664),(25,1047,526,3,678),(25,1048,527,3,667),(25,1050,528,3,679),(25,1051,529,3,669),(25,1052,530,3,687),(25,1251,531,3,671),(25,1252,532,3,672),(25,1253,533,3,673),(25,1254,534,3,683),(25,1255,535,3,684),(25,1256,536,3,685),(25,1257,537,3,686),(25,1258,538,3,688),(25,1259,539,3,689),(26,932,540,3,674),(26,933,541,3,680),(26,934,542,3,681),(26,935,543,3,695),(26,881,544,3,697),(26,902,545,3,698),(26,897,546,3,699),(26,900,547,3,694),(26,903,548,3,701),(26,22,549,3,702),(26,41,550,3,705),(26,45,551,3,704),(26,46,552,3,709),(26,297,553,3,707),(26,298,554,3,708),(26,301,555,3,719),(26,384,556,3,716),(26,398,557,3,712),(26,331,558,3,717),(26,324,559,3,720),(26,56,560,3,730),(26,62,561,3,724),(26,73,562,3,725),(26,462,563,3,727),(26,450,564,3,728),(26,472,565,3,729),(26,259,566,3,731),(26,260,567,3,734),(26,261,568,3,735),(26,268,569,3,736),(26,470,570,3,740),(26,1102,571,3,741),(26,1103,572,3,743),(26,1105,573,3,744),(26,1106,574,3,751),(26,1107,575,3,752),(27,1231,576,3,792),(27,1232,577,3,785),(27,1233,578,3,786),(27,1234,579,3,787),(27,1235,580,3,793),(27,1236,581,3,794),(27,1237,582,3,799),(27,1238,583,3,800),(18,1434,584,3,737),(18,1435,585,3,722),(18,1436,586,3,738),(18,1437,587,3,790),(18,1438,588,2,819),(18,1439,589,3,820),(18,1440,590,1,NULL),(18,1441,591,1,NULL),(18,1442,592,1,NULL),(18,1443,593,1,NULL),(18,1444,594,1,NULL),(18,1445,595,1,NULL),(22,1577,596,3,645),(22,1578,597,3,647),(22,1579,598,3,648),(22,1580,599,3,650),(22,1581,600,3,653),(22,1582,601,1,654),(22,1583,602,1,655),(17,1618,603,1,NULL),(27,112,604,3,801),(27,117,605,3,802),(27,151,606,3,803),(27,306,607,3,804),(27,573,608,3,805),(27,582,609,3,806),(27,598,610,3,809),(27,599,611,3,810),(27,603,612,3,811),(27,604,613,3,814),(27,616,614,3,816),(27,617,615,3,818),(28,1364,616,3,753),(28,1365,617,3,758),(28,1366,618,3,755),(28,1710,619,3,756),(28,1712,620,3,764),(28,1711,621,3,766),(28,1396,622,3,761),(28,1713,623,3,762),(28,1714,624,3,763),(28,1715,625,3,767),(28,1716,626,3,783),(28,1717,627,3,769),(28,1718,628,3,770),(28,1720,629,3,771),(28,1721,630,3,772),(28,196,631,3,773),(28,249,632,3,774),(28,250,633,3,775),(28,296,634,3,776),(28,295,635,3,782),(28,293,636,3,778),(28,292,637,3,779),(28,646,638,3,780),(29,1523,639,1,NULL),(29,1533,640,1,NULL),(29,1535,641,1,NULL),(29,1537,642,1,NULL),(29,1538,643,1,NULL),(29,1539,644,1,NULL),(29,1543,645,1,NULL),(29,829,646,1,NULL),(29,844,647,1,NULL),(29,847,648,1,NULL),(29,932,649,1,NULL),(29,933,650,1,NULL),(29,934,651,1,NULL),(29,935,652,1,NULL),(29,902,653,1,NULL),(29,897,654,1,NULL),(29,903,655,1,NULL),(29,301,656,1,NULL),(29,22,657,1,NULL),(29,298,658,1,NULL),(29,332,659,1,NULL),(29,56,660,1,NULL),(29,73,661,1,NULL),(29,1742,662,1,NULL),(29,462,663,1,NULL),(29,1748,664,1,NULL),(29,1750,665,1,NULL),(29,261,666,1,NULL),(29,469,667,1,NULL),(29,1735,668,1,NULL),(29,1736,669,1,NULL),(29,499,670,1,NULL),(29,1106,671,1,NULL),(29,1104,672,1,NULL),(29,1107,673,1,NULL),(29,1101,674,1,NULL),(29,1108,675,1,NULL),(29,1109,676,1,NULL),(29,1110,677,1,NULL),(29,1111,678,1,NULL),(29,1123,679,1,NULL),(29,1124,680,1,NULL),(30,1705,681,3,821),(30,112,682,3,826),(30,1764,683,3,827),(30,961,684,2,824),(30,960,685,3,828),(30,144,686,3,830),(30,151,687,3,831),(30,161,688,3,832),(30,169,689,3,850),(30,188,690,3,834),(30,554,691,3,842),(30,555,692,3,836),(30,345,693,3,853),(30,359,694,3,838),(30,364,695,3,852),(30,361,696,3,840),(30,366,697,3,841),(30,1003,698,3,854),(30,1004,699,3,844),(30,1006,700,3,845),(30,1008,701,3,855),(30,1013,702,3,847),(30,1014,703,3,870),(30,1015,704,3,857),(30,1020,705,3,858),(30,1021,706,3,859),(30,1022,707,3,860),(30,1024,708,3,861),(30,1026,709,3,862),(30,1027,710,3,863),(30,1028,711,3,864),(30,1029,712,3,871),(30,1030,713,2,872),(30,1031,714,1,868),(30,596,715,1,869),(31,185,716,1,NULL),(31,344,717,1,NULL),(31,1557,718,1,NULL),(31,596,719,1,NULL),(31,599,720,1,NULL),(31,604,721,1,NULL),(31,600,722,1,NULL),(31,593,723,1,NULL),(31,615,724,1,NULL),(31,618,725,1,NULL),(31,613,726,1,NULL),(31,1558,727,1,NULL),(31,1559,728,1,NULL),(31,1560,729,1,NULL),(31,1565,730,1,NULL),(31,1566,731,1,NULL),(31,1568,732,1,NULL),(31,1569,733,1,NULL),(31,1572,734,1,NULL),(31,1231,735,1,NULL),(31,1237,736,1,NULL),(31,1238,737,1,NULL),(31,1235,738,1,NULL),(31,171,739,1,NULL),(31,188,740,1,NULL),(32,1795,741,1,NULL),(32,1797,742,1,NULL),(32,1799,743,1,NULL),(32,1803,744,1,NULL),(32,204,745,1,NULL),(32,205,746,1,NULL),(32,206,747,1,NULL),(32,207,748,1,NULL),(32,223,749,1,NULL),(32,233,750,1,NULL),(32,228,751,1,NULL),(32,983,752,1,NULL),(32,985,753,1,NULL),(32,986,754,1,NULL),(32,987,755,1,NULL),(32,988,756,1,NULL),(32,989,757,1,NULL);
/*!40000 ALTER TABLE `paperproblem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-07 22:00:35
