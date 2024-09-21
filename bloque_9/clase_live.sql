USE nautilus ;


-- TRIGGER DE VALIDACION
-- BEFORE INSERT 
/*

--> DELIMITER
CREATE
    TRIGGER [IF NOT EXISTS] trigger_name
    trigger_time trigger_event
    ON tbl_name FOR EACH ROW
    trigger_body  -> BEGIN -END
    
trigger_time: { BEFORE | AFTER }
trigger_event: { INSERT | UPDATE | DELETE }

*/


SELECT * FROM CLIENTE;

DROP TRIGGER IF EXISTS nautilus.before_insert_trigger_validacion_cuenta;
DROP TRIGGER IF EXISTS nautilus.before_update_trigger_validacion_cuenta;
DROP TRIGGER IF EXISTS nautilus.before_delete_trigger_validacion_cuenta;

DELIMITER //
CREATE
	TRIGGER nautilus.before_insert_trigger_validacion_cuenta
	BEFORE INSERT ON nautilus.CLIENTE
    FOR EACH ROW
	BEGIN
		IF NEW.cuenta NOT LIKE 'ES792%' THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'NO PERTENECE A LA CUENTA AFILIADA';
		END IF;
    END //
    
    
CREATE
	TRIGGER nautilus.before_update_trigger_validacion_cuenta
	BEFORE UPDATE ON nautilus.CLIENTE
    FOR EACH ROW
	BEGIN
		IF (OLD.email LIKE '%@mail.com' AND NEW.email LIKE '%@yahoo.com') THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'NO PERMITE EL CAMBIOA ESA CUENTA DE EMAIL';    
		END IF;
    END //

CREATE
	TRIGGER nautilus.before_delete_trigger_validacion_cuenta
	BEFORE DELETE ON nautilus.CLIENTE
    FOR EACH ROW
	BEGIN
		IF (OLD.email LIKE '%@example.com') THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'NO TE DEJO IR';    
		END IF;
    END //
    
DELIMITER ;

INSERT INTO nautilus.CLIENTE
VALUES
(NULL,'9382823823','ES792-8912739817928','pablo@mail.com');


SET SQL_SAFE_UPDATES = 0;

UPDATE nautilus.CLIENTE
	SET email = 'pablito_emoxito@yahoo.com'
    WHERE email = 'pablo@mail.com';

UPDATE nautilus.CLIENTE
	SET email = 'sixto_romano@yahoo.com'
    WHERE email = 'cliente6@example.com';
        

DELETE FROM nautilus.CLIENTE
	WHERE email = 'cliente3@example.com';
    
    
    
-- TRIGGERS DE AUDITORIA
CREATE TABLE nautilus.log_cambio_vehiculo
	(
		id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        id_vehiculo INT ,
		fecha_vehiculo DATE,
		modelo VARCHAR(200),
        tipo_vehiculo VARCHAR(200),
        usuario_cambio VARCHAR(200),
        fecha_cuando_cambio DATETIME DEFAULT (CURRENT_TIMESTAMP),
        tipo_modificacion ENUM('BORRADO','ACTUALIZADO')
    );

CREATE TABLE nautilus.log_cambio_vehiculo_verbose
	(
		id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        id_vehiculo INT ,
        id_vehiculo_viejo INT ,
		fecha_vehiculo DATE,
        fecha_vehiculo_viejo DATE,
		modelo VARCHAR(200),
        modelo_viejo VARCHAR(200),
        tipo_vehiculo VARCHAR(200),
        tipo_vehiculo_viejo VARCHAR(200),
        usuario_cambio VARCHAR(200),
        fecha_cuando_cambio DATETIME DEFAULT (CURRENT_TIMESTAMP),
        tipo_modificacion ENUM('BORRADO','ACTUALIZADO')
    );


DROP TRIGGER IF EXISTS nautilus.after_update_vehiculo;
DROP TRIGGER IF EXISTS nautilus.after_update_vehiculo_verbose;

DELIMITER //
CREATE 
	TRIGGER nautilus.after_update_vehiculo
    AFTER UPDATE ON nautilus.VEHICULO
    FOR EACH ROW
BEGIN
	INSERT INTO 
    nautilus.log_cambio_vehiculo
    (
	 id_vehiculo
	,fecha_vehiculo
	,modelo
	,tipo_vehiculo
	,usuario_cambio
	,tipo_modificacion)
    VALUES
    (
	 OLD.id_vehiculo
    ,OLD.fecha_vehiculo
    ,OLD.modelo
    ,OLD.tipo_vehiculo
    ,SESSION_USER()
    ,2
    );
END //


DELIMITER //
CREATE 
	TRIGGER nautilus.after_delete_vehiculo
    AFTER DELETE ON nautilus.VEHICULO
    FOR EACH ROW
BEGIN
	INSERT INTO 
    nautilus.log_cambio_vehiculo
    (
	 id_vehiculo
	,fecha_vehiculo
	,modelo
	,tipo_vehiculo
	,usuario_cambio
	,tipo_modificacion)
    VALUES
    (
	 OLD.id_vehiculo
    ,OLD.fecha_vehiculo
    ,OLD.modelo
    ,OLD.tipo_vehiculo
    ,SESSION_USER()
    ,1
    );
END //
    
DELIMITER ;
    
DELIMITER //
CREATE 
	TRIGGER nautilus.after_update_vehiculo_verbose
    AFTER UPDATE ON nautilus.VEHICULO
    FOR EACH ROW
BEGIN
	INSERT INTO 
    nautilus.log_cambio_vehiculo_verbose
    (
	 id_vehiculo
	,id_vehiculo_viejo
	,fecha_vehiculo
    ,fecha_vehiculo_viejo
	,modelo
    ,modelo_viejo
	,tipo_vehiculo
    ,tipo_vehiculo_viejo
	,usuario_cambio
	,tipo_modificacion)
    VALUES
    (
		NEW.id_vehiculo
    ,OLD.id_vehiculo
	,NEW.fecha_vehiculo
    ,OLD.fecha_vehiculo
    ,NEW.modelo
    ,OLD.modelo
    ,NEW.tipo_vehiculo
    ,OLD.tipo_vehiculo
    ,SESSION_USER()
    ,2
    );
END //
    
    
DELIMITER ;


SELECT * FROM nautilus.VEHICULO;
SELECT * FROM nautilus.log_cambio_vehiculo;

SELECT * FROM nautilus.log_cambio_vehiculo_verbose;

SELECT
		v.*
   ,	lv.* 
FROM nautilus.VEHICULO AS v
JOIN nautilus.log_cambio_vehiculo AS lv
	ON v.id_vehiculo = lv.id_vehiculo;



UPDATE nautilus.VEHICULO
SET fecha_vehiculo = '2023-10-10'
WHERE id_vehiculo = 6;

UPDATE nautilus.VEHICULO
SET fecha_vehiculo = NOW()
,	id_vehiculo = 50
WHERE id_vehiculo = 10;


DELETE FROM nautilus.VEHICULO;

INSERT INTO nautilus.VEHICULO
SELECT
	id_vehiculo
,	fecha_vehiculo
,	modelo
,	tipo_vehiculo
FROM nautilus.log_cambio_vehiculo
WHERE tipo_modificacion = 1
;
