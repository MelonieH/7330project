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
-- Table structure for table `build`
--

DROP TABLE IF EXISTS `build`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build` (
  `PNAME` varchar(30) NOT NULL,
  `PVERSION` varchar(20) NOT NULL,
  `CID` int(11) NOT NULL,
  `CSTATUS` enum('Ready','Not-ready','Usable') NOT NULL DEFAULT 'Not-ready',
  PRIMARY KEY (`PNAME`,`PVERSION`,`CID`),
  KEY `CID` (`CID`),
  CONSTRAINT `build_ibfk_1` FOREIGN KEY (`PNAME`, `PVERSION`) REFERENCES `products` (`PNAME`, `PVERSION`),
  CONSTRAINT `build_ibfk_2` FOREIGN KEY (`CID`) REFERENCES `components` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build`
--

LOCK TABLES `build` WRITE;
/*!40000 ALTER TABLE `build` DISABLE KEYS */;
INSERT INTO `build` VALUES ('Excel','2010',1,'Ready'),('Excel','2010',3,'Not-ready'),('Excel','2015',1,'Ready'),('Excel','2015',4,'Ready'),('Excel','2015',6,'Not-ready'),('Excel','2018beta',1,'Ready'),('Excel','2018beta',2,'Ready'),('Excel','2018beta',5,'Ready'),('Excel','2018beta',9,'Usable'),('Excel','secret',1,'Ready'),('Excel','secret',2,'Ready'),('Excel','secret',5,'Ready'),('Excel','secret',8,'Ready');
/*!40000 ALTER TABLE `build` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AUPD_BUILD AFTER UPDATE ON BUILD FOR EACH ROW
BEGIN
	DECLARE ONENAME VARCHAR(30) DEFAULT '';
    DECLARE ONEVERSION VARCHAR(20) DEFAULT '';
    DECLARE `MIN` INT DEFAULT 0;
    DECLARE DONE BOOL DEFAULT FALSE;
	DECLARE CUR CURSOR FOR (SELECT BUILD.PNAME,BUILD.PVERSION FROM PROJECT.BUILD WHERE BUILD.CID=NEW.CID);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE=TRUE;
    OPEN CUR;
    REPEAT
		FETCH CUR INTO ONENAME,ONEVERSION;
        IF NOT DONE THEN
			SET `MIN`=(SELECT MAX(CHAR_LENGTH(CSTATUS)) FROM BUILD WHERE BUILD.PNAME=ONENAME AND BUILD.PVERSION=ONEVERSION);
            IF `MIN`=9 THEN
				UPDATE PRODUCTS SET PSTATUS='Not-ready' WHERE PNAME=ONENAME AND PVERSION=ONEVERSION;
			ELSEIF `MIN`=6 THEN
				UPDATE PRODUCTS SET PSTATUS='Usable' WHERE PNAME=ONENAME AND PVERSION=ONEVERSION;
			ELSE
				UPDATE PRODUCTS SET PSTATUS='Ready' WHERE PNAME=ONENAME AND PVERSION=ONEVERSION;
			END IF;
		END IF;
	UNTIL DONE END REPEAT;
    CLOSE CUR;
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
