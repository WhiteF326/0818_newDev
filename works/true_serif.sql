-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 05, 2021 at 08:26 AM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `proggame`
--

-- --------------------------------------------------------

--
-- Table structure for table `true_serif`
--

CREATE TABLE `true_serif` (
  `serif_id` int(10) NOT NULL,
  `question_no` int(10) NOT NULL,
  `file_name` varchar(30) NOT NULL,
  `file` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `true_serif`
--

INSERT INTO `true_serif` (`serif_id`, `question_no`, `file_name`, `file`) VALUES
(1, 1, '一問目正解時のセリフ', 0xe5a696e7b2bee3808ce38186e381bee3818fe58b95e38191e3828be381ade38082e38198e38283e38182e697a9e9809fe381aae38293e381a0e38191e381a9e38081e38193e38193e381abe38182e3828be382ace383a9e382afe382bfe38292e4b880e7b792e381abe78987e4bb98e38191e381a6e3818fe3828ce3828befbc9fe3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce58886e3818be3828ae381bee38197e3819fe38081e9a091e5bcb5e3828ae381bee38199e38082e3808d),
(2, 2, '二問目正解時のセリフ', 0xe5a696e7b2bee3808ce38184e38284e38181e383bce7b6bae9ba97e381abe381aae381a3e3819fe381ade38082e796b2e3828ce3819fe38197e38081e7a781e381aee5aeb6e381a7e4bc91e686a9e38197e38288e38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce58886e3818be3828ae381bee38197e3819fe38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e381aee4bdbfe38188e3828be98193e585b7e3818ce8a7a3e694bee38195e3828ce381bee38197e3819fe38082efbc9ae381aee38193e3818ee3828a2c0d0ae99a9ce5aeb3e789a9e38292e7a0b4e5a38ae381a7e3818de3828be38288e38186e381abe381aae3828ae381bee38197e3819fe380820d0a),
(3, 2, '二問目正解時のセリフ', 0xe5a696e7b2bee3808ce38284e381a3e3819fe381adefbc81e38193e381aee8aabfe5ad90e381a7e381a9e38293e381a9e38293e8a18ce3818fe38288efbc81e3808d2c0d0ae5a696e7b2bee3808ce6aca1e381afe38182e381a3e381a1e581b4e381aee382ace383a9e382afe382bfe38292e78987e4bb98e38191e38288e38186efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce4ba86e8a7a3e38184e3819fe38197e381bee38197e3819fe38082e3808d);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `true_serif`
--
ALTER TABLE `true_serif`
  ADD UNIQUE KEY `serif_id` (`serif_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `true_serif`
--
ALTER TABLE `true_serif`
  MODIFY `serif_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
