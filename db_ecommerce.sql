-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.28-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando dados para a tabela db_ecommerce.tb_addresses: ~0 rows (aproximadamente)

-- Copiando dados para a tabela db_ecommerce.tb_carts: ~0 rows (aproximadamente)

-- Copiando dados para a tabela db_ecommerce.tb_cartsproducts: ~0 rows (aproximadamente)

-- Copiando dados para a tabela db_ecommerce.tb_categories: ~2 rows (aproximadamente)
INSERT INTO `tb_categories` (`idcategory`, `descategory`, `dtregister`) VALUES
	(2, 'Apple', '2023-05-03 12:36:37'),
	(3, 'Google', '2023-05-03 12:36:42');

-- Copiando dados para a tabela db_ecommerce.tb_categoriesproducts: ~0 rows (aproximadamente)
INSERT INTO `tb_categoriesproducts` (`idcategory`, `idproduct`) VALUES
	(3, 30);

-- Copiando dados para a tabela db_ecommerce.tb_orders: ~0 rows (aproximadamente)

-- Copiando dados para a tabela db_ecommerce.tb_ordersstatus: ~4 rows (aproximadamente)
INSERT INTO `tb_ordersstatus` (`idstatus`, `desstatus`, `dtregister`) VALUES
	(1, 'Em Aberto', '2017-03-13 06:00:00'),
	(2, 'Aguardando Pagamento', '2017-03-13 06:00:00'),
	(3, 'Pago', '2017-03-13 06:00:00'),
	(4, 'Entregue', '2017-03-13 06:00:00');

-- Copiando dados para a tabela db_ecommerce.tb_persons: ~3 rows (aproximadamente)
INSERT INTO `tb_persons` (`idperson`, `desperson`, `desemail`, `nrphone`, `dtregister`) VALUES
	(1, 'Joao Rangel', 'admin@hcode.com.br', 2147483647, '2017-03-01 06:00:00'),
	(7, 'Suporte', 'suporte@hcode.com.br', 1112345678, '2017-03-15 19:10:27'),
	(8, 'development', 'emailfordevelopmentt@gmail.com', 1999999999, '2023-05-02 14:40:34');

-- Copiando dados para a tabela db_ecommerce.tb_products: ~6 rows (aproximadamente)
INSERT INTO `tb_products` (`idproduct`, `desproduct`, `vlprice`, `vlwidth`, `vlheight`, `vllength`, `vlweight`, `desurl`, `dtregister`) VALUES
	(4, 'Ipad 32', 2499.99, 0.75, 16.95, 24.50, 0.47, 'ipad-32gb', '2023-05-03 13:53:51'),
	(22, 'Smartphone Motorola Moto G5 Plus', 1135.23, 15.20, 7.40, 0.70, 0.16, 'smartphone-motorola-moto-g5-plus', '2023-05-03 18:32:37'),
	(23, 'Smartphone Moto Z Play', 1887.78, 14.10, 0.90, 1.16, 0.13, 'smartphone-moto-z-play', '2023-05-03 18:32:37'),
	(24, 'Smartphone Samsung Galaxy J5 Pro', 1299.00, 14.60, 7.10, 0.80, 0.16, 'smartphone-samsung-galaxy-j5', '2023-05-03 18:32:37'),
	(25, 'Smartphone Samsung Galaxy J7 Prime', 1149.00, 15.10, 7.50, 0.80, 0.16, 'smartphone-samsung-galaxy-j7', '2023-05-03 18:32:37'),
	(26, 'Smartphone Samsung Galaxy J3 Dual', 679.90, 14.20, 7.10, 0.70, 0.14, 'smartphone-samsung-galaxy-j3', '2023-05-03 18:32:37');

-- Copiando dados para a tabela db_ecommerce.tb_productscategories: ~6 rows (aproximadamente)
INSERT INTO `tb_productscategories` (`idcategory`, `idproduct`) VALUES
	(2, 4),
	(3, 22),
	(3, 23),
	(3, 24),
	(3, 25),
	(3, 26);

-- Copiando dados para a tabela db_ecommerce.tb_users: ~2 rows (aproximadamente)
INSERT INTO `tb_users` (`iduser`, `idperson`, `deslogin`, `despassword`, `inadmin`, `dtregister`) VALUES
	(1, 1, 'admin', '$2y$12$YlooCyNvyTji8bPRcrfNfOKnVMmZA9ViM2A3IpFjmrpIbp5ovNmga', 1, '2017-03-13 06:00:00'),
	(7, 7, 'suporte', '$2y$12$HFjgUm/mk1RzTy4ZkJaZBe0Mc/BA2hQyoUckvm.lFa6TesjtNpiMe', 1, '2017-03-15 19:10:27'),
	(8, 8, 'development', '$2y$12$IsSruBMc1tveQXyvMhyWIeHHhc2Vtl7Uo/xsns/F/uC9LMZApO4QG', 1, '2023-05-02 14:40:34');

-- Copiando dados para a tabela db_ecommerce.tb_userslogs: ~0 rows (aproximadamente)

-- Copiando dados para a tabela db_ecommerce.tb_userspasswordsrecoveries: ~3 rows (aproximadamente)
INSERT INTO `tb_userspasswordsrecoveries` (`idrecovery`, `iduser`, `desip`, `dtrecovery`, `dtregister`) VALUES
	(1, 7, '127.0.0.1', NULL, '2017-03-15 19:10:59'),
	(2, 7, '127.0.0.1', '2017-03-15 13:33:45', '2017-03-15 19:11:18'),
	(3, 7, '127.0.0.1', '2017-03-15 13:37:35', '2017-03-15 19:37:12'),
	(4, 8, '127.0.0.1', NULL, '2023-05-02 14:41:06');

-- Copiando dados para a tabela db_ecommerce.users: ~0 rows (aproximadamente)
INSERT INTO `users` (`id`, `name`, `email`, `createdAt`, `updatedAt`) VALUES
	(1, 'Matheus', 'matheussilvacontat@gmail.com', '2023-04-24 16:03:02', '2023-04-24 16:03:02');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
