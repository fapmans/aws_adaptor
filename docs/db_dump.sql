-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: os_adaptor
-- ------------------------------------------------------
-- Server version	5.5.47-0ubuntu0.14.04.1

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
-- Table structure for table `adaptor_apf`
--

DROP TABLE IF EXISTS `adaptor_apf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adaptor_apf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adaptor_apf`
--

LOCK TABLES `adaptor_apf` WRITE;
/*!40000 ALTER TABLE `adaptor_apf` DISABLE KEYS */;
INSERT INTO `adaptor_apf` VALUES (1,'BRGB','BR-GB Universities Policy Federation for IaaS Clouds');
/*!40000 ALTER TABLE `adaptor_apf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adaptor_attribute`
--

DROP TABLE IF EXISTS `adaptor_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adaptor_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `apf_id` int(11) DEFAULT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `ontology` tinyint(1) NOT NULL,
  `enumerated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adaptor_attribute_38543614` (`tenant_id`),
  KEY `adaptor_attribute_apf_id_32e24136f414592_fk_adaptor_apf_id` (`apf_id`),
  CONSTRAINT `adaptor_attribute_apf_id_32e24136f414592_fk_adaptor_apf_id` FOREIGN KEY (`apf_id`) REFERENCES `adaptor_apf` (`id`),
  CONSTRAINT `adaptor_attribut_tenant_id_3c8c0097acb854b8_fk_adaptor_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `adaptor_tenant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adaptor_attribute`
--

LOCK TABLES `adaptor_attribute` WRITE;
/*!40000 ALTER TABLE `adaptor_attribute` DISABLE KEYS */;
INSERT INTO `adaptor_attribute` VALUES (1,'role',NULL,1,'UFPE Openstack role',0,1),(2,'user.role',1,NULL,'Ontology user\'s role attribute',1,1),(3,'service',NULL,NULL,'Openstack service',0,1),(4,'resource.service',NULL,NULL,'Service in which the Resource is contained',1,1),(5,'action',NULL,NULL,'Action in Openstack Service',0,1),(6,'action.type',NULL,NULL,'Type of an Action',1,1),(7,'resource.type',NULL,NULL,'Type of a resource',1,1),(8,'action.parameter',NULL,NULL,'Parameter of an action',1,1),(9,'user_id',NULL,NULL,'Identifier of the user',0,0),(10,'user.id',NULL,NULL,'Identifier for users in the ontology',1,0),(11,'role',NULL,2,'Roles at UKC',0,1);
/*!40000 ALTER TABLE `adaptor_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adaptor_attributemapping`
--

DROP TABLE IF EXISTS `adaptor_attributemapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adaptor_attributemapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apf_attribute_id` int(11) NOT NULL,
  `local_attribute_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adapto_apf_attribute_id_73b4059310ca365d_fk_adaptor_attribute_id` (`apf_attribute_id`),
  KEY `adap_local_attribute_id_1aebdd0c89535b03_fk_adaptor_attribute_id` (`local_attribute_id`),
  CONSTRAINT `adapto_apf_attribute_id_73b4059310ca365d_fk_adaptor_attribute_id` FOREIGN KEY (`apf_attribute_id`) REFERENCES `adaptor_attribute` (`id`),
  CONSTRAINT `adap_local_attribute_id_1aebdd0c89535b03_fk_adaptor_attribute_id` FOREIGN KEY (`local_attribute_id`) REFERENCES `adaptor_attribute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adaptor_attributemapping`
--

LOCK TABLES `adaptor_attributemapping` WRITE;
/*!40000 ALTER TABLE `adaptor_attributemapping` DISABLE KEYS */;
INSERT INTO `adaptor_attributemapping` VALUES (1,2,1),(2,4,3),(3,6,5),(4,7,5),(5,8,5),(6,10,9),(7,2,11),(8,7,3);
/*!40000 ALTER TABLE `adaptor_attributemapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adaptor_hierarchy`
--

DROP TABLE IF EXISTS `adaptor_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adaptor_hierarchy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `child_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adaptor_hierarchy_f36263a3` (`child_id`),
  KEY `adaptor_hierarchy_6be37982` (`parent_id`),
  CONSTRAINT `adaptor_hierarchy_child_id_327fab496d845a81_fk_adaptor_value_id` FOREIGN KEY (`child_id`) REFERENCES `adaptor_value` (`id`),
  CONSTRAINT `adaptor_hierarchy_parent_id_4cc627fc92fca7a9_fk_adaptor_value_id` FOREIGN KEY (`parent_id`) REFERENCES `adaptor_value` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adaptor_hierarchy`
--

LOCK TABLES `adaptor_hierarchy` WRITE;
/*!40000 ALTER TABLE `adaptor_hierarchy` DISABLE KEYS */;
INSERT INTO `adaptor_hierarchy` VALUES (1,3,1),(2,5,3),(3,7,1),(4,7,5),(5,13,7),(6,11,13),(7,9,11),(8,4,2),(9,6,4),(10,8,2),(11,8,6),(12,14,8),(13,12,14),(14,10,12),(15,22,20),(16,23,20),(17,24,20),(18,64,63),(19,65,64),(20,66,65),(21,67,66);
/*!40000 ALTER TABLE `adaptor_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adaptor_operator`
--

DROP TABLE IF EXISTS `adaptor_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adaptor_operator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `apf_id` int(11) DEFAULT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `ontology` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adaptor_operator_38543614` (`tenant_id`),
  KEY `adaptor_operator_apf_id_62ca0bac926e6878_fk_adaptor_apf_id` (`apf_id`),
  CONSTRAINT `adaptor_operator_apf_id_62ca0bac926e6878_fk_adaptor_apf_id` FOREIGN KEY (`apf_id`) REFERENCES `adaptor_apf` (`id`),
  CONSTRAINT `adaptor_operator_tenant_id_2de79b3058217062_fk_adaptor_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `adaptor_tenant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adaptor_operator`
--

LOCK TABLES `adaptor_operator` WRITE;
/*!40000 ALTER TABLE `adaptor_operator` DISABLE KEYS */;
INSERT INTO `adaptor_operator` VALUES (2,'=',NULL,NULL,'Openstack equals',0),(3,'!=',NULL,NULL,'Openstack not equals',0),(4,'=',NULL,NULL,'equals',1),(5,'!=',NULL,NULL,'not equals',1);
/*!40000 ALTER TABLE `adaptor_operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adaptor_operatormapping`
--

DROP TABLE IF EXISTS `adaptor_operatormapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adaptor_operatormapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apf_operator_id` int(11) NOT NULL,
  `local_operator_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adaptor_o_apf_operator_id_b913120b919d191_fk_adaptor_operator_id` (`apf_operator_id`),
  KEY `adapto_local_operator_id_632b9bf89de2da29_fk_adaptor_operator_id` (`local_operator_id`),
  CONSTRAINT `adaptor_o_apf_operator_id_b913120b919d191_fk_adaptor_operator_id` FOREIGN KEY (`apf_operator_id`) REFERENCES `adaptor_operator` (`id`),
  CONSTRAINT `adapto_local_operator_id_632b9bf89de2da29_fk_adaptor_operator_id` FOREIGN KEY (`local_operator_id`) REFERENCES `adaptor_operator` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adaptor_operatormapping`
--

LOCK TABLES `adaptor_operatormapping` WRITE;
/*!40000 ALTER TABLE `adaptor_operatormapping` DISABLE KEYS */;
INSERT INTO `adaptor_operatormapping` VALUES (1,4,2),(2,5,3);
/*!40000 ALTER TABLE `adaptor_operatormapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adaptor_tenant`
--

DROP TABLE IF EXISTS `adaptor_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adaptor_tenant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adaptor_tenant`
--

LOCK TABLES `adaptor_tenant` WRITE;
/*!40000 ALTER TABLE `adaptor_tenant` DISABLE KEYS */;
INSERT INTO `adaptor_tenant` VALUES (1,'UFPE','Universidade Federal de Pernambuco'),(2,'UKC','University of Kent at Canterbury');
/*!40000 ALTER TABLE `adaptor_tenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adaptor_value`
--

DROP TABLE IF EXISTS `adaptor_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adaptor_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adaptor_val_attribute_id_b9e7c6591d0f54a_fk_adaptor_attribute_id` (`attribute_id`),
  CONSTRAINT `adaptor_val_attribute_id_b9e7c6591d0f54a_fk_adaptor_attribute_id` FOREIGN KEY (`attribute_id`) REFERENCES `adaptor_attribute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adaptor_value`
--

LOCK TABLES `adaptor_value` WRITE;
/*!40000 ALTER TABLE `adaptor_value` DISABLE KEYS */;
INSERT INTO `adaptor_value` VALUES (1,'admin',1,'UFPE Openstack Admin role'),(2,'administrator',2,'BRGB administrator role'),(3,'professor_adjunto',1,'Professor Adjunto da UFPE'),(4,'Professor',2,'BRGB Professor role'),(5,'professor_assistente',1,'Professor Assistente da UFPE'),(6,'lecturer',2,'BRGB Lecturer role'),(7,'funcionario',1,'Funcionario da UFPE'),(8,'staff',2,'BRGB Staff role'),(9,'estudante_graduacao',1,'Estudante da Graduacao UFPE'),(10,'undergrad',2,'BRGB undergraduate student role'),(11,'estudante_mestrado',1,'Estudante de Mestrado da UFPE'),(12,'msc',2,'BRGB MSc student role'),(13,'estudante_doutorado',1,'Estudante de Doutorado da UFPE'),(14,'phd',2,'BRGB PhD student role'),(15,'identity',3,'Keystone - Openstack Identity Service'),(16,'security_service',4,'Ontology Security Service'),(17,'list',6,'action list'),(18,'create',6,'action create'),(19,'read',6,'action read'),(20,'write',6,'action write'),(21,'delete',6,'action delete'),(22,'update',6,'action update'),(23,'append',6,'action append'),(24,'replace',6,'action replace'),(25,'resume',6,'action resume'),(26,'suspend',6,'action suspend'),(27,'start',6,'action start'),(28,'stop',6,'action stop'),(29,'add',6,'action add'),(30,'remove',6,'action remove'),(31,'get_service_dis',5,'action=get; resource=service'),(32,'list_services_dis',5,'action=list; resource=service'),(33,'create_service_dis',5,'action=create; resource=service'),(34,'update_service_dis',5,'action=update; resource=service'),(35,'delete_service_dis',5,'action=delete; resource=service'),(36,'get_user',5,'action=get; resource=user'),(37,'list_users',5,'action=list; resource=user'),(38,'create_user',5,'action=create; resource=user'),(39,'update_user',5,'action=update; resource=user'),(40,'delete_user',5,'action=delete; resource=user'),(41,'change_password',5,'action=update; resource=user; param=password'),(42,'get_group',5,'action=get; resource=group'),(43,'list_groups',5,'action=list; resource=group'),(44,'create_group',5,'action=create; resource=group'),(45,'update_group',5,'action=update; resource=group'),(46,'delete_group',5,'action=delete; resource=group'),(47,'list_users_in_group',5,'action=read; resource=group; param=user_list'),(48,'remove_user_from_group',5,'action=remove; resource=group; param=user'),(49,'check_user_in_group',5,'action=read; resource=group; param=user'),(50,'add_user_to_group',5,'action=add; resource=group; param=user'),(51,'get_role',5,'action=get; resource=role'),(52,'list_roles',5,'action=list; resource=role'),(53,'create_role',5,'action=create; resource=role'),(54,'update_role',5,'action=update; resource=role'),(55,'delete_role',5,'action=delete; resource=role'),(56,'service',7,'IaaS Service'),(57,'user',7,'User'),(58,'user_group',7,'Group of users'),(59,'user_role',7,'Role'),(60,'user.password',8,'User\'s password attribute'),(61,'user_list',8,'List of users in a group'),(62,'user',8,'user in a group'),(63,'root',11,'Root Role at Kent'),(64,'professor',11,'Professor Role at Kent'),(65,'staff',11,'Staff Role at Kent'),(66,'phd',11,'PhD Student at Kent'),(67,'student',11,'Student at Kent'),(68,'compute',3,'Nova - Openstack Compute Service'),(69,'network',3,'Neutron - Openstack Network Service'),(70,'create',5,'action=create'),(71,'get',5,'action=get'),(72,'update',5,'action=update'),(73,'delete',5,'action=delete'),(74,'start',5,'action=start'),(75,'stop',5,'action=stop'),(76,'reboot',5,'action=reboot'),(77,'attach_interface',5,'action=attach_interface'),(78,'detach_interface',5,'action=detach_interface'),(79,'attach_volume',5,'action=attach_interface'),(80,'detach_volume',5,'action=detach_volume'),(81,'snapshot',5,'action=snapshot'),(82,'volume_snapshot_create',5,'action=volume_snapshot_create'),(83,'volume_snapshot_delete',5,'action=volume_snapshot_delete'),(84,'compute_service',4,'Ontology Compute Service'),(85,'virtual_machine',7,'VM resource'),(86,'snapshot',7,'VM Snapshot'),(87,'virtual_hard_disk',7,'VM VHD (Volume)'),(88,'virtual_network_interface',7,'VM VNIF'),(89,'virtual_network_interface',8,'VM VNIF'),(90,'virtual_hard_disk',8,'VM VHD (Volume)');
/*!40000 ALTER TABLE `adaptor_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adaptor_valuemapping`
--

DROP TABLE IF EXISTS `adaptor_valuemapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adaptor_valuemapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apf_value_id` int(11) NOT NULL,
  `local_value_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adaptor_valuem_apf_value_id_46fbc6c2389535c5_fk_adaptor_value_id` (`apf_value_id`),
  KEY `adaptor_valu_local_value_id_2de149b25f2e7d6e_fk_adaptor_value_id` (`local_value_id`),
  CONSTRAINT `adaptor_valuem_apf_value_id_46fbc6c2389535c5_fk_adaptor_value_id` FOREIGN KEY (`apf_value_id`) REFERENCES `adaptor_value` (`id`),
  CONSTRAINT `adaptor_valu_local_value_id_2de149b25f2e7d6e_fk_adaptor_value_id` FOREIGN KEY (`local_value_id`) REFERENCES `adaptor_value` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adaptor_valuemapping`
--

LOCK TABLES `adaptor_valuemapping` WRITE;
/*!40000 ALTER TABLE `adaptor_valuemapping` DISABLE KEYS */;
INSERT INTO `adaptor_valuemapping` VALUES (1,2,1),(2,4,3),(3,6,5),(4,8,7),(5,10,9),(6,12,11),(7,14,13),(8,16,15),(9,19,31),(10,56,31),(11,17,32),(12,56,32),(13,18,33),(14,56,33),(15,22,34),(16,56,34),(17,21,35),(18,56,35),(19,19,36),(20,57,36),(21,17,37),(22,57,37),(23,18,38),(24,57,38),(25,22,39),(26,57,39),(27,21,40),(28,57,40),(29,22,41),(30,57,41),(31,60,41),(32,19,42),(33,58,42),(34,17,43),(35,58,43),(36,18,44),(37,58,44),(38,22,45),(39,58,45),(40,21,46),(41,58,46),(42,19,47),(43,58,47),(44,61,47),(45,30,48),(46,58,48),(47,62,48),(48,19,49),(49,58,49),(50,62,49),(51,29,50),(52,58,50),(53,62,50),(54,19,51),(55,59,51),(56,17,52),(57,59,52),(58,18,53),(59,59,53),(60,22,54),(61,59,54),(62,21,55),(63,59,55),(64,2,63),(65,4,64),(66,8,65),(67,14,66),(68,12,67),(69,84,68),(70,84,69),(71,85,68),(72,18,70),(73,19,71),(74,22,72),(75,21,73),(76,27,74),(77,28,75),(78,29,77),(79,89,77),(80,30,78),(81,89,78),(82,29,79),(83,90,79),(84,30,80),(85,90,80),(86,88,69);
/*!40000 ALTER TABLE `adaptor_valuemapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group__permission_id_4fef5ad9082e562f_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_6f477d0495dc7cc_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group__permission_id_4fef5ad9082e562f_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth__content_type_id_7a9d26b040f98806_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add tenant',7,'add_tenant'),(20,'Can change tenant',7,'change_tenant'),(21,'Can delete tenant',7,'delete_tenant'),(22,'Can add apf',8,'add_apf'),(23,'Can change apf',8,'change_apf'),(24,'Can delete apf',8,'delete_apf'),(25,'Can add attribute',9,'add_attribute'),(26,'Can change attribute',9,'change_attribute'),(27,'Can delete attribute',9,'delete_attribute'),(28,'Can add operator',10,'add_operator'),(29,'Can change operator',10,'change_operator'),(30,'Can delete operator',10,'delete_operator'),(31,'Can add value',11,'add_value'),(32,'Can change value',11,'change_value'),(33,'Can delete value',11,'delete_value'),(34,'Can add hierarchy',12,'add_hierarchy'),(35,'Can change hierarchy',12,'change_hierarchy'),(36,'Can delete hierarchy',12,'delete_hierarchy'),(37,'Can add attribute mapping',13,'add_attributemapping'),(38,'Can change attribute mapping',13,'change_attributemapping'),(39,'Can delete attribute mapping',13,'delete_attributemapping'),(40,'Can add operator mapping',14,'add_operatormapping'),(41,'Can change operator mapping',14,'change_operatormapping'),(42,'Can delete operator mapping',14,'delete_operatormapping'),(43,'Can add value mapping',15,'add_valuemapping'),(44,'Can change value mapping',15,'change_valuemapping'),(45,'Can delete value mapping',15,'delete_valuemapping');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_39dcb7af1eceb282_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_39dcb7af1eceb282_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_53d1cd491404ec3b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_u_permission_id_25c14b46a1f3ad31_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_permissi_user_id_158b9b204b654515_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_u_permission_id_25c14b46a1f3ad31_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `djang_content_type_id_6810a0ad9a872e7a_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_5af573cd33b17e28_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_5af573cd33b17e28_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `djang_content_type_id_6810a0ad9a872e7a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_7d0f8e1c7be181c2_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (8,'adaptor','apf'),(9,'adaptor','attribute'),(13,'adaptor','attributemapping'),(12,'adaptor','hierarchy'),(10,'adaptor','operator'),(14,'adaptor','operatormapping'),(7,'adaptor','tenant'),(11,'adaptor','value'),(15,'adaptor','valuemapping'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-01-05 21:16:52'),(2,'auth','0001_initial','2016-01-05 21:16:52'),(3,'admin','0001_initial','2016-01-05 21:16:52'),(4,'contenttypes','0002_remove_content_type_name','2016-01-05 21:16:52'),(5,'auth','0002_alter_permission_name_max_length','2016-01-05 21:16:52'),(6,'auth','0003_alter_user_email_max_length','2016-01-05 21:16:52'),(7,'auth','0004_alter_user_username_opts','2016-01-05 21:16:52'),(8,'auth','0005_alter_user_last_login_null','2016-01-05 21:16:52'),(9,'auth','0006_require_contenttypes_0002','2016-01-05 21:16:53'),(10,'sessions','0001_initial','2016-01-05 21:16:53'),(11,'adaptor','0001_initial','2016-01-05 21:37:32'),(12,'adaptor','0002_auto_20160105_2205','2016-01-05 22:06:18'),(13,'adaptor','0003_auto_20160107_1253','2016-01-07 12:53:44'),(14,'adaptor','0004_auto_20160107_1253','2016-01-07 12:53:44'),(15,'adaptor','0005_auto_20160107_1328','2016-01-07 13:28:58'),(16,'adaptor','0006_attribute_enumerated','2016-01-13 02:01:14');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-30 23:23:51
