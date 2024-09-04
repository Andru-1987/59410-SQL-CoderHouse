DROP DATABASE IF EXISTS kmart;

CREATE DATABASE kmart;
USE kmart;

CREATE TABLE `products`(
	id_producto			INT NOT NULL AUTO_INCREMENT ,  -- DEFAULT i++
    nombre_producto		VARCHAR(100) DEFAULT 'producto x',
    precio 				FLOAT(10,2) DEFAULT 100.00,
	`nombre-cliente` 	VARCHAR(200) DEFAULT 'cliente x',
    -- status				BOOL DEFAULT TRUE ,
    PRIMARY KEY (id_producto)
);

INSERT INTO `kmart`.`products` 
(	nombre_producto
,	precio
,	`nombre-cliente` 
) VALUES
('Ham - Smoked, Bone - In', 77.33, 'Plambee'),
('Glass Clear 7 Oz Xl', 25.59, 'Brainverse'),
('Sauce - Apple, Unsweetened', 51.65, 'Kaymbo'),
('Beef - Tenderloin Tails', 11.8, 'Skiptube'),
('Latex Rubber Gloves Size 9', 89.56, 'Topicstorm'),
('Cup - 6oz, Foam', 21.39, 'Photobean'),
('Sauce - Oyster', 35.61, 'Meezzy'),
('Soup Campbells Split Pea And Ham', 66.32, 'Eamia'),
('Cheese - Fontina', 90.08, 'Fivespan'),
('Quail - Whole, Bone - In', 66.01, 'Mybuzz'),
('Pastry - Banana Tea Loaf', 54.39, 'Mita'),
('Lamb - Leg, Diced', 60.15, 'Kwilith'),
('Madeira', 90.7, 'Zooxo'),
('Sproutsmustard Cress', 58.49, 'Dabshots'),
('Crackers - Graham', 78.46, 'Bubblebox'),
('Jello - Assorted', 34.55, 'Thoughtsphere'),
('Pea - Snow', 91.8, 'Tagpad'),
('Pheasants - Whole', 63.83, 'Talane'),
('Chips Potato Reg 43g', 59.43, 'Skilith'),
('Bread - Sticks, Thin, Plain', 69.5, 'Gigabox'),
('Crush - Grape, 355 Ml', 23.2, 'Youspan'),
('Longos - Chicken Curried', 14.7, 'Livetube'),
('Seedlings - Clamshell', 70.6, 'Kwilith'),
('Olive - Spread Tapenade', null, 'Mydeo'),
('Beef - Inside Round', 73.97, 'Browsebug'),
('Haggis', null, 'Skinte'),
('Chips - Assorted', 23.05, 'Camido'),
('Carrots - Purple, Organic', 56.06, 'Ooba'),
('Onions - Green', null, 'Wikibox'),
('Dc - Sakura Fu', 77.18, 'Agimba'),
('Crab - Claws, Snow 16 - 24', 93.92, 'Bubbletube'),
('Mushroom - Lg - Cello', 89.53, 'Skyndu'),
('Glass - Wine, Plastic, Clear 5 Oz', 38.05, 'Wikibox'),
('Ice Cream - Super Sandwich', 44.08, 'Oba'),
('Quail - Jumbo', 48.56, 'Mynte'),
('Cinnamon Rolls', 83.72, 'Brightbean'),
('Tea - Darjeeling, Azzura', 63.12, 'Buzzbean'),
('Wine - Chateau Timberlay', 94.05, 'Skiptube'),
('Pork - Tenderloin, Fresh', 52.06, 'Leexo'),
('Gatorade - Xfactor Berry', 65.52, 'Skinte'),
('Creme De Menth - White', null, 'Trudeo'),
('Pasta - Ravioli', 76.03, 'Skyble'),
('Juice - V8, Tomato', 85.05, 'Feedfire'),
('Chocolate - Pistoles, Lactee, Milk', null, 'Devpoint'),
('Black Currants', null, 'Skiba'),
('Veal - Ground', 57.74, 'Trupe'),
('Soup Campbells - Italian Wedding', 14.59, 'Zooveo'),
('Cherries - Bing, Canned', null, 'Edgeclub'),
('Cleaner - Pine Sol', 15.72, 'Eidel'),
('Chicken - Base', null, 'Skajo'),
('Lemon Pepper', 97.99, 'Voonix'),
('Oven Mitt - 13 Inch', 48.54, 'Shuffledrive'),
('Sherry - Dry', 45.97, 'Buzzshare'),
('Mousse - Passion Fruit', 30.66, 'Skinix'),
('Pastry - Butterscotch Baked', 76.05, 'Meembee'),
('Chicken Breast Wing On', 86.94, 'Bubbletube'),
('Wine - Rosso Del Veronese Igt', 43.86, 'Agivu'),
('Yeast Dry - Fermipan', 28.09, 'Pixope'),
('Placemat - Scallop, White', 66.38, 'Abatz'),
('Syrup - Kahlua Chocolate', 42.16, 'Rhycero'),
('Wonton Wrappers', 62.73, 'Zoombeat'),
('Cheese - St. Paulin', 59.95, 'Aibox'),
('Cheese - Shred Cheddar / Mozza', null, 'Demizz'),
('Table Cloth 72x144 White', 30.41, 'Skidoo'),
('Brandy - Bar', 27.31, 'Flipbug'),
('Campari', 12.69, 'Buzzshare'),
('Wine - Valpolicella Masi', 66.81, 'Kwilith'),
('Bread - Bistro White', 38.53, 'Trunyx'),
('Cheese - Wine', 43.82, 'Skinte'),
('Pie Box - Cello Window 2.5', 78.06, 'Zoovu'),
('Pasta - Shells, Medium, Dry', 56.03, 'LiveZ'),
('Cheese - Le Cheve Noir', 88.16, 'Skibox'),
('Cheese Cloth', 38.03, 'Gigashots'),
('Frangelico', 24.39, 'Podcat'),
('Water - Green Tea Refresher', 73.03, 'Roomm'),
('Chocolate - Dark Callets', 91.01, 'Miboo');


DROP DATABASE IF EXISTS miguel_ventas;
CREATE DATABASE miguel_ventas;

CREATE TABLE miguel_ventas.total_segmentos(
id_segmentos INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
categoria VARCHAR(200),
ventas_totales DECIMAL(10,2),
fecha_de_informacion DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

/*
INSERT INTO miguel_ventas.total_segmentos
(categoria,ventas_totales)
SELECT 
categoria
, IFNULL(SUM(precio),0.00) AS TOTAL_POR_CATEGORIA
FROM 
(SELECT 
id_producto
, nombre_producto
, precio
, CASE
WHEN precio IS NULL THEN 'CATEGORIA NO ENCONTRADA'
WHEN precio BETWEEN 0 AND 20 THEN 'CATEGORIA BAJA'
WHEN precio BETWEEN 21 AND 50 THEN 'CATEGORIA MEDIA'
ELSE 'CATEGORIA PREMIUM'
END AS categoria
FROM `kmart`.`products` ) AS segmento

GROUP BY categoria 
;
*/

-- CREACION DE TABLA TEMPORAL PARA USO INTERNO
DROP TABLE IF EXISTS temp_segmentos;
CREATE TEMPORARY TABLE temp_segmentos
AS
SELECT 
id_producto
, nombre_producto
, precio
, CASE
	WHEN precio IS NULL THEN 'CATEGORIA NO ENCONTRADA'
	WHEN precio BETWEEN 0 AND 20 THEN 'CATEGORIA BAJA'
	WHEN precio BETWEEN 21 AND 50 THEN 'CATEGORIA MEDIA'
	ELSE 'CATEGORIA PREMIUM'
END AS categoria
FROM `kmart`.`products` ;


-- AGRUPAR PARA TENER SEGMENTOS AGRUPADOS
INSERT INTO miguel_ventas.total_segmentos
(categoria,ventas_totales)
	SELECT 
		categoria
	,	IFNULL(SUM(precio),0.00) AS TOTAL_POR_CATEGORIA
	FROM temp_segmentos
    GROUP BY categoria;


SELECT * FROM miguel_ventas.total_segmentos;

INSERT INTO `kmart`.`products` 
(	nombre_producto
,	precio
,	`nombre-cliente` 
) VALUES
('Ham - Smoked, Bone - In', 108.33, 'Plambee'),
('Glass Clear 7 Oz Xl', 99.99, 'Brainverse');



-- 

UPDATE `kmart`.`products` AS o -- original
	SET precio = 44.89
    WHERE 
		EXISTS   -- donde viven
		(SELECT 
			-- 	1
            *
			FROM temp_segmentos AS temp
			WHERE categoria LIKE 'CATEGORIA NO ENCONTRADA'
				AND temp.id_producto = o.id_producto);


SELECT * FROM `kmart`.`products` ;
