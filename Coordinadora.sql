-- Crear la base de datos
CREATE DATABASE coordinadora;

-- Usar la base de datos
USE coordinadora;

-- Crear la tabla para direcciones
CREATE TABLE direcciones (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    direccion TEXT(100) NOT NULL
);

-- Crear la tabla para tipos de cliente
CREATE TABLE tipoCliente (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL,
    tipo VARCHAR(10) NOT NULL
);

-- Crear la tabla para cargos
CREATE TABLE cargos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT(100) NOT NULL,
    ocupacion VARCHAR(11) NOT NULL
);

-- Crear la tabla para rutas
CREATE TABLE rutas (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT(100),
    nombre_ruta VARCHAR(25) NOT NULL,
    rutaGPS VARCHAR(50),
    ruta VARCHAR(50) NOT NULL
);

-- Crear la tabla para bodegas
CREATE TABLE bodegas (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    ubicacion VARCHAR(50) NOT NULL,
    capacidad VARCHAR(25) NOT NULL,
    estado TEXT(100) NOT NULL
);

-- Crear la tabla para inventarios
CREATE TABLE inventarios (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    IdBodegaFk INT(11) NOT NULL,
    IdPaquetes_InventarioFk INT(11) NOT NULL,
    FOREIGN KEY (IdBodegaFk) REFERENCES bodegas(Id)
);

-- Crear la tabla para paquetes
CREATE TABLE paquetes (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    marca VARCHAR(25) NOT NULL,
    Nacional_interNac VARCHAR(50) NOT NULL,
    costoProducto INT(25) NOT NULL,
    costoEnvio INT(50) NOT NULL,
    IdDetallesFk INT(11) NOT NULL,
    tipo_paquete VARCHAR(50) NOT NULL
);

-- Crear la tabla para detalles
CREATE TABLE detalles (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    IdPaqueteFk INT(11),
    tamano VARCHAR(25),
    peso VARCHAR(25),
    volumen VARCHAR(25),
    estado TEXT(50) NOT NULL,
    IdrutaFk INT(11) NOT NULL,
    IdEnvioFk INT(11) NOT NULL
);

-- Crear la tabla para clientes
CREATE TABLE clientes (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    edad INT(10) NOT NULL,
    IdDireccionFk INT(11) NOT NULL,
    IdTipoClienteFk INT(11) NOT NULL,
    contrasena VARCHAR(80) NOT NULL,
    FOREIGN KEY (IdDireccionFk) REFERENCES direcciones(Id),
    FOREIGN KEY (IdTipoClienteFk) REFERENCES tipoCliente(Id)
);

-- Crear la tabla para empleados
CREATE TABLE empleados (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    edad INT(10) NOT NULL,
    contrasena VARCHAR(80) NOT NULL,
    IdDireccionFk INT(11) NOT NULL,
    yearsWork INT(10) NOT NULL,
    IdCargoFk INT(11) NOT NULL,
    FOREIGN KEY (IdDireccionFk) REFERENCES direcciones(Id),
    FOREIGN KEY (IdCargoFk) REFERENCES cargos(Id)
);

-- Crear la tabla para pedidos
CREATE TABLE pedidos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    fechaPedido TIMESTAMP NOT NULL,
    IdClienteFk INT(11) NOT NULL,
    fechaEntrega TIMESTAMP NOT NULL,
    direccionEntrega VARCHAR(25) NOT NULL,
    costoProducto INT(50) NOT NULL,
    CostoEnvio INT(11) NOT NULL,
    IdPaqueteFk INT(11) NOT NULL,
    observacioneDetalles VARCHAR(50) NOT NULL,
    FOREIGN KEY (IdClienteFk) REFERENCES clientes(Id),
    FOREIGN KEY (IdPaqueteFk) REFERENCES paquetes(Id)
);

-- Crear la tabla para envios
CREATE TABLE envios (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    veiculo VARCHAR(25) NOT NULL,
    IdRutaFk INT(11) NOT NULL,
    IdBodegaFk INT(11) NOT NULL,
    IdCargoFk INT(11) NOT NULL
);

-- Crear la tabla para envio_paquete
CREATE TABLE envio_paquete (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    IdEnvioFk INT(11) NOT NULL,
    IdPaqueteFk INT(11) NOT NULL,
    FOREIGN KEY (IdEnvioFk) REFERENCES envios(Id),
    FOREIGN KEY (IdPaqueteFk) REFERENCES paquetes(Id)
);


-- Crear la tabla para paquete_inventario
CREATE TABLE paquete_inventario (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    IdInventarioFk INT(11) NOT NULL,
    IdPaqueteFk INT(11) NOT NULL,
    FOREIGN KEY (IdInventarioFk) REFERENCES inventarios(Id),
    FOREIGN KEY (IdPaqueteFk) REFERENCES paquetes(Id)
);

-- Agregar restricciones de clave externa a la tabla detalles
ALTER TABLE detalles
    ADD FOREIGN KEY (IdEnvioFk) REFERENCES envios(Id);

-- Agregar restricciones de clave externa a la tabla envios
ALTER TABLE envios
    ADD FOREIGN KEY (IdRutaFk) REFERENCES rutas(Id),
    ADD FOREIGN KEY (IdBodegaFk) REFERENCES bodegas(Id),
    ADD FOREIGN KEY (IdCargoFk) REFERENCES cargos(Id);
