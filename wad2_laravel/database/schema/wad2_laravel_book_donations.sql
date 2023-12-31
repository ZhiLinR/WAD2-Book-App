
USE `wad2`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: wad2_laravel
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `book_donations`
--

DROP TABLE IF EXISTS `book_donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_donations` (
  `drive_id` varchar(255) NOT NULL,
  `location` text NOT NULL,
  PRIMARY KEY (`drive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_donations`
--

LOCK TABLES `book_donations` WRITE;
/*!40000 ALTER TABLE `book_donations` DISABLE KEYS */;
INSERT INTO `book_donations` VALUES ('Drive','{\"location\": { \"lat\": 1.3065396327671674, \"lng\": 103.85271589509796 },\"img\": \"/bookDrive/everNewBook.jpg\" , \"name\":\"Evernew Book Store\" , \"address\":\"19 Upper Dickson Rd, Singapore 207478\"}'),('Drive2','{\"location\": { \"lat\": 1.4101765417872338, \"lng\": 103.90165654237263 },\"img\": \"/bookDrive/timesWaterWay.jpeg\" , \"name\":\"Times Waterway Point\" , \"address\":\"BLOCK 313A Sumang Link, Singapore 821313\"} '),('Drive3','{\"location\": { \"lat\": 1.348962233921741, \"lng\": 103.84915239993461 },\"img\": \"/bookDrive/booksmen.jpeg\", \"name\":\"BooksMen\" , \"address\":\"HDB Bishan #01-410, 505D Bishan Street 11 (S)574505, Singapore 574505\"}');
/*!40000 ALTER TABLE `book_donations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-03 22:14:13
