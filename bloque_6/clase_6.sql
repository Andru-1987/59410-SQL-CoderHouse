DROP DATABASE IF EXISTS kmart;

CREATE DATABASE kmart;
USE kmart;

CREATE TABLE `products`(
	id_producto			INT NOT NULL AUTO_INCREMENT ,  -- DEFAULT i++
    nombre_producto		VARCHAR(100) DEFAULT 'producto x',
    precio 				FLOAT(10,2) DEFAULT 100.00,
	`nombre-cliente` 	VARCHAR(200) DEFAULT 'cliente x',
    PRIMARY KEY (id_producto)
);


-- DML INSERT 

/*
INSERT INTO tbl_name (a,b,c)
   VALUES
    (1,2,3), 
    (4,5,6), 
    (7,8,9);
*/

TRUNCATE TABLE `kmart`.`products` ;

SELECT *
FROM `kmart`.`products` ;

INSERT INTO `kmart`.`products` 
(
	id_producto
,	nombre_producto
,	precio
,	`nombre-cliente` 
) VALUES
(100,'tita',1, 'Marcelo');

INSERT INTO `kmart`.`products` 
(
	id_producto
,	nombre_producto
,	precio
,	`nombre-cliente` 
) VALUES
(NULL,'tita',1, 'Marcelo');

INSERT INTO `kmart`.`products` 
(	nombre_producto
,	precio
,	`nombre-cliente` )
VALUE
('oreo',10,'Emma');



INSERT INTO `kmart`.`products` 
(	nombre_producto
,	`nombre-cliente` )
VALUE
('arroz con leche','Maximo');



INSERT INTO `kmart`.`products` 
(	nombre_producto
,	precio
,	`nombre-cliente` )
VALUE
('papas fritas',DEFAULT,DEFAULT);


INSERT INTO `kmart`.`products` 
(	nombre_producto
-- ,	precio
-- ,	`nombre-cliente` 
)
VALUE
('papas al horno');


INSERT INTO `kmart`.`products` 
(	nombre_producto
,	precio
,	`nombre-cliente` )
VALUE
('papas francesas',NULL,NULL);


-- BULK INSERT

INSERT INTO `kmart`.`products` 
(	nombre_producto
,	precio
,	`nombre-cliente` 
) VALUES
  ('Laptop', 999.99, 'Alice Smith'),
  ('Smartphone', 699.99, 'Bob Johnson'),
  ('Tablet', 299.99, 'Charlie Brown'),
  ('Headphones', 199.99, 'David Wilson'),
  ('Smartwatch', 249.99, 'Eva Green'),
  ('Camera', 499.99, 'Frank White'),
  ('Printer', 149.99, 'Grace Black'),
  ('Monitor', 199.99, 'Hannah Blue'),
  ('Keyboard', 49.99, 'Ian Red'),
  ('Mouse', 29.99, 'Jack Yellow');

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
