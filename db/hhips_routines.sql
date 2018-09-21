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
-- Temporary view structure for view `v_workperdayproblem`
--

DROP TABLE IF EXISTS `v_workperdayproblem`;
/*!50001 DROP VIEW IF EXISTS `v_workperdayproblem`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_workperdayproblem` AS SELECT 
 1 AS `workday`,
 1 AS `totalproblem`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_workbypaper`
--

DROP TABLE IF EXISTS `v_workbypaper`;
/*!50001 DROP VIEW IF EXISTS `v_workbypaper`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_workbypaper` AS SELECT 
 1 AS `idwork`,
 1 AS `workdate`,
 1 AS `idproblem`,
 1 AS `usedtime`,
 1 AS `workdetail`,
 1 AS `workmark`,
 1 AS `reason`,
 1 AS `idstarreason`,
 1 AS `starreasonname`,
 1 AS `starreasonfactor`,
 1 AS `idpaper`,
 1 AS `problemchapterid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_chapterproblemwithlastwork`
--

DROP TABLE IF EXISTS `v_chapterproblemwithlastwork`;
/*!50001 DROP VIEW IF EXISTS `v_chapterproblemwithlastwork`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_chapterproblemwithlastwork` AS SELECT 
 1 AS `modulename`,
 1 AS `idwork`,
 1 AS `usedtime`,
 1 AS `workdate`,
 1 AS `workmark`,
 1 AS `workdetail`,
 1 AS `reason`,
 1 AS `problemchapterid`,
 1 AS `idproblem`,
 1 AS `problemanswerdetail`,
 1 AS `problemanswerstring`,
 1 AS `problemcisactive`,
 1 AS `problemdetail`,
 1 AS `problemindex`,
 1 AS `problemlevel`,
 1 AS `problemmodule`,
 1 AS `problemtotalusetime`,
 1 AS `problemtotalworktime`,
 1 AS `oldusedtime`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_problem_chapersummary`
--

DROP TABLE IF EXISTS `v_problem_chapersummary`;
/*!50001 DROP VIEW IF EXISTS `v_problem_chapersummary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_problem_chapersummary` AS SELECT 
 1 AS `problemchapterid`,
 1 AS `idproblem`,
 1 AS `problemtotalworktime`,
 1 AS `problemtotalusetime`,
 1 AS `problemmaxtime`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_paperproblem`
--

DROP TABLE IF EXISTS `v_paperproblem`;
/*!50001 DROP VIEW IF EXISTS `v_paperproblem`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_paperproblem` AS SELECT 
 1 AS `idproblem`,
 1 AS `problemlevel`,
 1 AS `problemdetail`,
 1 AS `problemchapterid`,
 1 AS `problemindex`,
 1 AS `problemmodule`,
 1 AS `problemcisactive`,
 1 AS `problemanswerstring`,
 1 AS `problemanswerdetail`,
 1 AS `problemstatus`,
 1 AS `paperproblemid`,
 1 AS `idpaper`,
 1 AS `isactive`,
 1 AS `papername`,
 1 AS `idwork`,
 1 AS `workdetail`,
 1 AS `reason`,
 1 AS `idstarreason`,
 1 AS `usedtime`,
 1 AS `workmark`,
 1 AS `workdate`,
 1 AS `modulename`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_workperday`
--

DROP TABLE IF EXISTS `v_workperday`;
/*!50001 DROP VIEW IF EXISTS `v_workperday`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_workperday` AS SELECT 
 1 AS `workday`,
 1 AS `totalproblem`,
 1 AS `totaltime`,
 1 AS `totalwork`,
 1 AS `workmark`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_workperdaytime`
--

DROP TABLE IF EXISTS `v_workperdaytime`;
/*!50001 DROP VIEW IF EXISTS `v_workperdaytime`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_workperdaytime` AS SELECT 
 1 AS `workday`,
 1 AS `workmark`,
 1 AS `totalstar`,
 1 AS `totalwork`,
 1 AS `totaltime`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_papersummary`
--

DROP TABLE IF EXISTS `v_papersummary`;
/*!50001 DROP VIEW IF EXISTS `v_papersummary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_papersummary` AS SELECT 
 1 AS `idpaper`,
 1 AS `papername`,
 1 AS `paperdate`,
 1 AS `paperstatus`,
 1 AS `totalusedtime`,
 1 AS `totalproblem`,
 1 AS `totaldone`,
 1 AS `totalanswer`,
 1 AS `avgperproblem`,
 1 AS `avgperanswer`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_workdetaillist`
--

DROP TABLE IF EXISTS `v_workdetaillist`;
/*!50001 DROP VIEW IF EXISTS `v_workdetaillist`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_workdetaillist` AS SELECT 
 1 AS `idwork`,
 1 AS `startdate`,
 1 AS `workdate`,
 1 AS `idproblem`,
 1 AS `usedtime`,
 1 AS `workdetail`,
 1 AS `workmark`,
 1 AS `reason`,
 1 AS `idstarreason`,
 1 AS `starreasonname`,
 1 AS `starreasonfactor`,
 1 AS `problemlevel`,
 1 AS `problemindex`,
 1 AS `idmodule`,
 1 AS `modulename`,
 1 AS `idpaper`,
 1 AS `papername`,
 1 AS `problemchapterid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_problem`
--

DROP TABLE IF EXISTS `v_problem`;
/*!50001 DROP VIEW IF EXISTS `v_problem`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_problem` AS SELECT 
 1 AS `idproblem`,
 1 AS `problemlevel`,
 1 AS `problemdetail`,
 1 AS `problemchapterid`,
 1 AS `problemindex`,
 1 AS `problemmodule`,
 1 AS `problemcisactive`,
 1 AS `problemanswerstring`,
 1 AS `problemanswerdetail`,
 1 AS `modulename`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_tagbyproblem`
--

DROP TABLE IF EXISTS `v_tagbyproblem`;
/*!50001 DROP VIEW IF EXISTS `v_tagbyproblem`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_tagbyproblem` AS SELECT 
 1 AS `idtag`,
 1 AS `tagname`,
 1 AS `idproblem`,
 1 AS `idtag4problem`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_chaptersummary`
--

DROP TABLE IF EXISTS `v_chaptersummary`;
/*!50001 DROP VIEW IF EXISTS `v_chaptersummary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_chaptersummary` AS SELECT 
 1 AS `idsourcechapter`,
 1 AS `sourceid`,
 1 AS `sourcechapterindex`,
 1 AS `sourcechaptername`,
 1 AS `chapterproblemcount`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_workperdayproblem`
--

/*!50001 DROP VIEW IF EXISTS `v_workperdayproblem`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_workperdayproblem` AS select cast(`w`.`workdate` as date) AS `workday`,count(distinct `w`.`idproblem`) AS `totalproblem` from `work` `w` group by cast(`w`.`workdate` as date) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_workbypaper`
--

/*!50001 DROP VIEW IF EXISTS `v_workbypaper`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_workbypaper` AS select `w`.`idwork` AS `idwork`,`w`.`workdate` AS `workdate`,`w`.`idproblem` AS `idproblem`,round((`w`.`usedtime` / 60),0) AS `usedtime`,`w`.`workdetail` AS `workdetail`,`w`.`workmark` AS `workmark`,`w`.`reason` AS `reason`,`w`.`idstarreason` AS `idstarreason`,`sr`.`starreasonname` AS `starreasonname`,`sr`.`starreasonfactor` AS `starreasonfactor`,`pw`.`idpaper` AS `idpaper`,`p`.`problemchapterid` AS `problemchapterid` from (((`work` `w` join `paperwork` `pw` on((`pw`.`idwork` = `w`.`idwork`))) join `problem` `p` on((`w`.`idproblem` = `p`.`idproblem`))) left join `starreason` `sr` on((`w`.`idstarreason` = `sr`.`idstarreason`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_chapterproblemwithlastwork`
--

/*!50001 DROP VIEW IF EXISTS `v_chapterproblemwithlastwork`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_chapterproblemwithlastwork` AS select `m`.`modulename` AS `modulename`,`w`.`idwork` AS `idwork`,round((`w`.`usedtime` / 60),0) AS `usedtime`,`w`.`workdate` AS `workdate`,`w`.`workmark` AS `workmark`,`w`.`workdetail` AS `workdetail`,`w`.`reason` AS `reason`,`p`.`problemchapterid` AS `problemchapterid`,`p`.`idproblem` AS `idproblem`,`p`.`problemanswerdetail` AS `problemanswerdetail`,`p`.`problemanswerstring` AS `problemanswerstring`,`p`.`problemcisactive` AS `problemcisactive`,`p`.`problemdetail` AS `problemdetail`,`p`.`problemindex` AS `problemindex`,`p`.`problemlevel` AS `problemlevel`,`p`.`problemmodule` AS `problemmodule`,round((`s`.`problemtotalusetime` / 60),0) AS `problemtotalusetime`,`s`.`problemtotalworktime` AS `problemtotalworktime`,round(((`s`.`problemtotalusetime` - `w`.`usedtime`) / 60),0) AS `oldusedtime` from (((`problem` `p` join `module` `m` on((`p`.`problemmodule` = `m`.`idmodule`))) join `v_problem_chapersummary` `s` on((`p`.`idproblem` = `s`.`idproblem`))) left join `work` `w` on((`w`.`idwork` = (select `w2`.`idwork` from `work` `w2` where (`w2`.`idproblem` = `p`.`idproblem`) order by `w2`.`workdate` desc limit 1)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_problem_chapersummary`
--

/*!50001 DROP VIEW IF EXISTS `v_problem_chapersummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_problem_chapersummary` AS select `p`.`problemchapterid` AS `problemchapterid`,`p`.`idproblem` AS `idproblem`,count(`w`.`idwork`) AS `problemtotalworktime`,sum(`w`.`usedtime`) AS `problemtotalusetime`,max(`w`.`usedtime`) AS `problemmaxtime` from (`problem` `p` left join `work` `w` on((`p`.`idproblem` = `w`.`idproblem`))) group by `p`.`idproblem` order by `p`.`idproblem` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_paperproblem`
--

/*!50001 DROP VIEW IF EXISTS `v_paperproblem`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_paperproblem` AS select `p`.`idproblem` AS `idproblem`,`p`.`problemlevel` AS `problemlevel`,`p`.`problemdetail` AS `problemdetail`,`p`.`problemchapterid` AS `problemchapterid`,`p`.`problemindex` AS `problemindex`,`p`.`problemmodule` AS `problemmodule`,`p`.`problemcisactive` AS `problemcisactive`,`p`.`problemanswerstring` AS `problemanswerstring`,`p`.`problemanswerdetail` AS `problemanswerdetail`,`pp`.`problemstatus` AS `problemstatus`,`pp`.`paperproblemid` AS `paperproblemid`,`per`.`idpaper` AS `idpaper`,`per`.`isactive` AS `isactive`,`per`.`papername` AS `papername`,`w`.`idwork` AS `idwork`,`w`.`workdetail` AS `workdetail`,`w`.`reason` AS `reason`,`w`.`idstarreason` AS `idstarreason`,round((`w`.`usedtime` / 60),0) AS `usedtime`,`w`.`workmark` AS `workmark`,`w`.`workdate` AS `workdate`,`m`.`modulename` AS `modulename` from ((((`paperproblem` `pp` join `problem` `p` on((`pp`.`problemid` = `p`.`idproblem`))) join `paper` `per` on((`pp`.`paperid` = `per`.`idpaper`))) left join `work` `w` on((`pp`.`idwork` = `w`.`idwork`))) join `module` `m` on((`p`.`problemmodule` = `m`.`idmodule`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_workperday`
--

/*!50001 DROP VIEW IF EXISTS `v_workperday`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_workperday` AS select `wp`.`workday` AS `workday`,`wp`.`totalproblem` AS `totalproblem`,`wt`.`totaltime` AS `totaltime`,`wt`.`totalwork` AS `totalwork`,`wt`.`workmark` AS `workmark` from (`v_workperdayproblem` `wp` join `v_workperdaytime` `wt` on((`wp`.`workday` = `wt`.`workday`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_workperdaytime`
--

/*!50001 DROP VIEW IF EXISTS `v_workperdaytime`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_workperdaytime` AS select cast(`w`.`workdate` as date) AS `workday`,`w`.`workmark` AS `workmark`,count(`w`.`idstarreason`) AS `totalstar`,count(0) AS `totalwork`,round((sum(`w`.`usedtime`) / 60),0) AS `totaltime` from `work` `w` group by cast(`w`.`workdate` as date),`w`.`workmark` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_papersummary`
--

/*!50001 DROP VIEW IF EXISTS `v_papersummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_papersummary` AS select `p`.`idpaper` AS `idpaper`,`p`.`papername` AS `papername`,`p`.`paperdate` AS `paperdate`,`p`.`isactive` AS `paperstatus`,round((sum(`w`.`usedtime`) / 60),0) AS `totalusedtime`,count(distinct `pp`.`problemid`) AS `totalproblem`,count(distinct `pw`.`idproblem`) AS `totaldone`,count(`w`.`idwork`) AS `totalanswer`,round(((sum(`w`.`usedtime`) / count(distinct `pw`.`idproblem`)) / 60),0) AS `avgperproblem`,round(((sum(`w`.`usedtime`) / count(`w`.`idwork`)) / 60),0) AS `avgperanswer` from (((`paper` `p` left join `paperproblem` `pp` on((`pp`.`paperid` = `p`.`idpaper`))) left join `paperwork` `pw` on(((`pp`.`problemid` = `pw`.`idproblem`) and (`pp`.`paperid` = `pw`.`idpaper`)))) left join `work` `w` on((`pw`.`idwork` = `w`.`idwork`))) group by `p`.`idpaper`,`p`.`papername` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_workdetaillist`
--

/*!50001 DROP VIEW IF EXISTS `v_workdetaillist`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_workdetaillist` AS select `w`.`idwork` AS `idwork`,(`w`.`workdate` - interval `w`.`usedtime` second) AS `startdate`,`w`.`workdate` AS `workdate`,`w`.`idproblem` AS `idproblem`,round((`w`.`usedtime` / 60),0) AS `usedtime`,`w`.`workdetail` AS `workdetail`,`w`.`workmark` AS `workmark`,`w`.`reason` AS `reason`,`w`.`idstarreason` AS `idstarreason`,`sr`.`starreasonname` AS `starreasonname`,`sr`.`starreasonfactor` AS `starreasonfactor`,`p`.`problemlevel` AS `problemlevel`,`p`.`problemindex` AS `problemindex`,`m`.`idmodule` AS `idmodule`,`m`.`modulename` AS `modulename`,`pw`.`idpaper` AS `idpaper`,`pe`.`papername` AS `papername`,`p`.`problemchapterid` AS `problemchapterid` from (((((`work` `w` join `paperwork` `pw` on((`pw`.`idwork` = `w`.`idwork`))) join `problem` `p` on((`w`.`idproblem` = `p`.`idproblem`))) join `paper` `pe` on((`pw`.`idpaper` = `pe`.`idpaper`))) join `module` `m` on((`p`.`problemmodule` = `m`.`idmodule`))) left join `starreason` `sr` on((`w`.`idstarreason` = `sr`.`idstarreason`))) order by (`w`.`workdate` - interval `w`.`usedtime` second) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_problem`
--

/*!50001 DROP VIEW IF EXISTS `v_problem`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_problem` AS select `p`.`idproblem` AS `idproblem`,`p`.`problemlevel` AS `problemlevel`,`p`.`problemdetail` AS `problemdetail`,`p`.`problemchapterid` AS `problemchapterid`,`p`.`problemindex` AS `problemindex`,`p`.`problemmodule` AS `problemmodule`,`p`.`problemcisactive` AS `problemcisactive`,`p`.`problemanswerstring` AS `problemanswerstring`,`p`.`problemanswerdetail` AS `problemanswerdetail`,`m`.`modulename` AS `modulename` from (`problem` `p` join `module` `m` on((`p`.`problemmodule` = `m`.`idmodule`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_tagbyproblem`
--

/*!50001 DROP VIEW IF EXISTS `v_tagbyproblem`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_tagbyproblem` AS select `t`.`idtag` AS `idtag`,`t`.`tagname` AS `tagname`,`tp`.`idproblem` AS `idproblem`,`tp`.`idtag4problem` AS `idtag4problem` from ((`tag4problem` `tp` join `problem` `p` on((`tp`.`idproblem` = `p`.`idproblem`))) join `tag` `t` on((`tp`.`idtag` = `t`.`idtag`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_chaptersummary`
--

/*!50001 DROP VIEW IF EXISTS `v_chaptersummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_chaptersummary` AS select `c`.`idsourcechapter` AS `idsourcechapter`,`c`.`sourceid` AS `sourceid`,`c`.`sourcechapterindex` AS `sourcechapterindex`,`c`.`sourcechaptername` AS `sourcechaptername`,count(`p`.`idproblem`) AS `chapterproblemcount` from (`sourcechapter` `c` left join `problem` `p` on((`p`.`problemchapterid` = `c`.`idsourcechapter`))) group by `c`.`idsourcechapter`,`c`.`sourcechapterindex`,`c`.`sourcechaptername`,`c`.`sourceid` order by `c`.`sourcechapterindex` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-15 18:03:08
