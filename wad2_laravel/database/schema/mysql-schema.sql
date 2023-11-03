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

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fantasy_data`
--

DROP TABLE IF EXISTS `fantasy_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fantasy_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fantasy_data`
--

LOCK TABLES `fantasy_data` WRITE;
/*!40000 ALTER TABLE `fantasy_data` DISABLE KEYS */;
INSERT INTO `fantasy_data` VALUES (1,'{\"head\": \"Fantasy\", \"left\": {\"head\": \"Harry Potter and the Sorcerers Stone (Harry Potter, Book 1)\"}, \"right\": {\"head\": \"A game of Thrones\", \"left\": {\"head\": \"The Lord of the Rings\"}, \"right\": {\"head\": \"Own reco\"}}}');
/*!40000 ALTER TABLE `fantasy_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horror_data`
--

DROP TABLE IF EXISTS `horror_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horror_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horror_data`
--

LOCK TABLES `horror_data` WRITE;
/*!40000 ALTER TABLE `horror_data` DISABLE KEYS */;
INSERT INTO `horror_data` VALUES (1,'{\"head\": \"Horror\", \"left\": {\"head\": \"Escape Room\", \"left\": {\"head\": \"IT\", \"left\": {\"head\": \"Dracula\"}, \"right\": {\"head\": \"Own reco\"}}, \"right\": {\"head\": \"Own reco\"}}, \"right\": {\"head\": \"Own reco\"}}');
/*!40000 ALTER TABLE `horror_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mystery_data`
--

DROP TABLE IF EXISTS `mystery_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mystery_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mystery_data`
--

LOCK TABLES `mystery_data` WRITE;
/*!40000 ALTER TABLE `mystery_data` DISABLE KEYS */;
INSERT INTO `mystery_data` VALUES (1,'{\"head\": \"Mystery\", \"left\": {\"head\": \"Sherlock Holmes\"}, \"right\": {\"head\": \"Own Reco\"}}');
/*!40000 ALTER TABLE `mystery_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nonfiction_data`
--

DROP TABLE IF EXISTS `nonfiction_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nonfiction_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nonfiction_data`
--

LOCK TABLES `nonfiction_data` WRITE;
/*!40000 ALTER TABLE `nonfiction_data` DISABLE KEYS */;
INSERT INTO `nonfiction_data` VALUES (1,'{\"head\": \"Nonfiction\", \"left\": {\"head\": \"The Psychology of Stupid\"}, \"right\": {\"head\": \"Own Reco\"}}');
/*!40000 ALTER TABLE `nonfiction_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation`
--

DROP TABLE IF EXISTS `recommendation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendation` (
  `username` char(18) NOT NULL,
  `read_book_name` char(50) NOT NULL,
  `read_author` char(50) NOT NULL,
  `new_book_name` char(50) NOT NULL,
  `new_author` char(50) NOT NULL,
  PRIMARY KEY (`username`,`read_book_name`,`read_author`,`new_book_name`,`new_author`),
  KEY `recommendation_fk2` (`read_book_name`,`read_author`),
  KEY `recommendation_fk3` (`new_book_name`,`new_author`),
  CONSTRAINT `recommendation_fk1` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  CONSTRAINT `recommendation_fk2` FOREIGN KEY (`read_book_name`, `read_author`) REFERENCES `book` (`book_name`, `author`),
  CONSTRAINT `recommendation_fk3` FOREIGN KEY (`new_book_name`, `new_author`) REFERENCES `book` (`book_name`, `author`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation`
--

LOCK TABLES `recommendation` WRITE;
/*!40000 ALTER TABLE `recommendation` DISABLE KEYS */;
/*!40000 ALTER TABLE `recommendation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `romance_data`
--

DROP TABLE IF EXISTS `romance_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `romance_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `romance_data`
--

LOCK TABLES `romance_data` WRITE;
/*!40000 ALTER TABLE `romance_data` DISABLE KEYS */;
INSERT INTO `romance_data` VALUES (1,'{\"head\": \"Romance\", \"left\": {\"head\": \"The fault in the stars\"}, \"right\": {\"head\": \"Own Reco\"}}');
/*!40000 ALTER TABLE `romance_data` ENABLE KEYS */;
UNLOCK TABLES;

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
  KEY `User_pref_fk1_idx` (`username`),
  CONSTRAINT `User_pref_fk1` FOREIGN KEY (`username`) REFERENCES `users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_pref`
--

LOCK TABLES `user_pref` WRITE;
/*!40000 ALTER TABLE `user_pref` DISABLE KEYS */;
INSERT INTO `user_pref` VALUES ('henry@email.com',NULL,'{\"head\": \"fantasy\", \"left\": {\"head\": \"Harry Potter and the Sorcerers Stone (Harry Potter, Book 1)\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"mystery\", \"left\": {\"head\": \"The Adventures of Sherlock Holmes\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"romance\", \"left\": {\"head\": \"The Fault in Our Stars\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"nonfiction\", \"left\": {\"head\": \"The Psychology of Stupidity\"}, \"right\": {\"head\": \"great victory for chairman mao\'s revolutionary line\", \"left\": {\"head\": \"world war ii at sea\", \"left\": {\"head\": \"Factfulness\"}, \"right\": {\"head\": \"Own reco\"}}, \"right\": {\"head\": \"Own reco\"}}}','{\"head\": \"horror\", \"left\": {\"head\": \"The Escape Room\"}, \"right\": {\"head\": \"Own reco\"}}','[]','[]','[]','[\"great victory for chairman mao\'s revolutionary line\", \"world war ii at sea\"]','[]'),('jasper@email.com',NULL,'{\"head\": \"fantasy\", \"left\": {\"head\": \"Harry Potter and the Sorcerers Stone (Harry Potter, Book 1)\", \"left\": {\"head\": \"Bridge to Terabithia\"}, \"right\": {\"head\": \"Own reco\"}}, \"right\": {\"head\": \"the unifying force: star wars legends\", \"left\": {\"head\": \"lord of chaos\"}, \"right\": {\"head\": \"Own reco\"}}}','{\"head\": \"mystery\", \"left\": {\"head\": \"The Adventures of Sherlock Holmes\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"romance\", \"left\": {\"head\": \"The Fault in Our Stars\"}, \"right\": {\"head\": \"romeo and juliet\", \"left\": {\"head\": \"seduce me at sunrise\", \"left\": {\"head\": \"Captivated\"}, \"right\": {\"head\": \"Own reco\"}}, \"right\": {\"head\": \"Own reco\"}}}','{\"head\": \"nonfiction\", \"left\": {\"head\": \"The Psychology of Stupidity\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"horror\", \"left\": {\"head\": \"The Escape Room\"}, \"right\": {\"head\": \"Own reco\"}}','[\"harry potter and the sorcerer\'s stone (harry potter, book 1)\", \"the unifying force: star wars legends\", \"the unifying force: star wars legends\"]','[]','[\"romeo and juliet\"]','[]','[]'),('thuya@email.com',NULL,'{\"head\": \"fantasy\", \"left\": {\"head\": \"Harry Potter and the Sorcerers Stone (Harry Potter, Book 1)\"}, \"right\": {\"head\": \"the super cup face-off (geronimo stilton #81)\", \"left\": {\"head\": \"the amazing voyage\"}, \"right\": {\"head\": \"Own reco\"}}}','{\"head\": \"mystery\", \"left\": {\"head\": \"The Adventures of Sherlock Holmes\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"romance\", \"left\": {\"head\": \"The Fault in Our Stars\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"nonfiction\", \"left\": {\"head\": \"The Psychology of Stupidity\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"horror\", \"left\": {\"head\": \"The Escape Room\", \"left\": {\"head\": \"The Long Walk\"}, \"right\": {\"head\": \"Own reco\"}}, \"right\": {\"head\": \"Own reco\"}}','[\"the super cup face-off (geronimo stilton #81)\"]','[]','[]','[]','[\"the escape room\"]'),('zhiling@email.com',NULL,'{\"head\": \"fantasy\", \"left\": {\"head\": \"Harry Potter and the Sorcerers Stone (Harry Potter, Book 1)\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"mystery\", \"left\": {\"head\": \"The Adventures of Sherlock Holmes\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"romance\", \"left\": {\"head\": \"The Fault in Our Stars\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"nonfiction\", \"left\": {\"head\": \"The Psychology of Stupidity\"}, \"right\": {\"head\": \"Own reco\"}}','{\"head\": \"horror\", \"left\": {\"head\": \"The Escape Room\"}, \"right\": {\"head\": \"Own reco\"}}','[]','[]','[]','[]','[]');
/*!40000 ALTER TABLE `user_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jasper','jasper@email.com',NULL,'$2y$10$afVWlG7E/PjGrTyn4agJGeEUemTSKxCHeQlWU.1nE12d3lJHZiXu2',NULL,NULL,NULL),(2,'henry','henry@email.com',NULL,'$2y$10$g6TNCYvCxYQiWo4iOJENc.unFyLHUxLCZe6SJNGXikw36n0HzULZm',NULL,NULL,NULL),(3,'thuya','thuya@email.com',NULL,'$2y$10$KsemHs74tFhiNpyJgB3FneQJB1Y2ZNWLQ3u5ME.HvpVwXyNL/5Gxq',NULL,NULL,NULL),(6,'zhiling','zhiling@email.com',NULL,'$2y$10$8BG7.i2usi0LTUkbOepuiuuSK2RYoleSIKodT3Q.m1cHji/dvze6q',NULL,'2023-11-03 06:30:57','2023-11-03 06:30:57');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_users_insert` AFTER INSERT ON `users` FOR EACH ROW begin 
insert into user_pref(username,fantasy_data,mystery_data,romance_data,nonfiction_data,horror_data,fantasy_read,mystery_read,romance_read,nonfiction_read,horror_read)
values (NEW.email,'{"head":"fantasy","left":{"head":"Harry Potter and the Sorcerers Stone (Harry Potter, Book 1)"},"right":{"head":"Own reco"}}',
'{"head":"mystery","left":{"head":"The Adventures of Sherlock Holmes"},"right":{"head":"Own reco"}}',
'{"head":"romance","left":{"head":"The Fault in Our Stars"},"right":{"head":"Own reco"}}',
'{"head":"nonfiction","left":{"head":"The Psychology of Stupidity"},"right":{"head":"Own reco"}}',
'{"head":"horror","left":{"head":"The Escape Room"},"right":{"head":"Own reco"}}','[]','[]','[]','[]','[]');
end */;;
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

-- Dump completed on 2023-11-03 23:48:10
