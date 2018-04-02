-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 02, 2018 at 05:12 AM
-- Server version: 5.7.9
-- PHP Version: 5.6.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `heartattackprediction`
--

-- --------------------------------------------------------

--
-- Table structure for table `contactdetails`
--

DROP TABLE IF EXISTS `contactdetails`;
CREATE TABLE IF NOT EXISTS `contactdetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `MobileNo` varchar(100) NOT NULL,
  `LocationID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `LocationID` (`LocationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `ID` int(11) NOT NULL,
  `Lat` int(11) NOT NULL,
  `Lang` int(11) NOT NULL,
  `TimeStamp` date NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`ID`, `Lat`, `Lang`, `TimeStamp`) VALUES
(1, 33000, 22222, '2018-02-09'),
(2, 3333, 4444, '2018-02-08');

-- --------------------------------------------------------

--
-- Table structure for table `medicaldata`
--

DROP TABLE IF EXISTS `medicaldata`;
CREATE TABLE IF NOT EXISTS `medicaldata` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MdicaldataType` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `medicaldatadetails`
--

DROP TABLE IF EXISTS `medicaldatadetails`;
CREATE TABLE IF NOT EXISTS `medicaldatadetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `medicalDataID` int(11) NOT NULL,
  `data` varchar(200) NOT NULL,
  `Dignose` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `medicalDataID` (`medicalDataID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
CREATE TABLE IF NOT EXISTS `report` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `medicalDetailsID` int(11) NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `userID` (`userID`),
  KEY `medicalDetailsID` (`medicalDetailsID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sensorreading`
--

DROP TABLE IF EXISTS `sensorreading`;
CREATE TABLE IF NOT EXISTS `sensorreading` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Value` int(11) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sensorreading`
--

INSERT INTO `sensorreading` (`ID`, `Value`, `TimeStamp`) VALUES
(1, 444, '2018-02-10 12:03:03'),
(2, 300, '2018-02-10 12:14:40'),
(3, 292, '2018-02-11 04:32:10');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(60) NOT NULL,
  `LastName` varchar(60) NOT NULL,
  `Age` int(11) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Email` varchar(200) NOT NULL,
  `Password` int(11) NOT NULL,
  `ContactDetailsID` int(11) NOT NULL,
  `userTypeID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `userTypeID` (`userTypeID`),
  KEY `ContactDetailsID` (`ContactDetailsID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
CREATE TABLE IF NOT EXISTS `usertype` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(60) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contactdetails`
--
ALTER TABLE `contactdetails`
  ADD CONSTRAINT `contactdetails_ibfk_1` FOREIGN KEY (`LocationID`) REFERENCES `location` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`medicalDetailsID`) REFERENCES `medicaldatadetails` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`userTypeID`) REFERENCES `usertype` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`ContactDetailsID`) REFERENCES `contactdetails` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
