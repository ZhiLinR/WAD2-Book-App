-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: book_database
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
-- Table structure for table `user_pref`
--

DROP TABLE IF EXISTS `user_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_pref` (
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pref` char(50) DEFAULT NULL,
  `fantasy_data` json DEFAULT NULL,
  `mystery_data` json DEFAULT NULL,
  `romance_data` json DEFAULT NULL,
  `nonfiction_data` json DEFAULT NULL,
  `horror_data` json DEFAULT NULL,
  `fantasy_read` json DEFAULT NULL,
  `mystery_read` json DEFAULT NULL,
  `romance_read` json DEFAULT NULL,
  `nonfiction_read` json DEFAULT NULL,
  `horror_read` json DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_pref`
--

LOCK TABLES `user_pref` WRITE;
/*!40000 ALTER TABLE `user_pref` DISABLE KEYS */;
INSERT INTO `user_pref` VALUES ('jasper@email.com',NULL,'{\"head\": \"fantasy\", \"left\": {\"head\": \"Harry Potter and the Sorcerers Stone (Harry Potter, Book 1)\", \"left\": {\"head\": \"The Eye of the World\"}, \"right\": {\"head\": \"Own reco\"}}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"mystery\", \"left\": {\"head\": \"The Adventures of Sherlock Holmes\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"romance\", \"left\": {\"head\": \"The Fault in Our Stars\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"nonfiction\", \"left\": {\"head\": \"The Psychology of Stupidity\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"horror\", \"left\": {\"head\": \"The Escape Room\"}, \"right\": {\"head\": \"Own reco\"}}','[\"harry potter and the sorcerer\'s stone (harry potter, book 1)\"]','[]','[]','[]','[]'),('thuya@email.com','','{\"head\": \"fantasy\", \"left\": {\"head\": \"Harry Potter and the Sorcerers Stone (Harry Potter, Book 1)\"}, \"right\": {\"head\": \"A game of Thrones\", \"left\": {\"head\": \"The Lord of the Rings\"}, \"right\": {\"head\": \"Own reco\"}}}','{\"head\": \"mystery\", \"left\": {\"head\": \"The Adventures of Sherlock Holmes\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"romance\", \"left\": {\"head\": \"The Fault in Our Stars\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"nonfiction\", \"left\": {\"head\": \"The Psychology of Stupidity\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"horror\", \"left\": {\"head\": \"The Escape Room\", \"left\": {\"head\": \"IT\", \"left\": {\"head\": \"Dracula\"}, \"right\": {\"head\": \"Own reco\"}}, \"right\": {\"head\": \"Own reco\"}}, \"right\": {\"head\": \"Own reco\"}}','[\"A game of Thrones\"]','[]','[]','[]','[\"The Escape Room\", \"IT\"]');
/*!40000 ALTER TABLE `user_pref` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-03 16:08:57
