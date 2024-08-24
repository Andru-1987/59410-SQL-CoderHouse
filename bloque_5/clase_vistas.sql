DROP DATABASE IF EXISTS clase_pre_vista;
CREATE DATABASE clase_pre_vista;
USE clase_pre_vista;


CREATE TABLE clase_pre_vista.cliente (
	id	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name_client VARCHAR(100) DEFAULT 'usuario_nuevo' COMMENT 'Es el nombre del pibe',
    day_of_birth DATE DEFAULT (CURRENT_DATE)
) COMMENT 'TABLA DE CLIENTES DE MI KIOSKO';


-- logica de negocio o  tabla de hechos
CREATE TABLE clase_pre_vista.compra (
	id	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    producto VARCHAR(200),
    precio DECIMAL(10,2) DEFAULT 1000.00,
    fecha_compra DATE DEFAULT (CURRENT_DATE),
    cliente INT
);


ALTER TABLE clase_pre_vista.compra
	ADD CONSTRAINT fk_compra_vista
    FOREIGN KEY (cliente) REFERENCES clase_pre_vista.cliente(id);




insert into cliente (id, name_client, day_of_birth) values (1, 'Shelbi', '2021-12-04');
insert into cliente (id, name_client, day_of_birth) values (2, 'Amberly', '2006-12-01');
insert into cliente (id, name_client, day_of_birth) values (3, 'Monika', '2006-08-18');
insert into cliente (id, name_client, day_of_birth) values (4, 'Benedicta', '2013-02-22');
insert into cliente (id, name_client, day_of_birth) values (5, 'Penni', '2014-08-10');
insert into cliente (id, name_client, day_of_birth) values (6, 'Morey', '2014-11-27');
insert into cliente (id, name_client, day_of_birth) values (7, 'Felipe', '2004-06-13');
insert into cliente (id, name_client, day_of_birth) values (8, 'Homerus', '2003-06-28');
insert into cliente (id, name_client, day_of_birth) values (9, 'Haskel', '2005-12-28');
insert into cliente (id, name_client, day_of_birth) values (10, 'Lani', '2007-12-24');
insert into cliente (id, name_client, day_of_birth) values (11, 'Shelden', '1999-04-15');
insert into cliente (id, name_client, day_of_birth) values (12, 'Norris', '2005-11-13');
insert into cliente (id, name_client, day_of_birth) values (13, 'Janina', '2000-04-30');
insert into cliente (id, name_client, day_of_birth) values (14, 'Rosalinda', '2000-11-15');
insert into cliente (id, name_client, day_of_birth) values (15, 'Rosamund', '1999-09-15');
insert into cliente (id, name_client, day_of_birth) values (16, 'Tye', '2010-02-05');
insert into cliente (id, name_client, day_of_birth) values (17, 'Aluino', '2018-08-05');
insert into cliente (id, name_client, day_of_birth) values (18, 'Laraine', '2009-03-30');
insert into cliente (id, name_client, day_of_birth) values (19, 'Mattias', '2011-06-12');
insert into cliente (id, name_client, day_of_birth) values (20, 'Valma', '2006-02-10');
insert into cliente (id, name_client, day_of_birth) values (21, 'Billy', '2007-01-30');
insert into cliente (id, name_client, day_of_birth) values (22, 'Moselle', '2020-07-30');
insert into cliente (id, name_client, day_of_birth) values (23, 'Lamont', '2012-08-29');
insert into cliente (id, name_client, day_of_birth) values (24, 'Annecorinne', '2004-09-07');
insert into cliente (id, name_client, day_of_birth) values (25, 'Adelaila', '2004-09-07');

INSERT INTO clase_pre_vista.compra (producto, precio, fecha_compra, cliente)
VALUES
('Producto A', 1500.00, '2024-08-01', 1),
('Producto B', 750.00, '2024-08-02', 2),
('Producto C', 1230.50, '2024-08-03', 3),
('Producto D', 500.00, '2024-08-04', 4),
('Producto E', 1340.99, '2024-08-05', 5),
('Producto F', 2000.00, '2024-08-06', 6),
('Producto G', 895.25, '2024-08-07', 7),
('Producto H', 2300.10, '2024-08-08', 8),
('Producto I', 400.00, '2024-08-09', 9),
('Producto J', 1599.99, '2024-08-10', 10),
('Producto K', 999.99, '2024-08-11', 11),
('Producto L', 1050.75, '2024-08-12', 12),
('Producto M', 2550.00, '2024-08-13', 13),
('Producto N', 1345.99, '2024-08-14', 14),
('Producto O', 700.00, '2024-08-15', 15),
('Producto P', 875.50, '2024-08-16', 16),
('Producto Q', 400.00, '2024-08-17', 17),
('Producto R', 600.00, '2024-08-18', 18),
('Producto S', 900.00, '2024-08-19', 19),
('Producto T', 1200.00, '2024-08-20', 20);


INSERT INTO clase_pre_vista.compra (producto, precio, fecha_compra, cliente)
VALUES 
('Producto G', 895.25, '2024-08-07', 7),
('Producto H', 95.25, '2024-08-07', 7),
('Producto B', 85.25, '2024-08-07', 7),
('Producto 4', 89.25, '2024-08-07', 7),
('Producto 87123', 895.25, '2024-08-07', 7);


-- VISTAS
 
 DROP VIEW IF EXISTS clase_pre_vista.vw_cliente_nombre  ;
 
 CREATE VIEW clase_pre_vista.vw_cliente_nombre
	AS
		SELECT name_client
		FROM clase_pre_vista.cliente;
 
 
 SELECT  *
 FROM clase_pre_vista.vw_cliente_nombre;
 
 
 -- CLIENTE TODOS LOS QUE EMPIECEN CON LA LETRA M y CREAR UN EMAIL
 -- CON ESE CLIENTE
CREATE  
	OR REPLACE VIEW clase_pre_vista.vw_cliente_nombre_estef
AS 
	SELECT
		name_client,  -- 2
		CONCAT(LOWER(name_client),'@coderhouse-kiosko.com.ar') AS email -- 2
	FROM clase_pre_vista.cliente  -- 1
		WHERE name_client LIKE 'm%'  -- 3
	;
 
  
 SELECT *
 FROM  clase_pre_vista.vw_cliente_nombre_estef;
 


-- ventas de cada uno de mis clientes totales
-- ordenalo por mayor cantidad de ventas 

CREATE OR REPLACE VIEW clase_pre_vista.vw_ventas_gonza
AS
	SELECT 
	c.id ,
	LOWER(c.name_client) AS CLIENTE,
	COUNT(co.cliente) AS CANT_VENTAS   -- COUNT(*) vs COUNT(1)
	FROM clase_pre_vista.cliente AS c
		LEFT JOIN clase_pre_vista.compra AS co
			ON c.id = co.cliente
	GROUP BY c.id 
	ORDER BY CANT_VENTAS DESC
;

SELECT 
	*
FROM clase_pre_vista.vw_ventas_gonza LIMIT 3
;
