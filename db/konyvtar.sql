-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3307
-- Létrehozás ideje: 2025. Dec 09. 09:34
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `konyvtar`
--
CREATE DATABASE IF NOT EXISTS `konyvtar` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `konyvtar`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `diak`
--

CREATE TABLE `diak` (
  `diak_id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `osztaly` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `diak`
--

INSERT INTO `diak` (`diak_id`, `nev`, `osztaly`) VALUES
(1, 'Nagy Anna', '6.A'),
(2, 'Kiss Bence', '7.B'),
(3, 'Tóth Lili', '5.C'),
(4, 'Szabó Márk', '8.A');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kolcsonzes`
--

CREATE TABLE `kolcsonzes` (
  `kolcsonzes_id` int(11) NOT NULL,
  `diak_id` int(11) NOT NULL,
  `konyv_id` int(11) NOT NULL,
  `datum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `kolcsonzes`
--

INSERT INTO `kolcsonzes` (`kolcsonzes_id`, `diak_id`, `konyv_id`, `datum`) VALUES
(1, 1, 1, '2024-01-10'),
(2, 1, 2, '2024-02-05'),
(3, 2, 1, '2024-03-01'),
(4, 3, 4, '2024-04-12');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `konyv`
--

CREATE TABLE `konyv` (
  `konyv_id` int(11) NOT NULL,
  `cim` varchar(200) NOT NULL,
  `szerzo` varchar(100) NOT NULL,
  `mufaj_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `konyv`
--

INSERT INTO `konyv` (`konyv_id`, `cim`, `szerzo`, `mufaj_id`) VALUES
(1, 'Egri csillagok', 'Gárdonyi Géza', 1),
(2, 'A Pál utcai fiúk', 'Molnár Ferenc', 1),
(3, 'A Föld titkai', 'Dr. Kiss Péter', 3),
(4, 'Toldi', 'Arany János', 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `mufaj`
--

CREATE TABLE `mufaj` (
  `mufaj_id` int(11) NOT NULL,
  `mufaj_nev` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `mufaj`
--

INSERT INTO `mufaj` (`mufaj_id`, `mufaj_nev`) VALUES
(1, 'Regény'),
(2, 'Ifjúsági'),
(3, 'Ismeretterjesztő'),
(4, 'Dráma');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `diak`
--
ALTER TABLE `diak`
  ADD PRIMARY KEY (`diak_id`);

--
-- A tábla indexei `kolcsonzes`
--
ALTER TABLE `kolcsonzes`
  ADD PRIMARY KEY (`kolcsonzes_id`),
  ADD KEY `diak_id` (`diak_id`),
  ADD KEY `konyv_id` (`konyv_id`);

--
-- A tábla indexei `konyv`
--
ALTER TABLE `konyv`
  ADD PRIMARY KEY (`konyv_id`),
  ADD KEY `mufaj_id` (`mufaj_id`);

--
-- A tábla indexei `mufaj`
--
ALTER TABLE `mufaj`
  ADD PRIMARY KEY (`mufaj_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `diak`
--
ALTER TABLE `diak`
  MODIFY `diak_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `kolcsonzes`
--
ALTER TABLE `kolcsonzes`
  MODIFY `kolcsonzes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `konyv`
--
ALTER TABLE `konyv`
  MODIFY `konyv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `mufaj`
--
ALTER TABLE `mufaj`
  MODIFY `mufaj_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `kolcsonzes`
--
ALTER TABLE `kolcsonzes`
  ADD CONSTRAINT `kolcsonzes_ibfk_1` FOREIGN KEY (`diak_id`) REFERENCES `diak` (`diak_id`),
  ADD CONSTRAINT `kolcsonzes_ibfk_2` FOREIGN KEY (`konyv_id`) REFERENCES `konyv` (`konyv_id`);

--
-- Megkötések a táblához `konyv`
--
ALTER TABLE `konyv`
  ADD CONSTRAINT `konyv_ibfk_1` FOREIGN KEY (`mufaj_id`) REFERENCES `mufaj` (`mufaj_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
