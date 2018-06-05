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
-- Table structure for table `inspect`
--

DROP TABLE IF EXISTS `inspect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inspect` (
  `IID` int(11) NOT NULL,
  `INSPECTOR` int(5) NOT NULL,
  `CID` int(11) NOT NULL,
  `IDATE` date NOT NULL,
  `SCORE` int(3) NOT NULL,
  `TXTDESCRI` text,
  PRIMARY KEY (`IID`),
  KEY `inspect_ibfk_1` (`INSPECTOR`),
  KEY `inspect_ibfk_2` (`CID`),
  CONSTRAINT `inspect_ibfk_1` FOREIGN KEY (`INSPECTOR`) REFERENCES `employees` (`EID`),
  CONSTRAINT `inspect_ibfk_2` FOREIGN KEY (`CID`) REFERENCES `components` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inspect`
--

LOCK TABLES `inspect` WRITE;
/*!40000 ALTER TABLE `inspect` DISABLE KEYS */;
INSERT INTO `inspect` VALUES (1,10100,1,'2010-02-14',100,'legacy code which is already approved'),(2,10200,2,'2017-06-01',95,'initial release ready for usage'),(3,10100,3,'2010-02-22',55,'too many hard coded parameters, the software must be more maintainable and configurable because we want to use this in other products.'),(4,10100,3,'2010-02-24',78,'improved, but only handles DB2 format'),(5,10100,3,'2010-02-26',95,'Okay, handles DB3 format.'),(6,10100,3,'2010-02-28',100,'satisifed'),(7,10200,4,'2011-05-01',100,'Okay ready for use'),(8,10300,6,'2017-07-15',80,'Okay ready for beta testing'),(9,10100,7,'2014-06-10',90,'almost ready'),(10,10100,8,'2014-06-15',70,'Accuracy problems!'),(11,10100,8,'2014-06-30',100,'Okay problems fixed'),(12,10400,8,'2016-11-02',100,'lre-review for new employee to gain experience in the process.'),(13,10100,3,'2010-03-20',80,'satisifed'),(14,10100,1,'2010-03-20',80,'satisifed'),(15,10400,6,'2017-08-15',60,'needs rework, introduced new errors'),(16,10200,9,'2017-11-20',80,'minor fixes needed'),(17,10500,9,'2017-11-20',80,'minor fixes needed'),(18,10100,5,'2017-12-01',95,'ok'),(19,10100,3,'2017-12-02',55,'bad');
/*!40000 ALTER TABLE `inspect` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER BINS_INSPECT BEFORE INSERT ON INSPECT FOR EACH ROW
BEGIN
	DECLARE WDATE DATE;
    SET WDATE=(SELECT EMPLOYEES.HDATE FROM EMPLOYEES WHERE NEW.INSPECTOR=EMPLOYEES.EID);
	IF NEW.SCORE>100 OR NEW.SCORE<0 THEN
        SIGNAL SQLSTATE'45000'
		SET MESSAGE_TEXT="Improper SCORE value";
	END IF;
    
    IF DATEDIFF(NEW.IDATE,WDATE)<=0 THEN
		SIGNAL SQLSTATE'45000'
		SET MESSAGE_TEXT="Improper INSPECT DATE value";
	END IF;
    
    IF CHAR_LENGTH(NEW.TXTDESCRI)>4000 THEN
		SIGNAL SQLSTATE'45000'
		SET MESSAGE_TEXT="Improper TEXTURAL DESCRIPTION value";
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AINS_INSPECT AFTER INSERT ON INSPECT FOR EACH ROW
BEGIN
	DECLARE NDATE DATE;
	SET NDATE=(SELECT * FROM(SELECT INSPECT.IDATE FROM INSPECT WHERE INSPECT.CID=NEW.CID ORDER BY INSPECT.IDATE DESC LIMIT 1)AS T);
    IF TIMESTAMPDIFF(DAY,NDATE,NEW.IDATE)>=0 THEN
		IF NEW.SCORE>90 THEN
			UPDATE COMPONENTS
			SET COMPONENTS.CSTATUS='Ready' WHERE COMPONENTS.CID=NEW.CID;
		ELSEIF NEW.SCORE<75 THEN
			UPDATE COMPONENTS
			SET COMPONENTS.CSTATUS='Not-ready' WHERE COMPONENTS.CID=NEW.CID;
		ELSE
			UPDATE COMPONENTS
			SET COMPONENTS.CSTATUS='Usable' WHERE COMPONENTS.CID=NEW.CID;
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AUPD_INSPECT AFTER UPDATE ON INSPECT FOR EACH ROW
BEGIN
	IF (SELECT INSPECT.SCORE FROM INSPECT WHERE INSPECT.IID=OLD.IID)!=OLD.SCORE THEN
		SIGNAL SQLSTATE'45000'
		SET MESSAGE_TEXT="Can NOT UPDATE SCORE";
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ADEL_INSPECT AFTER DELETE ON INSPECT FOR EACH ROW
BEGIN
	UPDATE INSPECT SET INSPECT.IID=IID-1 WHERE INSPECT.IID>OLD.IID;
END */;;
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
