-- password is 'somePassword' hashed con http://www.nitrxgen.net/hashgen/ - Ojo que tal vez haya que agregar un '*' adelante
CREATE USER 'general'@'localhost' IDENTIFIED BY PASSWORD '*somePassword'; 

CREATE SCHEMA IF NOT EXISTS `agenda`;

USE `agenda`;

--
-- Base de datos: `agenda`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadoevento`
--

CREATE TABLE IF NOT EXISTS `estadoevento` (
`est_IdEstado` int(11) NOT NULL,
  `est_Descripcion` varchar(50) NOT NULL,
  `est_Color` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estadoevento`
--

INSERT INTO `estadoevento` (`est_IdEstado`, `est_Descripcion`, `est_Color`) VALUES
(1, 'Privado', 'Azul'),
(2, 'Confirmado', 'Verde'),
(3, 'Sin Confirmar', 'Amarillo'),
(4, 'Rechazado', 'Rojo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE IF NOT EXISTS `evento` (
`eve_IdEvento` bigint(20) NOT NULL,
  `eve_Fecha` date NOT NULL,
  `eve_Dia` varchar(20) NOT NULL,
  `eve_HoraInicio` int(11) NOT NULL,
  `eve_HoraFin` int(11) NOT NULL,
  `eve_Nombre` int(11) NOT NULL,
  `eve_usr_IdUsuario` bigint(20) NOT NULL,
  `eve_Descripcion` varchar(250) DEFAULT NULL,
  `eve_Direccion` varchar(250) DEFAULT NULL,
  `eve_Temario` varchar(250) DEFAULT NULL,
  `eve_sal_IdSala` int(11) DEFAULT NULL,
  `eve_TipoEvento` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invitado`
--

CREATE TABLE IF NOT EXISTS `invitado` (
`inv_IdInvitado` bigint(20) NOT NULL,
  `inv_est_IdEstado` bigint(20) NOT NULL,
  `inv_eve_IdEvento` bigint(20) NOT NULL,
  `inv_usr_IdUsuario` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(2, 'Sala Deluxe'),
(3, 'Sala Cordoba'),
(4, 'Sala Cordoba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
`usr_IdUsuario` bigint(20) NOT NULL,
  `usr_NombreUSR` varchar(50) NOT NULL,
  `usr_Password` varchar(16) NOT NULL,
  `usr_NombreREAL` varchar(50) NOT NULL,
  `usr_Apellido` varchar(50) NOT NULL,
  `usr_Idioma` varchar(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usr_IdUsuario`, `usr_NombreUSR`, `usr_Password`, `usr_NombreREAL`, `usr_Apellido`, `usr_Idioma`) VALUES
(1, 'Martu', '1234', 'Martina', 'Fernandez', 'es'),
(2, 'Pepe', '1111', 'Jose', 'Romano', 'es'),
(3, 'Lucho', '2222', 'Luciano', 'Bongianino', 'es'),
(4, 'Chari', 'miclave', 'Candelaria', 'Piazzali', 'es'),
(5, 'Chari', 'miclave', 'Candelaria', 'Piazzali', 'es'),
(6, 'Mike', '1234', 'Michael', 'Jackson', 'en'),
(7, 'Mike', '1234', 'Michael', 'Jackson', 'en');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estadoevento`
--
ALTER TABLE `estadoevento`
 ADD PRIMARY KEY (`est_IdEstado`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
 ADD PRIMARY KEY (`eve_IdEvento`), ADD KEY `eve_usr_IdUsuario` (`eve_usr_IdUsuario`);

--
-- Indices de la tabla `invitado`
--
ALTER TABLE `invitado`
 ADD PRIMARY KEY (`inv_IdInvitado`);

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
-- AUTO_INCREMENT de la tabla `estadoevento`
--
ALTER TABLE `estadoevento`
MODIFY `est_IdEstado` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
MODIFY `eve_IdEvento` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `invitado`
--
ALTER TABLE `invitado`
MODIFY `inv_IdInvitado` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `sala`
--
ALTER TABLE `sala`
MODIFY `sal_IdSala` bigint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
MODIFY `usr_IdUsuario` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `evento`
--
ALTER TABLE `evento`
ADD CONSTRAINT `fk_eve_usr_IdUsusario` FOREIGN KEY (`eve_usr_IdUsuario`) REFERENCES `usuario` (`usr_IdUsuario`);


  
GRANT ALL PRIVILEGES ON `agenda`.* TO 'general'@'localhost'
  IDENTIFIED BY PASSWORD '*somePassword';

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
