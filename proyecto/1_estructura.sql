DROP DATABASE IF EXISTS nautilus;
CREATE DATABASE nautilus;
USE nautilus;

CREATE TABLE CLIENTE(
id_cliente INT NOT NULL AUTO_INCREMENT,
dni VARCHAR(11),
cuenta VARCHAR(200),
email VARCHAR(254),
PRIMARY KEY (id_cliente)
) COMMENT 'INFORMACION BASICA DEL CLIENTE';

CREATE TABLE VEHICULO(
id_vehiculo INT NOT NULL AUTO_INCREMENT,
fecha_vehiculo DATE,
modelo VARCHAR(200),
tipo_vehiculo VARCHAR(200),
PRIMARY KEY(id_vehiculo)
);


CREATE TABLE TALLER(
id_taller INT NOT NULL AUTO_INCREMENT,
cuit VARCHAR(13),
tipo_reparacion VARCHAR(200),
comentarios_de_reparacion TEXT,
PRIMARY KEY(id_taller)
);

CREATE TABLE TASACION(
id_tasacion INT NOT NULL AUTO_INCREMENT,
fecha_tasacion DATETIME DEFAULT (CURRENT_TIMESTAMP),
coste DECIMAL(12,2),
tasador VARCHAR(200),
id_vehiculo INT,
PRIMARY KEY(id_tasacion)
);


CREATE TABLE TRANSACCION(
id_transaccion INT NOT NULL AUTO_INCREMENT,
id_vehiculo INT,
id_cliente INT,
fecha DATE DEFAULT (CURRENT_DATE),
importe DECIMAL(12,2) DEFAULT 50000.00,
PRIMARY KEY (id_transaccion)
)COMMENT 'TABLA LOGICA DEL NEGOCIO, VENTAS Y COMPRAS DE VEHICULOS';


CREATE TABLE TALLER_VEHICULO(
id_repacion INT NOT NULL AUTO_INCREMENT,
id_taller  INT,
id_vehiculo INT,
fecha_reparacion DATETIME DEFAULT (CURRENT_TIMESTAMP),
PRIMARY KEY(id_repacion)
);


-- ALTER
-- TASACION
ALTER TABLE TASACION
	ADD CONSTRAINT fk_tasacion_vehiculo
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo);


ALTER TABLE TRANSACCION
	ADD CONSTRAINT fk_trans_cliente
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente);

ALTER TABLE TRANSACCION
	ADD CONSTRAINT  fk_trans_vehiculo
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo);
    
ALTER TABLE TALLER_VEHICULO
	ADD CONSTRAINT  fk_taller_vehiculo
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo);
    
ALTER TABLE TALLER_VEHICULO
	ADD CONSTRAINT  fk_taller_taller
    FOREIGN KEY (id_taller) REFERENCES TALLER(id_taller);
    
    