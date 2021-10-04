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
-- データベース: `proggame`
--

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
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `freemode_results`
--

INSERT INTO `freemode_results` (`id`, `userid`, `stagename`, `score`, `cost`, `date`, `deleted`) VALUES
(1, 'test', 2, 810, 8, '2021-10-01 09:48:39', 1),
(2, 'test', 5, 810, 16, '2021-10-01 09:49:42', 1),
(3, 'test', 5, 810, 15, '2021-10-01 09:49:42', 1),
(4, 'test', 1, 0, 8, '2021-10-01 16:24:57', 1),
(5, 'test', 7, 0, 15, '2021-10-01 16:25:28', 1),
(6, 'test', 2, 0, 9, '2021-10-04 10:36:22', 0),
(7, 'test', 2, 0, 9, '2021-10-04 10:50:23', 0);

-- --------------------------------------------------------

--
-- テーブルの構造 `users`
--

CREATE TABLE `users` (
  `id` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `pass` varchar(512) NOT NULL,
  `story_progress` int(100) NOT NULL DEFAULT '0',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータのダンプ `users`
--

INSERT INTO `users` (`id`, `name`, `pass`, `story_progress`, `update_time`) VALUES
('Shiroha_F16', 'Mitta', '182052b9a60f4b3147502dda2337f948a26e93936c7e698e6393989bf37eb8f570332f79d3becfdaafc585e6c4cd3a93174a00aca5de408dae7bdb27aeb67de3', 0, '2021-09-30 09:34:50'),
('test', 'tester', 'ad541694138dc60e3e90eaed5e8699d83cc6081b96ca997e5483699e210433125625f4f771fa4f048e4158badaf6ec35e47b4316574c2147b5bc88fddf68fab9', 0, '2021-09-29 12:28:07');

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `freemode_results`
--
ALTER TABLE `freemode_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_freemode_id` (`userid`);

--
-- テーブルのインデックス `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- ダンプしたテーブルのAUTO_INCREMENT
--

--
-- テーブルのAUTO_INCREMENT `freemode_results`
--
ALTER TABLE `freemode_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `freemode_results`
--
ALTER TABLE `freemode_results`
  ADD CONSTRAINT `users_freemode_id` FOREIGN KEY (`userid`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
