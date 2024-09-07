-- CLASE DE IMPORTACION
DROP DATABASE IF EXISTS mondo;
CREATE DATABASE mondo 
	CHARACTER SET utf8mb4
	COLLATE utf8mb4_unicode_ci;

USE mondo;

CREATE TABLE pais (
    id_pais INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100),
    moneda ENUM('PESOS', 'LIBRAS', 'DOLAR'),
    idioma VARCHAR(200),
    PRIMARY KEY (id_pais)
);

CREATE TABLE ciudad(
	id_ciudad INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100),
    poblacion INT,
    id_pais INT,
    PRIMARY KEY (id_ciudad)
);


CREATE TABLE ciudadano(
	cod_legajo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(200),
    email VARCHAR(200),
    PRIMARY KEY (cod_legajo)
);

ALTER TABLE ciudadano
	ADD COLUMN id_pais INT 
    -- NOT NULL
    ;

ALTER TABLE ciudadano
	ADD CONSTRAINT fk_ciudadano_pais
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
	ON UPDATE CASCADE
    -- ON DELETE CASCADE - NO ACTION - RESTRICT
    ON DELETE
		CASCADE
    ;


-- ALTER TABLE	mondo.ciudad DROP CONSTRAINT fk_pais_ciudad;
-- ALTER TABLE	mondo.ciudadano DROP CONSTRAINT fk_ciudadano_pais ;
ALTER TABLE
	mondo.ciudad
    ADD CONSTRAINT fk_pais_ciudad
    FOREIGN KEY (id_pais) REFERENCES mondo.pais(id_pais)
    ON UPDATE 
		-- SET NULL
        CASCADE
	ON DELETE
		CASCADE
    ;
    


-- INTEGRIDAD REFERENCIAL 

SELECT 
* FROM mondo.pais;


SELECT 
* FROM mondo.ciudad;

SELECT 
* FROM mondo.ciudadano;


SET SQL_SAFE_UPDATES = 0;


UPDATE mondo.pais
	SET id_pais = 30
    WHERE nombre = 'chile';

DELETE FROM mondo.pais
	WHERE id_pais = 3;