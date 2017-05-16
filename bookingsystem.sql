-- phpMyAdmin SQL Dump
-- version 4.4.14.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2017-05-15 16:43:10
-- 服务器版本： 5.6.26
-- PHP Version: 5.5.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookingsystem`
--

-- --------------------------------------------------------

--
-- 表的结构 `bookingrecord`
--

CREATE TABLE IF NOT EXISTS `bookingrecord` (
  `bid` int(10) NOT NULL,
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `endTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tno` int(10) NOT NULL,
  `cName` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `cPhoneNumber` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `bsbooking`
--

CREATE TABLE IF NOT EXISTS `bsbooking` (
  `bid` int(10) NOT NULL,
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `endTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tno` int(10) NOT NULL,
  `cName` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `cPhoneNumber` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(3) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `bstable`
--

CREATE TABLE IF NOT EXISTS `bstable` (
  `tno` int(10) NOT NULL,
  `places` int(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bsbooking`
--
ALTER TABLE `bsbooking`
  ADD PRIMARY KEY (`bid`);

--
-- Indexes for table `bstable`
--
ALTER TABLE `bstable`
  ADD PRIMARY KEY (`tno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bsbooking`
--
ALTER TABLE `bsbooking`
  MODIFY `bid` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `bstable`
--
ALTER TABLE `bstable`
  MODIFY `tno` int(10) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
