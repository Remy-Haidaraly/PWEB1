-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 20, 2020 at 09:05 PM
-- Server version: 5.6.20-log
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sitevehiculealouer`
--

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE IF NOT EXISTS `client` (
  `idClient` int(11) AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `mdp` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `role` varchar(20) DEFAULT 'abonné',
  PRIMARY KEY(`idClient`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=0;

INSERT INTO `client` (`nom`, `mdp`, `email`,`role`) VALUES
('admin','d033e22ae348aeb5660fc2140aec35850c4da997','','admin'),
('loueur','d794795bb0992305cdf9ee64b10f00d5d896d448','','loueur'),
('BouBouCars', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Bouboucars@locataire.com', 'abonné'),
('KentoDéménagement', 'e454b8ab9aa35427c65d84c8c7e43591ff2f553b', 'KentoDéménagement@gmail.com','abonné'),
('LorisFilms', '8fef30defdef6adc63a96b1721c8b886c62625fa', 'LouisFilms@gmail.com','abonné'),
('MarieJo', '39dfa55283318d31afe5a3ff4a0e3253e2045e43', 'MarieJo@hotmail.com','abonné'),
('Stonks', '66dbf66334e9e5f9b10aa6118b5c7038a7b2ca21', 'VeryStonks@Stonkscorp.com','abonné'),
('TainkCorp', '39dfa55283318d31afe5a3ff4a0e3253e2045e43', 'TainkCorp@gmail.com', 'abonné'),
('ecoMangue', '81fe8bfe87576c3ecb22426f8e57847382917acf', 'ecoMangue@gmail.com','abonné'),
('AroufCo', '9faaded27d838568bf73eeb9069fe1a5b83e35b2', 'AroufCo@gmail.com','abonné'),
('HeenokRoi', '481902ec14eaf3fcfec6be82bd6a63b972ac517f', 'RoiHeenok@hotmail.com','abonné'),
('SunAndLeo', 'f7006ba4da6323bbab644ad046089f5705b99e76', 'Leo@Stonkscorp.com','abonné');

-- --------------------------------------------------------

--
-- Table structure for table `facturation`
--

CREATE TABLE IF NOT EXISTS `facturation` (
`idFacturation` int(11) NOT NULL AUTO_INCREMENT,
  `idClient` int(11) NOT NULL,
  `idVehicule` int(11) NOT NULL,
  `dateD` date NOT NULL,
  `dateF` date,
  `valeur` int(11) NOT NULL,
  `etat` tinyint(1) NOT NULL,
  FOREIGN KEY(`idClient`) REFERENCES client(`idClient`),
  FOREIGN KEY(`idVehicule`) REFERENCES vehicule(`idVehicule`),
  PRIMARY KEY(`idFacturation`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

INSERT INTO `facturation` (`idClient`, `idVehicule`, `DateD`, `DateF`,`valeur`, `etat`) VALUES
('7','1','2020-11-01', '2022-11-01', 21900, 1),
('6','2','2020-11-01', '2021-01-01', 7200, 0),
('3','3','2020-12-15', '2021-01-15', 2700, 0),
('3','4','2020-12-15', '2020-01-01', 750, 1),
('4','5','2020-11-10', '2020-11-20', 1390, 0),
('5','6','2021-03-1', '2021-03-07', 490, 1),
('3','7','2020-11-01', '2020-11-25', 3750, 1);


-- --------------------------------------------------------

--
-- Table structure for table `vehicule`
--

CREATE TABLE IF NOT EXISTS `vehicule` (
`idVehicule` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  `caracteristique` varchar(400) NOT NULL,
  `location` varchar(50) NOT NULL,
  `photo` varchar(200) NOT NULL,
  `prix` float(11) NOT NULL,
  PRIMARY KEY(`idVehicule`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;


--
-- Dumping data for table `vehicule`
--

INSERT INTO `vehicule` (`type`, `caracteristique`, `location`, `photo`, `prix`) VALUES
('Lexus LS', '{"moteur":"essence","vitesse":"manuele"}', '7', 'LexusLS', 30),
('Mercedes Classe S', '{"moteur":"essence","vitesse":"manuelle"}', '6', 'mercedesClasseS', 120),
('Bentley Bentayga', '{"moteur":"hybride","vitesse":"automatique"}', '3', 'BentleyBentayga', 90),
('Bentley Continent GT', '{"moteur":"diesel","vitesse":"manuelle"}', '3', 'BentleyContinentGT', 50),
('Rolls Royce Phantom', '{"moteur":"hybride","vitesse":"automatique"}', '4', 'RollsRoycePhantom',139),
('Porshe 911 GT3', '{"moteur":"diesel","vitesse":"automatique"}', '5', 'Porshe911GT3', 70),
('Mercedes Classe S ', '{"moteur":"essence","vitesse":"manuelle"}', '3', 'mercedesClasseS', 150),
('Porshe Panamera ', '{"moteur":"électrique","vitesse":"manuelle"}', 'disponible', 'PorshePanamera', 110),
('Audi A8', '{"moteur":"électrique","vitesse":"manuelle"}', 'disponible', 'AudiA8', 100),
('Lexus LS', '{"moteur":"électrique","vitesse":"automatique"}', 'disponible', 'LexusLS', 30),
('Mercedes Classe S ', '{"moteur":"essence","vitesse":"automatique"}', 'disponible', 'mercedesClasseS', 150),
('Porshe Panamera ', '{"moteur":"essence","vitesse":"manuelle"}', 'disponible', 'PorshePanamera', 190),
('Range Rover ', '{"moteur":"essence","vitesse":"manuelle"}', 'disponible', 'RangeRover',150);
;

--
-- Indexes for dumped tables
--

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
