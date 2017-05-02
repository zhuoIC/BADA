-- MySQL dump 10.15  Distrib 10.0.28-MariaDB, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	10.0.28-MariaDB-1~trusty

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
-- Table structure for table `habitante`
--

DROP TABLE IF EXISTS `habitante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `habitante` (
  `id` char(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fnac` date NOT NULL,
  `dondeVive` varchar(20) NOT NULL,
  `cf` char(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dondeVive` (`dondeVive`),
  KEY `cf` (`cf`),
  CONSTRAINT `habitante_ibfk_1` FOREIGN KEY (`dondeVive`) REFERENCES `vivienda` (`nrc`) ON UPDATE CASCADE,
  CONSTRAINT `habitante_ibfk_2` FOREIGN KEY (`cf`) REFERENCES `habitante` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habitante`
--

LOCK TABLES `habitante` WRITE;
/*!40000 ALTER TABLE `habitante` DISABLE KEYS */;
INSERT INTO `habitante` VALUES ('01','HAB01','1916-12-22','002','01'),('02','HAB02','1917-02-15','002','01'),('03','HAB03','1916-01-21','002','01'),('04','HAB04','1916-10-07','001','04'),('05','HAB05','1916-10-07','003','05');
/*!40000 ALTER TABLE `habitante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipio`
--

DROP TABLE IF EXISTS `municipio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `municipio` (
  `cp` char(5) NOT NULL DEFAULT '',
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`cp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipio`
--

LOCK TABLES `municipio` WRITE;
/*!40000 ALTER TABLE `municipio` DISABLE KEYS */;
INSERT INTO `municipio` VALUES ('29016','Málaga - El Limonar'),('29017','Málaga - Cruz Humilladero'),('29018','Málaga - Teatinos');
/*!40000 ALTER TABLE `municipio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propiedad`
--

DROP TABLE IF EXISTS `propiedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `propiedad` (
  `propietario` char(10) NOT NULL,
  `vivienda` varchar(20) NOT NULL,
  PRIMARY KEY (`propietario`,`vivienda`),
  KEY `vivienda` (`vivienda`),
  CONSTRAINT `propiedad_ibfk_2` FOREIGN KEY (`vivienda`) REFERENCES `vivienda` (`nrc`) ON UPDATE CASCADE,
  CONSTRAINT `propiedad_ibfk_3` FOREIGN KEY (`propietario`) REFERENCES `habitante` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propiedad`
--

LOCK TABLES `propiedad` WRITE;
/*!40000 ALTER TABLE `propiedad` DISABLE KEYS */;
INSERT INTO `propiedad` VALUES ('01','002'),('02','003'),('04','001'),('05','001');
/*!40000 ALTER TABLE `propiedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vivienda`
--

DROP TABLE IF EXISTS `vivienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vivienda` (
  `nrc` char(20) NOT NULL DEFAULT '',
  `direccion` varchar(50) NOT NULL,
  `municipio` char(5) NOT NULL,
  PRIMARY KEY (`nrc`),
  KEY `municipio` (`municipio`),
  CONSTRAINT `vivienda_ibfk_1` FOREIGN KEY (`municipio`) REFERENCES `municipio` (`cp`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vivienda`
--

LOCK TABLES `vivienda` WRITE;
/*!40000 ALTER TABLE `vivienda` DISABLE KEYS */;
INSERT INTO `vivienda` VALUES ('001','Direccion vivienda 001','29016'),('002','Direccion vivienda 002','29017'),('003','Direccion vivienda 003','29018');
/*!40000 ALTER TABLE `vivienda` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-13 13:41:12
