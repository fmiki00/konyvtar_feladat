-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3307
-- Létrehozás ideje: 2025. Dec 09. 10:27
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
-- Adatbázis: `fm_konyvtarfeladat`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `diak`
--

CREATE TABLE `diak` (
  `diakId` int(11) NOT NULL,
  `diakNeve` varchar(100) NOT NULL,
  `diakOsztaly` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `diak`
--

INSERT INTO `diak` (`diakId`, `diakNeve`, `diakOsztaly`) VALUES
(1, 'Farkas Miklós', 8),
(2, 'Simo Zsolt', 7),
(3, 'Medgyes Vendel', 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kolcsonzes`
--

CREATE TABLE `kolcsonzes` (
  `KolcsonzesId` int(11) NOT NULL,
  `kolcsonzesIdo` time NOT NULL,
  `diakId` int(11) NOT NULL,
  `konyvId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `kolcsonzes`
--

INSERT INTO `kolcsonzes` (`KolcsonzesId`, `kolcsonzesIdo`, `diakId`, `konyvId`) VALUES
(10, '08:25:00', 1, 1),
(11, '09:00:00', 2, 2),
(12, '09:15:00', 3, 3);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `konyv`
--

CREATE TABLE `konyv` (
  `konyvId` int(11) NOT NULL,
  `konyvCime` varchar(200) NOT NULL,
  `szerzoId` int(11) NOT NULL,
  `mufajId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `konyv`
--

INSERT INTO `konyv` (`konyvId`, `konyvCime`, `szerzoId`, `mufajId`) VALUES
(1, 'Vukk', 1, 1),
(2, 'A pál utcai fiúk', 2, 1),
(3, 'Egri csillagok', 3, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `mufaj`
--

CREATE TABLE `mufaj` (
  `mufajId` int(11) NOT NULL,
  `mufajNev` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `mufaj`
--

INSERT INTO `mufaj` (`mufajId`, `mufajNev`) VALUES
(1, 'Dráma');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szerzo`
--

CREATE TABLE `szerzo` (
  `szerzoId` int(11) NOT NULL,
  `szerzoNeve` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `szerzo`
--

INSERT INTO `szerzo` (`szerzoId`, `szerzoNeve`) VALUES
(1, 'Fekete Istvan'),
(2, 'Molnar Ferenc'),
(3, 'Gárdonyi Géza');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `diak`
--
ALTER TABLE `diak`
  ADD PRIMARY KEY (`diakId`);

--
-- A tábla indexei `kolcsonzes`
--
ALTER TABLE `kolcsonzes`
  ADD PRIMARY KEY (`KolcsonzesId`),
  ADD KEY `diakId` (`diakId`),
  ADD KEY `konyvId` (`konyvId`);

--
-- A tábla indexei `konyv`
--
ALTER TABLE `konyv`
  ADD PRIMARY KEY (`konyvId`),
  ADD KEY `szerzoId` (`szerzoId`),
  ADD KEY `mufajId` (`mufajId`);

--
-- A tábla indexei `mufaj`
--
ALTER TABLE `mufaj`
  ADD PRIMARY KEY (`mufajId`);

--
-- A tábla indexei `szerzo`
--
ALTER TABLE `szerzo`
  ADD PRIMARY KEY (`szerzoId`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `diak`
--
ALTER TABLE `diak`
  MODIFY `diakId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `kolcsonzes`
--
ALTER TABLE `kolcsonzes`
  MODIFY `KolcsonzesId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT a táblához `konyv`
--
ALTER TABLE `konyv`
  MODIFY `konyvId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `mufaj`
--
ALTER TABLE `mufaj`
  MODIFY `mufajId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `szerzo`
--
ALTER TABLE `szerzo`
  MODIFY `szerzoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `kolcsonzes`
--
ALTER TABLE `kolcsonzes`
  ADD CONSTRAINT `kolcsonzes_ibfk_1` FOREIGN KEY (`diakId`) REFERENCES `diak` (`diakId`),
  ADD CONSTRAINT `kolcsonzes_ibfk_2` FOREIGN KEY (`konyvId`) REFERENCES `konyv` (`konyvId`);

--
-- Megkötések a táblához `konyv`
--
ALTER TABLE `konyv`
  ADD CONSTRAINT `konyv_ibfk_1` FOREIGN KEY (`szerzoId`) REFERENCES `szerzo` (`szerzoId`),
  ADD CONSTRAINT `konyv_ibfk_2` FOREIGN KEY (`mufajId`) REFERENCES `mufaj` (`mufajId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
