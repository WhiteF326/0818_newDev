-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 05, 2021 at 08:19 AM
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
-- Table structure for table `false_serif`
--

CREATE TABLE `false_serif` (
  `serif_id` int(10) NOT NULL,
  `question_no` int(10) NOT NULL,
  `file_name` varchar(30) NOT NULL,
  `file` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `false_serif`
--

INSERT INTO `false_serif` (`serif_id`, `question_no`, `file_name`, `file`) VALUES
(1, 1, '一問目不正解時のセリフ', 0xe5a696e7b2bee3808ce38389e383b3e3839ee382a4efbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d),
(2, 2, '二問目不正解時のセリフ', 0xe5a696e7b2bee3808ce9a091e5bcb5e3828cefbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d);

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
(6, 'test', 2, 0, 9, '2021-10-04 10:36:22', 0),
(7, 'test', 2, 0, 9, '2021-10-04 10:50:23', 0),
(8, 'test', 2, 0, 9, '2021-10-05 15:04:19', 0),
(9, 'test', 13, 0, 14, '2021-10-05 15:39:23', 0),
(10, 'test', 18, 0, 13, '2021-10-05 16:05:10', 0),
(11, 'test', 19, 0, 16, '2021-10-05 16:06:27', 0),
(12, 'test', 19, 0, 16, '2021-10-05 16:07:11', 0),
(13, 'test', 19, 0, 16, '2021-10-05 16:09:38', 0),
(14, 'test', 19, 0, 16, '2021-10-05 16:09:47', 0),
(15, 'test', 19, 0, 16, '2021-10-05 16:09:56', 0),
(16, 'test', 19, 0, 16, '2021-10-05 16:30:42', 0),
(17, 'test', 1, 0, 0, '2021-10-05 16:59:53', 0),
(18, 'test', 1, 0, 8, '2021-10-05 17:01:36', 0),
(19, 'test', 1, 0, 8, '2021-10-05 17:02:23', 0),
(20, 'test', 1, 0, 8, '2021-10-05 17:02:29', 0),
(21, 'test', 1, 0, 0, '2021-10-05 17:03:28', 0),
(22, 'test', 1, 0, 8, '2021-10-05 17:03:41', 0),
(23, 'test', 1, 0, 0, '2021-10-05 17:04:51', 0),
(24, 'test', 25, 0, 0, '2021-10-05 17:07:00', 0),
(25, 'test', 25, 0, 8, '2021-10-05 17:11:19', 0),
(26, 'test', 19, 0, 0, '2021-10-05 17:18:36', 0),
(27, 'test', 19, 0, 8, '2021-10-05 17:18:50', 0);

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `serif_id` int(11) NOT NULL,
  `serif_file` blob NOT NULL,
  `serif_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id`, `serif_id`, `serif_file`, `serif_name`) VALUES
(1, 1, 0xe5a696e7b2bee3808ce381bee3819fe382ace383a9e382afe382bfe3818ce68da8e381a6e38289e3828ce381a6e3828befbc81e698a8e697a5e9a091e5bcb5e381a3e381a6e7b6bae9ba97e381abe38197e3819fe381aee381abefbc81e3808d2c0d0ae5a696e7b2bee3808ce280a6e381a3e381a6e38182e3828cefbc9fe4babae99693efbc9fe3818ae383bce38184e38081e5a4a7e4b888e5a4abefbc9fe3808d2c0d0ae280a6e3839de38381e383832c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce5889de38281e381bee38197e381a6e38082e3818ae4b896e8a9b1e59e8be382a2e383b3e38389e383ade382a4e38389e381aee382a4e382a2e381a8e794b3e38197e381bee38199e38082e3808d2c0d0ae5a696e7b2bee3808ce38182e38081e382a2e383b3e38389e383ade382a4e38389efbc9fe3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce381afe38184e38082e5aeb6e4ba8be585a8e888ace381afe38282e381a1e3828de38293e381aee38193e381a8e38081e58a9be4bb95e4ba8be38292e587bae69da5e381bee38199e381aee381a7e4bd95e381aae3828ae381a8e3818ae794b3e38197e4bb98e38191e3818fe381a0e38195e38184e38082e3808d2c0d0ae5a696e7b2bee3808ce381b8e38187efbd9ee38199e38194e38184e38198e38283e38293efbc81e381a8e38193e3828de381a7e38081e381aae38293e381a7e38193e38293e381aae381a8e38193e3828de381abe38184e3828be381aeefbc9fe3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce280a6e38199e381bfe381bee3819be38293e38082e8a898e686b6e383a1e383a2e383aae3818ce5889de69c9fe58c96e38195e3828ce381a6e38197e381bee381a3e381a6e38184e3828be381aee381a7e9818ee58ebbe381aee38193e381a8e3818ce58886e3818be3828ae381bee3819be38293e38082e3808d2c0d0ae5a696e7b2bee3808ce38288e3818fe3828fe3818be38293e381aae38184e38191e381a9e38081e8a898e686b6e381aae3818fe38197e381a1e38283e381a3e3819fe381bfe3819fe38184e381ade38082e38186e383bce38293e280a6e3808d2c0d0ae5a696e7b2bee3808ce38198e38283e38182e38081e38193e381aee6a3aee38292e5bea9e6b4bbe38199e3828be3818ae6898be4bc9de38184e4b880e7b792e381abe38199e3828befbc9fe381aae38293e3818be38284e381a3e381a6e3819fe38289e6809de38184e587bae38199e3818be38282e38197e3828ce381aae38184e38197e38082e3808d2c0d0ae5a696e7b2bee3808ce7a781e381aee5908de5898de381afe38395e382a7e382a4e38288e38081e38288e3828de38197e3818fe381ade382a4e382a2e38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce58886e3818be3828ae381bee38197e3819fe38081e38288e3828de38197e3818fe3818ae9a198e38184e38197e381bee38199e38082e38395e382a7e382a4e38195e38293e38082e3808d2c0d0ae5a696e7b2bee3808ce38198e38283e38182e8a9a6e38197e381abe6ada9e38184e381a6e381bfe38288e38186e38288e38082e7a781e381aee381a8e38193e3828de381bee381a7e6ada9e38184e381a6e381bfe381a6e38082e3808d, 'オープニング');

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

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `pass` varchar(512) NOT NULL,
  `story_progress` int(100) NOT NULL DEFAULT '0',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `pass`, `story_progress`, `update_time`) VALUES
('Shiroha_F16', 'Mitta', '182052b9a60f4b3147502dda2337f948a26e93936c7e698e6393989bf37eb8f570332f79d3becfdaafc585e6c4cd3a93174a00aca5de408dae7bdb27aeb67de3', 0, '2021-09-30 09:34:50'),
('test', 'tester', 'ad541694138dc60e3e90eaed5e8699d83cc6081b96ca997e5483699e210433125625f4f771fa4f048e4158badaf6ec35e47b4316574c2147b5bc88fddf68fab9', 2, '2021-09-29 12:28:07');

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
  MODIFY `serif_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `freemode_results`
--
ALTER TABLE `freemode_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `true_serif`
--
ALTER TABLE `true_serif`
  MODIFY `serif_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
