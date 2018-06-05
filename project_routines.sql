CREATE DATABASE  IF NOT EXISTS `project` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `project`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Temporary view structure for view `s`
--

DROP TABLE IF EXISTS `s`;
/*!50001 DROP VIEW IF EXISTS `s`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `s` AS SELECT 
 1 AS `COST`,
 1 AS `SENIORITY`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `count_c`
--

DROP TABLE IF EXISTS `count_c`;
/*!50001 DROP VIEW IF EXISTS `count_c`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `count_c` AS SELECT 
 1 AS `C`,
 1 AS `OWNER`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `seniority`
--

DROP TABLE IF EXISTS `seniority`;
/*!50001 DROP VIEW IF EXISTS `seniority`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `seniority` AS SELECT 
 1 AS `EID`,
 1 AS `SENIORITY`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `resp_c`
--

DROP TABLE IF EXISTS `resp_c`;
/*!50001 DROP VIEW IF EXISTS `resp_c`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `resp_c` AS SELECT 
 1 AS `INSPECTOR`,
 1 AS `INSP_C`,
 1 AS `AVG_S`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `owner_c`
--

DROP TABLE IF EXISTS `owner_c`;
/*!50001 DROP VIEW IF EXISTS `owner_c`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `owner_c` AS SELECT 
 1 AS `OWNER`,
 1 AS `COMP_C`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `s`
--

/*!50001 DROP VIEW IF EXISTS `s`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `s` AS select `project`.`GETCOST`(`inspect`.`SCORE`) AS `COST`,`project`.`GETSENIORITY`(`employees`.`HDATE`) AS `SENIORITY` from (`inspect` left join `employees` on((`inspect`.`INSPECTOR` = `employees`.`EID`))) where (year(`inspect`.`IDATE`) = 2010) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `count_c`
--

/*!50001 DROP VIEW IF EXISTS `count_c`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `count_c` AS select count(`components`.`CID`) AS `C`,`components`.`OWNER` AS `OWNER` from `components` group by `components`.`OWNER` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `seniority`
--

/*!50001 DROP VIEW IF EXISTS `seniority`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `seniority` AS select `employees`.`EID` AS `EID`,`project`.`GETSENIORITY`(`employees`.`HDATE`) AS `SENIORITY` from `employees` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `resp_c`
--

/*!50001 DROP VIEW IF EXISTS `resp_c`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `resp_c` AS select `inspect`.`INSPECTOR` AS `INSPECTOR`,count(`inspect`.`CID`) AS `INSP_C`,avg(`inspect`.`SCORE`) AS `AVG_S` from `inspect` group by `inspect`.`INSPECTOR` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `owner_c`
--

/*!50001 DROP VIEW IF EXISTS `owner_c`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `owner_c` AS select `components`.`OWNER` AS `OWNER`,count(`components`.`CID`) AS `COMP_C` from `components` group by `components`.`OWNER` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'project'
--

--
-- Dumping routines for database 'project'
--
/*!50003 DROP FUNCTION IF EXISTS `GETCOST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GETCOST`(SCORE INT) RETURNS int(11)
    NO SQL
    DETERMINISTIC
BEGIN
	DECLARE X INT;
    DECLARE COST INT DEFAULT 0;
    SET X=SCORE;
	IF X<90 THEN
		SET COST=200;
	ELSE
		SET COST=100;
	END IF;
    RETURN COST;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GETSENIORITY` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GETSENIORITY`(HDATE DATE) RETURNS varchar(10) CHARSET utf8
    NO SQL
    DETERMINISTIC
BEGIN
	DECLARE X INT;
    DECLARE SENIORITY VARCHAR(10) DEFAULT 'newbie';
    SET X=(DATEDIFF(CURDATE(),HDATE)/365);
	IF X<1 THEN
		SET SENIORITY='newbie';
    ELSEIF X<5 THEN
		SET SENIORITY='junior';
	ELSE
		SET SENIORITY='senior';
	END IF;
    RETURN SENIORITY;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-05 10:16:52
