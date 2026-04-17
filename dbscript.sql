/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: faco_luz
-- ------------------------------------------------------
-- Server version	11.8.2-MariaDB

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
-- Table structure for table `adulthistories`
--

CREATE DATABASE faco_luz;

USE faco_luz;

DROP TABLE IF EXISTS `adulthistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `adulthistories` (
  `patientId` uuid NOT NULL,
  `currentWorking` enum('Si','No') NOT NULL,
  `workType` varchar(30) DEFAULT NULL,
  `familyBurden` int(11) unsigned NOT NULL,
  `phone` varchar(15) NOT NULL,
  KEY `patientToAdultHistories` (`patientId`),
  CONSTRAINT `patientToAdultHistory` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adulthistories`
--

LOCK TABLES `adulthistories` WRITE;
/*!40000 ALTER TABLE `adulthistories` DISABLE KEYS */;
/*!40000 ALTER TABLE `adulthistories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changelogs`
--

DROP TABLE IF EXISTS `changelogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `changelogs` (
  `id` uuid NOT NULL,
  `changeType` int(11) NOT NULL,
  `dateTime` datetime NOT NULL,
  `userModificatorId` int(15) unsigned NOT NULL,
  `userModificatedId` int(15) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `modificatorToLogs` (`userModificatorId`),
  KEY `modificatedtoLogs` (`userModificatedId`),
  CONSTRAINT `modificatedtoLogs` FOREIGN KEY (`userModificatedId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `modificatorToLogs` FOREIGN KEY (`userModificatorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changelogs`
--

--
-- Table structure for table `childhistories`
--

DROP TABLE IF EXISTS `childhistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `childhistories` (
  `patientId` uuid NOT NULL,
  `currentStudying` enum('Si','No') NOT NULL,
  `representativeName` varchar(25) NOT NULL,
  `representativeIdentification` varchar(15) NOT NULL,
  `representativePhone` varchar(15) NOT NULL,
  `representativeInstructionGrade` enum('Ninguno','Prescolar','Primaria','Bachillerato','Universitario','Postgrado') NOT NULL,
  `representativeWorking` enum('Si','No') NOT NULL,
  `representativeWorkType` varchar(50) DEFAULT NULL,
  `representativeFamilyBurden` int(11) unsigned NOT NULL DEFAULT 0,
  `familyDentalHistory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `dietaryHabits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `height` decimal(2,2) unsigned DEFAULT NULL,
  `weight` decimal(2,2) unsigned DEFAULT NULL,
  KEY `patientToChildHistories` (`patientId`),
  CONSTRAINT `FK_childhistories_patients` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `childhistories`
--

LOCK TABLES `childhistories` WRITE;
/*!40000 ALTER TABLE `childhistories` DISABLE KEYS */;
/*!40000 ALTER TABLE `childhistories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clases`
--

DROP TABLE IF EXISTS `clases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clases` (
  `section` varchar(5) NOT NULL,
  `asignature` varchar(5) NOT NULL,
  `userId` int(10) unsigned NOT NULL,
  `role` tinyint(4) NOT NULL,
  `year` int(4) NOT NULL,
  KEY `FK_classes_users_2` (`userId`) USING BTREE,
  CONSTRAINT `userToClases` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clases`
--

--
-- Table structure for table `consultations`
--

DROP TABLE IF EXISTS `consultations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultations` (
  `id` uuid NOT NULL,
  `patientId` uuid NOT NULL,
  `consultationReason` varchar(100) NOT NULL,
  `currentDisease` varchar(50) NOT NULL,
  `dateTime` datetime NOT NULL,
  `treatment` varchar(200) NOT NULL,
  `systolicPresure` int(11) NOT NULL,
  `diastolicPresure` int(11) NOT NULL,
  `BPM` int(11) NOT NULL,
  `physicalExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `intraoralExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `gumEvaluation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `dentalDiagram` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `childrenDentalDiagram` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `forecast` varchar(50) NOT NULL,
  `complementaryTests` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `observations` varchar(100) NOT NULL,
  `temp` decimal(2,2) NOT NULL DEFAULT 0.00,
  `pregnacy` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`pregnacy`)),
  `reactionToAnesthesia` enum('Si','No','No Sabe') NOT NULL,
  `reactionToAnesthesiaDesc` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `patientToConsultations` (`patientId`),
  CONSTRAINT `patientToConsultations` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultations`
--

LOCK TABLES `consultations` WRITE;
/*!40000 ALTER TABLE `consultations` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dates`
--

DROP TABLE IF EXISTS `dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dates` (
  `id` uuid NOT NULL,
  `patientId` uuid DEFAULT NULL,
  `doctorId` int(10) unsigned DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `status` enum('Pendiente','Atendida','Cancelada') NOT NULL DEFAULT 'Pendiente',
  `invoiceId` uuid NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patientOnDate` (`patientId`),
  KEY `doctorOnDate` (`doctorId`),
  KEY `dates_invoices_FK` (`invoiceId`),
  CONSTRAINT `dates_invoices_FK` FOREIGN KEY (`invoiceId`) REFERENCES `invoices` (`id`),
  CONSTRAINT `doctorOnDate` FOREIGN KEY (`doctorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patientOnDate` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dates`
--

LOCK TABLES `dates` WRITE;
/*!40000 ALTER TABLE `dates` DISABLE KEYS */;
/*!40000 ALTER TABLE `dates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluations`
--

DROP TABLE IF EXISTS `evaluations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluations` (
  `id` uuid NOT NULL,
  `notes` varchar(200) NOT NULL,
  `consultationId` uuid NOT NULL,
  `studentId` int(10) unsigned NOT NULL,
  `teacherId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `consultationToEvaluation` (`consultationId`),
  KEY `studentIdToEvaluations` (`studentId`),
  KEY `teacherIdToEvaluations` (`teacherId`),
  CONSTRAINT `consultationToEvaluation` FOREIGN KEY (`consultationId`) REFERENCES `consultations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `studentIdToEvaluations` FOREIGN KEY (`studentId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `teacherIdToEvaluations` FOREIGN KEY (`teacherId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluations`
--

LOCK TABLES `evaluations` WRITE;
/*!40000 ALTER TABLE `evaluations` DISABLE KEYS */;
/*!40000 ALTER TABLE `evaluations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `billableitem` enum('Cirugia','Endodoncia','Ortodoncia','Peridoncia','Protesis Total','Protesis parcial removible','Protesis parcial fija','CIA','CIAN','Emergencia de CIA','Emergencia de CIAN') NOT NULL,
  `currency` enum('Bolivares en efectivo','Bolivares en transferencia','Dolares en efectivo','Exoneracion') NOT NULL,
  `reference` varchar(100) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `patientId` int(11) NOT NULL,
  `patientName` varchar(100) NOT NULL,
  `patientPhone` varchar(15) NOT NULL,
  `amount` float NOT NULL,
  `changeRate` float NOT NULL,
  `status` enum('Pendiente','Recibida','Rechazada') NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` uuid NOT NULL,
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `patientIdentificacion` int(10) unsigned DEFAULT NULL,
  `patientCode` int(10) unsigned DEFAULT NULL,
  `birthDate` date NOT NULL,
  `sex` enum('M','F') NOT NULL,
  `bloodType` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `address` varchar(100) NOT NULL,
  `emergencyName` varchar(50) NOT NULL,
  `emergencyPhone` varchar(15) NOT NULL,
  `instructionGrade` enum('Ninguno','Prescolar','Primaria','Bachiller','Universitario','Postgrado') NOT NULL,
  `race` enum('Blanco','Negro','Moreno','indigena') NOT NULL,
  `proneToBleeding` enum('Si','No','No sabe') DEFAULT NULL,
  `ailments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createPatient` datetime NOT NULL,
  `identificationType` enum('V','E','Cod.') NOT NULL,
  `birthPlace` varchar(50) NOT NULL,
  `addressMunicipality` varchar(25) NOT NULL,
  `addressCity` varchar(25) NOT NULL,
  `emergencyRelationship` enum('Madre','Padre','Abuelo/a','Hermano/a','Nieto/a','Hijo/a','Esposo/a','Tio/a','Sobrino/a','Otro') NOT NULL,
  `companionName` varchar(30) DEFAULT NULL,
  `companionPhone` varchar(15) DEFAULT NULL,
  `companionRelationship` enum('Madre','Padre','Abuelo/a','Hermano/a','Nieto/a','Hijo/a','Esposo/a','Tio/a','Sobrino/a','Otro') NOT NULL,
  `idStudent` int(10) unsigned NOT NULL,
  `idTeacher` int(10) unsigned NOT NULL,
  `habits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`habits`)),
  `ethnicity` enum('Wayuu','Añu','Bari','Yukpa','Japreria') DEFAULT NULL,
  `addressState` varchar(25) NOT NULL,
  `homeOwnership` enum('Familiar','Propia','Alquilada') NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `patientIdentificacion_patientCode` (`patientIdentificacion`,`patientCode`),
  KEY `historyIdStudent` (`idStudent`),
  KEY `historyIdTeacher` (`idTeacher`),
  CONSTRAINT `historyIdStudent` FOREIGN KEY (`idStudent`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `historyIdTeacher` FOREIGN KEY (`idTeacher`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `label` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`label`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES
('currencyRate',244);

/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE `prices` (
  `label` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`label`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO`prices` VALUES
('ciaConsulta',1),
('cianConsulta',1),
('ciaHistoria',1),
('cianHistoria',1),
('cirugia',1),
('endodoncia',1),
('ortodoncia',1),
('protesisTotal',1),
('protesisParcialFija',1),
('protesisParcialRemovible',1),
('emergenciaCia',1),
('emergenciaCian',1),
('peridoncia',1);

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `passwordSHA256` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `identificationType` int(10) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES
(1,'admin','admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',5,0,1);
UNLOCK TABLES;

--
-- Dumping routines for database 'faco_luz'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-12-07 19:26:25
