-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 15, 2021 at 12:28 AM
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
-- Database: `laa1355306-proggame`
--

-- --------------------------------------------------------

--
-- Table structure for table `false_serif`
--

CREATE TABLE `false_serif` (
  `serif_id` int(10) NOT NULL,
  `question_no` int(10) NOT NULL,
  `file_name` varchar(30) NOT NULL,
  `file` blob NOT NULL,
  `back_img` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `false_serif`
--

INSERT INTO `false_serif` (`serif_id`, `question_no`, `file_name`, `file`, `back_img`) VALUES
(1, 1, '一問目不正解時のセリフ', 0xe5a696e7b2bee3808ce38389e383b3e3839ee382a4efbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d, 'image/morigarakuta.png'),
(2, 2, '二問目不正解時のセリフ', 0xe5a696e7b2bee3808ce9a091e5bcb5e3828cefbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d, 'image/morigarakuta.png'),
(3, 3, '三問目不正解時のセリフ', 0xe5a696e7b2bee3808ce6839ce38197e38184efbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186e38082e3808d, 'image/youseihousetree.png'),
(4, 4, '四問目不正解時のセリフ', 0xe5a696e7b2bee3808ce38389e383b3e3839ee382a4efbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d, 'image/mori.png'),
(5, 5, '五問目正解時のセリフ', 0xe5a696e7b2bee3808ce9a091e5bcb5e3828cefbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d, 'image/karehana.png');

-- --------------------------------------------------------

--
-- Table structure for table `freemode_results`
--

CREATE TABLE `freemode_results` (
  `id` int(11) NOT NULL,
  `userid` varchar(16) NOT NULL,
  `stagename` int(10) NOT NULL,
  `score` int(10) NOT NULL,
  `cost` int(10) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `freemode_results`
--

INSERT INTO `freemode_results` (`id`, `userid`, `stagename`, `score`, `cost`, `date`, `deleted`) VALUES
(1, 'test', 2, 810, 8, '2021-10-01 09:48:39', 1),
(2, 'test', 5, 810, 16, '2021-10-01 09:49:42', 1),
(3, 'test', 5, 810, 15, '2021-10-01 09:49:42', 1),
(4, 'test', 1, 0, 8, '2021-10-01 16:24:57', 1),
(5, 'test', 7, 0, 15, '2021-10-01 16:25:28', 1),
(6, 'test', 2, 0, 9, '2021-10-04 10:36:22', 1),
(7, 'test', 2, 0, 9, '2021-10-04 10:50:23', 1),
(8, 'test', 2, 0, 9, '2021-10-04 16:48:23', 1),
(9, 'test', 17, 0, 12, '2021-10-05 11:04:53', 1),
(10, 'test', 17, 0, 12, '2021-10-05 11:05:02', 1),
(11, 'test', 17, 0, 12, '2021-10-05 11:05:29', 1),
(12, 'test', 17, 0, 12, '2021-10-05 11:05:39', 1),
(13, 'test', 17, 0, 12, '2021-10-05 11:06:52', 1),
(14, 'test', 17, 0, 12, '2021-10-05 11:11:10', 1),
(15, 'test', 17, 0, 12, '2021-10-05 11:11:43', 1),
(16, 'test', 17, 0, 12, '2021-10-05 11:12:11', 1),
(17, 'test', 17, 0, 12, '2021-10-05 11:12:27', 1),
(18, 'test', 17, 0, 12, '2021-10-05 11:14:24', 1),
(33, 'test', 1, 0, 8, '2021-10-05 16:35:53', 1),
(34, 'test', 1, 0, 8, '2021-10-05 16:42:25', 1),
(35, 'test', 1, 0, 8, '2021-10-05 16:42:29', 1),
(36, 'test', 1, 0, 8, '2021-10-05 16:42:36', 1),
(37, 'test', 1, 0, 8, '2021-10-05 16:51:49', 1),
(39, 'test', 1, 0, 8, '2021-10-05 16:55:20', 1),
(40, 'test', 1, 0, 8, '2021-10-05 17:24:33', 1),
(41, 'test', 1, 0, 8, '2021-10-05 17:27:55', 1),
(42, 'test', 1, 0, 8, '2021-10-05 17:28:06', 1),
(43, 'test', 1, 0, 8, '2021-10-05 17:28:32', 1),
(44, 'test4', 1, 0, 8, '2021-10-05 17:44:07', 0),
(45, 'test4', 5, 0, 9, '2021-10-05 17:44:32', 0),
(47, 'test4', 20, 0, 8, '2021-10-05 17:46:28', 0),
(48, 'test', 1, 0, 8, '2021-10-06 11:39:33', 1),
(49, 'test', 1, 0, 8, '2021-10-06 11:39:46', 1),
(50, 'test', 3, 0, 9, '2021-10-06 11:40:39', 1),
(51, 'test', 1, 0, 8, '2021-10-06 11:40:48', 1),
(52, 'test', 1, 0, 8, '2021-10-07 10:10:46', 1),
(53, 'test', 1, 0, 8, '2021-10-07 10:11:21', 1),
(54, 'test', 1, 0, 8, '2021-10-07 10:12:16', 1),
(55, 'test', 1, 0, 8, '2021-10-07 10:16:38', 1),
(56, 'test', 1, 0, 8, '2021-10-07 10:17:14', 1),
(57, 'fucker', 1, 0, 0, '2021-10-08 10:24:10', 1),
(58, 'fucker', 1, 0, 8, '2021-10-08 10:32:47', 0),
(59, 'fucker', 1, 0, 8, '2021-10-08 10:33:02', 0),
(60, 'fucker', 1, 0, 8, '2021-10-08 10:52:30', 0),
(61, 'test', 1, 0, 8, '2021-10-11 13:24:31', 1),
(62, 'test', 2, 0, 9, '2021-10-11 13:25:10', 1),
(63, 'test', 1, 0, 8, '2021-10-11 15:03:52', 1),
(64, 'test', 1, 0, 8, '2021-10-11 15:05:48', 1),
(65, 'test', 1, 0, 8, '2021-10-11 15:05:56', 1),
(66, 'test', 1, 0, 8, '2021-10-11 15:08:02', 1),
(67, 'test', 1, 0, 8, '2021-10-11 15:08:15', 1),
(68, 'test', 2, 0, 9, '2021-10-11 15:31:13', 1),
(69, 'test', 1, 0, 0, '2021-10-11 16:07:35', 1),
(70, 'test', 1, 0, 8, '2021-10-11 16:08:11', 1),
(71, 'test', 1, 0, 8, '2021-10-12 16:21:39', 1),
(72, 'test', 27, 0, 0, '2021-10-12 16:58:17', 1),
(73, 'test', 1, 0, 8, '2021-10-13 10:33:02', 1),
(74, 'test', 2, 0, 9, '2021-10-13 10:33:15', 1),
(75, 'test', 3, 0, 9, '2021-10-13 10:33:34', 1),
(76, 'test', 4, 0, 12, '2021-10-13 10:33:58', 1),
(77, 'test', 5, 0, 12, '2021-10-13 10:34:53', 1),
(78, 'test', 6, 0, 13, '2021-10-13 10:35:24', 1),
(79, 'test', 16, 0, 0, '2021-10-13 10:40:03', 1),
(80, 'test', 1, 0, 0, '2021-10-13 11:43:14', 1),
(81, 'test', 1, 0, 8, '2021-10-13 11:43:30', 1),
(82, 'test', 1, 0, 8, '2021-10-13 11:47:38', 1),
(83, 'test', 2, 0, 9, '2021-10-13 11:47:45', 1),
(84, 'test', 3, 0, 9, '2021-10-13 11:47:51', 1),
(85, 'test', 4, 0, 12, '2021-10-13 11:47:56', 1),
(86, 'test', 5, 0, 12, '2021-10-13 11:48:02', 1),
(87, 'test', 6, 0, 13, '2021-10-13 11:48:08', 1),
(88, 'test', 1, 0, 8, '2021-10-13 11:49:31', 1),
(89, 'test', 2, 0, 9, '2021-10-13 11:49:36', 1),
(90, 'test', 3, 0, 9, '2021-10-13 11:49:41', 1),
(91, 'test', 4, 0, 12, '2021-10-13 11:49:45', 1),
(92, 'test', 5, 0, 12, '2021-10-13 11:49:49', 1),
(93, 'test', 6, 0, 13, '2021-10-13 11:49:53', 1),
(94, 'test', 9, 0, 16, '2021-10-13 11:50:16', 1),
(95, 'test', 16, 0, 0, '2021-10-13 11:51:50', 1),
(96, 'test', 16, 0, 0, '2021-10-13 11:53:00', 1),
(97, 'test', 16, 0, 8, '2021-10-13 11:53:26', 1),
(98, 'test', 1, 0, 8, '2021-10-13 11:57:16', 1),
(99, 'test', 3, 0, 9, '2021-10-13 11:57:22', 1),
(100, 'test', 12, 0, 14, '2021-10-13 11:57:57', 1),
(101, 'test', 1, 0, 8, '2021-10-13 12:15:05', 1),
(102, 'test', 1, 0, 8, '2021-10-13 12:42:52', 0),
(103, 'test', 1, 0, 0, '2021-10-13 14:34:08', 0),
(104, 'test', 1, 0, 8, '2021-10-13 14:34:32', 0),
(105, 'test', 1, 0, 0, '2021-10-13 15:45:04', 0),
(106, 'test', 1, 0, 8, '2021-10-13 15:47:30', 0),
(107, 'test', 1, 0, 0, '2021-10-13 16:00:05', 0),
(108, 'test', 1, 0, 0, '2021-10-13 17:07:17', 0),
(109, 'test', 1, 0, 8, '2021-10-13 17:07:53', 0),
(110, 'test', 1, 0, 0, '2021-10-13 17:15:34', 0),
(111, 'test', 1, 0, 8, '2021-10-13 17:16:08', 0),
(112, 'test', 3, 0, 9, '2021-10-13 17:16:42', 0),
(113, 'test', 9, 0, 16, '2021-10-13 17:16:50', 0),
(114, 'test', 11, 0, 15, '2021-10-13 17:17:03', 0),
(115, 'test', 1, 0, 0, '2021-10-14 09:35:43', 0),
(116, 'test', 1, 0, 0, '2021-10-14 09:38:10', 0),
(117, 'test', 1, 0, 8, '2021-10-14 09:40:37', 0);

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `serif_id` int(11) NOT NULL,
  `serif_file` blob NOT NULL,
  `face_file` blob NOT NULL,
  `serif_name` varchar(20) NOT NULL,
  `back_img` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id`, `serif_id`, `serif_file`, `face_file`, `serif_name`, `back_img`) VALUES
(1, 1, 0x2d2de38193e38193e381afe983bde5b882e9968be799bae3818ce980b2e381bfe38081e5b7a5e6a5ade3818ce79b9be38293e381abe381aae381a3e3819fe3819be38184e381a7e88d92e5bb83e38197e381a6e38197e381bee381a3e3819fe6a3ae2c0d0ae6a3aee381a7e381afe69ca8e38085e3818ce69eafe3828ce38081e382ace383a9e382afe382bfe3818ce68da8e381a6e38289e3828ce381a6e38184e3828b2c0d0ae3819de38293e381aae6a3aee38292e5a696e7b2bee381a8e382a2e383b3e38389e383ade382a4e38389e3818ce58d94e58a9be38197e381a6e6a3aee38292e5bea9e6b4bbe38195e3819be3828be789a9e8aa9e2d2d2c0d0ae5a696e7b2bee3808ce381bee3819fe382ace383a9e382afe382bfe3818ce68da8e381a6e38289e3828ce381a6e3828befbc81e698a8e697a5e9a091e5bcb5e381a3e381a6e7b6bae9ba97e381abe38197e3819fe381aee381abefbc81e3808d2c0d0ae5a696e7b2bee3808ce280a6e381a3e381a6e38182e3828cefbc9fe4babae99693efbc9fe3818ae383bce38184e38081e5a4a7e4b888e5a4abefbc9fe3808d2c0d0ae280a6e3839de38381e383832c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce5889de38281e381bee38197e381a6e38082e3818ae4b896e8a9b1e59e8be382a2e383b3e38389e383ade382a4e38389e381aee382a4e382a2e381a8e794b3e38197e381bee38199e38082e3808d2c0d0ae5a696e7b2bee3808ce38182e38081e382a2e383b3e38389e383ade382a4e38389efbc9fe3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce381afe38184e38082e5aeb6e4ba8be585a8e888ace381afe38282e381a1e3828de38293e381aee38193e381a8e38081e58a9be4bb95e4ba8be38282e587bae69da5e381bee38199e381aee381a7e4bd95e381aae3828ae381a8e3818ae794b3e38197e4bb98e38191e3818fe381a0e38195e38184e38082e3808d2c0d0ae5a696e7b2bee3808ce381b8e38187efbd9ee38199e38194e38184e38198e38283e38293efbc81e381a8e38193e3828de381a7e38081e381aae38293e381a7e38193e38293e381aae381a8e38193e3828de381abe38184e3828be381aeefbc9fe3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce280a6e38199e381bfe381bee3819be38293e38082e8a898e686b6e383a1e383a2e383aae3818ce5889de69c9fe58c96e38195e3828ce381a6e38197e381bee381a3e381a6e38184e3828be381aee381a7e9818ee58ebbe381aee38193e381a8e3818ce58886e3818be3828ae381bee3819be38293e38082e3808d2c0d0ae5a696e7b2bee3808ce38288e3818fe3828fe3818be38293e381aae38184e38191e381a9e38081e8a898e686b6e381aae3818fe38197e381a1e38283e381a3e3819fe381bfe3819fe38184e381ade38082e38186e383bce38293e280a6e3808d2c0d0ae5a696e7b2bee3808ce38198e38283e38182e38081e38193e381aee6a3aee38292e5bea9e6b4bbe38199e3828be3818ae6898be4bc9de38184e4b880e7b792e381abe38199e3828befbc9fe381aae38293e3818be38284e381a3e381a6e3819fe38289e6809de38184e587bae38199e3818be38282e38197e3828ce381aae38184e38197e38082e3808d2c0d0ae5a696e7b2bee3808ce381bee3819ae38081e38193e38193e381abe38182e3828be382ace383a9e382afe382bfe38292e78987e4bb98e38191e381a6e3818fe3828ce3828befbc9fe3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce58886e3818be3828ae381bee38197e3819fe38081e9a091e5bcb5e3828ae381bee38199e38082e3808d, 0x302c302c302c352c342c302c312c332c322c332c342c312c312c312c31, 'オープニングとステージ１', 'image/morigarakuta.png'),
(2, 2, 0xe5a696e7b2bee3808ce38195e38181e79d80e38184e3819fe38288e38081e38193e38193e3818ce7a781e3818ce4bd8fe38293e381a7e38184e3828be5aeb6e38082e3818ae38184e38197e38184e7b485e88cb6e381a7e38282e9a3b2e38293e381a7e4bc91e686a9e38197e381bee38197e38287efbc81e3808d2c0d0ae5a696e7b2bee3808ce381a3e381a6e38188e38188efbc81efbc9fe69ca8e3818ce58092e3828ce381a6e3828befbc81e38193e381aee381bee381bee38198e38283e5aeb6e381abe585a5e3828ce381aae38184e38288efbd9ee3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce69ca8e38292e5a38ae38197e381a6e98193e38292e9968be3818de381bee38197e38287e38186e38081e7a781e381abe4bbbbe3819be381a6e3818fe381a0e38195e38184e38082e3808d2c0d0ae5a696e7b2bee3808ce58886e3818be381a3e3819fe38081e9a091e5bcb5e381a3e381a6e381adefbc81e3808d, 0x322c332c312c31, 'ステージ２', 'image/youseihousetree.png'),
(3, 3, 0xe382a2e383b3e38389e383ade382a4e38389e3808ce7b485e88cb6e3818ae38184e38197e3818be381a3e3819fe381a7e38199e38081e38194e381a1e3819de38186e38195e381bee381a7e38197e3819fe38082e3808d2c0d0ae5a696e7b2bee3808ce38184e38184e381aee38184e38184e381aee38082e58aa9e38191e381a6e38282e38289e381a3e3819fe38197e381ade38082e3819de3828ce38198e38283e6aca1e381aee4bd9ce6a5ade381abe280a6e3808d2c0d0ae382b0e383abe383abe383abe383abe280a62c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce38193e381aee58b95e789a9e3819fe381a1e381afefbc9fe38184e381bee381abe38282e8a5b2e381a3e381a6e3818de3819de38186e381a7e38199e38191e381a9e280a6e3808d2c0d0ae5a696e7b2bee3808ce6a3aee3818ce69eafe3828ce381a6e38197e381bee381a3e3819fe381aee3818ce58e9fe59ba0e381a7e78b82e69ab4e58c96e38197e381a6e38197e381bee381a3e3819fe381aee38082e3808d2c0d0ae382ace382a6e382ace382a6e38383efbc812c0d0ae5a696e7b2bee3808ce381b2e381a8e381bee3819ae38193e38193e381afe98083e38192e38288e38186efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce381afe38081e381afe38184efbc81e3808d, 0x322c312c302c342c312c302c352c35, 'ステージ３', 'image/doubutu.png'),
(4, 4, 0xe5a696e7b2bee3808ce38193e381aee5ba83e5a0b4e381abe381afe88ab1e3818ce6a48de38188e381a6e38182e381a3e3819fe38293e381a0e38191e381a9e38081e69eafe3828ce381a6e38197e381bee381a3e3819fe3818be38289e696b0e38197e3818fe6a48de38188e381a6e38184e38193e38186efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce699aee9809ae381aee88ab1e38288e3828ae5a4a7e3818de38184e38293e381a7e38199e381ade38082e3808d2c0d0ae5a696e7b2bee3808ce38193e381aee88ab1e381abe381afe38081e591a8e3828ae381aee6a48de789a9e381abe6a084e9a48ae38292e58886e38191e4b88ee38188e381a6e38184e3828be3818be38289e5a4a7e3818de38184e381aee38082e3808d2c0d0ae5a696e7b2bee3808ce4ba8ce4babae381a7e9a091e5bcb5e381a3e381a6e6a48de38188e381a6e38184e38193e38186efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce381afe38184efbc81e3808d, 0x312c312c312c322c32, 'ステージ４', 'image/karehana.png');

-- --------------------------------------------------------

--
-- Table structure for table `true_serif`
--

CREATE TABLE `true_serif` (
  `serif_id` int(10) NOT NULL,
  `question_no` int(10) NOT NULL,
  `file_name` varchar(30) NOT NULL,
  `file` blob NOT NULL,
  `back_img` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `true_serif`
--

INSERT INTO `true_serif` (`serif_id`, `question_no`, `file_name`, `file`, `back_img`) VALUES
(1, 1, '一問目正解時のセリフ', 0xe5a696e7b2bee3808ce38284e381a3e3819fe381adefbc81e38193e381aee8aabfe5ad90e381a7e381a9e38293e381a9e38293e8a18ce3818fe38288efbc81e3808d2c0d0ae5a696e7b2bee3808ce6aca1e381afe38182e381a3e381a1e581b4e381aee382ace383a9e382afe382bfe38292e78987e4bb98e38191e38288e38186efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce4ba86e8a7a3e38184e3819fe38197e381bee38197e3819fe38082e3808d, 'image/morigarakuta.png'),
(2, 2, '二問目正解時のセリフ', 0xe5a696e7b2bee3808ce38184e38284e38181e383bce7b6bae9ba97e381abe381aae381a3e3819fe381ade38082e796b2e3828ce3819fe38197e38081e7a781e381aee5aeb6e381a7e4bc91e686a9e38197e38288e38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce58886e3818be3828ae381bee38197e3819fe38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e381aee4bdbfe38188e3828be98193e585b7e3818ce8a7a3e694bee38195e3828ce381bee38197e3819fe38082efbc9ae381aee38193e3818ee3828a2c0d0ae99a9ce5aeb3e789a9e38292e7a0b4e5a38ae381a7e3818de3828be38288e38186e381abe381aae3828ae381bee38197e3819fe380820d0a, 'image/mori.png'),
(3, 3, '三問目正解時のセリフ', 0xe5a696e7b2bee3808ce38284e381a3e3819fefbc81e98193e3818ce9968be38184e3819fefbc81e38182e3828ae3818ce381a8e38186e38081e382a4e382a2e38082e7b485e88cb6e38194e381a1e3819de38186e38199e3828be38288e38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce38182e3828ae3818ce381a8e38186e38081e38186e3828ce38197e38184e381a7e38199e38082e3808d, 'image/youseihouse.png'),
(4, 4, '四問目正解時のセリフ', 0xe5a696e7b2bee3808ce38282e38186e8bfbde381a3e381a6e38193e381aae38184e3818be381aae38081e889afe3818be381a3e3819fefbd9ee38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce38182e381aee58b95e789a9e3819fe381a1e38292e3818ae381a8e381aae38197e3818fe38195e3819be3828be696b9e6b395e381afe381aae38184e38293e381a7e38199e3818befbc9fe3808d2c0d0ae5a696e7b2bee3808ce6a3aee38292e5bea9e6b4bbe38195e3819be3828ce381b0e3818ae381a8e381aae38197e3818fe381aae3828be381a8e6809de38186e38082e697a9e3818fe696b9e6b395e38292e8a68be381a4e38191e381aae3818fe381a1e38283e38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce3819de38186e381a7e38199e381ade38081e7a781e38282e7b2bee4b880e69dafe3818ae6898be4bc9de38184e38197e381bee38199e38082e3808d, 'image/mori.png'),
(5, 5, '五問目正解時のセリフ', 0xe5a696e7b2bee3808ce7b6bae9ba97e381aae88ab1e3818ce592b2e38184e3819fe381adefbc81e38284e381a3e3819fe38181efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce38193e3828ce381a7e6a3aee381aee5bea9e6b4bbe381abe8bf91e381a5e38184e381a6e3818de381bee38197e3819fe381ade38082e3808d2c0d0ae5a696e7b2bee3808ce3819de38186e381a0e381ade38081e6aca1e381aee4bd9ce6a5ade38282e9a091e5bcb5e3828de38186efbc81e3808d, 'image/kireihana.png');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `pass` varchar(512) NOT NULL,
  `story_progress` int(100) NOT NULL DEFAULT '0',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sfx_volume` int(3) NOT NULL DEFAULT '50',
  `bgm_volume` int(3) NOT NULL DEFAULT '50',
  `gamespeed` int(1) NOT NULL DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `pass`, `story_progress`, `update_time`, `sfx_volume`, `bgm_volume`, `gamespeed`) VALUES
('fucker', 'fucker', 'ccd14f620511ee570241a91e39959fcaf8634c25c914cb87091c7486db761b3304f8aa83f82533b7ac71f82578320bcfa96490e814ab6ae432bc8609e8691fa6', 1, '2021-10-07 17:01:54', 50, 50, 3),
('Shiroha_F16', 'Mitta', '182052b9a60f4b3147502dda2337f948a26e93936c7e698e6393989bf37eb8f570332f79d3becfdaafc585e6c4cd3a93174a00aca5de408dae7bdb27aeb67de3', 0, '2021-09-30 09:34:50', 50, 50, 3),
('test', 'tester', 'ad541694138dc60e3e90eaed5e8699d83cc6081b96ca997e5483699e210433125625f4f771fa4f048e4158badaf6ec35e47b4316574c2147b5bc88fddf68fab9', 1, '2021-09-29 12:28:07', 55, 55, 2),
('test123', 'test123', '3cb389b3cca91f68d72e2c72635c6e15867050e1ca1585c87654ebe474614a8f75e9cf26253725c03eb02454684468570baf7678970f5fffcac2c7cc8ba39060', 0, '2021-10-06 16:55:57', 50, 50, 3),
('test124', 'test124', '23f2fb4f72611f66ccd1b0dca19c16904e754791ade873031ecfdadfb2efe19d8a007807e0744a30d41bc56f498ffe7a3e1f0f2012c745d813a1da467cabfae9', 0, '2021-10-06 17:01:20', 50, 50, 3),
('test2', 'tester2', 'ad541694138dc60e3e90eaed5e8699d83cc6081b96ca997e5483699e210433125625f4f771fa4f048e4158badaf6ec35e47b4316574c2147b5bc88fddf68fab9', 1, '2021-10-05 17:42:17', 50, 50, 3),
('test3', 'tester3', 'ad541694138dc60e3e90eaed5e8699d83cc6081b96ca997e5483699e210433125625f4f771fa4f048e4158badaf6ec35e47b4316574c2147b5bc88fddf68fab9', 2, '2021-10-05 17:42:17', 50, 50, 3),
('test4', 'tester4', '96f1673ea94d0bfd334d0e280759e272b6e572cf124963fae9d9fdb2914ac743b824ea9307f619368db9074122bd173dc48bc629b28c087f0d54808d7dd4b703', 2, '2021-10-05 17:43:32', 50, 50, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `false_serif`
--
ALTER TABLE `false_serif`
  ADD UNIQUE KEY `serif_id` (`serif_id`);

--
-- Indexes for table `freemode_results`
--
ALTER TABLE `freemode_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_freemode_id` (`userid`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `serif_id` (`serif_id`);

--
-- Indexes for table `true_serif`
--
ALTER TABLE `true_serif`
  ADD UNIQUE KEY `serif_id` (`serif_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `false_serif`
--
ALTER TABLE `false_serif`
  MODIFY `serif_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `freemode_results`
--
ALTER TABLE `freemode_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `true_serif`
--
ALTER TABLE `true_serif`
  MODIFY `serif_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `freemode_results`
--
ALTER TABLE `freemode_results`
  ADD CONSTRAINT `users_freemode_id` FOREIGN KEY (`userid`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
