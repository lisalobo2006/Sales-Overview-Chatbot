CREATE DATABASE  IF NOT EXISTS `galaxy_cafe` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `galaxy_cafe`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: galaxy_cafe
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `bev_size`
--

DROP TABLE IF EXISTS `bev_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bev_size` (
  `SID` char(4) NOT NULL,
  `SIZE_NAME` char(10) DEFAULT NULL,
  `CAPACITY_ml` int DEFAULT NULL,
  PRIMARY KEY (`SID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bev_size`
--

LOCK TABLES `bev_size` WRITE;
/*!40000 ALTER TABLE `bev_size` DISABLE KEYS */;
INSERT INTO `bev_size` VALUES ('S001','Small',240),('S002','Medium',360),('S003','Large',480);
/*!40000 ALTER TABLE `bev_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beverage`
--

DROP TABLE IF EXISTS `beverage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beverage` (
  `BID` char(4) NOT NULL,
  `B_NAME` varchar(32) DEFAULT NULL,
  `bev_descr` varchar(200) DEFAULT NULL,
  `CATEGORY` char(20) DEFAULT NULL,
  `IMAGE` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`BID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beverage`
--

LOCK TABLES `beverage` WRITE;
/*!40000 ALTER TABLE `beverage` DISABLE KEYS */;
INSERT INTO `beverage` VALUES ('B001','Green Tea','A soothing, antioxidant rich brew with fresh grassy notes, a gentle earthy aroma, and a clean, refreshing finish.','Tea',NULL),('B002','Black Tea','A robust, full bodied classic with deep malty flavours, a rich fragrance, and a smooth, energising finish.','Tea','images/black.png'),('B003','Herbal Tea','A naturally caffeine-free infusion of hand-selected herbs and blossoms, offering calming aromas and a comforting taste.','Tea','images/herbal.png'),('B004','Oolong Tea','A beautifully balanced tea with floral undertones, a hint of sweetness, and a smooth, lingering finish.','Tea','images/oolong.png'),('B005','White Tea','A delicately crafted brew with subtle sweetness, soft floral notes, and a light, elegant character.','Tea','images/white.png'),('B006','Americano','Smooth and balanced whether served steaming hot or chilled over ice for a lighter finish.','Coffee','images/americano.png'),('B007','Cappuccino','Indulge in its rich espresso and creamy foam hot, or enjoy it iced for a cool, frothy delight.','Coffee','images/cappuccino.png'),('B008','Latte','Creamy and comforting when hot, or smooth and refreshing poured over ice.','Coffee','images/latte.png'),('B009','Mocha','A chocolate-infused favourite served warm and indulgent, or iced for a cool, sweet treat.','Coffee','images/mocha.png'),('B010','Macchiato','Bold espresso with a touch of milk, perfect hot for depth or iced for a crisp finish.','Coffee','images/macchiato.png'),('B011','Matcha Latte','Vibrant green matcha blended with creamy milk, soothing and earthy when hot or cool and energising served iced.','Tea&Coffee Blend','images/matcha_latte.png'),('B012','London Fog Latte','Earl Grey tea with steamed milk and a hint of vanilla, delicately fragrant hot or lightly sweet and refreshing over ice.','Tea&Coffee Blend','images/london.png'),('B013','Thai Tea with Espresso','Sweet, spiced Thai tea layered with espresso, rich and indulgent warm or bold and creamy poured over ice.','Tea&Coffee Blend','images/thai.png'),('B014','Chai Mocha','A warming fusion of spiced chai, chocolate, and espresso, decadently cozy hot or deliciously chilled for a sweet kick.','Tea&Coffee Blend','images/chai_mocha.png'),('B015','Hojicha Cafe Latte','Roasted green tea blended with espresso and creamy milk, offering a nutty, caramel-like warmth when hot or a smooth, toasty refreshment served iced.','Tea&Coffee Blend','images/hojicha.png'),('B016','Caramel Frappuccino','A classic blend of coffee, milk, and ice, topped with whipped cream and a drizzle of rich caramel sauce.','Frappuccino','images/caramel.png'),('B017','Mocha Frappuccino','A chocolate-lover’s delight, combining coffee, chocolate syrup, milk, and ice, finished with whipped cream.','Frappuccino','images/mocha_frappe.png'),('B018','Java Chip Frappuccino','A chocolaty, crunchy treat with chocolate chips blended into coffee, milk, and ice, topped with whipped cream and chocolate drizzle.','Frappuccino','images/javachip.png'),('B019','Vanilla Bean Crème Frappuccino','A creamy, coffee-free option made with vanilla bean, milk, and ice, topped with whipped cream.','Frappuccino','images/vanilla.png'),('B020','Pumpkin Spice Frappuccino','A seasonal favorite with pumpkin flavor, coffee, milk, and ice, topped with whipped cream and pumpkin spice.','Frappuccino','images/pumpkin.png');
/*!40000 ALTER TABLE `beverage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumable`
--

DROP TABLE IF EXISTS `consumable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumable` (
  `CNID` char(4) NOT NULL,
  `CN_NAME` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`CNID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumable`
--

LOCK TABLES `consumable` WRITE;
/*!40000 ALTER TABLE `consumable` DISABLE KEYS */;
INSERT INTO `consumable` VALUES ('CN01','Plastic cups(s)'),('CN02','Plastic cups(m)'),('CN03','Plastic cups(l)'),('CN04','Cup lid'),('CN05','Straws'),('CN06','Cup sleeves'),('CN07','Stir sticks'),('CN08','Takeaway trays'),('CN09','Paper towels'),('CN10','Disposable gloves'),('CN11','Garbage bags'),('CN12','Hand soap'),('CN13','Hand sanitizer');
/*!40000 ALTER TABLE `consumable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CID` char(4) NOT NULL,
  `C_NAME` varchar(32) DEFAULT NULL,
  `EMAIL` varchar(30) DEFAULT NULL,
  `COUNTRY_CODE` char(4) DEFAULT NULL,
  `PHONE_NUMBER` int DEFAULT NULL,
  `GENDER` char(2) DEFAULT NULL,
  `PASSWORD_` varbinary(200) DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  UNIQUE KEY `password` (`PASSWORD_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('C001','Trina Houston','t.h@gmail.com','+971',100010001,'F',_binary '$2y$10$dxof7qiVtOfQYlOERT7yKOJ58shHmyMyXLSxQ1O6ujhLINC/1QDre','uploads/profile_pics/default.jpeg'),('C002','Wan Ji Ming','wjm@gmail.com','+971',111111111,'M',_binary '$2y$10$bEyOq4h8nryyHOJjjeIgEe6ml0.nfD9u8eo7uiUfx68kGuW4oXrCy','uploads/profile_pics/default.jpeg'),('C003','Nadine Maynard','n.m@gmail.com','+971',222222222,'F',_binary '$2y$10$6QvDuBEuqk2pPMQIZzn4dObVCaKtwfGb/j/J1MpvYHn/ZbwjW0vFe','uploads/profile_pics/default.jpeg'),('C004','Benjamin Matus','b.m@gmail.com','+971',333333333,'M',_binary '$2y$10$aLMBJu8zY9vz5z8myrvDNOQiPx8tOvQhNbCeudzQ21IAliRBHi3Bu','uploads/profile_pics/default.jpeg'),('C005','Da Yu Lin','dyl@gmail.com','+971',444444444,'F',_binary '$2y$10$TkGwWuNAWVUJQmPrvlY1wOqpP66ypNoBvA2RGtxNwreuEhYkaooPa','uploads/profile_pics/default.jpeg'),('C006','Jose Salazar','j.s@gmail.com','+971',555555555,'M',_binary '$2y$10$bvsOcU.DPnUsbLJqxKj6He906fr6KK19LS4.ecJIqoK8L1YyxsdOy','uploads/profile_pics/default.jpeg'),('C007','Ruth Regalado','r.r@gmail.com','+971',666666666,'F',_binary '$2y$10$vHsJzKYpHoGcmnMBoghXQer0QaWsDc1NdLz3y5Q4ptDz/OAkcaqXy','uploads/profile_pics/default.jpeg'),('C008','Marcos Antonio','m.a@gmail.com','+971',777777777,'M',_binary '$2y$10$tYCWvUFAw1pFaQud.2I8HOBzA9.L9EiouYx1tczFpZ5NawEvXlE5G','uploads/profile_pics/default.jpeg'),('C009','Isabel Ana','i.a@gmail.com','+971',888888888,'F',_binary '$2y$10$H05wVoQNxZ2ux.IYdrr7ueekk8PcUN4SIb1gd8G5Hq1M8NXyDOHPK','uploads/profile_pics/default.jpeg'),('C010','Derek Shepard','d.s@gmail.com','+971',999999999,'M',_binary '$2y$10$bP/H05MnBDyaY5St0C53AufkIAaOAxZ24dFjRgihw.0MGOdbkeOf6','uploads/profile_pics/default.jpeg'),('C011','Meredith Grey','m.g@gmail.com','+971',101010101,'F',_binary '$2y$10$QEU.PYPoW/aoIE8t7PpCaeBZNVHd2oerrV1TDDBtuC3VntRjLF77O','uploads/profile_pics/default.jpeg'),('C012','Mark Sloane','m.s@gmail.com','+971',202020202,'M',_binary '$2y$10$4jhU1vMc9KnWkgFvBYZfMev0chDBaEMxg/PSOvNn5eA7yzqa/O1kC','uploads/profile_pics/default.jpeg'),('C013','Maggie Pierce','m.p@gmail.com','+971',303030303,'F',_binary '$2y$10$PDYlX4HeJ7NFHdnmF1VPx.BWPHIbBDMhFhb54W55AET5Q.Pf6yZBG','uploads/profile_pics/default.jpeg'),('C014','Jackson Avery','j.a@gmail.com','+971',404040404,'M',_binary '$2y$10$nrLHhM25BFz/vZsfHIXBUe3vLF06MUkSfRVLZOeVQwTVXw87SZSF2','uploads/profile_pics/default.jpeg'),('C015','April Kepner','a.k@gmail.com','+971',505050505,'F',_binary '$2y$10$bS4iyNAghOAY3IrjX9d3.Oj6Q1cV4kV8fTjWslCl74UlCS9WevGzm','uploads/profile_pics/default.jpeg'),('C016','Richard Webber','r.w@gmail.com','+971',606060606,'M',_binary '$2y$10$eF0C1R7zEwXC4KyVFlqM8OsjWH31BZBdqEYFyMpgFJxHsEB1I9oni','uploads/profile_pics/default.jpeg'),('C017','Arizona Robins','a.r@gmail.com','+971',707070707,'F',_binary '$2y$10$NG88izwLTakSKGMmqMo6suU34dj84PqlqYQDcQdLRHpjj2eZRTyC.','uploads/profile_pics/default.jpeg'),('C018','Alex Karev','ak@gmail.com','+971',808080808,'M',_binary '$2y$10$eCw/lkiiUDOOHuqCNFMcBOoAs4QIWmBrLplfwgBjjOCxa50RVP9cW','uploads/profile_pics/default.jpeg'),('C019','Jo Wilson','j.w@gmail.com','+971',909090909,'F',_binary '$2y$10$remTArbwezrSvLBzU.xUg.hDH5yOY6k7xPHTM9HBAK2KXkmdXCYmK','uploads/profile_pics/default.jpeg'),('C020','Jeremy Gilbert','j.g@gmail.com','+971',100100100,'M',_binary '$2y$10$4bYu6WDJ6ex1GH6xED65yuq/TYKvdFE345uJfQMAkcyIrXihwPZWW','uploads/profile_pics/default.jpeg');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `EID` char(4) NOT NULL,
  `E_NAME` varchar(32) DEFAULT NULL,
  `JOB_TITLE` varchar(20) DEFAULT NULL,
  `SALARY` float(7,2) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `COUNTRY_CODE` char(4) DEFAULT NULL,
  `PHONE_NUMBER` int DEFAULT NULL,
  `EMAIL` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`EID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('E001','Luke Castillian','Cashier',2200.00,'2004-01-15','+971',123456789,'lc@gmail.com'),('E002','Piper Lovegood','Cashier',2200.00,'2001-04-28','+971',234567891,'pl@gmail.com'),('E003','Annabeth Chase','Barista',2700.00,'1999-06-18','+971',345678912,'ac@gmail.com'),('E004','Grover Underwood','Barista',2700.00,'2000-07-24','+971',456789123,'gu@gmail.com'),('E005','Jason Grace','Barista',2700.00,'1995-09-11','+971',567891234,'jg@gmail.com'),('E006','Rachel McQueen','Mascot',2000.00,'2006-11-01','+971',678912345,'rm@gmail.com'),('E007','Percy Jackson','Mascot',2000.00,'2006-12-12','+971',789123456,'pj@gmail.com'),('E008','Leo Valdez','Cleaner',1800.00,'2003-02-19','+971',891234567,'lv@gmail.com'),('E009','Will Solace','Cleaner',1800.00,'2001-10-16','+971',912345678,'ws@gmail.com'),('E010','Nico DiAngelo','Manger',4500.00,'1990-04-02','+971',1234567,'nd@gmail.com');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `IID` char(4) NOT NULL,
  `I_NAME` varchar(32) DEFAULT NULL,
  `UNIT` char(2) DEFAULT NULL,
  PRIMARY KEY (`IID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES ('I001','Green tea leaves','g'),('I002','Black tea leaves','g'),('I003','Herbal tea blend','g'),('I004','Oolong tea leaves','g'),('I005','White tea leaves','g'),('I006','Earl Grey tea','g'),('I007','Thai tea mix','g'),('I008','Chai tea blend','g'),('I009','Matcha powder','g'),('I010','Hojicha powder','g'),('I011','Cocoa powder','g'),('I012','Chocolate chips','g'),('I013','Pumpkin spice seasoning','g'),('I014','Cinnamon powder','g'),('I015','Nutmeg powder','g'),('I016','Clove powder','g'),('I017','Star anise','g'),('I018','Cardamom','g'),('I019','Ginger powder','g'),('I020','Vanilla bean powder','g'),('I021','Pumpkin puree','g'),('I022','Salt','g'),('I023','Brewed coffee','ml'),('I024','Whipped cream','ml'),('I025','Chocolate syrup','ml'),('I026','Mocha sauce','ml'),('I027','Honey','ml'),('I028','Simple syrup','ml'),('I029','Vanilla syrup','ml'),('I030','Caramel syrup','ml'),('I031','Pumpkin spice syrup','ml'),('I032','Vanilla extract','ml'),('I033','Caramel sauce','ml'),('I034','Chocolate drizzle sauce','ml'),('I035','Frappuccino base syrup','ml'),('I036','Whole milk','L'),('I037','Almond milk','L'),('I038','Cream','L'),('I039','Espresso beans','kg'),('I040','Sugar','kg'),('I041','Brown sugar','kg'),('I042','Ice cubes','kg');
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_variant`
--

DROP TABLE IF EXISTS `menu_variant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_variant` (
  `MVID` char(4) NOT NULL,
  `SELLING_PRICE` float(4,2) DEFAULT NULL,
  `BID` char(4) DEFAULT NULL,
  `TID` char(4) DEFAULT NULL,
  `SID` char(4) DEFAULT NULL,
  PRIMARY KEY (`MVID`),
  KEY `FK_BID` (`BID`),
  KEY `FK_TID` (`TID`),
  KEY `FK_SID` (`SID`),
  CONSTRAINT `FK_BID` FOREIGN KEY (`BID`) REFERENCES `beverage` (`BID`),
  CONSTRAINT `FK_SID` FOREIGN KEY (`SID`) REFERENCES `bev_size` (`SID`),
  CONSTRAINT `FK_TID` FOREIGN KEY (`TID`) REFERENCES `temperature_type` (`TID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_variant`
--

LOCK TABLES `menu_variant` WRITE;
/*!40000 ALTER TABLE `menu_variant` DISABLE KEYS */;
INSERT INTO `menu_variant` VALUES ('M001',20.00,'B001','T001','S001'),('M002',22.00,'B001','T001','S002'),('M003',24.00,'B001','T001','S003'),('M004',20.00,'B001','T002','S001'),('M005',22.00,'B001','T002','S002'),('M006',24.00,'B001','T002','S003'),('M007',20.00,'B002','T001','S001'),('M008',22.00,'B002','T001','S002'),('M009',24.00,'B002','T001','S003'),('M010',20.00,'B002','T002','S001'),('M011',22.00,'B002','T002','S002'),('M012',24.00,'B002','T002','S003'),('M013',20.00,'B003','T001','S001'),('M014',22.00,'B003','T001','S002'),('M015',24.00,'B003','T001','S003'),('M016',20.00,'B003','T002','S001'),('M017',22.00,'B003','T002','S002'),('M018',24.00,'B003','T002','S003'),('M019',20.00,'B004','T001','S001'),('M020',22.00,'B004','T001','S002'),('M021',24.00,'B004','T001','S003'),('M022',20.00,'B004','T002','S001'),('M023',22.00,'B004','T002','S002'),('M024',24.00,'B004','T002','S003'),('M025',20.00,'B005','T001','S001'),('M026',22.00,'B005','T001','S002'),('M027',24.00,'B005','T001','S003'),('M028',20.00,'B005','T002','S001'),('M029',22.00,'B005','T002','S002'),('M030',24.00,'B005','T002','S003'),('M031',20.00,'B006','T001','S001'),('M032',22.00,'B006','T001','S002'),('M033',24.00,'B006','T001','S003'),('M034',20.00,'B006','T002','S001'),('M035',22.00,'B006','T002','S002'),('M036',24.00,'B006','T002','S003'),('M037',20.00,'B007','T001','S001'),('M038',22.00,'B007','T001','S002'),('M039',24.00,'B007','T001','S003'),('M040',20.00,'B007','T002','S001'),('M041',22.00,'B007','T002','S002'),('M042',24.00,'B007','T002','S003'),('M043',20.00,'B008','T001','S001'),('M044',22.00,'B008','T001','S002'),('M045',24.00,'B008','T001','S003'),('M046',20.00,'B008','T002','S001'),('M047',22.00,'B008','T002','S002'),('M048',24.00,'B008','T002','S003'),('M049',20.00,'B009','T001','S001'),('M050',22.00,'B009','T001','S002'),('M051',24.00,'B009','T001','S003'),('M052',20.00,'B009','T002','S001'),('M053',22.00,'B009','T002','S002'),('M054',24.00,'B009','T002','S003'),('M055',20.00,'B010','T001','S001'),('M056',22.00,'B010','T001','S002'),('M057',24.00,'B010','T001','S003'),('M058',20.00,'B010','T002','S001'),('M059',22.00,'B010','T002','S002'),('M060',24.00,'B010','T002','S003'),('M061',22.00,'B011','T001','S001'),('M062',24.00,'B011','T001','S002'),('M063',26.00,'B011','T001','S003'),('M064',22.00,'B011','T002','S001'),('M065',24.00,'B011','T002','S002'),('M066',26.00,'B011','T002','S003'),('M067',22.00,'B012','T001','S001'),('M068',24.00,'B012','T001','S002'),('M069',26.00,'B012','T001','S003'),('M070',22.00,'B012','T002','S001'),('M071',24.00,'B012','T002','S002'),('M072',26.00,'B012','T002','S003'),('M073',22.00,'B013','T001','S001'),('M074',24.00,'B013','T001','S002'),('M075',26.00,'B013','T001','S003'),('M076',22.00,'B013','T002','S001'),('M077',24.00,'B013','T002','S002'),('M078',26.00,'B013','T002','S003'),('M079',22.00,'B014','T001','S001'),('M080',24.00,'B014','T001','S002'),('M081',26.00,'B014','T001','S003'),('M082',22.00,'B014','T002','S001'),('M083',24.00,'B014','T002','S002'),('M084',26.00,'B014','T002','S003'),('M085',22.00,'B015','T001','S001'),('M086',24.00,'B015','T001','S002'),('M087',26.00,'B015','T001','S003'),('M088',22.00,'B015','T002','S001'),('M089',24.00,'B015','T002','S002'),('M090',26.00,'B015','T002','S003'),('M094',20.00,'B016','T002','S001'),('M095',22.00,'B016','T002','S002'),('M096',24.00,'B016','T002','S003'),('M100',20.00,'B017','T002','S001'),('M101',22.00,'B017','T002','S002'),('M102',24.00,'B017','T002','S003'),('M106',20.00,'B018','T002','S001'),('M107',22.00,'B018','T002','S002'),('M108',24.00,'B018','T002','S003'),('M112',20.00,'B019','T002','S001'),('M113',22.00,'B019','T002','S002'),('M114',24.00,'B019','T002','S003'),('M118',20.00,'B020','T002','S001'),('M119',22.00,'B020','T002','S002'),('M120',24.00,'B020','T002','S003');
/*!40000 ALTER TABLE `menu_variant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_type`
--

DROP TABLE IF EXISTS `payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_type` (
  `PTID` char(4) NOT NULL,
  `PT_METHOD` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`PTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_type`
--

LOCK TABLES `payment_type` WRITE;
/*!40000 ALTER TABLE `payment_type` DISABLE KEYS */;
INSERT INTO `payment_type` VALUES ('PT01','Cash'),('PT02','Credit Card'),('PT03','Debit Card');
/*!40000 ALTER TABLE `payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_detail`
--

DROP TABLE IF EXISTS `recipe_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_detail` (
  `RID` char(4) NOT NULL,
  `QUANTITY` float(5,3) DEFAULT NULL,
  `MVID` char(4) DEFAULT NULL,
  `IID` char(4) DEFAULT NULL,
  `CNID` char(4) DEFAULT NULL,
  `EID` char(4) DEFAULT NULL,
  PRIMARY KEY (`RID`),
  KEY `FK_MVID` (`MVID`),
  KEY `FK_IID` (`IID`),
  KEY `FK_CNID` (`CNID`),
  KEY `FK_EID` (`EID`),
  CONSTRAINT `FK_CNID` FOREIGN KEY (`CNID`) REFERENCES `consumable` (`CNID`),
  CONSTRAINT `FK_EID` FOREIGN KEY (`EID`) REFERENCES `employee` (`EID`),
  CONSTRAINT `FK_IID` FOREIGN KEY (`IID`) REFERENCES `ingredient` (`IID`),
  CONSTRAINT `FK_MVID` FOREIGN KEY (`MVID`) REFERENCES `menu_variant` (`MVID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_detail`
--

LOCK TABLES `recipe_detail` WRITE;
/*!40000 ALTER TABLE `recipe_detail` DISABLE KEYS */;
INSERT INTO `recipe_detail` VALUES ('R001',3.000,'M001','I001',NULL,'E010'),('R002',0.010,'M001','I040',NULL,'E010'),('R003',1.000,'M001',NULL,'CN01','E010'),('R004',1.000,'M001',NULL,'CN04','E010'),('R005',1.000,'M001',NULL,'CN06','E010'),('R006',1.000,'M001',NULL,'CN07','E010'),('R007',3.000,'M004','I001',NULL,'E010'),('R008',0.010,'M004','I040',NULL,'E010'),('R009',0.150,'M004','I042',NULL,'E010'),('R010',1.000,'M004',NULL,'CN01','E010'),('R011',1.000,'M004',NULL,'CN04','E010'),('R012',1.000,'M004',NULL,'CN05','E010'),('R013',1.000,'M004',NULL,'CN07','E010'),('R014',4.000,'M002','I001',NULL,'E010'),('R015',0.015,'M002','I040',NULL,'E010'),('R016',1.000,'M002',NULL,'CN02','E010'),('R017',1.000,'M002',NULL,'CN04','E010'),('R018',1.000,'M002',NULL,'CN06','E010'),('R019',1.000,'M002',NULL,'CN07','E010'),('R020',4.000,'M005','I001',NULL,'E010'),('R021',0.015,'M005','I040',NULL,'E010'),('R022',0.200,'M005','I042',NULL,'E010'),('R023',1.000,'M005',NULL,'CN02','E010'),('R024',1.000,'M005',NULL,'CN04','E010'),('R025',1.000,'M005',NULL,'CN05','E010'),('R026',1.000,'M005',NULL,'CN07','E010'),('R027',5.000,'M003','I001',NULL,'E010'),('R028',0.020,'M003','I040',NULL,'E010'),('R029',1.000,'M003',NULL,'CN03','E010'),('R030',1.000,'M003',NULL,'CN04','E010'),('R031',1.000,'M003',NULL,'CN06','E010'),('R032',1.000,'M003',NULL,'CN07','E010'),('R033',5.000,'M006','I001',NULL,'E010'),('R034',0.020,'M006','I040',NULL,'E010'),('R035',0.250,'M006','I042',NULL,'E010'),('R036',1.000,'M006',NULL,'CN03','E010'),('R037',1.000,'M006',NULL,'CN04','E010'),('R038',1.000,'M006',NULL,'CN05','E010'),('R039',1.000,'M006',NULL,'CN07','E010'),('R040',3.000,'M007','I002',NULL,'E010'),('R041',0.010,'M007','I040',NULL,'E010'),('R042',1.000,'M007',NULL,'CN01','E010'),('R043',1.000,'M007',NULL,'CN04','E010'),('R044',1.000,'M007',NULL,'CN06','E010'),('R045',1.000,'M007',NULL,'CN07','E010'),('R046',3.000,'M010','I002',NULL,'E010'),('R047',0.010,'M010','I040',NULL,'E010'),('R048',0.150,'M010','I042',NULL,'E010'),('R049',1.000,'M010',NULL,'CN01','E010'),('R050',1.000,'M010',NULL,'CN04','E010'),('R051',1.000,'M010',NULL,'CN05','E010'),('R052',1.000,'M010',NULL,'CN07','E010'),('R053',4.000,'M008','I002',NULL,'E010'),('R054',0.015,'M008','I040',NULL,'E010'),('R055',1.000,'M008',NULL,'CN02','E010'),('R056',1.000,'M008',NULL,'CN04','E010'),('R057',1.000,'M008',NULL,'CN06','E010'),('R058',1.000,'M008',NULL,'CN07','E010'),('R059',4.000,'M011','I002',NULL,'E010'),('R060',0.015,'M011','I040',NULL,'E010'),('R061',0.200,'M011','I042',NULL,'E010'),('R062',1.000,'M011',NULL,'CN02','E010'),('R063',1.000,'M011',NULL,'CN04','E010'),('R064',1.000,'M011',NULL,'CN05','E010'),('R065',1.000,'M011',NULL,'CN07','E010'),('R066',5.000,'M009','I002',NULL,'E010'),('R067',0.020,'M009','I040',NULL,'E010'),('R068',1.000,'M009',NULL,'CN03','E010'),('R069',1.000,'M009',NULL,'CN04','E010'),('R070',1.000,'M009',NULL,'CN06','E010'),('R071',1.000,'M009',NULL,'CN07','E010'),('R072',5.000,'M012','I002',NULL,'E010'),('R073',0.020,'M012','I040',NULL,'E010'),('R074',0.250,'M012','I042',NULL,'E010'),('R075',1.000,'M012',NULL,'CN03','E010'),('R076',1.000,'M012',NULL,'CN04','E010'),('R077',1.000,'M012',NULL,'CN05','E010'),('R078',1.000,'M012',NULL,'CN07','E010'),('R079',3.000,'M013','I003',NULL,'E010'),('R080',0.010,'M013','I040',NULL,'E010'),('R081',1.000,'M013',NULL,'CN01','E010'),('R082',1.000,'M013',NULL,'CN04','E010'),('R083',1.000,'M013',NULL,'CN06','E010'),('R084',1.000,'M013',NULL,'CN07','E010'),('R085',3.000,'M016','I003',NULL,'E010'),('R086',0.010,'M016','I040',NULL,'E010'),('R087',0.150,'M016','I042',NULL,'E010'),('R088',1.000,'M016',NULL,'CN01','E010'),('R089',1.000,'M016',NULL,'CN04','E010'),('R090',1.000,'M016',NULL,'CN05','E010'),('R091',1.000,'M016',NULL,'CN07','E010'),('R092',4.000,'M014','I003',NULL,'E010'),('R093',0.015,'M014','I040',NULL,'E010'),('R094',1.000,'M014',NULL,'CN02','E010'),('R095',1.000,'M014',NULL,'CN04','E010'),('R096',1.000,'M014',NULL,'CN06','E010'),('R097',1.000,'M014',NULL,'CN07','E010'),('R098',4.000,'M017','I003',NULL,'E010'),('R099',0.015,'M017','I040',NULL,'E010'),('R100',0.200,'M017','I042',NULL,'E010'),('R101',1.000,'M017',NULL,'CN02','E010'),('R102',1.000,'M017',NULL,'CN04','E010'),('R103',1.000,'M017',NULL,'CN05','E010'),('R104',1.000,'M017',NULL,'CN07','E010'),('R105',5.000,'M015','I003',NULL,'E010'),('R106',0.020,'M015','I040',NULL,'E010'),('R107',1.000,'M015',NULL,'CN03','E010'),('R108',1.000,'M015',NULL,'CN04','E010'),('R109',1.000,'M015',NULL,'CN06','E010'),('R110',1.000,'M015',NULL,'CN07','E010'),('R111',5.000,'M018','I003',NULL,'E010'),('R112',0.020,'M018','I040',NULL,'E010'),('R113',0.250,'M018','I042',NULL,'E010'),('R114',1.000,'M018',NULL,'CN03','E010'),('R115',1.000,'M018',NULL,'CN04','E010'),('R116',1.000,'M018',NULL,'CN05','E010'),('R117',1.000,'M018',NULL,'CN07','E010'),('R118',3.000,'M019','I004',NULL,'E010'),('R119',0.010,'M019','I040',NULL,'E010'),('R120',1.000,'M019',NULL,'CN01','E010'),('R121',1.000,'M019',NULL,'CN04','E010'),('R122',1.000,'M019',NULL,'CN06','E010'),('R123',1.000,'M019',NULL,'CN07','E010'),('R124',3.000,'M022','I004',NULL,'E010'),('R125',0.010,'M022','I040',NULL,'E010'),('R126',0.150,'M022','I042',NULL,'E010'),('R127',1.000,'M022',NULL,'CN01','E010'),('R128',1.000,'M022',NULL,'CN04','E010'),('R129',1.000,'M022',NULL,'CN05','E010'),('R130',1.000,'M022',NULL,'CN07','E010'),('R131',4.000,'M020','I004',NULL,'E010'),('R132',0.015,'M020','I040',NULL,'E010'),('R133',1.000,'M020',NULL,'CN02','E010'),('R134',1.000,'M020',NULL,'CN04','E010'),('R135',1.000,'M020',NULL,'CN06','E010'),('R136',1.000,'M020',NULL,'CN07','E010'),('R137',4.000,'M023','I004',NULL,'E010'),('R138',0.015,'M023','I040',NULL,'E010'),('R139',0.200,'M023','I042',NULL,'E010'),('R140',1.000,'M023',NULL,'CN02','E010'),('R141',1.000,'M023',NULL,'CN04','E010'),('R142',1.000,'M023',NULL,'CN05','E010'),('R143',1.000,'M023',NULL,'CN07','E010'),('R144',5.000,'M021','I004',NULL,'E010'),('R145',0.020,'M021','I040',NULL,'E010'),('R146',1.000,'M021',NULL,'CN03','E010'),('R147',1.000,'M021',NULL,'CN04','E010'),('R148',1.000,'M021',NULL,'CN06','E010'),('R149',1.000,'M021',NULL,'CN07','E010'),('R150',5.000,'M024','I004',NULL,'E010'),('R151',0.020,'M024','I040',NULL,'E010'),('R152',0.250,'M024','I042',NULL,'E010'),('R153',1.000,'M024',NULL,'CN03','E010'),('R154',1.000,'M024',NULL,'CN04','E010'),('R155',1.000,'M024',NULL,'CN05','E010'),('R156',1.000,'M024',NULL,'CN07','E010'),('R157',3.000,'M025','I005',NULL,'E010'),('R158',0.010,'M025','I040',NULL,'E010'),('R159',1.000,'M025',NULL,'CN01','E010'),('R160',1.000,'M025',NULL,'CN04','E010'),('R161',1.000,'M025',NULL,'CN06','E010'),('R162',1.000,'M025',NULL,'CN07','E010'),('R163',3.000,'M028','I005',NULL,'E010'),('R164',0.010,'M028','I040',NULL,'E010'),('R165',0.150,'M028','I042',NULL,'E010'),('R166',1.000,'M028',NULL,'CN01','E010'),('R167',1.000,'M028',NULL,'CN04','E010'),('R168',1.000,'M028',NULL,'CN05','E010'),('R169',1.000,'M028',NULL,'CN07','E010'),('R170',4.000,'M026','I005',NULL,'E010'),('R171',0.015,'M026','I040',NULL,'E010'),('R172',1.000,'M026',NULL,'CN02','E010'),('R173',1.000,'M026',NULL,'CN04','E010'),('R174',1.000,'M026',NULL,'CN06','E010'),('R175',1.000,'M026',NULL,'CN07','E010'),('R176',4.000,'M029','I005',NULL,'E010'),('R177',0.015,'M029','I040',NULL,'E010'),('R178',0.200,'M029','I042',NULL,'E010'),('R179',1.000,'M029',NULL,'CN02','E010'),('R180',1.000,'M029',NULL,'CN04','E010'),('R181',1.000,'M029',NULL,'CN05','E010'),('R182',1.000,'M029',NULL,'CN07','E010'),('R183',5.000,'M027','I005',NULL,'E010'),('R184',0.020,'M027','I040',NULL,'E010'),('R185',1.000,'M027',NULL,'CN03','E010'),('R186',1.000,'M027',NULL,'CN04','E010'),('R187',1.000,'M027',NULL,'CN06','E010'),('R188',1.000,'M027',NULL,'CN07','E010'),('R189',5.000,'M030','I005',NULL,'E010'),('R190',0.020,'M030','I040',NULL,'E010'),('R191',0.250,'M030','I042',NULL,'E010'),('R192',1.000,'M030',NULL,'CN03','E010'),('R193',1.000,'M030',NULL,'CN04','E010'),('R194',1.000,'M030',NULL,'CN05','E010'),('R195',1.000,'M030',NULL,'CN07','E010'),('R196',0.020,'M031','I039',NULL,'E010'),('R197',0.010,'M031','I040',NULL,'E010'),('R198',1.000,'M031',NULL,'CN01','E010'),('R199',1.000,'M031',NULL,'CN04','E010'),('R200',1.000,'M031',NULL,'CN06','E010'),('R201',1.000,'M031',NULL,'CN07','E010'),('R202',0.020,'M034','I039',NULL,'E010'),('R203',0.010,'M034','I040',NULL,'E010'),('R204',0.150,'M034','I042',NULL,'E010'),('R205',1.000,'M034',NULL,'CN01','E010'),('R206',1.000,'M034',NULL,'CN04','E010'),('R207',1.000,'M034',NULL,'CN05','E010'),('R208',1.000,'M034',NULL,'CN07','E010'),('R209',0.025,'M032','I039',NULL,'E010'),('R210',0.015,'M032','I040',NULL,'E010'),('R211',1.000,'M032',NULL,'CN02','E010'),('R212',1.000,'M032',NULL,'CN04','E010'),('R213',1.000,'M032',NULL,'CN06','E010'),('R214',1.000,'M032',NULL,'CN07','E010'),('R215',0.025,'M035','I039',NULL,'E010'),('R216',0.015,'M035','I040',NULL,'E010'),('R217',0.200,'M035','I042',NULL,'E010'),('R218',1.000,'M035',NULL,'CN02','E010'),('R219',1.000,'M035',NULL,'CN04','E010'),('R220',1.000,'M035',NULL,'CN05','E010'),('R221',1.000,'M035',NULL,'CN07','E010'),('R222',0.030,'M033','I039',NULL,'E010'),('R223',0.020,'M033','I040',NULL,'E010'),('R224',1.000,'M033',NULL,'CN03','E010'),('R225',1.000,'M033',NULL,'CN04','E010'),('R226',1.000,'M033',NULL,'CN06','E010'),('R227',1.000,'M033',NULL,'CN07','E010'),('R228',0.030,'M036','I039',NULL,'E010'),('R229',0.020,'M036','I040',NULL,'E010'),('R230',0.250,'M036','I042',NULL,'E010'),('R231',1.000,'M036',NULL,'CN03','E010'),('R232',1.000,'M036',NULL,'CN04','E010'),('R233',1.000,'M036',NULL,'CN05','E010'),('R234',1.000,'M036',NULL,'CN07','E010'),('R235',0.020,'M037','I039',NULL,'E010'),('R236',0.200,'M037','I036',NULL,'E010'),('R237',0.010,'M037','I040',NULL,'E010'),('R238',1.000,'M037',NULL,'CN01','E010'),('R239',1.000,'M037',NULL,'CN04','E010'),('R240',1.000,'M037',NULL,'CN06','E010'),('R241',1.000,'M037',NULL,'CN07','E010'),('R242',0.020,'M040','I039',NULL,'E010'),('R243',0.200,'M040','I036',NULL,'E010'),('R244',0.010,'M040','I040',NULL,'E010'),('R245',0.150,'M040','I042',NULL,'E010'),('R246',1.000,'M040',NULL,'CN01','E010'),('R247',1.000,'M040',NULL,'CN04','E010'),('R248',1.000,'M040',NULL,'CN05','E010'),('R249',1.000,'M040',NULL,'CN07','E010'),('R250',0.025,'M038','I039',NULL,'E010'),('R251',0.300,'M038','I036',NULL,'E010'),('R252',0.015,'M038','I040',NULL,'E010'),('R253',1.000,'M038',NULL,'CN02','E010'),('R254',1.000,'M038',NULL,'CN04','E010'),('R255',1.000,'M038',NULL,'CN06','E010'),('R256',1.000,'M038',NULL,'CN07','E010'),('R257',0.025,'M041','I039',NULL,'E010'),('R258',0.300,'M041','I036',NULL,'E010'),('R259',0.015,'M041','I040',NULL,'E010'),('R260',0.200,'M041','I042',NULL,'E010'),('R261',1.000,'M041',NULL,'CN02','E010'),('R262',1.000,'M041',NULL,'CN04','E010'),('R263',1.000,'M041',NULL,'CN05','E010'),('R264',1.000,'M041',NULL,'CN07','E010'),('R265',0.030,'M039','I039',NULL,'E010'),('R266',0.400,'M039','I036',NULL,'E010'),('R267',0.020,'M039','I040',NULL,'E010'),('R268',1.000,'M039',NULL,'CN03','E010'),('R269',1.000,'M039',NULL,'CN04','E010'),('R270',1.000,'M039',NULL,'CN06','E010'),('R271',1.000,'M039',NULL,'CN07','E010'),('R272',0.030,'M042','I039',NULL,'E010'),('R273',0.400,'M042','I036',NULL,'E010'),('R274',0.020,'M042','I040',NULL,'E010'),('R275',0.250,'M042','I042',NULL,'E010'),('R276',1.000,'M042',NULL,'CN03','E010'),('R277',1.000,'M042',NULL,'CN04','E010'),('R278',1.000,'M042',NULL,'CN05','E010'),('R279',1.000,'M042',NULL,'CN07','E010'),('R280',0.020,'M043','I039',NULL,'E010'),('R281',0.250,'M043','I036',NULL,'E010'),('R282',0.010,'M043','I040',NULL,'E010'),('R283',1.000,'M043',NULL,'CN01','E010'),('R284',1.000,'M043',NULL,'CN04','E010'),('R285',1.000,'M043',NULL,'CN06','E010'),('R286',1.000,'M043',NULL,'CN07','E010'),('R287',0.020,'M046','I039',NULL,'E010'),('R288',0.250,'M046','I036',NULL,'E010'),('R289',0.010,'M046','I040',NULL,'E010'),('R290',0.150,'M046','I042',NULL,'E010'),('R291',1.000,'M046',NULL,'CN01','E010'),('R292',1.000,'M046',NULL,'CN04','E010'),('R293',1.000,'M046',NULL,'CN05','E010'),('R294',1.000,'M046',NULL,'CN07','E010'),('R295',0.025,'M044','I039',NULL,'E010'),('R296',0.350,'M044','I036',NULL,'E010'),('R297',0.015,'M044','I040',NULL,'E010'),('R298',1.000,'M044',NULL,'CN02','E010'),('R299',1.000,'M044',NULL,'CN04','E010'),('R300',1.000,'M044',NULL,'CN06','E010'),('R301',1.000,'M044',NULL,'CN07','E010'),('R302',0.025,'M047','I039',NULL,'E010'),('R303',0.350,'M047','I036',NULL,'E010'),('R304',0.015,'M047','I040',NULL,'E010'),('R305',0.200,'M047','I042',NULL,'E010'),('R306',1.000,'M047',NULL,'CN02','E010'),('R307',1.000,'M047',NULL,'CN04','E010'),('R308',1.000,'M047',NULL,'CN05','E010'),('R309',1.000,'M047',NULL,'CN07','E010'),('R310',0.030,'M045','I039',NULL,'E010'),('R311',0.450,'M045','I036',NULL,'E010'),('R312',0.020,'M045','I040',NULL,'E010'),('R313',1.000,'M045',NULL,'CN03','E010'),('R314',1.000,'M045',NULL,'CN04','E010'),('R315',1.000,'M045',NULL,'CN06','E010'),('R316',1.000,'M045',NULL,'CN07','E010'),('R317',0.030,'M048','I039',NULL,'E010'),('R318',0.450,'M048','I036',NULL,'E010'),('R319',0.020,'M048','I040',NULL,'E010'),('R320',0.250,'M048','I042',NULL,'E010'),('R321',1.000,'M048',NULL,'CN03','E010'),('R322',1.000,'M048',NULL,'CN04','E010'),('R323',1.000,'M048',NULL,'CN05','E010'),('R324',1.000,'M048',NULL,'CN07','E010'),('R325',3.000,'M049','I020',NULL,'E010'),('R326',0.010,'M049','I040',NULL,'E010'),('R327',1.000,'M049',NULL,'CN01','E010'),('R328',1.000,'M049',NULL,'CN04','E010'),('R329',1.000,'M049',NULL,'CN06','E010'),('R330',1.000,'M049',NULL,'CN07','E010'),('R331',3.000,'M052','I020',NULL,'E010'),('R332',0.010,'M052','I040',NULL,'E010'),('R333',0.150,'M052','I042',NULL,'E010'),('R334',1.000,'M052',NULL,'CN01','E010'),('R335',1.000,'M052',NULL,'CN04','E010'),('R336',1.000,'M052',NULL,'CN05','E010'),('R337',1.000,'M052',NULL,'CN07','E010'),('R338',4.000,'M050','I020',NULL,'E010'),('R339',0.015,'M050','I040',NULL,'E010'),('R340',1.000,'M050',NULL,'CN02','E010'),('R341',1.000,'M050',NULL,'CN04','E010'),('R342',1.000,'M050',NULL,'CN06','E010'),('R343',1.000,'M050',NULL,'CN07','E010'),('R344',4.000,'M053','I020',NULL,'E010'),('R345',0.015,'M053','I040',NULL,'E010'),('R346',0.200,'M053','I042',NULL,'E010'),('R347',1.000,'M053',NULL,'CN02','E010'),('R348',1.000,'M053',NULL,'CN04','E010'),('R349',1.000,'M053',NULL,'CN05','E010'),('R350',1.000,'M053',NULL,'CN07','E010'),('R351',5.000,'M051','I020',NULL,'E010'),('R352',0.020,'M051','I040',NULL,'E010'),('R353',1.000,'M051',NULL,'CN03','E010'),('R354',1.000,'M051',NULL,'CN04','E010'),('R355',1.000,'M051',NULL,'CN06','E010'),('R356',1.000,'M051',NULL,'CN07','E010'),('R357',5.000,'M054','I020',NULL,'E010'),('R358',0.020,'M054','I040',NULL,'E010'),('R359',0.250,'M054','I042',NULL,'E010'),('R360',1.000,'M054',NULL,'CN03','E010'),('R361',1.000,'M054',NULL,'CN04','E010'),('R362',1.000,'M054',NULL,'CN05','E010'),('R363',1.000,'M054',NULL,'CN07','E010'),('R364',3.000,'M055','I021',NULL,'E010'),('R365',0.010,'M055','I040',NULL,'E010'),('R366',1.000,'M055',NULL,'CN01','E010'),('R367',1.000,'M055',NULL,'CN04','E010'),('R368',1.000,'M055',NULL,'CN06','E010'),('R369',1.000,'M055',NULL,'CN07','E010'),('R370',3.000,'M058','I021',NULL,'E010'),('R371',0.010,'M058','I040',NULL,'E010'),('R372',0.150,'M058','I042',NULL,'E010'),('R373',1.000,'M058',NULL,'CN01','E010'),('R374',1.000,'M058',NULL,'CN04','E010'),('R375',1.000,'M058',NULL,'CN05','E010'),('R376',1.000,'M058',NULL,'CN07','E010'),('R377',4.000,'M056','I021',NULL,'E010'),('R378',0.015,'M056','I040',NULL,'E010'),('R379',1.000,'M056',NULL,'CN02','E010'),('R380',1.000,'M056',NULL,'CN04','E010'),('R381',1.000,'M056',NULL,'CN06','E010'),('R382',1.000,'M056',NULL,'CN07','E010'),('R383',4.000,'M059','I021',NULL,'E010'),('R384',0.015,'M059','I040',NULL,'E010'),('R385',0.200,'M059','I042',NULL,'E010'),('R386',1.000,'M059',NULL,'CN02','E010'),('R387',1.000,'M059',NULL,'CN04','E010'),('R388',1.000,'M059',NULL,'CN05','E010'),('R389',1.000,'M059',NULL,'CN07','E010'),('R390',5.000,'M057','I021',NULL,'E010'),('R391',0.020,'M057','I040',NULL,'E010'),('R392',1.000,'M057',NULL,'CN03','E010'),('R393',1.000,'M057',NULL,'CN04','E010'),('R394',1.000,'M057',NULL,'CN06','E010'),('R395',1.000,'M057',NULL,'CN07','E010'),('R396',5.000,'M060','I021',NULL,'E010'),('R397',0.020,'M060','I040',NULL,'E010'),('R398',0.250,'M060','I042',NULL,'E010'),('R399',1.000,'M060',NULL,'CN03','E010'),('R400',1.000,'M060',NULL,'CN04','E010'),('R401',1.000,'M060',NULL,'CN05','E010'),('R402',1.000,'M060',NULL,'CN07','E010'),('R403',2.000,'M061','I009',NULL,'E010'),('R404',0.250,'M061','I036',NULL,'E010'),('R405',0.010,'M061','I040',NULL,'E010'),('R406',1.000,'M061',NULL,'CN01','E010'),('R407',1.000,'M061',NULL,'CN04','E010'),('R408',1.000,'M061',NULL,'CN06','E010'),('R409',1.000,'M061',NULL,'CN07','E010'),('R410',2.000,'M064','I009',NULL,'E010'),('R411',0.250,'M064','I036',NULL,'E010'),('R412',0.010,'M064','I040',NULL,'E010'),('R413',0.150,'M064','I042',NULL,'E010'),('R414',1.000,'M064',NULL,'CN01','E010'),('R415',1.000,'M064',NULL,'CN04','E010'),('R416',1.000,'M064',NULL,'CN05','E010'),('R417',1.000,'M064',NULL,'CN07','E010'),('R418',3.000,'M062','I009',NULL,'E010'),('R419',0.350,'M062','I036',NULL,'E010'),('R420',0.015,'M062','I040',NULL,'E010'),('R421',1.000,'M062',NULL,'CN02','E010'),('R422',1.000,'M062',NULL,'CN04','E010'),('R423',1.000,'M062',NULL,'CN06','E010'),('R424',1.000,'M062',NULL,'CN07','E010'),('R425',3.000,'M065','I009',NULL,'E010'),('R426',0.350,'M065','I036',NULL,'E010'),('R427',0.015,'M065','I040',NULL,'E010'),('R428',0.200,'M065','I042',NULL,'E010'),('R429',1.000,'M065',NULL,'CN02','E010'),('R430',1.000,'M065',NULL,'CN04','E010'),('R431',1.000,'M065',NULL,'CN05','E010'),('R432',1.000,'M065',NULL,'CN07','E010'),('R433',4.000,'M063','I009',NULL,'E010'),('R434',0.450,'M063','I036',NULL,'E010'),('R435',0.020,'M063','I040',NULL,'E010'),('R436',1.000,'M063',NULL,'CN03','E010'),('R437',1.000,'M063',NULL,'CN04','E010'),('R438',1.000,'M063',NULL,'CN06','E010'),('R439',1.000,'M063',NULL,'CN07','E010'),('R440',4.000,'M066','I009',NULL,'E010'),('R441',0.450,'M066','I036',NULL,'E010'),('R442',0.020,'M066','I040',NULL,'E010'),('R443',0.250,'M066','I042',NULL,'E010'),('R444',1.000,'M066',NULL,'CN03','E010'),('R445',1.000,'M066',NULL,'CN04','E010'),('R446',1.000,'M066',NULL,'CN05','E010'),('R447',1.000,'M066',NULL,'CN07','E010'),('R448',3.000,'M067','I006',NULL,'E010'),('R449',0.250,'M067','I036',NULL,'E010'),('R450',0.500,'M067','I020',NULL,'E010'),('R451',0.010,'M067','I040',NULL,'E010'),('R452',1.000,'M067',NULL,'CN01','E010'),('R453',1.000,'M067',NULL,'CN04','E010'),('R454',1.000,'M067',NULL,'CN06','E010'),('R455',1.000,'M067',NULL,'CN07','E010'),('R456',3.000,'M070','I006',NULL,'E010'),('R457',0.250,'M070','I036',NULL,'E010'),('R458',0.500,'M070','I020',NULL,'E010'),('R459',0.010,'M070','I040',NULL,'E010'),('R460',0.150,'M070','I042',NULL,'E010'),('R461',1.000,'M070',NULL,'CN01','E010'),('R462',1.000,'M070',NULL,'CN04','E010'),('R463',1.000,'M070',NULL,'CN05','E010'),('R464',1.000,'M070',NULL,'CN07','E010'),('R465',4.000,'M068','I006',NULL,'E010'),('R466',0.350,'M068','I036',NULL,'E010'),('R467',0.750,'M068','I020',NULL,'E010'),('R468',0.015,'M068','I040',NULL,'E010'),('R469',1.000,'M068',NULL,'CN02','E010'),('R470',1.000,'M068',NULL,'CN04','E010'),('R471',1.000,'M068',NULL,'CN06','E010'),('R472',1.000,'M068',NULL,'CN07','E010'),('R473',4.000,'M071','I006',NULL,'E010'),('R474',0.350,'M071','I036',NULL,'E010'),('R475',0.750,'M071','I020',NULL,'E010'),('R476',0.015,'M071','I040',NULL,'E010'),('R477',0.200,'M071','I042',NULL,'E010'),('R478',1.000,'M071',NULL,'CN02','E010'),('R479',1.000,'M071',NULL,'CN04','E010'),('R480',1.000,'M071',NULL,'CN05','E010'),('R481',1.000,'M071',NULL,'CN07','E010'),('R482',5.000,'M069','I006',NULL,'E010'),('R483',0.450,'M069','I036',NULL,'E010'),('R484',1.000,'M069','I020',NULL,'E010'),('R485',0.020,'M069','I040',NULL,'E010'),('R486',1.000,'M069',NULL,'CN03','E010'),('R487',1.000,'M069',NULL,'CN04','E010'),('R488',1.000,'M069',NULL,'CN06','E010'),('R489',1.000,'M069',NULL,'CN07','E010'),('R490',5.000,'M072','I006',NULL,'E010'),('R491',0.450,'M072','I036',NULL,'E010'),('R492',1.000,'M072','I020',NULL,'E010'),('R493',0.020,'M072','I040',NULL,'E010'),('R494',0.250,'M072','I042',NULL,'E010'),('R495',1.000,'M072',NULL,'CN03','E010'),('R496',1.000,'M072',NULL,'CN04','E010'),('R497',1.000,'M072',NULL,'CN05','E010'),('R498',1.000,'M072',NULL,'CN07','E010'),('R499',5.000,'M073','I007',NULL,'E010'),('R500',50.000,'M073','I023',NULL,'E010'),('R501',0.150,'M073','I036',NULL,'E010'),('R502',0.010,'M073','I041',NULL,'E010'),('R503',1.000,'M073',NULL,'CN01','E010'),('R504',1.000,'M073',NULL,'CN04','E010'),('R505',1.000,'M073',NULL,'CN06','E010'),('R506',1.000,'M073',NULL,'CN07','E010'),('R507',5.000,'M076','I007',NULL,'E010'),('R508',50.000,'M076','I023',NULL,'E010'),('R509',0.150,'M076','I036',NULL,'E010'),('R510',0.010,'M076','I041',NULL,'E010'),('R511',0.150,'M076','I042',NULL,'E010'),('R512',1.000,'M076',NULL,'CN01','E010'),('R513',1.000,'M076',NULL,'CN04','E010'),('R514',1.000,'M076',NULL,'CN05','E010'),('R515',1.000,'M076',NULL,'CN07','E010'),('R516',6.000,'M074','I007',NULL,'E010'),('R517',70.000,'M074','I023',NULL,'E010'),('R518',0.250,'M074','I036',NULL,'E010'),('R519',0.015,'M074','I041',NULL,'E010'),('R520',1.000,'M074',NULL,'CN02','E010'),('R521',1.000,'M074',NULL,'CN04','E010'),('R522',1.000,'M074',NULL,'CN06','E010'),('R523',1.000,'M074',NULL,'CN07','E010'),('R524',6.000,'M077','I007',NULL,'E010'),('R525',70.000,'M077','I023',NULL,'E010'),('R526',0.250,'M077','I036',NULL,'E010'),('R527',0.015,'M077','I041',NULL,'E010'),('R528',0.200,'M077','I042',NULL,'E010'),('R529',1.000,'M077',NULL,'CN02','E010'),('R530',1.000,'M077',NULL,'CN04','E010'),('R531',1.000,'M077',NULL,'CN05','E010'),('R532',1.000,'M077',NULL,'CN07','E010'),('R533',7.000,'M075','I007',NULL,'E010'),('R534',90.000,'M075','I023',NULL,'E010'),('R535',0.350,'M075','I036',NULL,'E010'),('R536',0.020,'M075','I041',NULL,'E010'),('R537',1.000,'M075',NULL,'CN03','E010'),('R538',1.000,'M075',NULL,'CN04','E010'),('R539',1.000,'M075',NULL,'CN06','E010'),('R540',1.000,'M075',NULL,'CN07','E010'),('R541',7.000,'M078','I007',NULL,'E010'),('R542',90.000,'M078','I023',NULL,'E010'),('R543',0.350,'M078','I036',NULL,'E010'),('R544',0.020,'M078','I041',NULL,'E010'),('R545',0.250,'M078','I042',NULL,'E010'),('R546',1.000,'M078',NULL,'CN03','E010'),('R547',1.000,'M078',NULL,'CN04','E010'),('R548',1.000,'M078',NULL,'CN05','E010'),('R549',1.000,'M078',NULL,'CN07','E010'),('R550',3.000,'M079','I008',NULL,'E010'),('R551',2.000,'M079','I011',NULL,'E010'),('R552',50.000,'M079','I023',NULL,'E010'),('R553',0.150,'M079','I036',NULL,'E010'),('R554',0.010,'M079','I040',NULL,'E010'),('R555',0.100,'M079','I014',NULL,'E010'),('R556',0.050,'M079','I015',NULL,'E010'),('R557',0.020,'M079','I016',NULL,'E010'),('R558',0.030,'M079','I018',NULL,'E010'),('R559',0.030,'M079','I019',NULL,'E010'),('R560',1.000,'M079',NULL,'CN01','E010'),('R561',1.000,'M079',NULL,'CN04','E010'),('R562',1.000,'M079',NULL,'CN06','E010'),('R563',1.000,'M079',NULL,'CN07','E010'),('R564',3.000,'M082','I008',NULL,'E010'),('R565',2.000,'M082','I011',NULL,'E010'),('R566',50.000,'M082','I023',NULL,'E010'),('R567',0.150,'M082','I036',NULL,'E010'),('R568',0.010,'M082','I040',NULL,'E010'),('R569',0.100,'M082','I014',NULL,'E010'),('R570',0.050,'M082','I015',NULL,'E010'),('R571',0.020,'M082','I016',NULL,'E010'),('R572',0.030,'M082','I018',NULL,'E010'),('R573',0.030,'M082','I019',NULL,'E010'),('R574',0.150,'M082','I042',NULL,'E010'),('R575',1.000,'M082',NULL,'CN01','E010'),('R576',1.000,'M082',NULL,'CN04','E010'),('R577',1.000,'M082',NULL,'CN05','E010'),('R578',1.000,'M082',NULL,'CN07','E010'),('R579',4.000,'M080','I008',NULL,'E010'),('R580',3.000,'M080','I011',NULL,'E010'),('R581',70.000,'M080','I023',NULL,'E010'),('R582',0.250,'M080','I036',NULL,'E010'),('R583',0.015,'M080','I040',NULL,'E010'),('R584',0.150,'M080','I014',NULL,'E010'),('R585',0.080,'M080','I015',NULL,'E010'),('R586',0.030,'M080','I016',NULL,'E010'),('R587',0.050,'M080','I018',NULL,'E010'),('R588',0.050,'M080','I019',NULL,'E010'),('R589',1.000,'M080',NULL,'CN02','E010'),('R590',1.000,'M080',NULL,'CN04','E010'),('R591',1.000,'M080',NULL,'CN06','E010'),('R592',1.000,'M080',NULL,'CN07','E010'),('R593',4.000,'M083','I008',NULL,'E010'),('R594',3.000,'M083','I011',NULL,'E010'),('R595',70.000,'M083','I023',NULL,'E010'),('R596',0.250,'M083','I036',NULL,'E010'),('R597',0.015,'M083','I040',NULL,'E010'),('R598',0.150,'M083','I014',NULL,'E010'),('R599',0.080,'M083','I015',NULL,'E010'),('R600',0.030,'M083','I016',NULL,'E010'),('R601',0.050,'M083','I018',NULL,'E010'),('R602',0.050,'M083','I019',NULL,'E010'),('R603',0.200,'M083','I042',NULL,'E010'),('R604',1.000,'M083',NULL,'CN02','E010'),('R605',1.000,'M083',NULL,'CN04','E010'),('R606',1.000,'M083',NULL,'CN05','E010'),('R607',1.000,'M083',NULL,'CN07','E010'),('R608',5.000,'M081','I008',NULL,'E010'),('R609',4.000,'M081','I011',NULL,'E010'),('R610',90.000,'M081','I023',NULL,'E010'),('R611',0.350,'M081','I036',NULL,'E010'),('R612',0.020,'M081','I040',NULL,'E010'),('R613',0.200,'M081','I014',NULL,'E010'),('R614',0.100,'M081','I015',NULL,'E010'),('R615',0.040,'M081','I016',NULL,'E010'),('R616',0.070,'M081','I018',NULL,'E010'),('R617',0.070,'M081','I019',NULL,'E010'),('R618',1.000,'M081',NULL,'CN03','E010'),('R619',1.000,'M081',NULL,'CN04','E010'),('R620',1.000,'M081',NULL,'CN06','E010'),('R621',1.000,'M081',NULL,'CN07','E010'),('R622',5.000,'M084','I008',NULL,'E010'),('R623',4.000,'M084','I011',NULL,'E010'),('R624',90.000,'M084','I023',NULL,'E010'),('R625',0.350,'M084','I036',NULL,'E010'),('R626',0.020,'M084','I040',NULL,'E010'),('R627',0.200,'M084','I014',NULL,'E010'),('R628',0.100,'M084','I015',NULL,'E010'),('R629',0.040,'M084','I016',NULL,'E010'),('R630',0.070,'M084','I018',NULL,'E010'),('R631',0.070,'M084','I019',NULL,'E010'),('R632',0.250,'M084','I042',NULL,'E010'),('R633',1.000,'M084',NULL,'CN03','E010'),('R634',1.000,'M084',NULL,'CN04','E010'),('R635',1.000,'M084',NULL,'CN05','E010'),('R636',1.000,'M084',NULL,'CN07','E010'),('R637',3.000,'M085','I010',NULL,'E010'),('R638',50.000,'M085','I023',NULL,'E010'),('R639',0.150,'M085','I036',NULL,'E010'),('R640',0.010,'M085','I041',NULL,'E010'),('R641',1.000,'M085',NULL,'CN01','E010'),('R642',1.000,'M085',NULL,'CN04','E010'),('R643',1.000,'M085',NULL,'CN06','E010'),('R644',1.000,'M085',NULL,'CN07','E010'),('R645',3.000,'M088','I010',NULL,'E010'),('R646',50.000,'M088','I023',NULL,'E010'),('R647',0.150,'M088','I036',NULL,'E010'),('R648',0.010,'M088','I041',NULL,'E010'),('R649',0.150,'M088','I042',NULL,'E010'),('R650',1.000,'M088',NULL,'CN01','E010'),('R651',1.000,'M088',NULL,'CN04','E010'),('R652',1.000,'M088',NULL,'CN05','E010'),('R653',1.000,'M088',NULL,'CN07','E010'),('R654',4.000,'M086','I010',NULL,'E010'),('R655',70.000,'M086','I023',NULL,'E010'),('R656',0.250,'M086','I036',NULL,'E010'),('R657',0.015,'M086','I041',NULL,'E010'),('R658',1.000,'M086',NULL,'CN02','E010'),('R659',1.000,'M086',NULL,'CN04','E010'),('R660',1.000,'M086',NULL,'CN06','E010'),('R661',1.000,'M086',NULL,'CN07','E010'),('R662',4.000,'M089','I010',NULL,'E010'),('R663',70.000,'M089','I023',NULL,'E010'),('R664',0.250,'M089','I036',NULL,'E010'),('R665',0.015,'M089','I041',NULL,'E010'),('R666',0.200,'M089','I042',NULL,'E010'),('R667',1.000,'M089',NULL,'CN02','E010'),('R668',1.000,'M089',NULL,'CN04','E010'),('R669',1.000,'M089',NULL,'CN05','E010'),('R670',1.000,'M089',NULL,'CN07','E010'),('R671',5.000,'M087','I010',NULL,'E010'),('R672',90.000,'M087','I023',NULL,'E010'),('R673',0.350,'M087','I036',NULL,'E010'),('R674',0.020,'M087','I041',NULL,'E010'),('R675',1.000,'M087',NULL,'CN03','E010'),('R676',1.000,'M087',NULL,'CN04','E010'),('R677',1.000,'M087',NULL,'CN06','E010'),('R678',1.000,'M087',NULL,'CN07','E010'),('R679',5.000,'M090','I010',NULL,'E010'),('R680',90.000,'M090','I023',NULL,'E010'),('R681',0.350,'M090','I036',NULL,'E010'),('R682',0.020,'M090','I041',NULL,'E010'),('R683',0.250,'M090','I042',NULL,'E010'),('R684',1.000,'M090',NULL,'CN03','E010'),('R685',1.000,'M090',NULL,'CN04','E010'),('R686',1.000,'M090',NULL,'CN05','E010'),('R687',1.000,'M090',NULL,'CN07','E010'),('R688',30.000,'M094','I035',NULL,'E010'),('R689',50.000,'M094','I023',NULL,'E010'),('R690',0.150,'M094','I036',NULL,'E010'),('R691',10.000,'M094','I030',NULL,'E010'),('R692',20.000,'M094','I024',NULL,'E010'),('R693',0.010,'M094','I041',NULL,'E010'),('R694',0.150,'M094','I042',NULL,'E010'),('R695',1.000,'M094',NULL,'CN01','E010'),('R696',1.000,'M094',NULL,'CN04','E010'),('R697',1.000,'M094',NULL,'CN05','E010'),('R698',1.000,'M094',NULL,'CN07','E010'),('R699',1.000,'M094',NULL,'CN08','E010'),('R700',40.000,'M095','I035',NULL,'E010'),('R701',70.000,'M095','I023',NULL,'E010'),('R702',0.250,'M095','I036',NULL,'E010'),('R703',15.000,'M095','I030',NULL,'E010'),('R704',25.000,'M095','I024',NULL,'E010'),('R705',0.010,'M095','I041',NULL,'E010'),('R706',0.200,'M095','I042',NULL,'E010'),('R707',1.000,'M095',NULL,'CN02','E010'),('R708',1.000,'M095',NULL,'CN04','E010'),('R709',1.000,'M095',NULL,'CN05','E010'),('R710',1.000,'M095',NULL,'CN07','E010'),('R711',1.000,'M095',NULL,'CN08','E010'),('R712',50.000,'M096','I035',NULL,'E010'),('R713',90.000,'M096','I023',NULL,'E010'),('R714',0.350,'M096','I036',NULL,'E010'),('R715',20.000,'M096','I030',NULL,'E010'),('R716',30.000,'M096','I024',NULL,'E010'),('R717',0.010,'M096','I041',NULL,'E010'),('R718',0.250,'M096','I042',NULL,'E010'),('R719',1.000,'M096',NULL,'CN03','E010'),('R720',1.000,'M096',NULL,'CN04','E010'),('R721',1.000,'M096',NULL,'CN05','E010'),('R722',1.000,'M096',NULL,'CN07','E010'),('R723',1.000,'M096',NULL,'CN08','E010'),('R724',30.000,'M100','I035',NULL,'E010'),('R725',50.000,'M100','I023',NULL,'E010'),('R726',0.150,'M100','I036',NULL,'E010'),('R727',10.000,'M100','I025',NULL,'E010'),('R728',20.000,'M100','I024',NULL,'E010'),('R729',0.150,'M100','I042',NULL,'E010'),('R730',1.000,'M100',NULL,'CN01','E010'),('R731',1.000,'M100',NULL,'CN04','E010'),('R732',1.000,'M100',NULL,'CN05','E010'),('R733',1.000,'M100',NULL,'CN07','E010'),('R734',1.000,'M100',NULL,'CN08','E010'),('R735',40.000,'M101','I035',NULL,'E010'),('R736',70.000,'M101','I023',NULL,'E010'),('R737',0.250,'M101','I036',NULL,'E010'),('R738',15.000,'M101','I025',NULL,'E010'),('R739',25.000,'M101','I024',NULL,'E010'),('R740',0.200,'M101','I042',NULL,'E010'),('R741',1.000,'M101',NULL,'CN02','E010'),('R742',1.000,'M101',NULL,'CN04','E010'),('R743',1.000,'M101',NULL,'CN05','E010'),('R744',1.000,'M101',NULL,'CN07','E010'),('R745',1.000,'M101',NULL,'CN08','E010'),('R746',50.000,'M102','I035',NULL,'E010'),('R747',90.000,'M102','I023',NULL,'E010'),('R748',0.350,'M102','I036',NULL,'E010'),('R749',20.000,'M102','I025',NULL,'E010'),('R750',30.000,'M102','I024',NULL,'E010'),('R751',0.250,'M102','I042',NULL,'E010'),('R752',1.000,'M102',NULL,'CN03','E010'),('R753',1.000,'M102',NULL,'CN04','E010'),('R754',1.000,'M102',NULL,'CN05','E010'),('R755',1.000,'M102',NULL,'CN07','E010'),('R756',1.000,'M102',NULL,'CN08','E010'),('R757',30.000,'M106','I035',NULL,'E010'),('R758',50.000,'M106','I023',NULL,'E010'),('R759',0.150,'M106','I036',NULL,'E010'),('R760',5.000,'M106','I012',NULL,'E010'),('R761',10.000,'M106','I026',NULL,'E010'),('R762',20.000,'M106','I024',NULL,'E010'),('R763',0.150,'M106','I042',NULL,'E010'),('R764',1.000,'M106',NULL,'CN01','E010'),('R765',1.000,'M106',NULL,'CN04','E010'),('R766',1.000,'M106',NULL,'CN05','E010'),('R767',1.000,'M106',NULL,'CN07','E010'),('R768',1.000,'M106',NULL,'CN08','E010'),('R769',40.000,'M107','I035',NULL,'E010'),('R770',70.000,'M107','I023',NULL,'E010'),('R771',0.250,'M107','I036',NULL,'E010'),('R772',7.000,'M107','I012',NULL,'E010'),('R773',15.000,'M107','I026',NULL,'E010'),('R774',25.000,'M107','I024',NULL,'E010'),('R775',0.200,'M107','I042',NULL,'E010'),('R776',1.000,'M107',NULL,'CN02','E010'),('R777',1.000,'M107',NULL,'CN04','E010'),('R778',1.000,'M107',NULL,'CN05','E010'),('R779',1.000,'M107',NULL,'CN07','E010'),('R780',1.000,'M107',NULL,'CN08','E010'),('R781',50.000,'M108','I035',NULL,'E010'),('R782',90.000,'M108','I023',NULL,'E010'),('R783',0.350,'M108','I036',NULL,'E010'),('R784',10.000,'M108','I012',NULL,'E010'),('R785',20.000,'M108','I026',NULL,'E010'),('R786',30.000,'M108','I024',NULL,'E010'),('R787',0.250,'M108','I042',NULL,'E010'),('R788',1.000,'M108',NULL,'CN03','E010'),('R789',1.000,'M108',NULL,'CN04','E010'),('R790',1.000,'M108',NULL,'CN05','E010'),('R791',1.000,'M108',NULL,'CN07','E010'),('R792',1.000,'M108',NULL,'CN08','E010'),('R793',30.000,'M112','I035',NULL,'E010'),('R794',0.150,'M112','I036',NULL,'E010'),('R795',3.000,'M112','I020',NULL,'E010'),('R796',20.000,'M112','I024',NULL,'E010'),('R797',0.150,'M112','I042',NULL,'E010'),('R798',1.000,'M112',NULL,'CN01','E010'),('R799',1.000,'M112',NULL,'CN04','E010'),('R800',1.000,'M112',NULL,'CN05','E010'),('R801',1.000,'M112',NULL,'CN07','E010'),('R802',1.000,'M112',NULL,'CN08','E010'),('R803',40.000,'M113','I035',NULL,'E010'),('R804',0.250,'M113','I036',NULL,'E010'),('R805',4.000,'M113','I020',NULL,'E010'),('R806',25.000,'M113','I024',NULL,'E010'),('R807',0.200,'M113','I042',NULL,'E010'),('R808',1.000,'M113',NULL,'CN02','E010'),('R809',1.000,'M113',NULL,'CN04','E010'),('R810',1.000,'M113',NULL,'CN05','E010'),('R811',1.000,'M113',NULL,'CN07','E010'),('R812',1.000,'M113',NULL,'CN08','E010'),('R813',50.000,'M114','I035',NULL,'E010'),('R814',0.350,'M114','I036',NULL,'E010'),('R815',5.000,'M114','I020',NULL,'E010'),('R816',30.000,'M114','I024',NULL,'E010'),('R817',0.250,'M114','I042',NULL,'E010'),('R818',1.000,'M114',NULL,'CN03','E010'),('R819',1.000,'M114',NULL,'CN04','E010'),('R820',1.000,'M114',NULL,'CN05','E010'),('R821',1.000,'M114',NULL,'CN07','E010'),('R822',1.000,'M114',NULL,'CN08','E010'),('R823',30.000,'M118','I035',NULL,'E010'),('R824',0.150,'M118','I036',NULL,'E010'),('R825',20.000,'M118','I021',NULL,'E010'),('R826',10.000,'M118','I031',NULL,'E010'),('R827',20.000,'M118','I024',NULL,'E010'),('R828',0.150,'M118','I042',NULL,'E010'),('R829',1.000,'M118',NULL,'CN01','E010'),('R830',1.000,'M118',NULL,'CN04','E010'),('R831',1.000,'M118',NULL,'CN05','E010'),('R832',1.000,'M118',NULL,'CN07','E010'),('R833',1.000,'M118',NULL,'CN08','E010'),('R834',40.000,'M119','I035',NULL,'E010'),('R835',0.250,'M119','I036',NULL,'E010'),('R836',30.000,'M119','I021',NULL,'E010'),('R837',15.000,'M119','I031',NULL,'E010'),('R838',25.000,'M119','I024',NULL,'E010'),('R839',0.200,'M119','I042',NULL,'E010'),('R840',1.000,'M119',NULL,'CN02','E010'),('R841',1.000,'M119',NULL,'CN04','E010'),('R842',1.000,'M119',NULL,'CN05','E010'),('R843',1.000,'M119',NULL,'CN07','E010'),('R844',1.000,'M119',NULL,'CN08','E010'),('R845',50.000,'M120','I035',NULL,'E010'),('R846',0.350,'M120','I036',NULL,'E010'),('R847',40.000,'M120','I021',NULL,'E010'),('R848',20.000,'M120','I031',NULL,'E010'),('R849',30.000,'M120','I024',NULL,'E010'),('R850',0.250,'M120','I042',NULL,'E010'),('R851',1.000,'M120',NULL,'CN03','E010'),('R852',1.000,'M120',NULL,'CN04','E010'),('R853',1.000,'M120',NULL,'CN05','E010'),('R854',1.000,'M120',NULL,'CN07','E010'),('R855',1.000,'M120',NULL,'CN08','E010');
/*!40000 ALTER TABLE `recipe_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_details`
--

DROP TABLE IF EXISTS `sales_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_details` (
  `SDID` char(4) NOT NULL,
  `QUANTITY` int DEFAULT NULL,
  `SELLING_PRICE` float(4,2) DEFAULT NULL,
  `SIID` char(4) DEFAULT NULL,
  `MVID` char(4) DEFAULT NULL,
  PRIMARY KEY (`SDID`),
  KEY `FK_SIID` (`SIID`),
  KEY `FK_SD_MVID` (`MVID`),
  CONSTRAINT `FK_SD_MVID` FOREIGN KEY (`MVID`) REFERENCES `menu_variant` (`MVID`),
  CONSTRAINT `FK_SIID` FOREIGN KEY (`SIID`) REFERENCES `sales_invoice` (`SIID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_details`
--

LOCK TABLES `sales_details` WRITE;
/*!40000 ALTER TABLE `sales_details` DISABLE KEYS */;
INSERT INTO `sales_details` VALUES ('S001',2,20.00,'SI01','M013'),('S002',1,24.00,'SI01','M003'),('S003',1,24.00,'SI02','M036'),('S004',1,22.00,'SI03','M011'),('S005',1,24.00,'SI04','M021'),('S006',1,20.00,'SI05','M001'),('S007',1,24.00,'SI06','M009'),('S008',1,24.00,'SI07','M120'),('S009',1,20.00,'SI08','M112'),('S010',1,24.00,'SI09','M108'),('S011',1,20.00,'SI10','M106'),('S012',1,20.00,'SI11','M061'),('S013',1,24.00,'SI11','M108'),('S014',1,22.00,'SI12','M047'),('S015',1,24.00,'SI13','M033'),('S016',1,24.00,'SI14','M036'),('S017',1,20.00,'SI15','M040'),('S018',1,22.00,'SI16','M005'),('S019',1,24.00,'SI17','M120'),('S020',1,24.00,'SI18','M108'),('S021',1,24.00,'SI19','M018'),('S022',1,22.00,'SI20','M023'),('S023',1,22.00,'SI21','M113'),('S024',1,20.00,'SI22','M007'),('S025',1,24.00,'SI23','M096'),('S026',2,20.00,'SI24','M025'),('S027',2,22.00,'SI25','M062'),('S028',2,20.00,'SI26','M118'),('S029',2,22.00,'SI27','M053'),('S030',2,20.00,'SI28','M019'),('S031',2,24.00,'SI29','M021'),('S032',2,22.00,'SI30','M032'),('S033',2,22.00,'SI31','M107'),('S034',2,22.00,'SI32','M101'),('S035',2,20.00,'SI33','M106'),('S036',2,20.00,'SI34','M070'),('S037',1,20.00,'SI35','M079'),('S038',1,20.00,'SI36','M085'),('S039',1,24.00,'SI37','M090'),('S040',1,20.00,'SI38','M019'),('S041',1,22.00,'SI39','M017'),('S042',1,20.00,'SI39','M013'),('S043',1,22.00,'SI40','M005');
/*!40000 ALTER TABLE `sales_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_invoice`
--

DROP TABLE IF EXISTS `sales_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_invoice` (
  `SIID` char(4) NOT NULL,
  `INVOICE_DATE` date DEFAULT NULL,
  `EID` char(4) DEFAULT NULL,
  `CID` char(4) DEFAULT NULL,
  `order_fulfilled` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`SIID`),
  KEY `FK_SI_EID` (`EID`),
  KEY `FK_SI_CID` (`CID`),
  CONSTRAINT `FK_SI_CID` FOREIGN KEY (`CID`) REFERENCES `customer` (`CID`),
  CONSTRAINT `FK_SI_EID` FOREIGN KEY (`EID`) REFERENCES `employee` (`EID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_invoice`
--

LOCK TABLES `sales_invoice` WRITE;
/*!40000 ALTER TABLE `sales_invoice` DISABLE KEYS */;
INSERT INTO `sales_invoice` VALUES ('SI01','2026-01-01','E001','C009','paid'),('SI02','2026-01-01','E001','C010','paid'),('SI03','2026-01-02','E002','C003','paid'),('SI04','2026-01-03','E001','C001','paid'),('SI05','2026-01-03','E001','C005','paid'),('SI06','2026-01-05','E001','C006','paid'),('SI07','2026-01-07','E001','C020','paid'),('SI08','2026-01-10','E001','C009','paid'),('SI09','2026-01-11','E002','C003','paid'),('SI10','2026-01-16','E001','C002','paid'),('SI11','2026-01-18','E002','C001','paid'),('SI12','2026-01-19','E001','C004','paid'),('SI13','2026-01-20','E001','C007','paid'),('SI14','2026-01-21','E002','C001','paid'),('SI15','2026-01-22','E001','C004','paid'),('SI16','2026-01-25','E002','C005','paid'),('SI17','2026-01-28','E002','C006','paid'),('SI18','2026-01-29','E001','C008','paid'),('SI19','2026-01-30','E002','C009','paid'),('SI20','2026-01-30','E002','C003','paid'),('SI21','2026-02-01','E001','C015','paid'),('SI22','2026-02-09','E001','C010','paid'),('SI23','2026-02-01','E002','C011','paid'),('SI24','2026-02-14','E001','C012','paid'),('SI25','2026-02-14','E001','C020','paid'),('SI26','2026-02-14','E001','C016','paid'),('SI27','2026-02-14','E001','C017','paid'),('SI28','2026-02-14','E001','C018','paid'),('SI29','2026-02-14','E002','C003','paid'),('SI30','2026-02-14','E001','C019','paid'),('SI31','2026-02-14','E002','C013','paid'),('SI32','2026-02-14','E001','C001','paid'),('SI33','2026-02-14','E001','C015','paid'),('SI34','2026-02-14','E002','C002','paid'),('SI35','2026-02-16','E001','C004','paid'),('SI36','2026-01-18','E002','C005','paid'),('SI37','2026-01-26','E002','C016','paid'),('SI38','2026-01-27','E001','C008','paid'),('SI39','2026-01-28','E002','C014','paid'),('SI40','2026-01-28','E002','C013','paid');
/*!40000 ALTER TABLE `sales_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_payment`
--

DROP TABLE IF EXISTS `sales_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_payment` (
  `SPID` char(4) NOT NULL,
  `TOTAL_AMOUNT` float(5,2) DEFAULT NULL,
  `PTID` char(4) DEFAULT NULL,
  `SIID` char(4) DEFAULT NULL,
  PRIMARY KEY (`SPID`),
  KEY `FK_SP_SIID` (`SIID`),
  KEY `FK_PTID` (`PTID`),
  CONSTRAINT `FK_PTID` FOREIGN KEY (`PTID`) REFERENCES `payment_type` (`PTID`),
  CONSTRAINT `FK_SP_SIID` FOREIGN KEY (`SIID`) REFERENCES `sales_invoice` (`SIID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_payment`
--

LOCK TABLES `sales_payment` WRITE;
/*!40000 ALTER TABLE `sales_payment` DISABLE KEYS */;
INSERT INTO `sales_payment` VALUES ('SP01',64.00,'PT02','SI01'),('SP02',24.00,'PT01','SI02'),('SP03',22.00,'PT01','SI03'),('SP04',24.00,'PT01','SI04'),('SP05',20.00,'PT02','SI05'),('SP06',24.00,'PT02','SI06'),('SP07',24.00,'PT03','SI07'),('SP08',20.00,'PT02','SI08'),('SP09',24.00,'PT03','SI09'),('SP10',20.00,'PT02','SI10'),('SP11',44.00,'PT02','SI11'),('SP12',22.00,'PT03','SI12'),('SP13',24.00,'PT01','SI13'),('SP14',24.00,'PT02','SI14'),('SP15',20.00,'PT03','SI15'),('SP16',22.00,'PT01','SI16'),('SP17',24.00,'PT02','SI17'),('SP18',24.00,'PT03','SI18'),('SP19',24.00,'PT02','SI19'),('SP20',22.00,'PT03','SI20'),('SP21',22.00,'PT02','SI21'),('SP22',20.00,'PT01','SI22'),('SP23',24.00,'PT01','SI23'),('SP24',40.00,'PT02','SI24'),('SP25',44.00,'PT01','SI25'),('SP26',40.00,'PT01','SI26'),('SP27',44.00,'PT01','SI27'),('SP28',40.00,'PT02','SI28'),('SP29',48.00,'PT02','SI29'),('SP30',44.00,'PT02','SI30'),('SP31',44.00,'PT03','SI31'),('SP32',44.00,'PT03','SI32'),('SP33',40.00,'PT02','SI33'),('SP34',40.00,'PT01','SI34'),('SP35',20.00,'PT01','SI35'),('SP36',20.00,'PT01','SI36'),('SP37',24.00,'PT01','SI37'),('SP38',20.00,'PT01','SI38'),('SP39',42.00,'PT01','SI39'),('SP40',2.00,'PT01','SI40'),('SP41',10.00,'PT02','SI40'),('SP42',10.00,'PT03','SI40');
/*!40000 ALTER TABLE `sales_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temperature_type`
--

DROP TABLE IF EXISTS `temperature_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temperature_type` (
  `TID` char(4) NOT NULL,
  `TYPE_NAME` char(3) DEFAULT NULL,
  PRIMARY KEY (`TID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temperature_type`
--

LOCK TABLES `temperature_type` WRITE;
/*!40000 ALTER TABLE `temperature_type` DISABLE KEYS */;
INSERT INTO `temperature_type` VALUES ('T001','Hot'),('T002','Ice');
/*!40000 ALTER TABLE `temperature_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-12  9:17:14
