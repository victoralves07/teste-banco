-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: keepimov
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert` (
  `id_alert` int NOT NULL AUTO_INCREMENT,
  `id_transportLine` int NOT NULL,
  `id_station` int DEFAULT NULL,
  `description_alert` varchar(500) NOT NULL,
  `alert_type` varchar(60) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status_alert` varchar(50) DEFAULT 'ativo',
  PRIMARY KEY (`id_alert`),
  KEY `id_transportLine` (`id_transportLine`),
  KEY `id_station` (`id_station`),
  KEY `idx_alert_status_date` (`status_alert`,`created_at`),
  CONSTRAINT `alert_ibfk_1` FOREIGN KEY (`id_transportLine`) REFERENCES `transport_line` (`id_transportLine`),
  CONSTRAINT `alert_ibfk_2` FOREIGN KEY (`id_station`) REFERENCES `station` (`id_station`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
INSERT INTO `alert` VALUES (1,1,6,'Atenção: ocorrência próxima à estação Santa Cruz.','operacional','2026-11-13 13:49:12','ativo'),(2,2,12,'Atenção: operação com alteração na região da estação Paulista.','operacional','2026-11-13 13:49:12','ativo'),(3,3,16,'Atenção: serviço com lentidão na região de Pinheiros.','operacional','2026-11-13 13:49:12','ativo');
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `id_favorite` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_transportLine` int DEFAULT NULL,
  `id_station` int DEFAULT NULL,
  `add_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `notification_on` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_favorite`),
  KEY `id_user` (`id_user`),
  KEY `id_transportLine` (`id_transportLine`),
  KEY `id_station` (`id_station`),
  CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`id_transportLine`) REFERENCES `transport_line` (`id_transportLine`),
  CONSTRAINT `favorite_ibfk_3` FOREIGN KEY (`id_station`) REFERENCES `station` (`id_station`),
  CONSTRAINT `favorite_chk_1` CHECK ((((`id_transportLine` is not null) and (`id_station` is null)) or ((`id_transportLine` is null) and (`id_station` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (1,1,1,NULL,'2026-11-13 13:47:49',1),(2,1,NULL,9,'2026-11-13 13:47:49',1),(3,2,2,NULL,'2026-11-13 13:47:49',1),(4,2,NULL,16,'2026-11-13 13:47:49',0);
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line_station`
--

DROP TABLE IF EXISTS `line_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line_station` (
  `id_line_station` int NOT NULL AUTO_INCREMENT,
  `id_transportLine` int NOT NULL,
  `id_station` int NOT NULL,
  `station_order` int NOT NULL,
  `travel_time_to_next_minutes` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_line_station`),
  UNIQUE KEY `id_transportLine` (`id_transportLine`,`station_order`),
  UNIQUE KEY `id_transportLine_2` (`id_transportLine`,`id_station`),
  KEY `idx_line_station_station` (`id_station`),
  CONSTRAINT `line_station_ibfk_1` FOREIGN KEY (`id_transportLine`) REFERENCES `transport_line` (`id_transportLine`),
  CONSTRAINT `line_station_ibfk_2` FOREIGN KEY (`id_station`) REFERENCES `station` (`id_station`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line_station`
--

LOCK TABLES `line_station` WRITE;
/*!40000 ALTER TABLE `line_station` DISABLE KEYS */;
INSERT INTO `line_station` VALUES (1,1,1,1,3.00),(2,1,2,2,2.00),(3,1,3,3,3.00),(4,1,4,4,2.00),(5,1,5,5,3.00),(6,1,6,6,2.00),(7,1,7,7,2.00),(8,1,8,8,4.00),(9,1,9,9,NULL),(10,2,9,1,3.00),(11,2,10,2,2.00),(12,2,11,3,2.00),(13,2,12,4,3.00),(14,2,13,5,2.00),(15,2,14,6,3.00),(16,2,15,7,2.00),(17,2,16,8,3.00),(18,2,17,9,NULL),(19,3,18,1,3.00),(20,3,19,2,2.00),(21,3,20,3,3.00),(22,3,21,4,4.00),(23,3,22,5,3.00),(24,3,23,6,3.00),(25,3,24,7,NULL);
/*!40000 ALTER TABLE `line_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id_post` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `text` varchar(500) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `id_repost` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_post`),
  KEY `id_user` (`id_user`),
  KEY `id_repost` (`id_repost`),
  KEY `idx_post_created` (`created_at`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`id_repost`) REFERENCES `post` (`id_post`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,1,'Hoje o trajeto foi tranquilo! Gostei de acompanhar minha linha pelo KeepiMov.',NULL,NULL,'2026-11-13 13:51:09'),(2,2,'Alguém sabe como está a movimentação na região de Pinheiros?',NULL,NULL,'2026-11-13 13:51:09'),(3,1,'Compartilhando uma publicação importante sobre o transporte público.',NULL,1,'2026-11-13 13:51:09');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_comment`
--

DROP TABLE IF EXISTS `post_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_comment` (
  `id_comment` int NOT NULL AUTO_INCREMENT,
  `id_post` int NOT NULL,
  `id_user` int NOT NULL,
  `comment_text` varchar(500) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comment`),
  KEY `id_user` (`id_user`),
  KEY `idx_comment_post` (`id_post`),
  CONSTRAINT `post_comment_ibfk_1` FOREIGN KEY (`id_post`) REFERENCES `post` (`id_post`),
  CONSTRAINT `post_comment_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comment`
--

LOCK TABLES `post_comment` WRITE;
/*!40000 ALTER TABLE `post_comment` DISABLE KEYS */;
INSERT INTO `post_comment` VALUES (1,1,2,'Que bom! Também utilizo bastante essa linha.','2026-11-13 13:52:37'),(2,2,1,'Ainda não passei por lá hoje, mas vou acompanhar os avisos.','2026-11-13 13:52:37'),(3,3,2,'Muito importante compartilhar informações com outros passageiros!','2026-11-13 13:52:37'),(4,1,2,'Que bom! Também utilizo bastante essa linha.','2026-11-13 13:53:04'),(5,2,1,'Ainda não passei por lá hoje, mas vou acompanhar os avisos.','2026-11-13 13:53:04'),(6,3,2,'Muito importante compartilhar informações com outros passageiros!','2026-11-13 13:53:04');
/*!40000 ALTER TABLE `post_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_like`
--

DROP TABLE IF EXISTS `post_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_like` (
  `id_like` int NOT NULL AUTO_INCREMENT,
  `id_post` int NOT NULL,
  `id_user` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_like`),
  UNIQUE KEY `id_post` (`id_post`,`id_user`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `post_like_ibfk_1` FOREIGN KEY (`id_post`) REFERENCES `post` (`id_post`),
  CONSTRAINT `post_like_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_like`
--

LOCK TABLES `post_like` WRITE;
/*!40000 ALTER TABLE `post_like` DISABLE KEYS */;
INSERT INTO `post_like` VALUES (1,1,2,'2026-11-13 13:52:00'),(2,2,1,'2026-11-13 13:52:00'),(3,3,2,'2026-11-13 13:52:00');
/*!40000 ALTER TABLE `post_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route_station`
--

DROP TABLE IF EXISTS `route_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route_station` (
  `id_route_station` int NOT NULL AUTO_INCREMENT,
  `id_route` int NOT NULL,
  `id_station` int NOT NULL,
  `id_transportLine` int NOT NULL,
  `step_order` int NOT NULL,
  PRIMARY KEY (`id_route_station`),
  UNIQUE KEY `id_route` (`id_route`,`step_order`),
  KEY `id_station` (`id_station`),
  KEY `id_transportLine` (`id_transportLine`),
  CONSTRAINT `route_station_ibfk_1` FOREIGN KEY (`id_route`) REFERENCES `saved_route` (`id_route`),
  CONSTRAINT `route_station_ibfk_2` FOREIGN KEY (`id_station`) REFERENCES `station` (`id_station`),
  CONSTRAINT `route_station_ibfk_3` FOREIGN KEY (`id_transportLine`) REFERENCES `transport_line` (`id_transportLine`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route_station`
--

LOCK TABLES `route_station` WRITE;
/*!40000 ALTER TABLE `route_station` DISABLE KEYS */;
INSERT INTO `route_station` VALUES (1,1,9,2,1),(2,1,10,2,2),(3,1,11,2,3),(4,1,12,2,4),(5,1,13,2,5),(6,1,14,2,6),(7,1,15,2,7),(8,1,16,2,8),(9,1,17,2,9),(19,2,1,1,1),(29,2,2,1,2),(30,2,3,1,3),(31,2,4,1,4),(32,2,5,1,5),(33,2,6,1,6),(34,2,7,1,7),(35,2,8,1,8);
/*!40000 ALTER TABLE `route_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_route`
--

DROP TABLE IF EXISTS `saved_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saved_route` (
  `id_route` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `origin_station` int NOT NULL,
  `destination_station` int NOT NULL,
  `route_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_route`),
  KEY `origin_station` (`origin_station`),
  KEY `destination_station` (`destination_station`),
  KEY `idx_route_user` (`id_user`),
  CONSTRAINT `saved_route_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  CONSTRAINT `saved_route_ibfk_2` FOREIGN KEY (`origin_station`) REFERENCES `station` (`id_station`),
  CONSTRAINT `saved_route_ibfk_3` FOREIGN KEY (`destination_station`) REFERENCES `station` (`id_station`),
  CONSTRAINT `saved_route_chk_1` CHECK ((`origin_station` <> `destination_station`))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_route`
--

LOCK TABLES `saved_route` WRITE;
/*!40000 ALTER TABLE `saved_route` DISABLE KEYS */;
INSERT INTO `saved_route` VALUES (1,1,9,17,'Da Luz até Butantã','2026-11-13 13:53:01'),(2,2,1,8,'Jabaquara até Paraíso','2026-11-13 13:53:01');
/*!40000 ALTER TABLE `saved_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `id_station` int NOT NULL AUTO_INCREMENT,
  `name_station` varchar(100) NOT NULL,
  `address` varchar(180) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`id_station`),
  KEY `idx_station_name` (`name_station`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'Jabaquara','Jabaquara, São Paulo - SP',NULL,NULL),(2,'Conceição','Conceição, São Paulo - SP',NULL,NULL),(3,'São Judas','São Judas, São Paulo - SP',NULL,NULL),(4,'Saúde','Saúde, São Paulo - SP',NULL,NULL),(5,'Praça da Árvore','Praça da Árvore, São Paulo - SP',NULL,NULL),(6,'Santa Cruz','Santa Cruz, São Paulo - SP',NULL,NULL),(7,'Ana Rosa','Ana Rosa, São Paulo - SP',NULL,NULL),(8,'Paraíso','Paraíso, São Paulo - SP',NULL,NULL),(9,'Luz','Luz, São Paulo - SP',NULL,NULL),(10,'República','República, São Paulo - SP',NULL,NULL),(11,'Higienópolis-Mackenzie','Consolação, São Paulo - SP',NULL,NULL),(12,'Paulista','Paulista, São Paulo - SP',NULL,NULL),(13,'Oscar Freire','Oscar Freire, São Paulo - SP',NULL,NULL),(14,'Fradique Coutinho','Pinheiros, São Paulo - SP',NULL,NULL),(15,'Faria Lima','Pinheiros, São Paulo - SP',NULL,NULL),(16,'Pinheiros','Pinheiros, São Paulo - SP',NULL,NULL),(17,'Butantã','Butantã, São Paulo - SP',NULL,NULL),(18,'Osasco','Osasco - SP',NULL,NULL),(19,'Presidente Altino','Osasco - SP',NULL,NULL),(20,'Ceasa','Vila Leopoldina, São Paulo - SP',NULL,NULL),(21,'Villa-Lobos-Jaguaré','Jaguaré, São Paulo - SP',NULL,NULL),(22,'Cidade Jardim','Cidade Jardim, São Paulo - SP',NULL,NULL),(23,'Berrini','Brooklin, São Paulo - SP',NULL,NULL),(24,'Morumbi','Morumbi, São Paulo - SP',NULL,NULL);
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_line`
--

DROP TABLE IF EXISTS `transport_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport_line` (
  `id_transportLine` int NOT NULL AUTO_INCREMENT,
  `name_line` varchar(80) NOT NULL,
  `transport_type` varchar(30) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  `status_line` varchar(50) DEFAULT 'ativo',
  PRIMARY KEY (`id_transportLine`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_line`
--

LOCK TABLES `transport_line` WRITE;
/*!40000 ALTER TABLE `transport_line` DISABLE KEYS */;
INSERT INTO `transport_line` VALUES (1,'Linha 1 - Azul','Metro','#005CA9','ativo'),(2,'Linha 4 - Amarela','Metro','#FFD800','ativo'),(3,'Linha 9 - Esmeralda','Trem','#00A859','ativo');
/*!40000 ALTER TABLE `transport_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `password_user` varchar(255) NOT NULL,
  `name_user` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `register_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'HASH_DE_TESTE_USUARIO_1','Lucas Almeida','lucas@keepimov.com','2026-11-13 13:31:48','2026-11-13 13:31:48'),(2,'HASH_DE_TESTE_USUARIO_2','Mariana Santos','mariana@keepimov.com','2026-11-13 13:31:48','2026-11-13 13:31:48');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warning`
--

DROP TABLE IF EXISTS `warning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warning` (
  `id_warning` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `description_warning` varchar(500) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status_warning` varchar(50) DEFAULT 'nao_lido',
  `warning_type` varchar(60) NOT NULL,
  PRIMARY KEY (`id_warning`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `warning_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warning`
--

LOCK TABLES `warning` WRITE;
/*!40000 ALTER TABLE `warning` DISABLE KEYS */;
INSERT INTO `warning` VALUES (1,1,'Lembrete: confira as condições da sua rota antes de sair.','2026-11-13 13:50:16','ativo','informativo'),(2,2,'Aviso: mantenha seus dados de perfil atualizados.','2026-11-13 13:50:16','ativo','informativo'),(3,1,'Lembrete: confira seus trajetos salvos no KeepiMov.','2026-11-13 13:50:16','ativo','lembrete');
/*!40000 ALTER TABLE `warning` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-13 11:20:19
