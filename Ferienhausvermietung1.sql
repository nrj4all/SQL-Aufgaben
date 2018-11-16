-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: Ferienhausvermietung1
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.18.04.1

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
-- Table structure for table `Haus`
--

DROP TABLE IF EXISTS `Haus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Haus` (
  `FHaus` char(15) NOT NULL,
  `AnzZimmer` tinyint(3) unsigned DEFAULT NULL,
  `Fläche` int(11) DEFAULT NULL,
  `Preisschl` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`FHaus`),
  KEY `Preisschl` (`Preisschl`),
  CONSTRAINT `Haus_ibfk_1` FOREIGN KEY (`Preisschl`) REFERENCES `Preise` (`Preisschl`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Haus`
--

LOCK TABLES `Haus` WRITE;
/*!40000 ALTER TABLE `Haus` DISABLE KEYS */;
INSERT INTO `Haus` VALUES ('Amsel',2,43,6),('Buntspecht',3,49,6),('Lerche',4,75,2),('Nachtigall',4,75,2),('Pirol',3,67,5),('Rotkehlchen',3,50,3),('Sperling',2,35,1),('Stieglitz',2,35,4);
/*!40000 ALTER TABLE `Haus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mieter`
--

DROP TABLE IF EXISTS `Mieter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Mieter` (
  `MieterNr` int(11) NOT NULL,
  `Name` char(20) NOT NULL,
  `PLZ` char(5) NOT NULL,
  `Ort` char(15) NOT NULL,
  `Strasse` char(20) DEFAULT NULL,
  `Telefon` char(15) DEFAULT NULL,
  PRIMARY KEY (`MieterNr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mieter`
--

LOCK TABLES `Mieter` WRITE;
/*!40000 ALTER TABLE `Mieter` DISABLE KEYS */;
INSERT INTO `Mieter` VALUES (1,'Weber','10117','Berlin','Leipziger Straße 47','1234567'),(2,'Klausen','10315','Berlin','Am Tierpark 3','5123456'),(3,'Hansen','12134','Strausberg','Hauptstraße 1','1234'),(4,'Wiese','12130','Erkner','Hauptmannstr. 9','4567'),(5,'Klinger','04600','Wittenberg','Berliner Straße 24','535353'),(6,'Hase','18260','Kühlungsborn','Strandstraße 25','62650');
/*!40000 ALTER TABLE `Mieter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Preise`
--

DROP TABLE IF EXISTS `Preise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Preise` (
  `Preisschl` tinyint(3) unsigned NOT NULL,
  `Ort` char(20) NOT NULL,
  `Kategorie` char(10) NOT NULL,
  `Tagespreis` int(11) NOT NULL,
  `Wochenpreis` int(11) NOT NULL,
  PRIMARY KEY (`Preisschl`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Preise`
--

LOCK TABLES `Preise` WRITE;
/*!40000 ALTER TABLE `Preise` DISABLE KEYS */;
INSERT INTO `Preise` VALUES (1,'Hinterthal','Einfach',120,650),(2,'Hinterthal','Luxus',300,1800),(3,'Hinterthal','Standard',200,1100),(4,'Zell','Einfach',90,500),(5,'Zell','Luxus',200,1000),(6,'Zell','Standard',130,700);
/*!40000 ALTER TABLE `Preise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vermietung`
--

DROP TABLE IF EXISTS `Vermietung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vermietung` (
  `VNr` int(11) NOT NULL AUTO_INCREMENT,
  `MieterNr` int(11) NOT NULL,
  `FHaus` char(15) NOT NULL,
  `Mietbeginn` date NOT NULL,
  `Mietende` date NOT NULL,
  `Anzahlung` int(11) DEFAULT NULL,
  `Betrag` int(11) NOT NULL,
  `bezahlt` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`VNr`),
  KEY `FHaus` (`FHaus`),
  KEY `MieterNr` (`MieterNr`),
  CONSTRAINT `Vermietung_ibfk_1` FOREIGN KEY (`FHaus`) REFERENCES `Haus` (`FHaus`),
  CONSTRAINT `Vermietung_ibfk_2` FOREIGN KEY (`MieterNr`) REFERENCES `Mieter` (`MieterNr`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vermietung`
--

LOCK TABLES `Vermietung` WRITE;
/*!40000 ALTER TABLE `Vermietung` DISABLE KEYS */;
INSERT INTO `Vermietung` VALUES (1,1,'Buntspecht','2004-05-07','2025-05-07',210,2100,1),(2,1,'Amsel','2003-05-07','2024-05-07',210,2100,1),(3,1,'Rotkehlchen','2021-12-06','2004-01-07',220,2200,1),(4,2,'Pirol','2007-08-07','2015-08-07',100,1200,1),(5,2,'Sperling','2015-08-07','2022-08-07',100,650,1),(6,3,'Buntspecht','2013-06-07','2027-06-07',210,1400,1),(7,4,'Stieglitz','2006-06-07','2020-06-07',100,1000,1),(8,5,'Nachtigall','2021-12-06','2004-01-07',360,3600,1),(9,5,'Pirol','2024-07-07','2007-08-07',100,2000,1),(10,5,'Nachtigall','2026-12-07','2009-01-08',360,3600,0),(11,6,'Lerche','2019-12-06','2002-01-07',360,3600,0),(12,6,'Lerche','2003-07-07','2017-07-07',0,3600,0),(13,6,'Lerche','2010-07-08','2018-07-08',0,2100,0),(14,6,'Lerche','2025-07-08','2029-07-08',0,1200,0),(15,6,'Lerche','2010-08-08','2020-08-08',0,2700,0),(16,6,'Pirol','2022-08-08','2012-09-08',0,3600,0),(17,2,'Rotkehlchen','2025-06-07','2003-08-07',0,6300,0);
/*!40000 ALTER TABLE `Vermietung` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-12 12:32:17
