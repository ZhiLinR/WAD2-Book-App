CREATE DATABASE  IF NOT EXISTS `wad2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `wad2`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: wad2
-- ------------------------------------------------------
-- Server version	8.0.27

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
  `donation_id` int NOT NULL AUTO_INCREMENT,
  `fk_user_donor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bk_name` varchar(255) NOT NULL,
  `gcc_bk_id` varchar(255) DEFAULT NULL,
  `category` text,
  `author` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL DEFAULT '7RXX+2Q Singapore',
  `description` text,
  `fk_user_receiver` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pickup_time` time DEFAULT NULL,
  `directory_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`donation_id`,`fk_user_donor`,`bk_name`,`author`),
  KEY `fk_user_donor` (`fk_user_donor`),
  KEY `fk_user_receiver` (`fk_user_receiver`),
  CONSTRAINT `book_donations_ibfk_1` FOREIGN KEY (`fk_user_donor`) REFERENCES `users` (`email`),
  CONSTRAINT `book_donations_ibfk_2` FOREIGN KEY (`fk_user_receiver`) REFERENCES `users` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_donations`
--

LOCK TABLES `book_donations` WRITE;
/*!40000 ALTER TABLE `book_donations` DISABLE KEYS */;
INSERT INTO `book_donations` VALUES (1,'jasper@email.com','Lord of the Rings',NULL,'Fantasy','J. R. R. Tolkien.','8VGQ+MX Singapore','Giving away an old Lord of the Rings book. Condition 8/10',NULL,NULL,NULL),(2,'henry@email.com','Influence: The Psychology of Persuasion',NULL,'Business','Robert Cialdini','7VWV+WR Singapore','Don\'t need it anymore. ',NULL,NULL,NULL),(3,'thuya@email.com','Impro: Improvisation and the Theatre',NULL,'Art and Creativity','Keith Johnstone','8W24+G3 Singapore','Great book! Condition 7/10, read a few times but clearing up space in my house',NULL,NULL,NULL),(13,'thuya@email.com','Bizness',NULL,NULL,'Keith Johnstone','7RXX+2Q Singapore',NULL,NULL,NULL,NULL),(14,'thuya@email.com','Harry Potter:  Test',NULL,NULL,'Robert Cialdini','7RXX+2Q Singapore',NULL,NULL,NULL,NULL),(15,'thuya@email.com','Test',NULL,NULL,'Robert Cialdini','7RXX+2Q Singapore','200',NULL,NULL,NULL),(16,'thuya@email.com','Test',NULL,NULL,'Robert Cialdini','7RXX+2Q Singapore','200',NULL,NULL,NULL);
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
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
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
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2014_10_12_100000_create_password_reset_tokens_table',2),(6,'2023_10_17_164501_wad2_laravel',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
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
-- Table structure for table `reading_history`
--

DROP TABLE IF EXISTS `reading_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reading_history` (
  `fk_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gcc_bk_id` varchar(255) NOT NULL,
  `status` enum('saved','reading','completed') DEFAULT 'saved',
  `page_num` int DEFAULT '0',
  `last_read_date` date DEFAULT NULL,
  PRIMARY KEY (`fk_user`,`gcc_bk_id`),
  CONSTRAINT `reading_history_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reading_history`
--

LOCK TABLES `reading_history` WRITE;
/*!40000 ALTER TABLE `reading_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `reading_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_pref`
--

DROP TABLE IF EXISTS `user_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_pref` (
  `pref_id` int NOT NULL AUTO_INCREMENT,
  `fk_user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pref` text NOT NULL,
  PRIMARY KEY (`pref_id`),
  KEY `fk_user_id` (`fk_user_id`),
  CONSTRAINT `user_pref_ibfk_1` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_pref`
--

LOCK TABLES `user_pref` WRITE;
/*!40000 ALTER TABLE `user_pref` DISABLE KEYS */;
INSERT INTO `user_pref` VALUES (1,'jasper@email.com','Fantasy'),(2,'jasper@email.com','Business'),(3,'thuya@email.com','Fantasy'),(4,'thuya@email.com','Art'),(5,'henry@email.com','Technology'),(6,'henry@email.com','Fiction');
/*!40000 ALTER TABLE `user_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_saved_books`
--

DROP TABLE IF EXISTS `user_saved_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_saved_books` (
  `pref_id` int NOT NULL AUTO_INCREMENT,
  `gcc_bk_id` varchar(255) DEFAULT NULL,
  `local_bk_id` int DEFAULT NULL,
  `fk_user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`pref_id`),
  KEY `local_bk_id` (`local_bk_id`),
  KEY `fk_user_id` (`fk_user_id`),
  CONSTRAINT `user_saved_books_ibfk_1` FOREIGN KEY (`local_bk_id`) REFERENCES `book_donations` (`donation_id`),
  CONSTRAINT `user_saved_books_ibfk_2` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_saved_books`
--

LOCK TABLES `user_saved_books` WRITE;
/*!40000 ALTER TABLE `user_saved_books` DISABLE KEYS */;
INSERT INTO `user_saved_books` VALUES (1,NULL,2,'jasper@email.com'),(2,NULL,2,'henry@email.com'),(3,NULL,1,'thuya@email.com'),(4,NULL,3,'jasper@email.com');
/*!40000 ALTER TABLE `user_saved_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jasper','jasper@email.com',NULL,'$2y$10$UBPlCKv3MTrSIXc2Gkrqaewlqn/nmLQE/csK40jJaC9iK9sy/VtzK',NULL,NULL,NULL),(2,'henry','henry@email.com',NULL,'$2y$10$3ZCgCkUJJ06SUkTau.PeWu6/XdaZoCEwjFfO.qRmZLPS7DskMhzJC',NULL,NULL,NULL),(3,'thuya','thuya@email.com',NULL,'$2y$10$EHYls3LDy61bmOHwWF2Mp.191Wl2K4cidZ.TBRhIvPij.tK33hObG','kKl6l2Q1T5alXUQAfXKR3x0BcNG9fQJdF2tGJOeCsh6k0rd2C5OrvCHuR2CG',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-27 22:05:28
