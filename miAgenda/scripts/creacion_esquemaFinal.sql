-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-02-2016 a las 14:47:20
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

DROP TABLE IF EXISTS `evento`;
CREATE TABLE IF NOT EXISTS `evento` (
`eve_IdEvento` bigint(20) NOT NULL,
  `eve_Fecha` date NOT NULL,
  `eve_HoraInicio` time NOT NULL,
  `eve_HoraFin` time NOT NULL,
  `eve_Nombre` varchar(100) NOT NULL,
  `eve_usr_IdUsuario` int(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `evento`
--

INSERT INTO `evento` (`eve_IdEvento`, `eve_Fecha`, `eve_HoraInicio`, `eve_HoraFin`, `eve_Nombre`, `eve_usr_IdUsuario`) VALUES
(50, '2015-11-11', '11:00:00', '16:00:00', 'Casamiento', 1),
(51, '2015-11-19', '12:00:00', '13:00:00', 'dasdsad', 1),
(52, '2012-11-12', '12:00:00', '13:00:00', 'asdsadsa', 1),
(54, '2016-01-04', '12:30:00', '13:30:00', 'Privado', 1),
(55, '2016-01-26', '04:00:00', '08:00:00', 'Mi evento privado uno', 1),
(56, '2016-01-25', '12:00:00', '13:00:00', 'asdsad', 1),
(57, '2015-11-19', '12:00:00', '13:00:00', 'sad', 1),
(58, '2015-11-19', '12:00:00', '13:00:00', 'asdsa', 1),
(71, '2016-02-24', '12:00:00', '13:00:00', 'aaa', 1),
(81, '2016-02-27', '23:00:00', '23:59:00', 'a', 1),
(85, '2016-02-29', '00:00:00', '00:30:00', 'asdsa', 5),
(95, '2016-02-22', '02:00:00', '03:30:00', 'Lunes', 1),
(96, '2016-02-25', '02:00:00', '04:00:00', 'Reunion Mike', 5),
(98, '2016-02-22', '01:00:00', '01:30:00', 'LUNES', 1),
(99, '2016-02-22', '01:00:00', '02:30:00', 'Junta', 1),
(100, '2016-02-22', '02:00:00', '05:00:00', 'Cumple mama', 5),
(101, '2016-02-22', '01:00:00', '02:30:00', 'Popo', 1),
(102, '2016-02-25', '02:30:00', '03:30:00', 'Mi evento Jueves', 1),
(103, '2016-02-22', '01:00:00', '02:30:00', 'd', 1),
(104, '2016-01-19', '04:30:00', '09:00:00', 'sadas', 1),
(105, '2016-02-29', '00:30:00', '03:00:00', 'asasa', 1),
(106, '2016-02-23', '01:00:00', '03:00:00', 'Martes', 1),
(107, '2016-02-23', '00:00:00', '02:00:00', 'Martes reunion', 1),
(108, '2016-02-29', '18:00:00', '18:30:00', 'Final Web 2', 1),
(109, '2016-03-01', '00:30:00', '02:30:00', 'Casamiento', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventoprivado`
--

DROP TABLE IF EXISTS `eventoprivado`;
CREATE TABLE IF NOT EXISTS `eventoprivado` (
  `pri_IdEventoPrivado` int(11) NOT NULL,
  `pri_Descripcion` varchar(100) DEFAULT NULL,
  `pri_Direccion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `eventoprivado`
--

INSERT INTO `eventoprivado` (`pri_IdEventoPrivado`, `pri_Descripcion`, `pri_Direccion`) VALUES
(51, 'sdsa', 'sadsad'),
(52, 'sadas', ''),
(54, 'asasasas', 'senillosa 482'),
(55, 'Dos horas de evento', 'PEdro bidegain 4242'),
(56, 'sd', 'asdsadsad'),
(71, 'aa', 'aa'),
(81, '', ''),
(85, 'a', 'asas'),
(95, '', ''),
(98, '', ''),
(101, 'lalala', 'Pedro bidegain 4242'),
(102, 'la la la', 'Directorio 161'),
(103, 'aaaaaaaaaaaaaa', 'Av. La Plata 5412'),
(105, '', ''),
(106, '', ''),
(108, 'Examen Final de Programación Web 2', 'Paraguay 1401');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventoreunion`
--

DROP TABLE IF EXISTS `eventoreunion`;
CREATE TABLE IF NOT EXISTS `eventoreunion` (
  `reu_IdEventoReunion` int(11) NOT NULL,
  `reu_Temario` varchar(100) DEFAULT NULL,
  `reu_sal_IdSala` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `eventoreunion`
--

INSERT INTO `eventoreunion` (`reu_IdEventoReunion`, `reu_Temario`, `reu_sal_IdSala`) VALUES
(50, 'bla bla bla', 3),
(57, 'asd', 1),
(58, 'asd', 1),
(96, '', 1),
(99, '', 2),
(100, 'sada', 4),
(104, '', 1),
(107, '', 4),
(109, 'Casamiento Lujan', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invitacion`
--

DROP TABLE IF EXISTS `invitacion`;
CREATE TABLE IF NOT EXISTS `invitacion` (
`inv_IdInvitacion` bigint(20) NOT NULL,
  `inv_Estado` varchar(20) NOT NULL,
  `inv_eve_IdEvento` bigint(20) NOT NULL,
  `inv_usr_IdUsuario` int(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `invitacion`
--

INSERT INTO `invitacion` (`inv_IdInvitacion`, `inv_Estado`, `inv_eve_IdEvento`, `inv_usr_IdUsuario`) VALUES
(61, 'Pendiente', 50, 3),
(62, 'Confirmado', 50, 5),
(63, 'Pendiente', 50, 4),
(64, 'Pendiente', 57, 2),
(65, 'Pendiente', 57, 4),
(144, 'Pendiente', 96, 4),
(145, 'Pendiente', 96, 2),
(146, 'Pendiente', 96, 3),
(147, 'Rechazado', 96, 1),
(151, 'Pendiente', 100, 1),
(152, 'Pendiente', 100, 4),
(153, 'Pendiente', 100, 6),
(154, 'Pendiente', 100, 3),
(158, 'Pendiente', 104, 3),
(159, 'Pendiente', 104, 5),
(160, 'Pendiente', 104, 2),
(168, 'Pendiente', 99, 2),
(169, 'Pendiente', 99, 3),
(170, 'Pendiente', 99, 50),
(171, 'Pendiente', 107, 28),
(172, 'Pendiente', 107, 6),
(173, 'Pendiente', 107, 2),
(174, 'Pendiente', 109, 8),
(175, 'Pendiente', 109, 9),
(176, 'Pendiente', 109, 4),
(177, 'Pendiente', 109, 10),
(178, 'Pendiente', 109, 2),
(179, 'Pendiente', 109, 5),
(180, 'Pendiente', 109, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sala`
--

DROP TABLE IF EXISTS `sala`;
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

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
`usr_IdUsuario` int(20) NOT NULL,
  `usr_NombreUSR` varchar(50) NOT NULL,
  `usr_Password` varchar(16) NOT NULL,
  `usr_NombreREAL` varchar(50) NOT NULL,
  `usr_Apellido` varchar(50) NOT NULL,
  `usr_Idioma` varchar(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usr_IdUsuario`, `usr_NombreUSR`, `usr_Password`, `usr_NombreREAL`, `usr_Apellido`, `usr_Idioma`) VALUES
(1, 'Martu', '1234', 'Martina', 'Fernandez', 'es'),
(2, 'Pepe', '1111', 'Jose', 'Romano', 'es'),
(3, 'Lucho', '2222', 'Luciano', 'Bongianino', 'es'),
(4, 'Chari', 'miclave', 'Candelaria', 'Piazzali', 'es'),
(5, 'Mike', '1234', 'Michael', 'Jackson', 'en'),
(6, 'Sofia', '1111', 'Sofia', 'Martinez', 'es'),
(7, 'Cata', '999', 'Catalina', 'Iglesias', 'es'),
(8, 'Jou', 'j', 'Joana', 'Gich', 'es'),
(9, 'Alan', '1212', 'Alan', 'Vera', 'es'),
(10, 'Pablito', '5252', 'Pablo', 'Bonillo', 'es'),
(11, 'Beti', '5555', 'Betiana', 'Arias', 'es'),
(12, 'Tom', 't', 'Tomas', 'Hudson', 'en'),
(13, 'Eze', 'e', 'Ezequiel', 'Urien', 'es'),
(14, 'Nico', 'n', 'Nicolas', 'Comandini', 'es'),
(15, 'Anna', 'a', 'Anna', 'Marcenall', 'es'),
(16, 'Agus', 'aaa', 'Agustina', 'Fernandez', 'es'),
(17, 'Caro', '0000', 'Carolina', 'Fernandez', 'es'),
(18, 'Ivan', 'i', 'Ivan', 'Gomez', 'es'),
(19, 'Nico', 'n', 'Nicolas', 'Bruno', 'es'),
(20, 'Estefi', '1', 'Estefania', 'Ravera', 'es'),
(21, 'Pau', 'p', 'Paula', 'Borrescio', 'es'),
(22, 'Maca', 'm', 'Macarena', 'Blasi', 'es'),
(23, 'Sil', 's', 'Silvia', 'Martinez', 'es'),
(24, 'Mati', '2', 'Matias', 'Martello', 'es'),
(25, 'Cami', 'ca', 'Camila', 'Otero', 'es'),
(26, 'Bon', 'b', 'Bon', 'Jovi', 'es'),
(27, 'Iari', '3', 'Iara', 'Dorrego', 'es'),
(28, 'Feli', 'f', 'Felipe', 'Diaz', 'es'),
(29, 'Alvaro', '123', 'Alvaro', 'Montes', 'es'),
(30, 'Dolo', '90', 'Dolores', 'Gimenez', 'es'),
(31, 'Lujan', '987', 'Lujan', 'Ferraro', 'es'),
(32, 'Miru', '4', 'Miranda', 'Aguirre', 'es'),
(33, 'Estella', 'e', 'Estella', 'Guerrero', 'es'),
(34, 'Tino', 't', 'Agustin', 'Rivero', 'es'),
(35, 'Nacho', 'n', 'Ignacio', 'Triñanes', 'es'),
(36, 'Susan', 's', 'Susana', 'Prada', 'en'),
(37, 'Otto', 'o', 'Octavio', 'Repetto', 'es'),
(38, 'Flor', 'f', 'Florencia', 'Lapas', 'es'),
(39, 'Chris', 'c', 'Christian', 'Lopez', 'es'),
(40, 'Aru', 'a', 'Ariel', 'Moeremans', 'es'),
(41, 'Marian', 'm', 'Mariano', 'Malmierca', 'es'),
(42, 'Rober', '222', 'Roberto', 'Bobino', 'es'),
(43, 'Dimas', 'd', 'Dimas', 'Fazzini', 'es'),
(44, 'Calu', 'c', 'Carla', 'Guerra', 'es'),
(45, 'Peter', 'p', 'Pedro', 'Alfonso', 'es'),
(46, 'Maru', 'm', 'Mariana', 'Ruiz', 'es'),
(47, 'Luli', '12', 'Luciana', 'Morales', 'es'),
(48, 'Vani', 'v', 'Vanina', 'Domke', 'es'),
(49, 'Clau', 'c', 'Claudia', 'Freigeiro', 'es'),
(50, 'Tomi', 't', 'Tomas', 'Hernandez', 'es'),
(51, 'Maria', 'm', 'Maria', 'Leon', 'es');

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
MODIFY `eve_IdEvento` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=110;
--
-- AUTO_INCREMENT de la tabla `invitacion`
--
ALTER TABLE `invitacion`
MODIFY `inv_IdInvitacion` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=181;
--
-- AUTO_INCREMENT de la tabla `sala`
--
ALTER TABLE `sala`
MODIFY `sal_IdSala` bigint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
MODIFY `usr_IdUsuario` int(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=52;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `evento`
--
ALTER TABLE `evento`
ADD CONSTRAINT `fk_eve_usr_IdUsuario` FOREIGN KEY (`eve_usr_IdUsuario`) REFERENCES `usuario` (`usr_IdUsuario`);

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

  