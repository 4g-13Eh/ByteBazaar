/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.5.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: bytebazaar_v2
-- ------------------------------------------------------
-- Server version	11.5.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `bytebazaar_v2`
--

/*!40000 DROP DATABASE IF EXISTS `bytebazaar_v2`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bytebazaar_v2` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;

USE `bytebazaar_v2`;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_item` (
  `Id` varchar(255) NOT NULL,
  `cartId` varchar(36) DEFAULT NULL,
  `itemId` varchar(36) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `cartId` (`cartId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`cartId`) REFERENCES `carts` (`Id`),
  CONSTRAINT `cart_item_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `items` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `Id` char(36) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
(1,'Audio'),
(2,'Büro'),
(3,'Drohnen'),
(4,'Foto'),
(5,'Video'),
(6,'Gaming'),
(7,'Netzwerk'),
(8,'Notebooks'),
(9,'TV'),
(10,'PC'),
(11,'Handys');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_category`
--

DROP TABLE IF EXISTS `item_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_category` (
  `itemId` char(36) NOT NULL,
  `categoryId` int(11) NOT NULL,
  PRIMARY KEY (`itemId`,`categoryId`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `item_category_ibfk_1` FOREIGN KEY (`itemId`) REFERENCES `items` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `item_category_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_category`
--

LOCK TABLES `item_category` WRITE;
/*!40000 ALTER TABLE `item_category` DISABLE KEYS */;
INSERT INTO `item_category` VALUES
('1a3979b2-6a22-4e8b-b432-ce9f8825ad82',1),
('9eee051a-7baa-4316-8286-5ef8ac45ef81',1),
('ba1159cd-52d3-4434-9910-6ace7543f619',1),
('792efb81-3d5f-4694-b286-3c9f95e7169e',2),
('92ba4aa0-f6bf-46a6-97a2-079710dc4b3c',3),
('dc5a16d0-8ab9-47ea-aa05-af35fa60aad4',3),
('4934cc28-2404-40f6-9679-3d06bbce03ae',4),
('92ba4aa0-f6bf-46a6-97a2-079710dc4b3c',4),
('dc5a16d0-8ab9-47ea-aa05-af35fa60aad4',4),
('4934cc28-2404-40f6-9679-3d06bbce03ae',5),
('92ba4aa0-f6bf-46a6-97a2-079710dc4b3c',5),
('dc5a16d0-8ab9-47ea-aa05-af35fa60aad4',5),
('18389a27-918e-451f-82ac-7b4aa30a50e5',6),
('1b94405f-0692-4633-a7b2-4ce0742ff278',6),
('6c2f7a0b-24c7-4d17-8dfb-a1f601dc68a0',6),
('ba1159cd-52d3-4434-9910-6ace7543f619',6),
('01fd8574-da95-4549-8c23-79212d909ca6',7),
('fbd78519-05c6-48a2-9dfe-cf56b1997aec',7),
('6c2f7a0b-24c7-4d17-8dfb-a1f601dc68a0',8),
('8151c70b-de46-46dd-acf6-6a3261399e9b',8),
('78157129-5b56-444d-b04b-53a618a28789',9),
('18389a27-918e-451f-82ac-7b4aa30a50e5',10),
('1b94405f-0692-4633-a7b2-4ce0742ff278',10),
('6c2f7a0b-24c7-4d17-8dfb-a1f601dc68a0',10),
('e6389018-c5ca-4769-83a3-03385b156d0f',11);
/*!40000 ALTER TABLE `item_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `Id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `picture` varchar(255) NOT NULL,
  `price` float DEFAULT NULL,
  `in_stock` tinyint(1) NOT NULL,
  `stock_num` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES
('01fd8574-da95-4549-8c23-79212d909ca6','Wi-Fi 6 Router','High-speed router with Wi-Fi 6 support for faster internet connectivity.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',130,1,56),
('18389a27-918e-451f-82ac-7b4aa30a50e5','Curved Gaming Monitor','34-inch curved monitor with 144Hz refresh rate and 1ms response time.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',500,0,0),
('1a3979b2-6a22-4e8b-b432-ce9f8825ad82','Noise-Cancelling Earbuds','Compact wireless earbuds with active noise-cancelling technology.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',150,0,0),
('1b94405f-0692-4633-a7b2-4ce0742ff278','Mechanical Gaming Keyboard','RGB backlit mechanical keyboard with customizable keys.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',100,1,82),
('4934cc28-2404-40f6-9679-3d06bbce03ae','Professional DSLR Camera','Full-frame DSLR camera with 24MP sensor and 4K video recording.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',2000,0,0),
('6c2f7a0b-24c7-4d17-8dfb-a1f601dc68a0','Gaming Laptop','High-performance laptop with NVIDIA graphics and Intel i7 processor.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',1300,1,16),
('78157129-5b56-444d-b04b-53a618a28789','4K Ultra HD TV','55-inch Smart TV with 4K resolution and HDR support.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',700,0,0),
('792efb81-3d5f-4694-b286-3c9f95e7169e','Ergonomic Office Chair','Comfortable office chair with lumbar support and adjustable height.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',150,1,45),
('8151c70b-de46-46dd-acf6-6a3261399e9b','2-in-1 Laptop/Tablet','Convertible laptop with touch screen and detachable keyboard.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',900,1,40),
('92ba4aa0-f6bf-46a6-97a2-079710dc4b3c','Drone with 4K Camera','Advanced drone with 4K camera and GPS for precise flying.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',500,1,35),
('9eee051a-7baa-4316-8286-5ef8ac45ef81','Portable Bluetooth Speaker','Waterproof portable speaker with deep bass and long battery life.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',60,1,200),
('ba1159cd-52d3-4434-9910-6ace7543f619','Wireless Bluetooth Headphones','High-quality over-ear Bluetooth headphones with noise-cancellation.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',200,1,150),
('dc5a16d0-8ab9-47ea-aa05-af35fa60aad4','4K Action Camera','Waterproof action camera with 4K resolution and wide-angle lens.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',250,0,0),
('e6389018-c5ca-4769-83a3-03385b156d0f','Smartphone with 5G','Latest generation smartphone with 5G connectivity and OLED display.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',800,1,75),
('fbd78519-05c6-48a2-9dfe-cf56b1997aec','Smart Home Security Camera','Wireless security camera with motion detection and night vision.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzBCowy5A4eNzFEhgMS-Rd0897WC3Pq7JSNw&s',90,1,130);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `is_expired` tinyint(1) DEFAULT NULL,
  `is_revoked` tinyint(1) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `token_type` char(40) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `unique_token` (`token`),
  KEY `FKqwinwa8ldeiwgfkby67e9uu07` (`userId`),
  CONSTRAINT `FKqwinwa8ldeiwgfkby67e9uu07` FOREIGN KEY (`userId`) REFERENCES `users` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1272 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `Id` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `cartId` char(36) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `cartId` (`cartId`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`cartId`) REFERENCES `carts` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-10-15 10:57:01
