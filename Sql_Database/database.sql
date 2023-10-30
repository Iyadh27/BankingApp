-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: banking_system
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `customer_id` varchar(20) NOT NULL,
  `savings_exist` tinyint DEFAULT NULL,
  `current_exist` tinyint DEFAULT NULL,
  `FD_exist` tinyint DEFAULT NULL,
  `loan_exist` tinyint DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('CUS1',1,0,1,1),('CUS10',1,0,0,1),('CUS2',1,0,1,0),('CUS3',0,1,0,0),('CUS4',1,0,1,0),('CUS5',1,0,0,0),('CUS6',1,1,1,1),('CUS7',1,0,1,1),('CUS8',1,1,1,1),('CUS9',1,0,1,0);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(50) DEFAULT NULL,
  `manager_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (1,'Main Branch','2'),(2,'Downtown Branch','3'),(3,'West Branch','5');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `current_account`
--

DROP TABLE IF EXISTS `current_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `current_account` (
  `account_no` varchar(20) NOT NULL,
  `customer_id` varchar(20) DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`account_no`),
  KEY `current_account_ibfk_2_idx` (`branch_id`),
  KEY `current_account_ibfk_1_idx` (`customer_id`),
  CONSTRAINT `current_account_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `current_account_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `current_account`
--

LOCK TABLES `current_account` WRITE;
/*!40000 ALTER TABLE `current_account` DISABLE KEYS */;
INSERT INTO `current_account` VALUES ('C1','CUS3',1,'2023-09-11',500000.00),('C2','CUS6',1,'2023-10-10',350000.00),('C3','CUS8',1,'2023-10-15',560000.00);
/*!40000 ALTER TABLE `current_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` varchar(20) NOT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `telephone` char(10) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('CUS1','person','John Doe','123 Main St','1234567890'),('CUS10','person','Mark Rober','655 Wood Road','7489512548'),('CUS2','person','Jane Smith','456 Elm St','9876543210'),('CUS3','organization','ABC Corp','789 Oak St','5555555555'),('CUS4','person','Tim Cook','565 Beverly Hills','7845123698'),('CUS5','person','bruce Wayne','556 Hill Street','9876543210'),('CUS6','organization','XYZ Company','456 Elm Street','2222222222'),('CUS7','person','Jane Doe','789 Maple Street','3333333333'),('CUS8','organization','Acme Corporation','1011 Pine Street','4444444444'),('CUS9','person','Peter Parker','1234 Queens Boulevard','8945762159');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `role` varchar(15) NOT NULL,
  `branch_id` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `employee_ibfk_1_idx` (`branch_id`) /*!80000 INVISIBLE */,
  KEY `employee_ibfk_2_idx` (`employee_id`) /*!80000 INVISIBLE */,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('EMP1','Mark Hall','Worker',1),('EMP2','Clark Jhons','Manager',1),('EMP3','Smith Cover','Manager',2),('EMP4','Jason Bank','Worker',2),('EMP5','Walter White','Manager',3),('EMP6','Jesse Pink','Worker',3);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixed_deposit`
--

DROP TABLE IF EXISTS `fixed_deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixed_deposit` (
  `fd_id` varchar(20) NOT NULL,
  `account_no` varchar(20) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `rate` decimal(4,2) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`fd_id`),
  KEY `fixed_deposit_ibfk_1_idx` (`account_no`),
  CONSTRAINT `fixed_deposit_ibfk_1` FOREIGN KEY (`account_no`) REFERENCES `savings_account` (`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixed_deposit`
--

LOCK TABLES `fixed_deposit` WRITE;
/*!40000 ALTER TABLE `fixed_deposit` DISABLE KEYS */;
INSERT INTO `fixed_deposit` VALUES ('FD1','S1',250000.00,'2023-06-20',12,7.50,'2024-06-20 00:00:00'),('FD2','S2',400000.00,'2023-06-21',12,7.50,'2024-06-21 00:00:00'),('FD3','S4',50000.00,'2023-07-15',24,8.50,'2025-07-15 00:00:00'),('FD4','S6',1000000.00,'2023-08-02',12,7.50,'2024-08-02 00:00:00'),('FD5','S7',150000.00,'2023-08-20',36,9.50,'2026-08-20 00:00:00'),('FD6','S8',300000.00,'2023-09-20',6,9.50,'2024-03-20 00:00:00'),('FD7','S9',50000.00,'2023-10-20',12,7.50,'2024-10-20 00:00:00');
/*!40000 ALTER TABLE `fixed_deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `installement`
--

DROP TABLE IF EXISTS `installement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `installement` (
  `installement_id` varchar(50) NOT NULL,
  `ins_amount` int DEFAULT NULL,
  `date_settled` date DEFAULT NULL,
  `loan_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`installement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `installement`
--

LOCK TABLES `installement` WRITE;
/*!40000 ALTER TABLE `installement` DISABLE KEYS */;
/*!40000 ALTER TABLE `installement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `fd_id` varchar(20) DEFAULT NULL,
  `loan_amount` decimal(10,2) DEFAULT NULL,
  `interest_rate` decimal(4,2) DEFAULT NULL,
  `total_installments` int DEFAULT NULL,
  `remaining_installments` int DEFAULT NULL,
  `installement_amount` decimal(10,2) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `installment_due_date` date DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `loan_ibfk_1_idx` (`fd_id`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`fd_id`) REFERENCES `fixed_deposit` (`fd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,'FD1',50000.00,12.50,12,10,4687.50,'2024-07-22','2023-07-22','2023-09-22'),(2,'FD4',100000.00,13.50,24,22,4729.17,'2025-08-05','2023-08-05','2023-10-05'),(3,'FD5',100000.00,12.50,12,11,9375.00,'2024-08-22','2023-08-22','2023-09-22'),(4,'FD6',50000.00,13.50,24,24,2364.58,'2025-09-23','2023-09-23','2023-09-23'),(5,NULL,100000.00,12.50,12,12,9375.00,'2024-10-22','2023-10-22','2023-11-22');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_payment`
--

DROP TABLE IF EXISTS `loan_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `settle_date` date DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `loan_payment_ibfk_1_idx` (`loan_id`),
  CONSTRAINT `loan_payment_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_payment`
--

LOCK TABLES `loan_payment` WRITE;
/*!40000 ALTER TABLE `loan_payment` DISABLE KEYS */;
INSERT INTO `loan_payment` VALUES (1,1,'2023-08-21'),(2,2,'2023-09-04'),(3,3,'2023-09-21'),(4,1,'2023-09-21'),(5,2,'2023-10-04');
/*!40000 ALTER TABLE `loan_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_request`
--

DROP TABLE IF EXISTS `loan_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_request` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `customer_id` varchar(20) DEFAULT NULL,
  `loan_amount` decimal(10,2) DEFAULT NULL,
  `interest_rate` decimal(4,2) DEFAULT NULL,
  `approval_status` tinyint DEFAULT NULL,
  `employee_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`request_id`),
  KEY `loan_request_ibfk_1_idx` (`customer_id`),
  CONSTRAINT `loan_request_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_request`
--

LOCK TABLES `loan_request` WRITE;
/*!40000 ALTER TABLE `loan_request` DISABLE KEYS */;
INSERT INTO `loan_request` VALUES (1,5,'CUS10',100000.00,12.50,1,'EMP5');
/*!40000 ALTER TABLE `loan_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization` (
  `customer_id` varchar(20) NOT NULL,
  `type` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `organization_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES ('CUS3','NGO'),('CUS6','Company'),('CUS8','Company');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `customer_id` varchar(20) NOT NULL,
  `age` int DEFAULT NULL,
  `nic` char(12) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `person_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('CUS1',20,'1234569789'),('CUS10',36,'2352648712'),('CUS2',35,'9999999995'),('CUS4',50,'5959595965'),('CUS5',70,'8888888888'),('CUS7',13,'7878787854'),('CUS9',8,'1025647895');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_account`
--

DROP TABLE IF EXISTS `savings_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `savings_account` (
  `account_no` varchar(20) NOT NULL,
  `account_type` varchar(15) DEFAULT NULL,
  `customer_id` varchar(20) DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `starting_amount` decimal(10,2) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `remaining_withdrawals` int DEFAULT NULL,
  PRIMARY KEY (`account_no`),
  KEY `savings_account_ibfk_2_idx1` (`account_type`),
  KEY `savings_account_ibfk_1_idx` (`customer_id`),
  KEY `savings_account_ibfk_2_idx` (`branch_id`),
  CONSTRAINT `savings_account_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `savings_account_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savings_account`
--

LOCK TABLES `savings_account` WRITE;
/*!40000 ALTER TABLE `savings_account` DISABLE KEYS */;
INSERT INTO `savings_account` VALUES ('S1','Adult','CUS1',1,'2023-05-10',100000.00,90000.00,5),('S2','Adult','CUS2',1,'2023-05-10',50000.00,45000.00,3),('S3','Adult','CUS4',1,'2023-05-17',20000.00,6500.00,2),('S4','Senior','CUS5',2,'2023-06-01',1250000.00,1250000.00,5),('S5','organization','CUS6',1,'2023-06-16',250000.00,200000.00,4),('S6','Teen','CUS7',2,'2023-06-28',10000.00,9000.00,1),('S7','Organization','CUS8',1,'2023-08-17',6000000.00,5500000.00,2),('S8','Children','CUS9',2,'2023-09-17',5000.00,5000.00,3),('S9','Adult','CUS10',3,'2023-10-17',350000.00,350000.00,5);
/*!40000 ALTER TABLE `savings_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_account_type`
--

DROP TABLE IF EXISTS `savings_account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `savings_account_type` (
  `account_type` varchar(15) NOT NULL,
  `age_needed` int DEFAULT NULL,
  `interest_rate` decimal(4,2) DEFAULT NULL,
  `minimum_amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`account_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savings_account_type`
--

LOCK TABLES `savings_account_type` WRITE;
/*!40000 ALTER TABLE `savings_account_type` DISABLE KEYS */;
INSERT INTO `savings_account_type` VALUES ('Adult',18,10.00,1000.00),('Children',2,12.00,0.00),('Senior',60,13.00,1000.00),('Teen',12,11.00,500.00);
/*!40000 ALTER TABLE `savings_account_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `account_no` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `transactions_ibfk_1_idx` (`branch_id`),
  KEY `transactions_ibfk_2_idx` (`account_no`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`account_no`) REFERENCES `current_account` (`account_no`),
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`account_no`) REFERENCES `savings_account` (`account_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfer` (
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  PRIMARY KEY (`sender_id`,`receiver_id`),
  KEY `transfer_ibfk_2_idx` (`receiver_id`),
  CONSTRAINT `transfer_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `transactions` (`transaction_id`),
  CONSTRAINT `transfer_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `transactions` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer`
--

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_name` varchar(20) NOT NULL,
  `password_hash` char(200) DEFAULT NULL,
  `user_id` varchar(20) NOT NULL,
  `user_type` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`),
  KEY `user_ibfk_1_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('John Doe','$2a$10$abcdef','CUS1','customer'),('Mark Rober','$2a$10$123def','CUS10','customer'),('Jane Smith','$2a$10$123456','CUS2','customer'),('ABC Corp','$2a$10$789xyz','CUS3','customer'),('Tim Cook','$2a$10$pqr123','CUS4','employee'),('Bruce Wayne','$2a$10$xyz456','CUS5','customer'),('XYZ Company','$2a$10$mnopqr','CUS6','customer'),('Jane Doe','$2a$10$789abc','CUS7','customer'),('Acme Corporation','$2a$10$xyz789','CUS8','customer'),('Peter Parker','$2a$10$def456','CUS9','customer'),('Mark Hall','$2a$10$abcdef','EMP1','employee'),('Clark Jhons','$2a$10$abcdef','EMP2','employee'),('Smith Cover','$2a$10$abcdef','EMP3','employee'),('Jason Bank','$2a$10$abcdef','EMP4','employee'),('Walter White','$2a$10$abcdef','EMP5','employee'),('Jesse Pink','$2a$10$abcdef','EMP6','employee');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-30 19:00:40
