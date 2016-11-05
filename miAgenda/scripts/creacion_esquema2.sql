-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-11-2015 a las 05:42:28
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
CREATE USER 'noroot'@'localhost' IDENTIFIED BY PASSWORD '*B04E11FAAAE9A5A019BAF695B40F3BF1997EB194'; 

--
-- Base de datos: `agenda`
--
CREATE DATABASE IF NOT EXISTS `agenda` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `agenda`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE IF NOT EXISTS `evento` (
`eve_IdEvento` bigint(20) NOT NULL,
  `eve_Fecha` date NOT NULL,
  `eve_HoraInicio` time NOT NULL,
  `eve_HoraFin` time NOT NULL,
  `eve_Nombre` varchar(100) NOT NULL,
  `eve_usr_IdUsuario` int(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `evento`
--

INSERT INTO `evento` (`eve_IdEvento`, `eve_Fecha`, `eve_HoraInicio`, `eve_HoraFin`, `eve_Nombre`, `eve_usr_IdUsuario`) VALUES
(47, '2015-11-20', '19:00:00', '23:00:00', 'Cumpleaños Agustina', 1),
(48, '2015-11-16', '12:00:00', '15:25:00', 'Mi evento privado', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventoprivado`
--

CREATE TABLE IF NOT EXISTS `eventoprivado` (
  `pri_IdEventoPrivado` int(11) NOT NULL,
  `pri_Descripcion` varchar(100) DEFAULT NULL,
  `pri_Direccion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `eventoprivado`
--

INSERT INTO `eventoprivado` (`pri_IdEventoPrivado`, `pri_Descripcion`, `pri_Direccion`) VALUES
(48, 'sadsda', 'sadsadsad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventoreunion`
--

CREATE TABLE IF NOT EXISTS `eventoreunion` (
  `reu_IdEventoReunion` int(11) NOT NULL,
  `reu_Temario` varchar(100) DEFAULT NULL,
  `reu_sal_IdSala` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `eventoreunion`
--

INSERT INTO `eventoreunion` (`reu_IdEventoReunion`, `reu_Temario`, `reu_sal_IdSala`) VALUES
(47, 'Cumpleaños de agustina fernandez', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invitacion`
--

CREATE TABLE IF NOT EXISTS `invitacion` (
`inv_IdInvitacion` bigint(20) NOT NULL,
  `inv_Estado` varchar(20) NOT NULL,
  `inv_eve_IdEvento` bigint(20) NOT NULL,
  `inv_usr_IdUsuario` int(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `invitacion`
--

INSERT INTO `invitacion` (`inv_IdInvitacion`, `inv_Estado`, `inv_eve_IdEvento`, `inv_usr_IdUsuario`) VALUES
(40, 'Pendiente', 47, 2),
(41, 'Pendiente', 47, 3),
(42, 'Pendiente', 47, 5),
(43, 'Pendiente', 47, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sala`
--

CREATE TABLE IF NOT EXISTS `sala` (
`sal_IdSala` bigint(11) NOT NULL,
  `sal_Descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `sala`
--

INSERT INTO `sala` (`sal_IdSala`, `sal_Descripcion`) VALUES
(1, 'Sala Deluxe'),
(2, 'Sala Cordoba'),
(3, 'Hotel Hilton'),
(4, 'Hotel Sheraton');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
`usr_IdUsuario` int(20) NOT NULL,
  `usr_NombreUSR` varchar(50) NOT NULL,
  `usr_Password` varchar(16) NOT NULL,
  `usr_NombreREAL` varchar(50) NOT NULL,
  `usr_Apellido` varchar(50) NOT NULL,
  `usr_Idioma` varchar(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usr_IdUsuario`, `usr_NombreUSR`, `usr_Password`, `usr_NombreREAL`, `usr_Apellido`, `usr_Idioma`) VALUES
(1, 'Martu', '1234', 'Martina', 'Fernandez', 'es'),
(2, 'Pepe', '1111', 'Jose', 'Romano', 'es'),
(3, 'Lucho', '2222', 'Luciano', 'Bongianino', 'es'),
(4, 'Chari', 'miclave', 'Candelaria', 'Piazzali', 'es'),
(5, 'Mike', '1234', 'Michael', 'Jackson', 'en');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
 ADD PRIMARY KEY (`eve_IdEvento`), ADD KEY `eve_usr_IdUsuario` (`eve_usr_IdUsuario`);

--
-- Indices de la tabla `eventoprivado`
--
ALTER TABLE `eventoprivado`
 ADD PRIMARY KEY (`pri_IdEventoPrivado`);

--
-- Indices de la tabla `eventoreunion`
--
ALTER TABLE `eventoreunion`
 ADD PRIMARY KEY (`reu_IdEventoReunion`);

--
-- Indices de la tabla `invitacion`
--
ALTER TABLE `invitacion`
 ADD PRIMARY KEY (`inv_IdInvitacion`), ADD KEY `inv_eve_IdEvento` (`inv_eve_IdEvento`), ADD KEY `inv_usr_IdUsuario` (`inv_usr_IdUsuario`), ADD KEY `inv_eve_IdEvento_2` (`inv_eve_IdEvento`);

--
-- Indices de la tabla `sala`
--
ALTER TABLE `sala`
 ADD PRIMARY KEY (`sal_IdSala`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
 ADD PRIMARY KEY (`usr_IdUsuario`), ADD KEY `usr_Idm_IdIdioma` (`usr_Idioma`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
MODIFY `eve_IdEvento` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT de la tabla `invitacion`
--
ALTER TABLE `invitacion`
MODIFY `inv_IdInvitacion` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=44;
--
-- AUTO_INCREMENT de la tabla `sala`
--
ALTER TABLE `sala`
MODIFY `sal_IdSala` bigint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
MODIFY `usr_IdUsuario` int(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `invitacion`
--
ALTER TABLE `invitacion`
ADD CONSTRAINT `fk_inv_eve_IdEvento` FOREIGN KEY (`inv_eve_IdEvento`) REFERENCES `evento` (`eve_IdEvento`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_inv_usr_IdUsuario` FOREIGN KEY (`inv_usr_IdUsuario`) REFERENCES `usuario` (`usr_IdUsuario`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

  
GRANT ALL PRIVILEGES ON `agenda`.* TO 'noroot'@'localhost'
  IDENTIFIED BY PASSWORD '*B04E11FAAAE9A5A019BAF695B40F3BF1997EB194';
