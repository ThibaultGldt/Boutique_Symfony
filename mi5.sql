-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : Dim 20 fév. 2022 à 19:34
-- Version du serveur :  5.7.31
-- Version de PHP : 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `mi5`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visuel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `texte` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id`, `libelle`, `visuel`, `texte`) VALUES
(1, 'Fruits', 'images/fruits.jpg', 'De la passion ou de ton imagination'),
(2, 'Légumes', 'images/legumes.jpg', 'Plus tu en manges, moins tu en es un'),
(3, 'Junk Food', 'images/junk_food.jpg', 'Chère et cancérogène, tu es prévenu(e)');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usager_id` int(11) DEFAULT NULL,
  `date_commande` date NOT NULL,
  `statut` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6EEAA67D4F36F0FC` (`usager_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `usager_id`, `date_commande`, `statut`) VALUES
(1, 1, '2022-02-02', 'En traitement'),
(2, 1, '2022-02-02', 'En traitement'),
(3, 1, '2022-02-02', 'En traitement'),
(4, 1, '2022-02-02', 'En traitement'),
(5, 1, '2022-02-02', 'En traitement'),
(6, 1, '2022-02-02', 'En traitement'),
(7, 1, '2022-02-02', 'En traitement'),
(8, 1, '2022-02-02', 'En traitement'),
(9, 1, '2022-02-02', 'En traitement'),
(10, 1, '2022-02-02', 'En traitement'),
(11, 1, '2022-02-02', 'En traitement'),
(12, 1, '2022-02-02', 'En traitement'),
(13, 1, '2022-02-03', 'En traitement'),
(14, 1, '2022-02-03', 'En traitement'),
(15, 1, '2022-02-03', 'En traitement'),
(16, 1, '2022-02-03', 'En traitement'),
(17, 1, '2022-02-03', 'En traitement'),
(18, 1, '2022-02-03', 'En traitement'),
(19, 1, '2022-02-03', 'En traitement'),
(20, 1, '2022-02-03', 'En traitement'),
(21, 1, '2022-02-03', 'En traitement'),
(22, 1, '2022-02-03', 'En traitement'),
(23, 1, '2022-02-03', 'En traitement'),
(24, 1, '2022-02-03', 'En traitement'),
(25, 1, '2022-02-03', 'En traitement'),
(26, 1, '2022-02-03', 'En traitement'),
(27, 1, '2022-02-03', 'En traitement'),
(28, 1, '2022-02-03', 'En traitement'),
(29, 1, '2022-02-03', 'En traitement'),
(30, 1, '2022-02-03', 'En traitement'),
(31, 1, '2022-02-04', 'En traitement'),
(32, 1, '2022-02-04', 'En traitement'),
(33, 1, '2022-02-07', 'En traitement'),
(34, 3, '2022-02-07', 'En traitement'),
(35, 6, '2022-02-08', 'En traitement'),
(36, 6, '2022-02-08', 'En traitement'),
(37, 6, '2022-02-08', 'En traitement'),
(38, 6, '2022-02-08', 'En traitement'),
(39, 6, '2022-02-08', 'En traitement'),
(40, 6, '2022-02-08', 'En traitement'),
(41, 6, '2022-02-08', 'En traitement'),
(42, 6, '2022-02-16', 'En traitement');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20220118141618', '2022-01-18 14:19:31', 174),
('DoctrineMigrations\\Version20220201124820', '2022-02-01 12:48:57', 78),
('DoctrineMigrations\\Version20220201144828', '2022-02-01 14:48:44', 330);

-- --------------------------------------------------------

--
-- Structure de la table `ligne_commande`
--

DROP TABLE IF EXISTS `ligne_commande`;
CREATE TABLE IF NOT EXISTS `ligne_commande` (
  `commande_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `quantite` int(11) DEFAULT NULL,
  `prix` double DEFAULT NULL,
  PRIMARY KEY (`commande_id`,`article_id`),
  KEY `IDX_3170B74B82EA2E54` (`commande_id`),
  KEY `IDX_3170B74B7294869C` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ligne_commande`
--

INSERT INTO `ligne_commande` (`commande_id`, `article_id`, `quantite`, `prix`) VALUES
(2, 2, 1, 2.11),
(2, 4, 1, 2.9),
(2, 6, 1, 1.81),
(12, 5, 2, 3.4),
(13, 6, 1, 1.81),
(14, 5, 1, 1.7),
(19, 5, 1, 1.7),
(21, 5, 1, 1.7),
(22, 5, 1, 1.7),
(24, 8, 1, 8.25),
(26, 5, 1, 1.7),
(27, 5, 1, 1.7),
(29, 9, 1, 2.5),
(31, 8, 8, 66),
(32, 5, 1, 1.7),
(33, 3, 14, 39.76),
(35, 5, 4, 6.8),
(35, 9, 1, 2.5),
(41, 5, 2, 3.4),
(42, 4, 1, 2.9);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categorie_id` int(11) NOT NULL,
  `libelle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visuel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `texte` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prix` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_29A5EC27BCF5E72D` (`categorie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `categorie_id`, `libelle`, `visuel`, `texte`, `prix`) VALUES
(1, 1, 'Pomme', 'images/pommes.jpg', 'Elle est bonne pour la tienne', 3.42),
(2, 1, 'Poire', 'images/poires.jpg', 'Ici tu n\'en es pas une', 2.11),
(3, 1, 'Pêche', 'images/peche.jpg', 'Elle va te la donner', 2.84),
(4, 2, 'Carotte', 'images/carottes.jpg', 'C\'est bon pour ta vue', 2.9),
(5, 2, 'Tomate', 'images/tomates.jpg', 'Fruit ou Légume ? Légume', 1.7),
(6, 2, 'Chou Romanesco', 'images/romanesco.jpg', 'Mange des fractales', 1.81),
(7, 3, 'Nutella', 'images/nutella.jpg', 'C\'est bon, sauf pour ta santé', 4.5),
(8, 3, 'Pizza', 'images/pizza.jpg', 'Y\'a pas pire que za', 8.25),
(9, 3, 'Oreo', 'images/oreo.jpg', 'Seulement si tu es un smartphone', 2.5);

-- --------------------------------------------------------

--
-- Structure de la table `usager`
--

DROP TABLE IF EXISTS `usager`;
CREATE TABLE IF NOT EXISTS `usager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_3CDC65FFE7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `usager`
--

INSERT INTO `usager` (`id`, `email`, `roles`, `password`, `nom`, `prenom`) VALUES
(1, 'test@test.fr', '[]', 'test', 'test', 'test'),
(3, 'mi5@iut2.fr', '[\"ROLE_ADMIN\"]', '$2y$13$GKrsCgTNF924P6R9iEeUr.Qdank6WsSx9Khe4lI/TVJ2hFU3UfsoC', 'mi5', 'mi5'),
(4, '1234@567.fr', '[]', '$2y$13$NPalBhbO1qJ.ff.seBHXduu.A7YS6xfGg73Vz4kOYEeuSwtJA7/Ou', '123', '456'),
(5, 'afaf@afaf.afaf', '[\"ROLE_CLIENT\"]', '$2y$13$zLnVc9iXk2.Il3DY5spH..pboItUJxbb22Yty/7mK5M.n93oeIDkq', 'afaf', 'afaf'),
(6, 'glandutthibault@gmail.com', '[\"ROLE_CLIENT\"]', '$2y$13$biiwV54TQM3emqJTVF2JMeSvktOB5ZEWbw15zXX8eZnqED21zvRea', 'glandut', 'thibault'),
(7, 'AAA@BBB.fr', '[\"ROLE_CLIENT\"]', '$2y$13$B1mb2AAv.73PTV7bAB7rWeipZangxSqhuWEign6ci4CVwZO7Rn/0y', 'testcaptcha', 'captchatest');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `FK_6EEAA67D4F36F0FC` FOREIGN KEY (`usager_id`) REFERENCES `usager` (`id`);

--
-- Contraintes pour la table `ligne_commande`
--
ALTER TABLE `ligne_commande`
  ADD CONSTRAINT `FK_3170B74B7294869C` FOREIGN KEY (`article_id`) REFERENCES `produit` (`id`),
  ADD CONSTRAINT `FK_3170B74B82EA2E54` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`id`);

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `FK_29A5EC27BCF5E72D` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
