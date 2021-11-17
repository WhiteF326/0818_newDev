-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- ホスト: localhost:3306
-- 生成日時: 
-- サーバのバージョン： 5.7.24
-- PHP のバージョン: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `laa1355306-proggame`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `create_stages`
--

CREATE TABLE `create_stages` (
  `stageid` int(11) NOT NULL,
  `userid` varchar(16) NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `stagetext` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `create_stages`
--

INSERT INTO `create_stages` (`stageid`, `userid`, `is_public`, `stagetext`) VALUES
(6, 'test', 0, '{\n  \"stage\": [\n    [0, 0, 0, 0, 0, 0, 0, 0, 0],\n    [0, 1, 1, 1, 2, 1, 1, 1, 0],\n    [0, 0, 0, 0, 0, 0, 0, 0, 0]\n  ],\n  \"param\": [\n    [0, 0, 0, 0, 0, 0, 0, 0, 0],\n    [0, 0, 0, 0, 0, 0, 0, 0, 0],\n    [0, 0, 0, 0, 0, 0, 0, 0, 0]\n  ],\n  \n  \"start\": [1, 1, \"right\"],\n  \"goal\": [1, 7],\n  \"controll\": [1, 5],\n  \"costList\": {\n    \"move\": \"3\",\n    \"destroy\": \"5\",\n    \"create\": \"5\",\n    \"loop\": \"1\",\n    \"if\": \"1\",\n    \"repair\": \"10\"\n  },\n  \"maxCost\": 27,\n  \"maxStep\": 21,\n  \"unlocked\": [\n    \"move\",\n    \"destroy\"\n  ],\n  \"message\": \"デフォルトのステージです。\",\n  \"title\": \"無題\",\n  \"bgm\": \"forest_ver2\"\n}\n'),
(7, 'test', 0, '{\"stage\":[[0,0,0,0,0,0,0,0,0],[0,1,1,1,2,1,1,1,0],[0,0,0,0,0,0,0,0,0]],\"param\":[[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]],\"start\":[1,1,\"right\"],\"goal\":[1,7],\"controll\":[1,5],\"costList\":{\"move\":\"3\",\"destroy\":\"5\",\"create\":\"5\",\"loop\":\"1\",\"if\":\"1\",\"repair\":\"10\"},\"maxCost\":27,\"maxStep\":21,\"unlocked\":[\"move\",\"destroy\"],\"message\":\"デフォルトのステージです。\",\"title\":\"無題 - コピー\",\"bgm\":\"forest_ver2\"}');

-- --------------------------------------------------------

--
-- テーブルの構造 `create_testlist`
--

CREATE TABLE `create_testlist` (
  `userid` varchar(16) NOT NULL,
  `hashed` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `false_serif`
--

CREATE TABLE `false_serif` (
  `serif_id` int(10) NOT NULL,
  `question_no` int(10) NOT NULL,
  `file_name` varchar(30) NOT NULL,
  `file` blob NOT NULL,
  `back_img` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `false_serif`
--

INSERT INTO `false_serif` (`serif_id`, `question_no`, `file_name`, `file`, `back_img`) VALUES
(1, 1, '一問目不正解時のセリフ', 0xe5a696e7b2bee3808ce38389e383b3e3839ee382a4efbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d, 'image/morigarakuta.png'),
(2, 2, '二問目不正解時のセリフ', 0xe5a696e7b2bee3808ce9a091e5bcb5e3828cefbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d, 'image/morigarakuta.png'),
(3, 3, '三問目不正解時のセリフ', 0xe5a696e7b2bee3808ce6839ce38197e38184efbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186e38082e3808d, 'image/youseihousetree.png'),
(4, 4, '四問目不正解時のセリフ', 0xe5a696e7b2bee3808ce38389e383b3e3839ee382a4efbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d, 'image/mori.png'),
(5, 5, '五問目正解時のセリフ', 0xe5a696e7b2bee3808ce9a091e5bcb5e3828cefbc81e38282e381a3e3818be38184e38381e383a3e383ace383b3e382b8e38197e381a6e381bfe38288e38186efbc81e3808d, 'image/karehana.png');

-- --------------------------------------------------------

--
-- テーブルの構造 `freemode_results`
--

CREATE TABLE `freemode_results` (
  `id` int(11) NOT NULL,
  `userid` varchar(16) NOT NULL,
  `stagename` int(10) NOT NULL,
  `score` int(10) NOT NULL,
  `cost` int(10) NOT NULL,
  `program` text,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `freemode_results`
--

INSERT INTO `freemode_results` (`id`, `userid`, `stagename`, `score`, `cost`, `program`, `date`, `deleted`) VALUES
(1, 'test', 2, 810, 8, NULL, '2021-10-01 09:48:39', 1),
(2, 'test', 5, 810, 16, NULL, '2021-10-01 09:49:42', 1),
(3, 'test', 5, 810, 15, NULL, '2021-10-01 09:49:42', 1),
(4, 'test', 1, 0, 8, NULL, '2021-10-01 16:24:57', 1),
(5, 'test', 7, 0, 15, NULL, '2021-10-01 16:25:28', 1),
(6, 'test', 2, 0, 9, NULL, '2021-10-04 10:36:22', 1),
(7, 'test', 2, 0, 9, NULL, '2021-10-04 10:50:23', 1),
(8, 'test', 2, 0, 9, NULL, '2021-10-04 16:48:23', 1),
(9, 'test', 17, 0, 12, NULL, '2021-10-05 11:04:53', 1),
(10, 'test', 17, 0, 12, NULL, '2021-10-05 11:05:02', 1),
(11, 'test', 17, 0, 12, NULL, '2021-10-05 11:05:29', 1),
(12, 'test', 17, 0, 12, NULL, '2021-10-05 11:05:39', 1),
(13, 'test', 17, 0, 12, NULL, '2021-10-05 11:06:52', 1),
(14, 'test', 17, 0, 12, NULL, '2021-10-05 11:11:10', 1),
(15, 'test', 17, 0, 12, NULL, '2021-10-05 11:11:43', 1),
(16, 'test', 17, 0, 12, NULL, '2021-10-05 11:12:11', 1),
(17, 'test', 17, 0, 12, NULL, '2021-10-05 11:12:27', 1),
(18, 'test', 17, 0, 12, NULL, '2021-10-05 11:14:24', 1),
(33, 'test', 1, 0, 8, NULL, '2021-10-05 16:35:53', 1),
(34, 'test', 1, 0, 8, NULL, '2021-10-05 16:42:25', 1),
(35, 'test', 1, 0, 8, NULL, '2021-10-05 16:42:29', 1),
(36, 'test', 1, 0, 8, NULL, '2021-10-05 16:42:36', 1),
(37, 'test', 1, 0, 8, NULL, '2021-10-05 16:51:49', 1),
(39, 'test', 1, 0, 8, NULL, '2021-10-05 16:55:20', 1),
(40, 'test', 1, 0, 8, NULL, '2021-10-05 17:24:33', 1),
(41, 'test', 1, 0, 8, NULL, '2021-10-05 17:27:55', 1),
(42, 'test', 1, 0, 8, NULL, '2021-10-05 17:28:06', 1),
(43, 'test', 1, 0, 8, NULL, '2021-10-05 17:28:32', 1),
(44, 'test4', 1, 0, 8, NULL, '2021-10-05 17:44:07', 0),
(45, 'test4', 5, 0, 9, NULL, '2021-10-05 17:44:32', 0),
(47, 'test4', 20, 0, 8, NULL, '2021-10-05 17:46:28', 0),
(48, 'test', 1, 0, 8, NULL, '2021-10-06 11:39:33', 1),
(49, 'test', 1, 0, 8, NULL, '2021-10-06 11:39:46', 1),
(50, 'test', 3, 0, 9, NULL, '2021-10-06 11:40:39', 1),
(51, 'test', 1, 0, 8, NULL, '2021-10-06 11:40:48', 1),
(52, 'test', 1, 0, 8, NULL, '2021-10-07 10:10:46', 1),
(53, 'test', 1, 0, 8, NULL, '2021-10-07 10:11:21', 1),
(54, 'test', 1, 0, 8, NULL, '2021-10-07 10:12:16', 1),
(55, 'test', 1, 0, 8, NULL, '2021-10-07 10:16:38', 1),
(56, 'test', 1, 0, 8, NULL, '2021-10-07 10:17:14', 1),
(57, 'fucker', 1, 0, 0, NULL, '2021-10-08 10:24:10', 1),
(58, 'fucker', 1, 0, 8, NULL, '2021-10-08 10:32:47', 0),
(59, 'fucker', 1, 0, 8, NULL, '2021-10-08 10:33:02', 0),
(60, 'fucker', 1, 0, 8, NULL, '2021-10-08 10:52:30', 0),
(61, 'test', 1, 0, 8, NULL, '2021-10-11 13:24:31', 1),
(62, 'test', 2, 0, 9, NULL, '2021-10-11 13:25:10', 1),
(63, 'test', 1, 0, 8, NULL, '2021-10-11 15:03:52', 1),
(64, 'test', 1, 0, 8, NULL, '2021-10-11 15:05:48', 1),
(65, 'test', 1, 0, 8, NULL, '2021-10-11 15:05:56', 1),
(66, 'test', 1, 0, 8, NULL, '2021-10-11 15:08:02', 1),
(67, 'test', 1, 0, 8, NULL, '2021-10-11 15:08:15', 1),
(68, 'test', 2, 0, 9, NULL, '2021-10-11 15:31:13', 1),
(69, 'test', 1, 0, 0, NULL, '2021-10-11 16:07:35', 1),
(70, 'test', 1, 0, 8, NULL, '2021-10-11 16:08:11', 1),
(71, 'test', 1, 0, 8, NULL, '2021-10-12 12:37:05', 1),
(72, 'test', 4, 0, 12, NULL, '2021-10-12 12:38:55', 1),
(73, 'test', 4, 0, 12, NULL, '2021-10-12 12:40:31', 1),
(74, 'test', 18, 0, 0, NULL, '2021-10-12 12:42:28', 1),
(75, 'test', 18, 0, 8, NULL, '2021-10-12 12:44:04', 1),
(76, 'test', 4, 0, 12, NULL, '2021-10-12 14:36:41', 1),
(77, 'test', 1, 0, 8, NULL, '2021-10-12 15:15:42', 1),
(78, 'test', 1, 0, 8, NULL, '2021-10-12 15:16:52', 1),
(79, 'test', 1, 0, 8, NULL, '2021-10-12 15:17:02', 1),
(80, 'test', 1, 0, 8, NULL, '2021-10-12 15:17:21', 1),
(81, 'test', 1, 0, 8, NULL, '2021-10-12 15:18:24', 1),
(82, 'test', 1, 0, 8, NULL, '2021-10-12 15:18:56', 1),
(83, 'test', 1, 0, 8, NULL, '2021-10-12 15:19:06', 1),
(84, 'test', 1, 0, 8, NULL, '2021-10-12 15:19:11', 1),
(85, 'test', 1, 0, 8, NULL, '2021-10-12 15:19:18', 1),
(86, 'test', 1, 0, 8, NULL, '2021-10-12 15:19:24', 1),
(87, 'test', 1, 0, 8, NULL, '2021-10-12 15:19:51', 1),
(88, 'test', 1, 0, 8, NULL, '2021-10-12 15:20:15', 1),
(89, 'test', 1, 0, 8, NULL, '2021-10-12 15:20:22', 1),
(90, 'test', 1, 0, 8, NULL, '2021-10-12 15:20:53', 1),
(91, 'test', 2, 0, 9, NULL, '2021-10-12 15:21:27', 1),
(92, 'test', 2, 0, 9, NULL, '2021-10-12 15:27:14', 1),
(93, 'test', 1, 0, 0, NULL, '2021-10-13 16:15:17', 1),
(94, 'test', 1, 0, 0, NULL, '2021-10-13 16:15:24', 1),
(95, 'test', 1, 0, 0, NULL, '2021-10-13 16:17:33', 1),
(96, 'test', 1, 0, 0, NULL, '2021-10-13 16:22:17', 1),
(97, 'test', 1, 0, 8, NULL, '2021-10-13 16:22:32', 1),
(98, 'test', 1, 0, 0, NULL, '2021-10-13 16:23:23', 1),
(99, 'test', 1, 0, 0, NULL, '2021-10-13 16:44:49', 1),
(100, 'test', 1, 0, 0, NULL, '2021-10-13 16:47:05', 1),
(101, 'test', 1, 0, 0, NULL, '2021-10-14 09:51:18', 1),
(102, 'test', 1, 0, 0, NULL, '2021-10-14 10:01:09', 1),
(103, 'test', 1, 0, 8, NULL, '2021-10-14 10:01:42', 1),
(104, 'test', 1, 0, 0, NULL, '2021-10-14 10:03:24', 1),
(105, 'test', 1, 0, 8, NULL, '2021-10-15 10:49:57', 1),
(106, 'test', 1, 0, 8, NULL, '2021-10-27 10:08:00', 1),
(107, 'test', 1, 0, 8, NULL, '2021-10-27 10:08:23', 1),
(108, 'test', 1, 6, 8, NULL, '2021-10-27 10:08:55', 1),
(109, 'test', 1, 6, 8, NULL, '2021-10-27 10:09:05', 1),
(110, 'test', 1, 6, 8, NULL, '2021-10-27 10:09:13', 1),
(111, 'test', 2, 3, 9, NULL, '2021-10-27 10:09:25', 1),
(112, 'test', 2, 252, 9, NULL, '2021-10-27 10:13:40', 1),
(113, 'test', 2, 0, 9, NULL, '2021-10-27 10:18:25', 1),
(114, 'test', 2, 0, 9, NULL, '2021-10-27 10:18:34', 1),
(115, 'test', 2, 0, 9, NULL, '2021-10-27 10:18:55', 1),
(116, 'test', 2, 0, 9, NULL, '2021-10-27 10:19:01', 1),
(117, 'test', 2, 249, 9, NULL, '2021-10-27 10:22:41', 1),
(118, 'test', 2, -1059, 9, NULL, '2021-10-27 10:23:15', 1),
(119, 'test', 2, -1059, 9, NULL, '2021-10-27 10:23:28', 1),
(120, 'test', 2, 240, 9, NULL, '2021-10-27 10:28:50', 1),
(121, 'test', 2, 240, 9, NULL, '2021-10-27 10:31:00', 1),
(122, 'test', 2, 240, 9, NULL, '2021-10-27 10:32:06', 1),
(123, 'test', 2, 240, 9, NULL, '2021-10-27 10:32:20', 1),
(124, 'test', 2, 32, 23, NULL, '2021-10-27 10:33:40', 1),
(125, 'test', 1, -3, 8, NULL, '2021-10-27 10:33:59', 1),
(126, 'test', 1, 0, 8, NULL, '2021-10-27 10:34:26', 1),
(127, 'test', 2, -6, 9, NULL, '2021-10-27 10:35:21', 1),
(128, 'test', 2, -6, 9, NULL, '2021-10-27 10:35:27', 1),
(129, 'test', 2, -6, 9, NULL, '2021-10-27 10:40:53', 1),
(130, 'test', 2, -7, 9, NULL, '2021-10-27 10:41:01', 1),
(131, 'test', 4, -13, 12, NULL, '2021-10-27 10:41:10', 1),
(132, 'test', 10, -20, 16, NULL, '2021-10-27 10:41:42', 1),
(133, 'test', 10, -20, 16, NULL, '2021-10-27 10:43:42', 1),
(134, 'test', 10, -20, 16, NULL, '2021-10-27 10:44:55', 1),
(135, 'test', 10, -20, 16, NULL, '2021-10-27 10:46:33', 1),
(136, 'test', 10, -20, 16, NULL, '2021-10-27 10:47:10', 1),
(137, 'test', 10, -20, 16, NULL, '2021-10-27 10:48:04', 1),
(138, 'test', 10, -20, 16, NULL, '2021-10-27 10:48:26', 1),
(139, 'test', 10, -20, 16, NULL, '2021-10-27 10:49:18', 1),
(140, 'test', 10, -27, 16, NULL, '2021-10-27 10:49:33', 1),
(141, 'test', 10, -27, 16, NULL, '2021-10-27 10:49:45', 1),
(142, 'test', 10, -27, 16, NULL, '2021-10-27 10:49:54', 1),
(143, 'test', 10, 0, 16, NULL, '2021-10-27 11:18:01', 1),
(144, 'test', 10, 0, 16, NULL, '2021-10-27 11:18:11', 1),
(145, 'test', 10, 0, 16, NULL, '2021-10-27 11:18:40', 1),
(146, 'test', 10, 0, 16, NULL, '2021-10-27 11:18:59', 1),
(147, 'test', 10, 0, 16, NULL, '2021-10-27 11:19:36', 1),
(148, 'test', 10, -27, 16, NULL, '2021-10-27 11:20:15', 1),
(149, 'test', 10, -27, 16, NULL, '2021-10-27 11:20:53', 1),
(150, 'test', 10, -27, 16, NULL, '2021-10-27 11:22:28', 1),
(151, 'test', 10, -27, 16, NULL, '2021-10-27 11:22:33', 1),
(152, 'test', 10, -27, 16, NULL, '2021-10-27 11:23:48', 1),
(153, 'test', 10, -27, 16, NULL, '2021-10-27 11:24:01', 1),
(154, 'test', 10, -27, 16, NULL, '2021-10-27 11:24:33', 1),
(155, 'test', 10, -27, 16, NULL, '2021-10-27 11:24:38', 1),
(156, 'test', 10, -27, 16, NULL, '2021-10-27 11:24:45', 1),
(157, 'test', 10, -27, 16, NULL, '2021-10-27 11:25:23', 1),
(158, 'test', 10, -27, 16, NULL, '2021-10-27 11:26:00', 1),
(159, 'test', 10, -27, 16, NULL, '2021-10-27 11:27:05', 1),
(160, 'test', 10, -27, 16, NULL, '2021-10-27 11:34:47', 1),
(161, 'test', 10, -27, 16, NULL, '2021-10-27 11:35:03', 1),
(162, 'test', 10, -27, 16, NULL, '2021-10-27 11:37:36', 1),
(163, 'test', 10, -27, 16, NULL, '2021-10-27 11:38:10', 1),
(164, 'test', 10, -27, 16, NULL, '2021-10-27 11:41:53', 1),
(165, 'test', 10, -27, 16, NULL, '2021-10-27 11:43:01', 1),
(166, 'test', 10, -27, 16, NULL, '2021-10-27 11:43:12', 1),
(167, 'test', 10, -27, 16, NULL, '2021-10-27 11:44:09', 1),
(168, 'test', 10, -27, 16, NULL, '2021-10-27 11:46:00', 1),
(169, 'test', 10, -27, 16, NULL, '2021-10-27 12:13:38', 1),
(170, 'test', 10, -27, 16, NULL, '2021-10-27 12:52:56', 1),
(171, 'test', 10, -27, 16, NULL, '2021-10-27 12:53:12', 1),
(172, 'test', 10, -27, 16, NULL, '2021-10-27 12:53:41', 1),
(173, 'test', 10, -27, 16, NULL, '2021-10-27 12:54:09', 1),
(174, 'test', 10, -27, 16, NULL, '2021-10-27 12:55:08', 1),
(175, 'test', 10, -27, 16, NULL, '2021-10-27 12:55:35', 1),
(176, 'test', 10, -27, 16, NULL, '2021-10-27 12:56:01', 1),
(177, 'test', 10, -27, 16, NULL, '2021-10-27 12:56:31', 1),
(178, 'test', 10, -27, 16, NULL, '2021-10-27 12:56:50', 1),
(179, 'test', 10, -27, 16, NULL, '2021-10-27 12:57:37', 1),
(180, 'test', 10, -27, 16, NULL, '2021-10-27 12:58:30', 1),
(181, 'test', 10, -27, 16, NULL, '2021-10-27 12:58:41', 1),
(182, 'test', 10, -27, 16, NULL, '2021-10-27 13:00:02', 1),
(183, 'test', 10, -27, 16, NULL, '2021-10-27 13:00:52', 1),
(184, 'test', 10, -27, 16, NULL, '2021-10-27 13:01:30', 1),
(185, 'test', 10, -27, 16, NULL, '2021-10-27 13:01:46', 1),
(186, 'test', 10, -27, 16, NULL, '2021-10-27 13:01:54', 1),
(187, 'test', 10, -27, 16, NULL, '2021-10-27 13:02:16', 1),
(188, 'test', 10, -27, 16, NULL, '2021-10-27 13:02:41', 1),
(189, 'test', 10, -27, 16, NULL, '2021-10-27 13:03:05', 1),
(190, 'test', 10, -27, 16, NULL, '2021-10-27 13:03:33', 1),
(191, 'test', 10, -27, 16, NULL, '2021-10-27 13:06:00', 1),
(192, 'test', 10, -27, 16, NULL, '2021-10-27 13:06:35', 1),
(193, 'test', 10, -27, 16, NULL, '2021-10-27 13:06:41', 1),
(194, 'test', 10, -27, 16, NULL, '2021-10-27 13:06:45', 1),
(195, 'test', 10, -27, 16, NULL, '2021-10-27 13:07:14', 1),
(196, 'test', 10, -27, 16, NULL, '2021-10-27 13:08:51', 1),
(197, 'test', 10, -27, 16, NULL, '2021-10-27 13:09:24', 1),
(198, 'test', 10, -27, 16, NULL, '2021-10-27 13:10:30', 1),
(199, 'test', 10, -27, 16, NULL, '2021-10-27 13:12:43', 1),
(200, 'test', 10, -27, 16, NULL, '2021-10-27 13:13:15', 1),
(201, 'test', 10, -27, 16, NULL, '2021-10-27 13:13:28', 1),
(202, 'test', 10, -27, 16, NULL, '2021-10-27 13:13:53', 1),
(203, 'test', 10, -27, 16, NULL, '2021-10-27 13:14:56', 1),
(204, 'test', 10, -27, 16, NULL, '2021-10-27 13:15:09', 1),
(205, 'test', 10, -27, 16, NULL, '2021-10-27 13:15:39', 1),
(206, 'test', 10, -27, 16, NULL, '2021-10-27 13:16:12', 1),
(207, 'test', 10, -27, 16, NULL, '2021-10-27 13:16:28', 1),
(208, 'test', 10, -27, 16, NULL, '2021-10-27 13:16:37', 1),
(209, 'test', 10, -27, 16, NULL, '2021-10-27 13:16:58', 1),
(210, 'test', 10, -27, 16, NULL, '2021-10-27 13:17:56', 1),
(211, 'test', 10, -27, 16, NULL, '2021-10-27 13:18:19', 1),
(212, 'test', 10, -27, 16, NULL, '2021-10-27 13:18:37', 1),
(213, 'test', 10, -27, 16, NULL, '2021-10-27 13:19:03', 1),
(214, 'test', 10, -27, 16, NULL, '2021-10-27 13:19:09', 1),
(215, 'test', 10, -27, 16, NULL, '2021-10-27 13:19:22', 1),
(216, 'test', 10, -27, 16, NULL, '2021-10-27 14:31:23', 1),
(217, 'test', 10, -27, 16, NULL, '2021-10-27 14:58:45', 1),
(218, 'test', 10, -27, 16, NULL, '2021-10-27 15:06:12', 1),
(219, 'test', 10, -27, 16, NULL, '2021-10-27 15:07:43', 1),
(220, 'test', 10, -27, 16, NULL, '2021-10-27 15:08:00', 1),
(221, 'test', 10, -27, 16, NULL, '2021-10-27 15:08:30', 1),
(222, 'test', 10, -27, 16, NULL, '2021-10-27 15:09:03', 1),
(223, 'test', 10, -27, 16, NULL, '2021-10-27 15:09:54', 1),
(224, 'test', 10, -27, 16, NULL, '2021-10-27 15:10:06', 1),
(225, 'test', 10, -27, 16, NULL, '2021-10-27 15:10:47', 1),
(226, 'test', 10, -27, 16, NULL, '2021-10-27 15:12:55', 1),
(227, 'test', 10, -27, 16, NULL, '2021-10-27 15:13:33', 1),
(228, 'test', 10, -27, 16, NULL, '2021-10-27 15:16:57', 1),
(229, 'test', 10, -27, 16, NULL, '2021-10-27 15:17:32', 1),
(230, 'test', 10, -27, 16, NULL, '2021-10-27 15:17:41', 1),
(231, 'test', 10, -27, 16, NULL, '2021-10-27 15:17:49', 1),
(232, 'test', 10, -27, 16, NULL, '2021-10-27 15:18:06', 1),
(233, 'test', 10, -27, 16, NULL, '2021-10-27 15:18:13', 1),
(234, 'test', 10, -27, 16, NULL, '2021-10-27 15:18:32', 1),
(235, 'test', 10, -27, 16, NULL, '2021-10-27 15:19:18', 1),
(236, 'test', 10, -27, 16, NULL, '2021-10-27 15:19:40', 1),
(237, 'test', 10, -27, 16, NULL, '2021-10-27 15:19:50', 1),
(238, 'test', 10, -27, 16, NULL, '2021-10-27 15:20:54', 1),
(239, 'test', 10, -27, 16, NULL, '2021-10-27 15:20:55', 1),
(240, 'test', 10, -27, 16, NULL, '2021-10-27 15:20:55', 1),
(241, 'test', 10, -27, 16, NULL, '2021-10-27 15:21:19', 1),
(242, 'test', 10, -27, 16, NULL, '2021-10-27 15:22:07', 1),
(243, 'test', 10, -27, 16, NULL, '2021-10-27 15:22:15', 1),
(244, 'test', 10, -27, 16, NULL, '2021-10-27 15:22:25', 1),
(245, 'test', 10, -27, 16, NULL, '2021-10-27 15:22:28', 1),
(246, 'test', 10, -27, 16, NULL, '2021-10-27 15:23:24', 1),
(247, 'test', 10, -27, 16, NULL, '2021-10-27 15:26:42', 1),
(248, 'test', 10, -27, 16, NULL, '2021-10-27 15:27:02', 1),
(249, 'test', 10, -27, 16, NULL, '2021-10-27 15:28:43', 1),
(250, 'test', 10, -27, 16, NULL, '2021-10-27 15:30:45', 1),
(251, 'test', 10, -27, 16, NULL, '2021-10-27 15:30:51', 1),
(252, 'test', 10, -27, 16, NULL, '2021-10-27 15:31:12', 1),
(253, 'test', 10, 99999, 16, NULL, '2021-10-27 15:33:19', 1),
(254, 'test', 1, -1, 8, NULL, '2021-10-28 10:46:51', 1),
(255, 'test', 1, -1, 8, NULL, '2021-10-28 10:47:40', 1),
(256, 'test', 2, 259, 8, NULL, '2021-10-28 15:07:01', 1),
(257, 'test', 1, 259, 8, NULL, '2021-10-28 15:10:31', 1),
(258, 'test', 1, 259, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"uYC@Ck}kHwI-:W=C_t9i\" x=\"47\" y=\"27\">\n    <field name=\"vector\">LEFT</field>\n    <next>\n      <block type=\"destroy\" id=\"c=k_]{|_JY=1Ng1J{)V$\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-28 15:10:53', 1),
(259, 'test', 7, 918, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"wV|0rc**_w|hDr:Y3{;e\" x=\"126\" y=\"51\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"LyZ`E%S}BT.Bx+MWk#@a\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 10:09:20', 1),
(260, 'test', 7, 918, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"wV|0rc**_w|hDr:Y3{;e\" x=\"126\" y=\"51\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"LyZ`E%S}BT.Bx+MWk#@a\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 10:10:36', 1),
(261, 'test', 10, 212, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"O|hw7tks.aWAUW*6I,MH\" x=\"157\" y=\"108\">\n    <field name=\"REPEATAMOUNT\">30</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"Bh.,i,:aUEEkWQ_0OF9r\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"destroy\" id=\"]E7MicQ;U`a9iF4CJDKX\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 10:12:29', 1),
(262, 'test', 7, 918, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"wV|0rc**_w|hDr:Y3{;e\" x=\"126\" y=\"51\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"LyZ`E%S}BT.Bx+MWk#@a\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 10:52:17', 1),
(263, 'test', 9, 186, 23, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"zQ+os*[i!Q;VPjo9!MQ|\" x=\"156\" y=\"50\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"move\" id=\"H@e-]8=2Y{[g6iNme^3,\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"move\" id=\"=5Xo,1}_-W2E!6f:w^01\">\n            <field name=\"vector\">RIGHT</field>\n            <next>\n              <block type=\"move\" id=\"Lw1G{9ffpepuJSXgZ2,Y\">\n                <field name=\"vector\">RIGHT</field>\n                <next>\n                  <block type=\"move\" id=\"r~()jV+jtgb#mRM.xHHB\">\n                    <field name=\"vector\">RIGHT</field>\n                    <next>\n                      <block type=\"move\" id=\"]!G{a$M+2m]U]m69c%as\">\n                        <field name=\"vector\">RIGHT</field>\n                        <next>\n                          <block type=\"destroy\" id=\"Nq$XM+=?!J_FW|ms.eMw\"></block>\n                        </next>\n                      </block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 10:52:43', 1),
(264, 'test', 9, 416, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"K(k)Z=|JMz%@pwucr_@$\" x=\"143\" y=\"28\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"zQ+os*[i!Q;VPjo9!MQ|\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"destroy\" id=\"Nq$XM+=?!J_FW|ms.eMw\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 10:52:59', 1),
(265, 'test', 9, 416, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"K(k)Z=|JMz%@pwucr_@$\" x=\"143\" y=\"28\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"zQ+os*[i!Q;VPjo9!MQ|\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"destroy\" id=\"Nq$XM+=?!J_FW|ms.eMw\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 10:54:53', 1),
(266, 'test', 9, 186, 23, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"U^s.a9KD_])@;go|@)c~\" x=\"125\" y=\"24\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"GW.*16i2w!9~~mqXH;{X\" x=\"152\" y=\"80\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"B_EFlEuJ]pO.[^0krGxi\" x=\"180\" y=\"136\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"-(8aM-lsitL`%6.qV}1=\" x=\"208\" y=\"192\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"XU$=@yyO/js-TzV2}%PV\" x=\"236\" y=\"248\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\";J?T8v@B0w*ea9wbWlP)\" x=\"264\" y=\"304\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\" x=\"319\" y=\"369\"></block>\n</xml>', '2021-10-29 10:55:14', 1),
(267, 'test', 9, 416, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"l7/}6/2T6ROh;9v?ihR6\" x=\"90\" y=\"15\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"U^s.a9KD_])@;go|@)c~\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n  </block>\n  <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\" x=\"319\" y=\"369\"></block>\n</xml>', '2021-10-29 10:55:44', 1),
(268, 'test', 9, 186, 23, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"[yW)g0b(1~~I~6C@Ix-|\" x=\"147\" y=\"31\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"$J~FXq|J([6A_n|iBiOd\" x=\"174\" y=\"87\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"Os3tT!jea5ITWy]iamlV\" x=\"202\" y=\"143\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"gHpB_ItYMReraHjj_+]^\" x=\"230\" y=\"199\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"#3(:s{A*LL=E_sfv$$?g\" x=\"258\" y=\"255\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"e/rSJpvOqv|n@@RLj?9O\" x=\"286\" y=\"311\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\" x=\"319\" y=\"369\"></block>\n</xml>', '2021-10-29 10:56:04', 1),
(269, 'test', 9, 93, 23, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"[yW)g0b(1~~I~6C@Ix-|\" x=\"147\" y=\"31\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"$J~FXq|J([6A_n|iBiOd\" x=\"174\" y=\"87\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"Os3tT!jea5ITWy]iamlV\" x=\"202\" y=\"143\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"gHpB_ItYMReraHjj_+]^\" x=\"230\" y=\"199\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"#3(:s{A*LL=E_sfv$$?g\" x=\"258\" y=\"255\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"e/rSJpvOqv|n@@RLj?9O\" x=\"286\" y=\"311\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\" x=\"319\" y=\"369\"></block>\n</xml>', '2021-10-29 10:58:25', 1),
(270, 'test', 9, 93, 23, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"[yW)g0b(1~~I~6C@Ix-|\" x=\"147\" y=\"31\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"$J~FXq|J([6A_n|iBiOd\" x=\"174\" y=\"87\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"Os3tT!jea5ITWy]iamlV\" x=\"202\" y=\"143\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"gHpB_ItYMReraHjj_+]^\" x=\"230\" y=\"199\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"#3(:s{A*LL=E_sfv$$?g\" x=\"258\" y=\"255\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"e/rSJpvOqv|n@@RLj?9O\" x=\"286\" y=\"311\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\" x=\"319\" y=\"369\"></block>\n</xml>', '2021-10-29 10:58:53', 1),
(271, 'test', 9, 93, 23, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"[yW)g0b(1~~I~6C@Ix-|\" x=\"147\" y=\"31\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"$J~FXq|J([6A_n|iBiOd\" x=\"174\" y=\"87\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"Os3tT!jea5ITWy]iamlV\" x=\"202\" y=\"143\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"gHpB_ItYMReraHjj_+]^\" x=\"230\" y=\"199\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"#3(:s{A*LL=E_sfv$$?g\" x=\"258\" y=\"255\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"e/rSJpvOqv|n@@RLj?9O\" x=\"286\" y=\"311\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\" x=\"319\" y=\"369\"></block>\n</xml>', '2021-10-29 10:59:05', 1),
(272, 'test', 9, 365, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"6Bys497j?k9HwjKRf2;s\" x=\"130\" y=\"18\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"[yW)g0b(1~~I~6C@Ix-|\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n  </block>\n  <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\" x=\"319\" y=\"369\"></block>\n</xml>', '2021-10-29 10:59:21', 1),
(273, 'test', 9, 93, 23, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"#d?=7*JaJTw-Y*E8Ci.7\" x=\"370\" y=\"98\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"}kgCHl0K6?*y`(q}Oc]M\" x=\"397\" y=\"154\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"1uXMKnxT4_M,[3~oJfI~\" x=\"425\" y=\"210\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"O,-30`NwS-SS8gP[IZzd\" x=\"453\" y=\"266\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"Efb5Ohww[A3XCS*D}:6v\" x=\"481\" y=\"322\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"~]?~eNTe@yFKBoA-S7Vl\" x=\"509\" y=\"378\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:00:02', 1),
(274, 'test', 6, 100, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"b8T-chTl(l0$UOy/EH1|\" x=\"155\" y=\"120\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"#e#8%N#O%V{`zwcvhd77\">\n        <next>\n          <block type=\"move\" id=\"%qGMw=Q@,jk*Y]Rl?K#!\">\n            <field name=\"vector\">RIGHT</field>\n            <next>\n              <block type=\"move\" id=\"X[Hrl??ER3dw(YI^S3Nq\">\n                <field name=\"vector\">RIGHT</field>\n                <next>\n                  <block type=\"move\" id=\"~)6y4$TUMQ=[NpKec=5q\">\n                    <field name=\"vector\">RIGHT</field>\n                    <next>\n                      <block type=\"create\" id=\"[pvz*H!RCN-?)(kslkrz\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:00:38', 1),
(275, 'test', 1, 226, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"Hp6Y{3yNjKC!!sbU|CVy\" x=\"0\" y=\"47\">\n    <field name=\"vector\">LEFT</field>\n    <next>\n      <block type=\"destroy\" id=\"65I$vOgYCQt!#,Fg]r.8\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:00:53', 1),
(276, 'test', 2, 226, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"67Ju,hIrzx,DYuTeI3d0\" x=\"83\" y=\"36\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"Fhoci=4o$H%a@$8?J}9v\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:00:59', 1),
(277, 'test', 3, 304, 14, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"GC$l6*WIYbk3a#wJDO33\" x=\"62\" y=\"22\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"move\" id=\"Jx@9#Gz6?Lmq`^_Std=f\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"move\" id=\"RVwnmqBg]2~3hfT5~b{=\">\n            <field name=\"vector\">BACK</field>\n            <next>\n              <block type=\"destroy\" id=\"CDa!FYOPsRXAX{@p-o.5\"></block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:01:24', 1),
(278, 'test', 4, 408, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"=RrLiLauUt.n9S$YjnY6\" x=\"78\" y=\"186\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"create\" id=\"yk+{0r3#}8hW:oZJr=D;\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:01:46', 1),
(279, 'test', 5, 238, 17, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"=H5|PoloGFA|fD6LLi/#\" x=\"237\" y=\"68\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"k$[@V%D)S|VX*kmzPF8(\" x=\"264\" y=\"124\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"yq~z[gQvm;A^(5atW#me\" x=\"292\" y=\"180\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"YC=Ho5w/W7,R$dgGyX/.\" x=\"320\" y=\"236\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"create\" id=\"m@T+8nk@$H~6zD4jgdbE\" x=\"352\" y=\"282\"></block>\n</xml>', '2021-10-29 11:02:06', 1),
(280, 'test', 7, 885, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"wV|0rc**_w|hDr:Y3{;e\" x=\"126\" y=\"51\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"LyZ`E%S}BT.Bx+MWk#@a\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:02:17', 1),
(281, 'test', 8, 1610, 28, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"YKQN{/}KouMy!p[aSoyN\" x=\"93\" y=\"31\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\";A47v/,7enDVE5=Atyqa\">\n        <next>\n          <block type=\"move\" id=\"23~j5Sby$`jX29kwAy1C\">\n            <field name=\"vector\">FRONT</field>\n            <next>\n              <block type=\"move\" id=\"YSK5oD-I!|Gf*9i4aE#3\">\n                <field name=\"vector\">FRONT</field>\n                <next>\n                  <block type=\"move\" id=\"%/fd7p41PPn(}jajDSuY\">\n                    <field name=\"vector\">FRONT</field>\n                    <next>\n                      <block type=\"move\" id=\"6dre,PW3(TE]j5,jVc(k\">\n                        <field name=\"vector\">FRONT</field>\n                        <next>\n                          <block type=\"move\" id=\"OO}V5U_W7`qO|~xyx#9f\">\n                            <field name=\"vector\">LEFT</field>\n                            <next>\n                              <block type=\"create\" id=\"hi1y0ktZ?V.FFg%=-{g~\"></block>\n                            </next>\n                          </block>\n                        </next>\n                      </block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:03:05', 1),
(282, 'test', 8, 1547, 25, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"YKQN{/}KouMy!p[aSoyN\" x=\"93\" y=\"31\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\";A47v/,7enDVE5=Atyqa\">\n        <next>\n          <block type=\"move\" id=\"23~j5Sby$`jX29kwAy1C\">\n            <field name=\"vector\">FRONT</field>\n            <next>\n              <block type=\"move\" id=\"YSK5oD-I!|Gf*9i4aE#3\">\n                <field name=\"vector\">FRONT</field>\n                <next>\n                  <block type=\"move\" id=\"%/fd7p41PPn(}jajDSuY\">\n                    <field name=\"vector\">FRONT</field>\n                    <next>\n                      <block type=\"move\" id=\"OO}V5U_W7`qO|~xyx#9f\">\n                        <field name=\"vector\">LEFT</field>\n                        <next>\n                          <block type=\"create\" id=\"hi1y0ktZ?V.FFg%=-{g~\"></block>\n                        </next>\n                      </block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:03:27', 1),
(283, 'test', 1, 201, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"Hp6Y{3yNjKC!!sbU|CVy\" x=\"0\" y=\"47\">\n    <field name=\"vector\">LEFT</field>\n    <next>\n      <block type=\"destroy\" id=\"65I$vOgYCQt!#,Fg]r.8\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:04:21', 1),
(284, 'test', 2, 201, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"67Ju,hIrzx,DYuTeI3d0\" x=\"83\" y=\"36\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"Fhoci=4o$H%a@$8?J}9v\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:04:27', 1),
(285, 'test', 3, 259, 14, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"GC$l6*WIYbk3a#wJDO33\" x=\"62\" y=\"22\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"move\" id=\"Jx@9#Gz6?Lmq`^_Std=f\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"move\" id=\"RVwnmqBg]2~3hfT5~b{=\">\n            <field name=\"vector\">BACK</field>\n            <next>\n              <block type=\"destroy\" id=\"CDa!FYOPsRXAX{@p-o.5\"></block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:04:35', 1),
(286, 'test', 4, 383, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"=RrLiLauUt.n9S$YjnY6\" x=\"78\" y=\"186\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"create\" id=\"yk+{0r3#}8hW:oZJr=D;\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:04:41', 1),
(287, 'test', 5, 183, 17, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"=H5|PoloGFA|fD6LLi/#\" x=\"237\" y=\"68\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"k$[@V%D)S|VX*kmzPF8(\" x=\"264\" y=\"124\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"yq~z[gQvm;A^(5atW#me\" x=\"292\" y=\"180\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"YC=Ho5w/W7,R$dgGyX/.\" x=\"320\" y=\"236\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"create\" id=\"m@T+8nk@$H~6zD4jgdbE\" x=\"352\" y=\"282\"></block>\n</xml>', '2021-10-29 11:04:48', 1),
(288, 'test', 6, 30, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"b8T-chTl(l0$UOy/EH1|\" x=\"155\" y=\"120\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"#e#8%N#O%V{`zwcvhd77\">\n        <next>\n          <block type=\"move\" id=\"%qGMw=Q@,jk*Y]Rl?K#!\">\n            <field name=\"vector\">RIGHT</field>\n            <next>\n              <block type=\"move\" id=\"X[Hrl??ER3dw(YI^S3Nq\">\n                <field name=\"vector\">RIGHT</field>\n                <next>\n                  <block type=\"move\" id=\"~)6y4$TUMQ=[NpKec=5q\">\n                    <field name=\"vector\">RIGHT</field>\n                    <next>\n                      <block type=\"create\" id=\"[pvz*H!RCN-?)(kslkrz\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:04:54', 1),
(289, 'test', 6, 30, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"b8T-chTl(l0$UOy/EH1|\" x=\"155\" y=\"120\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"#e#8%N#O%V{`zwcvhd77\">\n        <next>\n          <block type=\"move\" id=\"%qGMw=Q@,jk*Y]Rl?K#!\">\n            <field name=\"vector\">RIGHT</field>\n            <next>\n              <block type=\"move\" id=\"X[Hrl??ER3dw(YI^S3Nq\">\n                <field name=\"vector\">RIGHT</field>\n                <next>\n                  <block type=\"move\" id=\"~)6y4$TUMQ=[NpKec=5q\">\n                    <field name=\"vector\">RIGHT</field>\n                    <next>\n                      <block type=\"create\" id=\"[pvz*H!RCN-?)(kslkrz\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:05:39', 1),
(290, 'test', 6, 66, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"b8T-chTl(l0$UOy/EH1|\" x=\"155\" y=\"120\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"#e#8%N#O%V{`zwcvhd77\">\n        <next>\n          <block type=\"move\" id=\"%qGMw=Q@,jk*Y]Rl?K#!\">\n            <field name=\"vector\">RIGHT</field>\n            <next>\n              <block type=\"move\" id=\"X[Hrl??ER3dw(YI^S3Nq\">\n                <field name=\"vector\">RIGHT</field>\n                <next>\n                  <block type=\"move\" id=\"~)6y4$TUMQ=[NpKec=5q\">\n                    <field name=\"vector\">RIGHT</field>\n                    <next>\n                      <block type=\"create\" id=\"[pvz*H!RCN-?)(kslkrz\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:06:03', 1),
(291, 'test', 6, 66, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"b8T-chTl(l0$UOy/EH1|\" x=\"155\" y=\"120\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"#e#8%N#O%V{`zwcvhd77\">\n        <next>\n          <block type=\"move\" id=\"%qGMw=Q@,jk*Y]Rl?K#!\">\n            <field name=\"vector\">RIGHT</field>\n            <next>\n              <block type=\"move\" id=\"X[Hrl??ER3dw(YI^S3Nq\">\n                <field name=\"vector\">RIGHT</field>\n                <next>\n                  <block type=\"move\" id=\"~)6y4$TUMQ=[NpKec=5q\">\n                    <field name=\"vector\">RIGHT</field>\n                    <next>\n                      <block type=\"create\" id=\"[pvz*H!RCN-?)(kslkrz\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:06:11', 1),
(292, 'test', 6, 96, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"b8T-chTl(l0$UOy/EH1|\" x=\"155\" y=\"120\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"#e#8%N#O%V{`zwcvhd77\">\n        <next>\n          <block type=\"move\" id=\"%qGMw=Q@,jk*Y]Rl?K#!\">\n            <field name=\"vector\">RIGHT</field>\n            <next>\n              <block type=\"move\" id=\"X[Hrl??ER3dw(YI^S3Nq\">\n                <field name=\"vector\">RIGHT</field>\n                <next>\n                  <block type=\"move\" id=\"~)6y4$TUMQ=[NpKec=5q\">\n                    <field name=\"vector\">RIGHT</field>\n                    <next>\n                      <block type=\"create\" id=\"[pvz*H!RCN-?)(kslkrz\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:07:50', 1),
(293, 'test', 6, 156, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"b8T-chTl(l0$UOy/EH1|\" x=\"155\" y=\"120\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"#e#8%N#O%V{`zwcvhd77\">\n        <next>\n          <block type=\"move\" id=\"%qGMw=Q@,jk*Y]Rl?K#!\">\n            <field name=\"vector\">RIGHT</field>\n            <next>\n              <block type=\"move\" id=\"X[Hrl??ER3dw(YI^S3Nq\">\n                <field name=\"vector\">RIGHT</field>\n                <next>\n                  <block type=\"move\" id=\"~)6y4$TUMQ=[NpKec=5q\">\n                    <field name=\"vector\">RIGHT</field>\n                    <next>\n                      <block type=\"create\" id=\"[pvz*H!RCN-?)(kslkrz\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:08:29', 1),
(294, 'test', 5, 236, 17, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"=H5|PoloGFA|fD6LLi/#\" x=\"237\" y=\"68\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"k$[@V%D)S|VX*kmzPF8(\" x=\"264\" y=\"124\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"yq~z[gQvm;A^(5atW#me\" x=\"292\" y=\"180\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"YC=Ho5w/W7,R$dgGyX/.\" x=\"320\" y=\"236\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"create\" id=\"m@T+8nk@$H~6zD4jgdbE\" x=\"352\" y=\"282\"></block>\n</xml>', '2021-10-29 11:08:38', 1),
(295, 'test', 7, 883, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"wV|0rc**_w|hDr:Y3{;e\" x=\"126\" y=\"51\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"LyZ`E%S}BT.Bx+MWk#@a\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:08:52', 1),
(296, 'test', 8, 1606, 28, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"YKQN{/}KouMy!p[aSoyN\" x=\"93\" y=\"31\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\";A47v/,7enDVE5=Atyqa\">\n        <next>\n          <block type=\"move\" id=\"vaDrQs1e^h_%y|/1A~/e\">\n            <field name=\"vector\">FRONT</field>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n  <block type=\"move\" id=\"3*Ojvu@Orn[G.ddu.k$n\" x=\"121\" y=\"151\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"move\" id=\"[pV85VC#D:L^uR8RTWmw\" x=\"149\" y=\"207\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"move\" id=\"KW2V3WHeJzFp.iSyU;X(\" x=\"177\" y=\"263\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"move\" id=\"m#n~g#)pZ,Xg8$9TV{xp\">\n        <field name=\"vector\">LEFT</field>\n        <next>\n          <block type=\"create\" id=\"$M,],aPotF_TCR+T8dJr\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:09:19', 1),
(297, 'test', 9, 91, 23, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"#d?=7*JaJTw-Y*E8Ci.7\" x=\"370\" y=\"98\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"}kgCHl0K6?*y`(q}Oc]M\" x=\"397\" y=\"154\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"1uXMKnxT4_M,[3~oJfI~\" x=\"425\" y=\"210\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"O,-30`NwS-SS8gP[IZzd\" x=\"453\" y=\"266\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"Efb5Ohww[A3XCS*D}:6v\" x=\"481\" y=\"322\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"~]?~eNTe@yFKBoA-S7Vl\" x=\"461\" y=\"378\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:09:33', 1),
(298, 'test', 10, 183, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"r3sPb(%P?L%(~vx~J3`3\" x=\"189\" y=\"99\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"(sp%t[cI{]qs(%si!hbo\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"destroy\" id=\"^Q/(;##?+YBV`gib(rMJ\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 11:09:50', 1),
(299, 'test', 9, 363, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"[_!M}d/G;}2fL9vrpe9A\" x=\"360\" y=\"79\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"#d?=7*JaJTw-Y*E8Ci.7\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n  </block>\n  <block type=\"destroy\" id=\"0D9#30p,IuDa]22FgN7c\" x=\"461\" y=\"410\"></block>\n</xml>', '2021-10-29 11:10:11', 1),
(300, 'test', 11, 463, 21, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"ZE5LK7T#z(h]X]SP~b+3\" x=\"188\" y=\"110\">\n    <field name=\"REPEATAMOUNT\">5</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"IKwMMoCT[^mfR;;lJQli\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"v!*74(8sEt!s}j#M.pHG\">\n        <field name=\"REPEATAMOUNT\">3</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"^+RRdStrvT0)Z*j(9iT}\">\n            <field name=\"vector\">FRONT</field>\n            <next>\n              <block type=\"destroy\" id=\"hS:GnRO0ywp2huKXCaud\"></block>\n            </next>\n          </block>\n        </statement>\n        <next>\n          <block type=\"move\" id=\"9._0[j$vC/Dg{hu4l+(+\">\n            <field name=\"vector\">LEFT</field>\n            <next>\n              <block type=\"destroy\" id=\"CCv*nj6-ShkQ.hTY`=nl\"></block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:11:11', 1),
(301, 'test', 11, 871, 13, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"ZE5LK7T#z(h]X]SP~b+3\" x=\"188\" y=\"110\">\n    <field name=\"REPEATAMOUNT\">4</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"IKwMMoCT[^mfR;;lJQli\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"v!*74(8sEt!s}j#M.pHG\">\n        <field name=\"REPEATAMOUNT\">3</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"^+RRdStrvT0)Z*j(9iT}\">\n            <field name=\"vector\">FRONT</field>\n          </block>\n        </statement>\n        <next>\n          <block type=\"destroy\" id=\"CCv*nj6-ShkQ.hTY`=nl\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:11:38', 1),
(302, 'test', 12, 1019, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(Ub^p}m]2M|:e||%m!`j\" x=\"86\" y=\"120\">\n    <field name=\"REPEATAMOUNT\">2</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"9KbKFVRmPU|61hd4$}l!\">\n        <field name=\"vector\">BACK</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"create\" id=\"Dm~N9HAlxEI=.59W6ai6\"></block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:12:04', 1),
(303, 'test', 12, 1019, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(Ub^p}m]2M|:e||%m!`j\" x=\"86\" y=\"120\">\n    <field name=\"REPEATAMOUNT\">2</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"9KbKFVRmPU|61hd4$}l!\">\n        <field name=\"vector\">BACK</field>\n        <next>\n          <block type=\"create\" id=\"Dm~N9HAlxEI=.59W6ai6\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 11:12:15', 1),
(304, 'test', 13, 1533, 12, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"G|1+kx}O(]i=v-f:Io4b\" x=\"145\" y=\"148\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"h/ho)yxOYpg^B+%cDa+H\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"move\" id=\"u^Lr:}:X!=i|ma97q3M6\">\n        <field name=\"vector\">FRONT</field>\n        <next>\n          <block type=\"destroy\" id=\"@sxft.qRPZ]ZD%YeR%M)\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:12:46', 1),
(305, 'test', 13, 1473, 12, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"G|1+kx}O(]i=v-f:Io4b\" x=\"145\" y=\"148\">\n    <field name=\"REPEATAMOUNT\">3</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"h/ho)yxOYpg^B+%cDa+H\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"move\" id=\"u^Lr:}:X!=i|ma97q3M6\">\n        <field name=\"vector\">FRONT</field>\n        <next>\n          <block type=\"create\" id=\"HBUVGpQR07Ybg0?70N1]\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:13:27', 1),
(306, 'test', 14, 1383, 17, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"M7`|qZe`;iPVm}Z/Geo9\" x=\"12\" y=\"136\">\n    <field name=\"REPEATAMOUNT\">3</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"lPBYsUOnp}G{L0}XC5o|\">\n        <field name=\"vector\">BACK</field>\n        <next>\n          <block type=\"destroy\" id=\"9aYw@Yaks]/qx9!?C1@N\"></block>\n        </next>\n      </block>\n    </statement>\n    <next>\n      <block type=\"move\" id=\"_/D.n,6ex@ZU9JbgqZE?\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"destroy\" id=\"h%|GhdYw0aoR6!$}$Cq@\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:14:03', 1);
INSERT INTO `freemode_results` (`id`, `userid`, `stagename`, `score`, `cost`, `program`, `date`, `deleted`) VALUES
(307, 'test', 14, 867, 27, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"lPBYsUOnp}G{L0}XC5o|\" x=\"206\" y=\"28\">\n    <field name=\"vector\">BACK</field>\n    <next>\n      <block type=\"destroy\" id=\"9aYw@Yaks]/qx9!?C1@N\">\n        <next>\n          <block type=\"move\" id=\"fK$%8FpTn016IX!kUa7V\">\n            <field name=\"vector\">BACK</field>\n            <next>\n              <block type=\"destroy\" id=\"c)/!Aj92@s?Zp#h9(/E_\">\n                <next>\n                  <block type=\"move\" id=\"BQVJu25b~a[M*`q{CV*_\">\n                    <field name=\"vector\">BACK</field>\n                    <next>\n                      <block type=\"move\" id=\"_/D.n,6ex@ZU9JbgqZE?\">\n                        <field name=\"vector\">RIGHT</field>\n                        <next>\n                          <block type=\"destroy\" id=\"h%|GhdYw0aoR6!$}$Cq@\"></block>\n                        </next>\n                      </block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:14:31', 1),
(308, 'test', 15, 1236, 12, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"p-rr2{!:#AbE[2kvvG5G\" x=\"201\" y=\"68\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"8)V]ZAQuIXccCKfvQ(W.\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"move\" id=\"FoA=~9,o2c`=AG0E1o1C\">\n        <field name=\"vector\">FRONT</field>\n        <next>\n          <block type=\"create\" id=\"VudM*D`I@+ZTDI-ZR|+M\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:15:00', 1),
(309, 'test', 15, 831, 23, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"ATQ/4R/=YzcK+2azo:f0\" x=\"151\" y=\"102\">\n    <field name=\"REPEATAMOUNT\">4</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"zwzvb@*W|1)=lGJhQGSL\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"move\" id=\"7o1BxC%]WIIk1l*Z6ukN\">\n        <field name=\"vector\">FRONT</field>\n        <next>\n          <block type=\"create\" id=\",2K*Atrij}cj/(a?+Ye0\">\n            <next>\n              <block type=\"move\" id=\"_fEh5kp1FV}PAQ2:c.y(\">\n                <field name=\"vector\">FRONT</field>\n                <next>\n                  <block type=\"move\" id=\"Xs`8h9WsUdf[wbGH6LIp\">\n                    <field name=\"vector\">LEFT</field>\n                    <next>\n                      <block type=\"destroy\" id=\"r$~|mQ*{RWj;]XdeWqNR\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:15:49', 1),
(310, 'test', 16, 2313, 12, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"*8%$0zP/XNUJjW3n|r##\" x=\"94\" y=\"106\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"$$]ZVD4F@nNJxLfE]g_W\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"move\" id=\"0}{fiWDhzdF|]8--B=J-\">\n        <field name=\"vector\">BACK</field>\n        <next>\n          <block type=\"create\" id=\"^S`ZJe0N1#|p!M+7uIaO\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:16:43', 1),
(311, 'test', 17, 273, 24, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"lBAC,h0rSU5~Q!5VPE=%\" x=\"83\" y=\"22\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"LVtj[fR^,-V5x.I:{]HJ\">\n        <next>\n          <block type=\"move\" id=\"YjkG/2adJ704vxdOn;EG\">\n            <field name=\"vector\">FRONT</field>\n            <next>\n              <block type=\"destroy\" id=\"!?^p9Pl@%*o4vK.qrU*j\">\n                <next>\n                  <block type=\"move\" id=\"uap/h,3t,?p7A7HDy69{\">\n                    <field name=\"vector\">FRONT</field>\n                    <next>\n                      <block type=\"create\" id=\"}]4iRuGCc|arTMKQTQoQ\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:17:45', 1),
(312, 'test', 17, 431, 16, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"nSBhoO:^z~_*o-I2fX(?\" x=\"44\" y=\"123\">\n    <field name=\"REPEATAMOUNT\">3</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"3dx%4P8LafpgKHZ8Td-2\">\n        <field name=\"vector\">FRONT</field>\n        <next>\n          <block type=\"if\" id=\"RAYucDwwPdv9(?]1Xs6!\">\n            <value name=\"STATEMENT\">\n              <block type=\"sensor_foot_dest\" id=\"V!O1fy_0oI+^K`p.!M}t\"></block>\n            </value>\n            <statement name=\"TRUE\">\n              <block type=\"destroy\" id=\"n#ONB$1Wf5N%t4[eWL#S\"></block>\n            </statement>\n            <statement name=\"FALSE\">\n              <block type=\"create\" id=\"r/N~*PA:tc9siWcGfrJn\"></block>\n            </statement>\n          </block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 11:18:19', 1),
(313, 'test', 18, 1328, 14, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"kjD)^@+b1JMIb1;!TPfp\" x=\"49\" y=\"110\">\n    <field name=\"REPEATAMOUNT\">5</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\"%1sm1^K!j]Dd-ZgEa9z=\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_floor\" id=\"!*h]RzA7:ki,jiK5,Vub\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"move\" id=\"9HRmH=.?k730Tx]qB~xN\">\n            <field name=\"vector\">FRONT</field>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"HI/7{p^F7F|P;t__W6}m\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n        <next>\n          <block type=\"destroy\" id=\"x,-UgzhM44|F.@No7}KM\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 11:19:32', 1),
(314, 'test', 19, 542, 15, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"}D*vg]|]UZ9ku7d~xeyE\" x=\"0\" y=\"0\">\n    <field name=\"REPEATAMOUNT\">8</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\"1hAJ@usvgy8v9Db5)gyZ\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_loop\" id=\"Qc{Tbc_},fq+B/,*xNJk\">\n            <field name=\"COUNTER\">4</field>\n          </block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"move\" id=\"5_jgAS?ly.%0*s12L_PE\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"~`4KE1BMx|ViM@);r!!d\">\n            <field name=\"vector\">FRONT</field>\n          </block>\n        </statement>\n        <next>\n          <block type=\"destroy\" id=\"iD53:T|6:jkeb6f.BH$6\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 11:20:43', 1),
(315, 'test', 20, 958, 14, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"kR(c8[CJf@=jQqD+`9Z0\" x=\"50\" y=\"33\">\n    <field name=\"REPEATAMOUNT\">9</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\"p3L/hLSm2@W]VL7lGG$g\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_stab\" id=\"z|Q;?I0sGRBDEgEolREY\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"move\" id=\"d)`tm~qna47Dro9EP8/:\">\n            <field name=\"vector\">BACK</field>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"HT7qnc^V,KnCbxw;fA7[\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n        <next>\n          <block type=\"destroy\" id=\"{t|%=dAw1/0(AqDGJ3%3\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 11:22:03', 1),
(316, 'test', 21, 630, 14, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"+~7en@+Jh:H4?3#^k}ec\" x=\"26\" y=\"74\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\"{Y0p.KE_6UI4Wt,l)D$%\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_dest\" id=\",Cgk%._atD8GU{CZ(9dH\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"move\" id=\"A9MA#@8bW:qIR*)CPK-l\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"3O0H6OvW0DUJYUZ=Hc9J\">\n            <field name=\"vector\">BACK</field>\n          </block>\n        </statement>\n        <next>\n          <block type=\"destroy\" id=\"SKO~irTd#Tw!7dat$xuB\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 11:24:10', 1),
(317, 'test', 21, 348, 24, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"#{XH+pO`;aNZ-ah}Op5y\" x=\"46\" y=\"49\">\n    <field name=\"vector\">BACK</field>\n    <next>\n      <block type=\"loop\" id=\"+~7en@+Jh:H4?3#^k}ec\">\n        <field name=\"REPEATAMOUNT\">4</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"destroy\" id=\"|[+[G/mVpNk+Ct~|.Q0e\">\n            <next>\n              <block type=\"move\" id=\"A++Jxldm)4HN!N]~7[T#\">\n                <field name=\"vector\">RIGHT</field>\n              </block>\n            </next>\n          </block>\n        </statement>\n        <next>\n          <block type=\"move\" id=\"L2#zAGRIYl.?GD+@qU`K\">\n            <field name=\"vector\">BACK</field>\n            <next>\n              <block type=\"loop\" id=\"qE_}I}L.b|iu%bvia{?0\">\n                <field name=\"REPEATAMOUNT\">2</field>\n                <statement name=\"REPEATBLOCK\">\n                  <block type=\"destroy\" id=\"B9o3dX6rNZv[}!/WM`A2\">\n                    <next>\n                      <block type=\"move\" id=\"t!0A(V#ry{=[{Ys%snu0\">\n                        <field name=\"vector\">RIGHT</field>\n                      </block>\n                    </next>\n                  </block>\n                </statement>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:24:51', 1),
(318, 'test', 21, 478, 20, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"#{XH+pO`;aNZ-ah}Op5y\" x=\"46\" y=\"49\">\n    <field name=\"vector\">BACK</field>\n    <next>\n      <block type=\"loop\" id=\"+~7en@+Jh:H4?3#^k}ec\">\n        <field name=\"REPEATAMOUNT\">4</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"destroy\" id=\"|[+[G/mVpNk+Ct~|.Q0e\">\n            <next>\n              <block type=\"move\" id=\"A++Jxldm)4HN!N]~7[T#\">\n                <field name=\"vector\">RIGHT</field>\n              </block>\n            </next>\n          </block>\n        </statement>\n        <next>\n          <block type=\"move\" id=\"L2#zAGRIYl.?GD+@qU`K\">\n            <field name=\"vector\">BACK</field>\n            <next>\n              <block type=\"destroy\" id=\"Q+M7S}gOJO+4f}f:NHVj\"></block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:25:13', 1),
(319, 'test', 22, 655, 24, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"fh]B~2tjK+3+%Yss}pkV\" x=\"85\" y=\"17\">\n    <field name=\"REPEATAMOUNT\">4</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"h$tu^3*n)MW]cyWO~V1%\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"if\" id=\"#:|*K?/2K2/6UKU`glwZ\">\n            <value name=\"STATEMENT\">\n              <block type=\"sensor_foot_dest\" id=\".`vE(y8RVWLHusd6s8P}\"></block>\n            </value>\n            <statement name=\"TRUE\">\n              <block type=\"destroy\" id=\"%S=ITl.?Rdl`eI0qt}:p\"></block>\n            </statement>\n            <statement name=\"FALSE\">\n              <block type=\"create\" id=\"Fp@$~ITj9c[5QXGkM6-U\"></block>\n            </statement>\n          </block>\n        </next>\n      </block>\n    </statement>\n    <next>\n      <block type=\"move\" id=\"8G~3fnlBLk,x#eYFrV/2\">\n        <field name=\"vector\">FRONT</field>\n        <next>\n          <block type=\"destroy\" id=\"`mJgpB0yd=?#Z;=[^)eO\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:26:11', 1),
(320, 'test', 23, 440, 32, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(okS9~I2$,yanz+X(d).\" x=\"68\" y=\"21\">\n    <field name=\"REPEATAMOUNT\">3</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"FXORB8pr-pP[:3GVLo`B\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"HTq7Ni~y(0_?{+,CH|%1\">\n        <field name=\"REPEATAMOUNT\">5</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"if\" id=\"XGp`w(}St/SV9[xK23)X\">\n            <value name=\"STATEMENT\">\n              <block type=\"sensor_foot_dest\" id=\"%2Bfljg;M7eX.p8./jbc\"></block>\n            </value>\n            <statement name=\"TRUE\">\n              <block type=\"destroy\" id=\"Oo;2G)pY%JtK}`=qf8=w\">\n                <next>\n                  <block type=\"move\" id=\"Ar7Lw.NDVOoLctBlx%q~\">\n                    <field name=\"vector\">RIGHT</field>\n                  </block>\n                </next>\n              </block>\n            </statement>\n            <statement name=\"FALSE\">\n              <block type=\"move\" id=\"g/@TRf?*nPC{T!Ka)eSk\">\n                <field name=\"vector\">FRONT</field>\n              </block>\n            </statement>\n          </block>\n        </statement>\n        <next>\n          <block type=\"move\" id=\"BPd!Ac2`+i^Gj2u6{=a^\">\n            <field name=\"vector\">LEFT</field>\n            <next>\n              <block type=\"move\" id=\"AE5fN|r@oY00,[$/Kf*9\">\n                <field name=\"vector\">LEFT</field>\n                <next>\n                  <block type=\"move\" id=\"IaXJ]Qh+qF5*H;vPS`4D\">\n                    <field name=\"vector\">FRONT</field>\n                    <next>\n                      <block type=\"create\" id=\"x/JO!NX.gY.Aa{].(PVh\"></block>\n                    </next>\n                  </block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:28:24', 1),
(321, 'test', 23, 496, 30, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(okS9~I2$,yanz+X(d).\" x=\"68\" y=\"21\">\n    <field name=\"REPEATAMOUNT\">3</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"FXORB8pr-pP[:3GVLo`B\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"HTq7Ni~y(0_?{+,CH|%1\">\n        <field name=\"REPEATAMOUNT\">5</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"if\" id=\"XGp`w(}St/SV9[xK23)X\">\n            <value name=\"STATEMENT\">\n              <block type=\"sensor_foot_dest\" id=\"%2Bfljg;M7eX.p8./jbc\"></block>\n            </value>\n            <statement name=\"TRUE\">\n              <block type=\"destroy\" id=\"Oo;2G)pY%JtK}`=qf8=w\">\n                <next>\n                  <block type=\"move\" id=\"Ar7Lw.NDVOoLctBlx%q~\">\n                    <field name=\"vector\">RIGHT</field>\n                  </block>\n                </next>\n              </block>\n            </statement>\n            <statement name=\"FALSE\">\n              <block type=\"move\" id=\"g/@TRf?*nPC{T!Ka)eSk\">\n                <field name=\"vector\">FRONT</field>\n              </block>\n            </statement>\n          </block>\n        </statement>\n        <next>\n          <block type=\"loop\" id=\"E*{P[lGz}/to.PTRQt}.\">\n            <field name=\"REPEATAMOUNT\">2</field>\n            <statement name=\"REPEATBLOCK\">\n              <block type=\"move\" id=\"AE5fN|r@oY00,[$/Kf*9\">\n                <field name=\"vector\">LEFT</field>\n              </block>\n            </statement>\n            <next>\n              <block type=\"move\" id=\"IaXJ]Qh+qF5*H;vPS`4D\">\n                <field name=\"vector\">FRONT</field>\n                <next>\n                  <block type=\"create\" id=\"x/JO!NX.gY.Aa{].(PVh\"></block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:28:58', 1),
(322, 'test', 23, 603, 27, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(okS9~I2$,yanz+X(d).\" x=\"68\" y=\"21\">\n    <field name=\"REPEATAMOUNT\">5</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\":!~(r{-i@M%si/_~2`A0\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_dest\" id=\"*hz(k|U].3JwE*.~ZJ`D\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"loop\" id=\"S}Z!F*3!_J3z!lYz7:J/\">\n            <field name=\"REPEATAMOUNT\">2</field>\n            <statement name=\"REPEATBLOCK\">\n              <block type=\"destroy\" id=\"?U8mZ%W:NFFf.q4%?Jll\">\n                <next>\n                  <block type=\"move\" id=\"8Rlz9Lf4?!N;,1q.Jl`v\">\n                    <field name=\"vector\">RIGHT</field>\n                  </block>\n                </next>\n              </block>\n            </statement>\n            <next>\n              <block type=\"move\" id=\"D`[tydcEQn@99__#c%4?\">\n                <field name=\"vector\">FRONT</field>\n              </block>\n            </next>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"#;0zGk9pnH(KAgDbgRXg\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"xfA/;EZf-o]cxDJw^wm4\">\n        <field name=\"REPEATAMOUNT\">2</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"%cJA)NfW[9TpXB|6rj53\">\n            <field name=\"vector\">LEFT</field>\n            <next>\n              <block type=\"create\" id=\"x)+@oI8}trQ:%-uuLMG*\"></block>\n            </next>\n          </block>\n        </statement>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:33:02', 1),
(323, 'test', 23, 603, 27, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(okS9~I2$,yanz+X(d).\" x=\"68\" y=\"21\">\n    <field name=\"REPEATAMOUNT\">5</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\":!~(r{-i@M%si/_~2`A0\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_dest\" id=\"*hz(k|U].3JwE*.~ZJ`D\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"loop\" id=\"S}Z!F*3!_J3z!lYz7:J/\">\n            <field name=\"REPEATAMOUNT\">2</field>\n            <statement name=\"REPEATBLOCK\">\n              <block type=\"destroy\" id=\"?U8mZ%W:NFFf.q4%?Jll\">\n                <next>\n                  <block type=\"move\" id=\"8Rlz9Lf4?!N;,1q.Jl`v\">\n                    <field name=\"vector\">RIGHT</field>\n                  </block>\n                </next>\n              </block>\n            </statement>\n            <next>\n              <block type=\"move\" id=\"D`[tydcEQn@99__#c%4?\">\n                <field name=\"vector\">FRONT</field>\n              </block>\n            </next>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"#;0zGk9pnH(KAgDbgRXg\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"xfA/;EZf-o]cxDJw^wm4\">\n        <field name=\"REPEATAMOUNT\">2</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"%cJA)NfW[9TpXB|6rj53\">\n            <field name=\"vector\">LEFT</field>\n            <next>\n              <block type=\"create\" id=\"x)+@oI8}trQ:%-uuLMG*\"></block>\n            </next>\n          </block>\n        </statement>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:34:01', 1),
(324, 'test', 24, 1976, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"O3;MSK;zBi$g^1Uta8W3\" x=\"51\" y=\"48\">\n    <field name=\"REPEATAMOUNT\">2</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"loop\" id=\"90H%{t8imJtYYfpj*a,z\">\n        <field name=\"REPEATAMOUNT\">2</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\",-xX^-R~dD@#hWko7{^0\">\n            <field name=\"vector\">FRONT</field>\n          </block>\n        </statement>\n        <next>\n          <block type=\"move\" id=\"6WtR#),kx[NOm)-HetIv\">\n            <field name=\"vector\">RIGHT</field>\n            <next>\n              <block type=\"destroy\" id=\"_0uXrJoT;2U81m6[I;(W\"></block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\";$@LmE4UH+pYc,i*v?S3\">\n        <field name=\"REPEATAMOUNT\">2</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"ke9}}A;(wOQBG|zs%J`d\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n        <next>\n          <block type=\"destroy\" id=\"vn,hk^SvNhjm^~%cFum%\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:35:43', 1),
(325, 'test', 24, 2430, 14, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"O3;MSK;zBi$g^1Uta8W3\" x=\"51\" y=\"48\">\n    <field name=\"REPEATAMOUNT\">8</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\"0HPCAf^MOt%]0|^AwnEv\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_stab\" id=\"C1C/$;gG(qPRpj0DB9IH\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"move\" id=\"H%Bn2:?lvjqP~Gfl-0/J\">\n            <field name=\"vector\">FRONT</field>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\".t~8/cmAGU]cts]lV`OO\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n        <next>\n          <block type=\"destroy\" id=\"vn,hk^SvNhjm^~%cFum%\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 11:36:25', 1),
(326, 'test', 23, 603, 27, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(okS9~I2$,yanz+X(d).\" x=\"68\" y=\"21\">\n    <field name=\"REPEATAMOUNT\">5</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\":!~(r{-i@M%si/_~2`A0\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_dest\" id=\"*hz(k|U].3JwE*.~ZJ`D\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"loop\" id=\"S}Z!F*3!_J3z!lYz7:J/\">\n            <field name=\"REPEATAMOUNT\">2</field>\n            <statement name=\"REPEATBLOCK\">\n              <block type=\"destroy\" id=\"?U8mZ%W:NFFf.q4%?Jll\">\n                <next>\n                  <block type=\"move\" id=\"8Rlz9Lf4?!N;,1q.Jl`v\">\n                    <field name=\"vector\">RIGHT</field>\n                  </block>\n                </next>\n              </block>\n            </statement>\n            <next>\n              <block type=\"move\" id=\"D`[tydcEQn@99__#c%4?\">\n                <field name=\"vector\">FRONT</field>\n              </block>\n            </next>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"#;0zGk9pnH(KAgDbgRXg\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"xfA/;EZf-o]cxDJw^wm4\">\n        <field name=\"REPEATAMOUNT\">2</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"%cJA)NfW[9TpXB|6rj53\">\n            <field name=\"vector\">LEFT</field>\n            <next>\n              <block type=\"create\" id=\"x)+@oI8}trQ:%-uuLMG*\"></block>\n            </next>\n          </block>\n        </statement>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:38:40', 1),
(327, 'test', 16, 2313, 12, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"*8%$0zP/XNUJjW3n|r##\" x=\"94\" y=\"106\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"$$]ZVD4F@nNJxLfE]g_W\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"move\" id=\"0}{fiWDhzdF|]8--B=J-\">\n        <field name=\"vector\">BACK</field>\n        <next>\n          <block type=\"create\" id=\"^S`ZJe0N1#|p!M+7uIaO\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:39:09', 1),
(328, 'test', 10, 183, 9, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"r3sPb(%P?L%(~vx~J3`3\" x=\"189\" y=\"99\">\n    <field name=\"REPEATAMOUNT\">6</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"(sp%t[cI{]qs(%si!hbo\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"destroy\" id=\"^Q/(;##?+YBV`gib(rMJ\"></block>\n        </next>\n      </block>\n    </statement>\n  </block>\n</xml>', '2021-10-29 11:41:02', 1),
(329, 'test', 23, 603, 27, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(okS9~I2$,yanz+X(d).\" x=\"68\" y=\"21\">\n    <field name=\"REPEATAMOUNT\">5</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\":!~(r{-i@M%si/_~2`A0\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_dest\" id=\"*hz(k|U].3JwE*.~ZJ`D\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"loop\" id=\"S}Z!F*3!_J3z!lYz7:J/\">\n            <field name=\"REPEATAMOUNT\">2</field>\n            <statement name=\"REPEATBLOCK\">\n              <block type=\"destroy\" id=\"?U8mZ%W:NFFf.q4%?Jll\">\n                <next>\n                  <block type=\"move\" id=\"8Rlz9Lf4?!N;,1q.Jl`v\">\n                    <field name=\"vector\">RIGHT</field>\n                  </block>\n                </next>\n              </block>\n            </statement>\n            <next>\n              <block type=\"move\" id=\"D`[tydcEQn@99__#c%4?\">\n                <field name=\"vector\">FRONT</field>\n              </block>\n            </next>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"#;0zGk9pnH(KAgDbgRXg\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"xfA/;EZf-o]cxDJw^wm4\">\n        <field name=\"REPEATAMOUNT\">2</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"%cJA)NfW[9TpXB|6rj53\">\n            <field name=\"vector\">LEFT</field>\n            <next>\n              <block type=\"create\" id=\"x)+@oI8}trQ:%-uuLMG*\"></block>\n            </next>\n          </block>\n        </statement>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:41:33', 1),
(330, 'test', 23, 603, 27, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(okS9~I2$,yanz+X(d).\" x=\"68\" y=\"21\">\n    <field name=\"REPEATAMOUNT\">5</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\":!~(r{-i@M%si/_~2`A0\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_dest\" id=\"*hz(k|U].3JwE*.~ZJ`D\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"loop\" id=\"S}Z!F*3!_J3z!lYz7:J/\">\n            <field name=\"REPEATAMOUNT\">2</field>\n            <statement name=\"REPEATBLOCK\">\n              <block type=\"destroy\" id=\"?U8mZ%W:NFFf.q4%?Jll\">\n                <next>\n                  <block type=\"move\" id=\"8Rlz9Lf4?!N;,1q.Jl`v\">\n                    <field name=\"vector\">RIGHT</field>\n                  </block>\n                </next>\n              </block>\n            </statement>\n            <next>\n              <block type=\"move\" id=\"D`[tydcEQn@99__#c%4?\">\n                <field name=\"vector\">FRONT</field>\n              </block>\n            </next>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"#;0zGk9pnH(KAgDbgRXg\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"xfA/;EZf-o]cxDJw^wm4\">\n        <field name=\"REPEATAMOUNT\">2</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"%cJA)NfW[9TpXB|6rj53\">\n            <field name=\"vector\">LEFT</field>\n            <next>\n              <block type=\"create\" id=\"x)+@oI8}trQ:%-uuLMG*\"></block>\n            </next>\n          </block>\n        </statement>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:46:42', 1),
(331, 'test', 23, 603, 27, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"(okS9~I2$,yanz+X(d).\" x=\"68\" y=\"21\">\n    <field name=\"REPEATAMOUNT\">5</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"if\" id=\":!~(r{-i@M%si/_~2`A0\">\n        <value name=\"STATEMENT\">\n          <block type=\"sensor_foot_dest\" id=\"*hz(k|U].3JwE*.~ZJ`D\"></block>\n        </value>\n        <statement name=\"TRUE\">\n          <block type=\"loop\" id=\"S}Z!F*3!_J3z!lYz7:J/\">\n            <field name=\"REPEATAMOUNT\">2</field>\n            <statement name=\"REPEATBLOCK\">\n              <block type=\"destroy\" id=\"?U8mZ%W:NFFf.q4%?Jll\">\n                <next>\n                  <block type=\"move\" id=\"8Rlz9Lf4?!N;,1q.Jl`v\">\n                    <field name=\"vector\">RIGHT</field>\n                  </block>\n                </next>\n              </block>\n            </statement>\n            <next>\n              <block type=\"move\" id=\"D`[tydcEQn@99__#c%4?\">\n                <field name=\"vector\">FRONT</field>\n              </block>\n            </next>\n          </block>\n        </statement>\n        <statement name=\"FALSE\">\n          <block type=\"move\" id=\"#;0zGk9pnH(KAgDbgRXg\">\n            <field name=\"vector\">RIGHT</field>\n          </block>\n        </statement>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"xfA/;EZf-o]cxDJw^wm4\">\n        <field name=\"REPEATAMOUNT\">2</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"%cJA)NfW[9TpXB|6rj53\">\n            <field name=\"vector\">LEFT</field>\n            <next>\n              <block type=\"create\" id=\"x)+@oI8}trQ:%-uuLMG*\"></block>\n            </next>\n          </block>\n        </statement>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-10-29 11:58:35', 1),
(332, 'test', 11, 871, 13, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"ZE5LK7T#z(h]X]SP~b+3\" x=\"188\" y=\"110\">\n    <field name=\"REPEATAMOUNT\">4</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"IKwMMoCT[^mfR;;lJQli\">\n        <field name=\"vector\">RIGHT</field>\n      </block>\n    </statement>\n    <next>\n      <block type=\"loop\" id=\"v!*74(8sEt!s}j#M.pHG\">\n        <field name=\"REPEATAMOUNT\">3</field>\n        <statement name=\"REPEATBLOCK\">\n          <block type=\"move\" id=\"^+RRdStrvT0)Z*j(9iT}\">\n            <field name=\"vector\">FRONT</field>\n          </block>\n        </statement>\n        <next>\n          <block type=\"destroy\" id=\"CCv*nj6-ShkQ.hTY`=nl\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-11-01 11:27:33', 1),
(333, 'test123', 1, 224, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"TaSx.;mEKSO{0`?a@*DV\" x=\"55\" y=\"60\">\n    <field name=\"vector\">LEFT</field>\n    <next>\n      <block type=\"destroy\" id=\"$ty$u*r=e?*].9ye5[oh\"></block>\n    </next>\n  </block>\n</xml>', '2021-11-01 13:02:17', 0),
(334, 'test123', 2, 224, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"s86/o_#.@]ac+){Z35sM\" x=\"89\" y=\"57\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"j|)SI{,4Vc,37V9}Hs}K\"></block>\n    </next>\n  </block>\n</xml>', '2021-11-01 13:02:27', 0),
(335, 'test123', 3, 302, 14, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"GC$l6*WIYbk3a#wJDO33\" x=\"62\" y=\"22\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"move\" id=\"Jx@9#Gz6?Lmq`^_Std=f\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"move\" id=\"RVwnmqBg]2~3hfT5~b{=\">\n            <field name=\"vector\">BACK</field>\n            <next>\n              <block type=\"destroy\" id=\"CDa!FYOPsRXAX{@p-o.5\"></block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-11-01 13:02:35', 0),
(336, 'test123', 7, 603, 19, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"wV|0rc**_w|hDr:Y3{;e\" x=\"126\" y=\"51\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"LyZ`E%S}BT.Bx+MWk#@a\">\n        <next>\n          <block type=\"move\" id=\"EOYh^HwF;zo+AY9V~@tq\">\n            <field name=\"vector\">FRONT</field>\n            <next>\n              <block type=\"move\" id=\"*WG;r@|)lg^3}bWO*0RB\">\n                <field name=\"vector\">FRONT</field>\n                <next>\n                  <block type=\"create\" id=\"Z8RA2`MRM8]`1Be_dpl_\"></block>\n                </next>\n              </block>\n            </next>\n          </block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-11-01 13:02:56', 0),
(337, 'test', 6, 156, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"D+_d+ls.`JZ(,7H5gA~)\" x=\"139\" y=\"66\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"ZG_q@(5.=UMeg:|I1{9u\"></block>\n    </next>\n  </block>\n  <block type=\"move\" id=\"[eFicAUMd3x[|HLS0HJ/\" x=\"188\" y=\"201\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"F!#rg;3,$dxsZVXn[#a!\" x=\"215\" y=\"257\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"R?aX^ei2/n)V4j$}#G8s\" x=\"243\" y=\"313\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"create\" id=\"zZ[K1_;oA.kLBd@53Fs;\" x=\"372\" y=\"384\"></block>\n</xml>', '2021-11-01 17:20:04', 0),
(338, 'test', 8, 1606, 28, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"3cjBf3m7X)LJzM1d22!,\" x=\"33\" y=\"40\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"MyRoYC;$u7.XV0[W*N8y\"></block>\n    </next>\n  </block>\n  <block type=\"move\" id=\"uIowJJiB%c_xg),MnrQb\" x=\"88\" y=\"152\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"move\" id=\"lhxv:O2M;@^(JsK+Oq#(\" x=\"116\" y=\"208\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"move\" id=\"]9GWsTu,q]-u9WNJ8RMh\" x=\"144\" y=\"264\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"move\" id=\"H[T~A0j|_WKJ*d=g-KJ.\" x=\"172\" y=\"320\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"move\" id=\"ju%2l2d)79h*S)DMbx,p\" x=\"217\" y=\"366\">\n    <field name=\"vector\">LEFT</field>\n  </block>\n  <block type=\"create\" id=\"wTlu^;^ocm/jwZo9_#+s\" x=\"239\" y=\"426\"></block>\n</xml>', '2021-11-01 17:20:23', 0),
(339, 'test', 7, 883, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"-hWfTFw$VP$ps82XORu*\" x=\"73\" y=\"47\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"MMP-gKU1ODMoir}%.w[v\"></block>\n    </next>\n  </block>\n</xml>', '2021-11-01 17:20:35', 0),
(340, 'test', 7, 883, 8, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"-hWfTFw$VP$ps82XORu*\" x=\"73\" y=\"47\">\n    <field name=\"vector\">RIGHT</field>\n    <next>\n      <block type=\"destroy\" id=\"MMP-gKU1ODMoir}%.w[v\"></block>\n    </next>\n  </block>\n</xml>', '2021-11-02 11:47:10', 0),
(341, 'test', 6, 156, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"D+_d+ls.`JZ(,7H5gA~)\" x=\"139\" y=\"66\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"ZG_q@(5.=UMeg:|I1{9u\"></block>\n    </next>\n  </block>\n  <block type=\"move\" id=\"[eFicAUMd3x[|HLS0HJ/\" x=\"188\" y=\"201\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"F!#rg;3,$dxsZVXn[#a!\" x=\"215\" y=\"257\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"R?aX^ei2/n)V4j$}#G8s\" x=\"243\" y=\"313\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"create\" id=\"zZ[K1_;oA.kLBd@53Fs;\" x=\"372\" y=\"384\"></block>\n</xml>', '2021-11-02 11:56:03', 0),
(342, 'test', 2, 0, 26, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"IzD36=ntQqNm0LWbom%2\" x=\"0\" y=\"13\">\n    <field name=\"vector\">LEFT</field>\n  </block>\n  <block type=\"move\" id=\";eo$j6DMatxm3x;vE||P\" x=\"28\" y=\"69\">\n    <field name=\"vector\">LEFT</field>\n  </block>\n  <block type=\"move\" id=\"nvSR=RY|}=yCHrd65,dO\" x=\"56\" y=\"125\">\n    <field name=\"vector\">LEFT</field>\n  </block>\n  <block type=\"move\" id=\"c/CnTjGcq4hKliGDjBZ;\" x=\"84\" y=\"181\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"3lmDn][,Zs}BcP0@aR;u\" x=\"112\" y=\"237\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"^.1%Ai0Tw~Wp*iYgf^k)\" x=\"140\" y=\"293\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"L=fJE)`pyzbUVg.16hV|\" x=\"168\" y=\"349\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"destroy\" id=\"zV4BoUd+kB[wWDXV4@2g\" x=\"195\" y=\"420\"></block>\n</xml>', '2021-11-02 12:50:08', 0),
(343, 'test', 6, 156, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"D+_d+ls.`JZ(,7H5gA~)\" x=\"139\" y=\"66\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"ZG_q@(5.=UMeg:|I1{9u\"></block>\n    </next>\n  </block>\n  <block type=\"move\" id=\"[eFicAUMd3x[|HLS0HJ/\" x=\"188\" y=\"201\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"F!#rg;3,$dxsZVXn[#a!\" x=\"215\" y=\"257\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"R?aX^ei2/n)V4j$}#G8s\" x=\"243\" y=\"313\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"create\" id=\"zZ[K1_;oA.kLBd@53Fs;\" x=\"372\" y=\"384\"></block>\n</xml>', '2021-11-02 14:46:56', 0),
(344, 'test', 6, 156, 22, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"D+_d+ls.`JZ(,7H5gA~)\" x=\"139\" y=\"66\">\n    <field name=\"vector\">FRONT</field>\n    <next>\n      <block type=\"destroy\" id=\"ZG_q@(5.=UMeg:|I1{9u\"></block>\n    </next>\n  </block>\n  <block type=\"move\" id=\"[eFicAUMd3x[|HLS0HJ/\" x=\"188\" y=\"201\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"F!#rg;3,$dxsZVXn[#a!\" x=\"215\" y=\"257\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"R?aX^ei2/n)V4j$}#G8s\" x=\"243\" y=\"313\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"create\" id=\"zZ[K1_;oA.kLBd@53Fs;\" x=\"372\" y=\"384\"></block>\n</xml>', '2021-11-02 14:47:17', 0),
(345, 'test', 13, 799, 26, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"move\" id=\"1}oE0/Rp|m,NBZF!H$j`\" x=\"111\" y=\"39\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"E%R,?BZO_ah[`_ZNkKHO\" x=\"138\" y=\"95\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"=Y/Xy15RHW~5~1JV8S=B\" x=\"166\" y=\"151\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"#q6~ZY3z^w:h/%3!]XQD\" x=\"194\" y=\"207\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"K-m!ebZKj[@0MIYrcp6C\" x=\"222\" y=\"263\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"mhthsG:w#oZ})5;CNr+;\" x=\"255\" y=\"307\">\n    <field name=\"vector\">RIGHT</field>\n  </block>\n  <block type=\"move\" id=\"n?h)R%h6D.)z+XAg^n[[\" x=\"283\" y=\"363\">\n    <field name=\"vector\">FRONT</field>\n  </block>\n  <block type=\"destroy\" id=\"=t~dy]~?EOqWA]NQ,NAG\" x=\"312\" y=\"415\"></block>\n</xml>', '2021-11-02 14:47:42', 0),
(346, 'test', 14, 1383, 17, '<xml xmlns=\"https://developers.google.com/blockly/xml\">\n  <block type=\"loop\" id=\"6QQBd_uzY1Bzjybu-_18\" x=\"72\" y=\"145\">\n    <field name=\"REPEATAMOUNT\">3</field>\n    <statement name=\"REPEATBLOCK\">\n      <block type=\"move\" id=\"hI`fn393$p_M!g*{xMN|\">\n        <field name=\"vector\">BACK</field>\n        <next>\n          <block type=\"destroy\" id=\"yS.!^}`A$@5?ez{Mv0/=\"></block>\n        </next>\n      </block>\n    </statement>\n    <next>\n      <block type=\"move\" id=\"y5vyMP4}FI^O8v_Fl:!A\">\n        <field name=\"vector\">RIGHT</field>\n        <next>\n          <block type=\"destroy\" id=\"n]IVKfA5C@C|u)fQ,PC9\"></block>\n        </next>\n      </block>\n    </next>\n  </block>\n</xml>', '2021-11-11 00:40:33', 0);

-- --------------------------------------------------------

--
-- テーブルの構造 `message`
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
-- テーブルのデータのダンプ `message`
--

INSERT INTO `message` (`id`, `serif_id`, `serif_file`, `face_file`, `serif_name`, `back_img`) VALUES
(1, 1, 0x2d2de38193e38193e381afe983bde5b882e9968be799bae3818ce980b2e381bfe38081e5b7a5e6a5ade3818ce79b9be38293e381abe381aae381a3e3819fe3819be38184e381a7e88d92e5bb83e38197e381a6e38197e381bee381a3e3819fe6a3ae2c0d0ae6a3aee381a7e381afe69ca8e38085e3818ce69eafe3828ce38081e382ace383a9e382afe382bfe3818ce68da8e381a6e38289e3828ce381a6e38184e3828b2c0d0ae3819de38293e381aae6a3aee38292e5a696e7b2bee381a8e382a2e383b3e38389e383ade382a4e38389e3818ce58d94e58a9be38197e381a6e6a3aee38292e5bea9e6b4bbe38195e3819be3828be789a9e8aa9e2d2d2c0d0ae5a696e7b2bee3808ce381bee3819fe382ace383a9e382afe382bfe3818ce68da8e381a6e38289e3828ce381a6e3828befbc81e698a8e697a5e9a091e5bcb5e381a3e381a6e7b6bae9ba97e381abe38197e3819fe381aee381abefbc81e3808d2c0d0ae5a696e7b2bee3808ce280a6e381a3e381a6e38182e3828cefbc9fe4babae99693efbc9fe3818ae383bce38184e38081e5a4a7e4b888e5a4abefbc9fe3808d2c0d0ae280a6e3839de38381e383832c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce5889de38281e381bee38197e381a6e38082e3818ae4b896e8a9b1e59e8be382a2e383b3e38389e383ade382a4e38389e381aee382a4e382a2e381a8e794b3e38197e381bee38199e38082e3808d2c0d0ae5a696e7b2bee3808ce38182e38081e382a2e383b3e38389e383ade382a4e38389efbc9fe3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce381afe38184e38082e5aeb6e4ba8be585a8e888ace381afe38282e381a1e3828de38293e381aee38193e381a8e38081e58a9be4bb95e4ba8be38282e587bae69da5e381bee38199e381aee381a7e4bd95e381aae3828ae381a8e3818ae794b3e38197e4bb98e38191e3818fe381a0e38195e38184e38082e3808d2c0d0ae5a696e7b2bee3808ce381b8e38187efbd9ee38199e38194e38184e38198e38283e38293efbc81e381a8e38193e3828de381a7e38081e381aae38293e381a7e38193e38293e381aae381a8e38193e3828de381abe38184e3828be381aeefbc9fe3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce280a6e38199e381bfe381bee3819be38293e38082e8a898e686b6e383a1e383a2e383aae3818ce5889de69c9fe58c96e38195e3828ce381a6e38197e381bee381a3e381a6e38184e3828be381aee381a7e9818ee58ebbe381aee38193e381a8e3818ce58886e3818be3828ae381bee3819be38293e38082e3808d2c0d0ae5a696e7b2bee3808ce38288e3818fe3828fe3818be38293e381aae38184e38191e381a9e38081e8a898e686b6e381aae3818fe38197e381a1e38283e381a3e3819fe381bfe3819fe38184e381ade38082e38186e383bce38293e280a6e3808d2c0d0ae5a696e7b2bee3808ce38198e38283e38182e38081e38193e381aee6a3aee38292e5bea9e6b4bbe38199e3828be3818ae6898be4bc9de38184e4b880e7b792e381abe38199e3828befbc9fe381aae38293e3818be38284e381a3e381a6e3819fe38289e6809de38184e587bae38199e3818be38282e38197e3828ce381aae38184e38197e38082e3808d2c0d0ae5a696e7b2bee3808ce381bee3819ae38081e38193e38193e381abe38182e3828be382ace383a9e382afe382bfe38292e78987e4bb98e38191e381a6e3818fe3828ce3828befbc9fe3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce58886e3818be3828ae381bee38197e3819fe38081e9a091e5bcb5e3828ae381bee38199e38082e3808d, 0x302c302c302c352c342c302c312c332c322c332c342c312c312c312c31, 'オープニングとステージ１', 'image/morigarakuta.png'),
(2, 2, 0xe5a696e7b2bee3808ce38195e38181e79d80e38184e3819fe38288e38081e38193e38193e3818ce7a781e3818ce4bd8fe38293e381a7e38184e3828be5aeb6e38082e3818ae38184e38197e38184e7b485e88cb6e381a7e38282e9a3b2e38293e381a7e4bc91e686a9e38197e381bee38197e38287efbc81e3808d2c0d0ae5a696e7b2bee3808ce381a3e381a6e38188e38188efbc81efbc9fe69ca8e3818ce58092e3828ce381a6e3828befbc81e38193e381aee381bee381bee38198e38283e5aeb6e381abe585a5e3828ce381aae38184e38288efbd9ee3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce69ca8e38292e5a38ae38197e381a6e98193e38292e9968be3818de381bee38197e38287e38186e38081e7a781e381abe4bbbbe3819be381a6e3818fe381a0e38195e38184e38082e3808d2c0d0ae5a696e7b2bee3808ce58886e3818be381a3e3819fe38081e9a091e5bcb5e381a3e381a6e381adefbc81e3808d, 0x322c332c312c31, 'ステージ２', 'image/youseihousetree.png'),
(3, 3, 0xe382a2e383b3e38389e383ade382a4e38389e3808ce7b485e88cb6e3818ae38184e38197e3818be381a3e3819fe381a7e38199e38081e38194e381a1e3819de38186e38195e381bee381a7e38197e3819fe38082e3808d2c0d0ae5a696e7b2bee3808ce38184e38184e381aee38184e38184e381aee38082e58aa9e38191e381a6e38282e38289e381a3e3819fe38197e381ade38082e3819de3828ce38198e38283e6aca1e381aee4bd9ce6a5ade381abe280a6e3808d2c0d0ae382b0e383abe383abe383abe383abe280a62c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce38193e381aee58b95e789a9e3819fe381a1e381afefbc9fe38184e381bee381abe38282e8a5b2e381a3e381a6e3818de3819de38186e381a7e38199e38191e381a9e280a6e3808d2c0d0ae5a696e7b2bee3808ce6a3aee3818ce69eafe3828ce381a6e38197e381bee381a3e3819fe381aee3818ce58e9fe59ba0e381a7e78b82e69ab4e58c96e38197e381a6e38197e381bee381a3e3819fe381aee38082e3808d2c0d0ae382ace382a6e382ace382a6e38383efbc812c0d0ae5a696e7b2bee3808ce381b2e381a8e381bee3819ae38193e38193e381afe98083e38192e38288e38186efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce381afe38081e381afe38184efbc81e3808d, 0x322c312c302c342c312c302c352c35, 'ステージ３', 'image/doubutu.png'),
(4, 4, 0xe5a696e7b2bee3808ce38193e381aee5ba83e5a0b4e381abe381afe88ab1e3818ce6a48de38188e381a6e38182e381a3e3819fe38293e381a0e38191e381a9e38081e69eafe3828ce381a6e38197e381bee381a3e3819fe3818be38289e696b0e38197e3818fe6a48de38188e381a6e38184e38193e38186efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce699aee9809ae381aee88ab1e38288e3828ae5a4a7e3818de38184e38293e381a7e38199e381ade38082e3808d2c0d0ae5a696e7b2bee3808ce38193e381aee88ab1e381abe381afe38081e591a8e3828ae381aee6a48de789a9e381abe6a084e9a48ae38292e58886e38191e4b88ee38188e381a6e38184e3828be3818be38289e5a4a7e3818de38184e381aee38082e3808d2c0d0ae5a696e7b2bee3808ce4ba8ce4babae381a7e9a091e5bcb5e381a3e381a6e6a48de38188e381a6e38184e38193e38186efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce381afe38184efbc81e3808d, 0x312c312c312c322c32, 'ステージ４', 'image/karehana.png');

-- --------------------------------------------------------

--
-- テーブルの構造 `true_serif`
--

CREATE TABLE `true_serif` (
  `serif_id` int(10) NOT NULL,
  `question_no` int(10) NOT NULL,
  `file_name` varchar(30) NOT NULL,
  `file` blob NOT NULL,
  `back_img` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `true_serif`
--

INSERT INTO `true_serif` (`serif_id`, `question_no`, `file_name`, `file`, `back_img`) VALUES
(1, 1, '一問目正解時のセリフ', 0xe5a696e7b2bee3808ce38284e381a3e3819fe381adefbc81e38193e381aee8aabfe5ad90e381a7e381a9e38293e381a9e38293e8a18ce3818fe38288efbc81e3808d2c0d0ae5a696e7b2bee3808ce6aca1e381afe38182e381a3e381a1e581b4e381aee382ace383a9e382afe382bfe38292e78987e4bb98e38191e38288e38186efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce4ba86e8a7a3e38184e3819fe38197e381bee38197e3819fe38082e3808d, 'image/morigarakuta.png'),
(2, 2, '二問目正解時のセリフ', 0xe5a696e7b2bee3808ce38184e38284e38181e383bce7b6bae9ba97e381abe381aae381a3e3819fe381ade38082e796b2e3828ce3819fe38197e38081e7a781e381aee5aeb6e381a7e4bc91e686a9e38197e38288e38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce58886e3818be3828ae381bee38197e3819fe38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e381aee4bdbfe38188e3828be98193e585b7e3818ce8a7a3e694bee38195e3828ce381bee38197e3819fe38082efbc9ae381aee38193e3818ee3828a2c0d0ae99a9ce5aeb3e789a9e38292e7a0b4e5a38ae381a7e3818de3828be38288e38186e381abe381aae3828ae381bee38197e3819fe380820d0a, 'image/mori.png'),
(3, 3, '三問目正解時のセリフ', 0xe5a696e7b2bee3808ce38284e381a3e3819fefbc81e98193e3818ce9968be38184e3819fefbc81e38182e3828ae3818ce381a8e38186e38081e382a4e382a2e38082e7b485e88cb6e38194e381a1e3819de38186e38199e3828be38288e38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce38182e3828ae3818ce381a8e38186e38081e38186e3828ce38197e38184e381a7e38199e38082e3808d, 'image/youseihouse.png'),
(4, 4, '四問目正解時のセリフ', 0xe5a696e7b2bee3808ce38282e38186e8bfbde381a3e381a6e38193e381aae38184e3818be381aae38081e889afe3818be381a3e3819fefbd9ee38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce38182e381aee58b95e789a9e3819fe381a1e38292e3818ae381a8e381aae38197e3818fe38195e3819be3828be696b9e6b395e381afe381aae38184e38293e381a7e38199e3818befbc9fe3808d2c0d0ae5a696e7b2bee3808ce6a3aee38292e5bea9e6b4bbe38195e3819be3828ce381b0e3818ae381a8e381aae38197e3818fe381aae3828be381a8e6809de38186e38082e697a9e3818fe696b9e6b395e38292e8a68be381a4e38191e381aae3818fe381a1e38283e38082e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce3819de38186e381a7e38199e381ade38081e7a781e38282e7b2bee4b880e69dafe3818ae6898be4bc9de38184e38197e381bee38199e38082e3808d, 'image/mori.png'),
(5, 5, '五問目正解時のセリフ', 0xe5a696e7b2bee3808ce7b6bae9ba97e381aae88ab1e3818ce592b2e38184e3819fe381adefbc81e38284e381a3e3819fe38181efbc81e3808d2c0d0ae382a2e383b3e38389e383ade382a4e38389e3808ce38193e3828ce381a7e6a3aee381aee5bea9e6b4bbe381abe8bf91e381a5e38184e381a6e3818de381bee38197e3819fe381ade38082e3808d2c0d0ae5a696e7b2bee3808ce3819de38186e381a0e381ade38081e6aca1e381aee4bd9ce6a5ade38282e9a091e5bcb5e3828de38186efbc81e3808d, 'image/kireihana.png');

-- --------------------------------------------------------

--
-- テーブルの構造 `users`
--

CREATE TABLE `users` (
  `id` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `pass` varchar(512) NOT NULL,
  `story_progress` int(100) NOT NULL DEFAULT '0',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sfx_volume` int(3) NOT NULL DEFAULT '50',
  `bgm_volume` int(3) NOT NULL DEFAULT '50',
  `gamespeed` int(1) NOT NULL DEFAULT '3',
  `mail_address` varchar(1024) NOT NULL,
  `mail_key` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `users`
--

INSERT INTO `users` (`id`, `name`, `pass`, `story_progress`, `update_time`, `sfx_volume`, `bgm_volume`, `gamespeed`, `mail_address`, `mail_key`) VALUES
('test', 'test', '3685f889f84cd58bcbd188e1ed6752fc5bf03b9242177383143900f620ffe5bb31edb5bdab53dd5dac14eb6131ddc5b1c40ffda8913813f5c4a87c4e1982a9db', 0, '2021-11-06 02:48:43', 50, 50, 3, 'PKvHjzZbqzuwZiiPjEkoYogwUQXmhcSKb9eV5uh1r58apsAvqMR6XTvdn0Tf26zTrdJSlQ4Muwmjq12AtGV/46ZDlmdqCnry4XnxG5Jl+JN5QcE4WkBcNsr3AjO5/dwqmHE5ojs030QHv0yC6QGq40wEFnZmn1I+ewJEpxYuPlcDFw9z4UTvwzw/KX6LvLsbcR6SVZ8RRYfYIfgbaF3N+3MOLsg0unKfNnKOO3hYnWjzD78gDpDT2+S9fE5nGK9+HjO7TxTNHXlHw/9tWirBoVdsGOZ/2rr3e2R8H5udQWDqtTGuGOKUzksGBdVzGE5HOfjNMlynLERQBTheg8dJeaSY+kI30g9Kfg1nCNzBojrBpV6Pnza8b4q5ZmUUX62UmswGeFatvL7UPZe1X5jyxwIQckvANqhV+z8uMJU/CQsOC28caR3ilTjJViIF9D05D0M7pJ04s80EeeaJVJtQq3nxMMG0pYvRFyFv0ntB06M=', '8sgxsgpdjjksogsg0w4gkkowg8sgxsgpdjjksogsg0w4gkkowg8sgxsgpdjjksogsg0w4gkkowg8sgxsgpdjjksogsg0w4gkkowg8sgxsgpdjjksogsg0w4gkkowg8sgxsgpdjjksogsg0w4gkkowg8sgxsgpdjjksogsg0w4gkkowg8sgxsgpdjjksogsg0w4gkkowg8sgxsgpdjjksogsg0w4gkkowg8sgxsgpdjjksogsg0w4gkkowg8sgxsg');

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `create_stages`
--
ALTER TABLE `create_stages`
  ADD PRIMARY KEY (`stageid`);

--
-- テーブルのインデックス `false_serif`
--
ALTER TABLE `false_serif`
  ADD UNIQUE KEY `serif_id` (`serif_id`);

--
-- テーブルのインデックス `freemode_results`
--
ALTER TABLE `freemode_results`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `message`
--
ALTER TABLE `message`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `serif_id` (`serif_id`);

--
-- テーブルのインデックス `true_serif`
--
ALTER TABLE `true_serif`
  ADD UNIQUE KEY `serif_id` (`serif_id`);

--
-- テーブルのインデックス `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mail_address` (`mail_address`);

--
-- ダンプしたテーブルのAUTO_INCREMENT
--

--
-- テーブルのAUTO_INCREMENT `create_stages`
--
ALTER TABLE `create_stages`
  MODIFY `stageid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- テーブルのAUTO_INCREMENT `false_serif`
--
ALTER TABLE `false_serif`
  MODIFY `serif_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- テーブルのAUTO_INCREMENT `freemode_results`
--
ALTER TABLE `freemode_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=347;

--
-- テーブルのAUTO_INCREMENT `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- テーブルのAUTO_INCREMENT `true_serif`
--
ALTER TABLE `true_serif`
  MODIFY `serif_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
