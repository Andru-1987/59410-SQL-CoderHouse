USE nautilus;

/*
CREATE
    [DEFINER = user]
    PROCEDURE [IF NOT EXISTS] sp_name ([proc_parameter[,...]])
    [characteristic ...] routine_body
    
*/

-- ETL  +> EXTRACT -> TRANSFORM -> LOAD STANDARIZA PROCESOS LOGICOS
-- SP -> NEGOCIO

-- -------------------------------------


DELIMITER //

CREATE PROCEDURE sp_muestra_historial()
BEGIN
	SELECT
		c.cuenta
	,	c.email
    ,	t.fecha AS fecha_transaccion
    ,	v.modelo
    ,	v.tipo_vehiculo
	,	fn_vehiculo_taller(v.id_vehiculo) AS 'ESTA EN EL TALLER?'
    
     FROM nautilus.TRANSACCION AS t
     LEFT JOIN nautilus.CLIENTE AS c
		USING(id_cliente)
	LEFT JOIN nautilus.VEHICULO AS v
		USING(id_vehiculo) ;
	
    
	SELECT 
		id_vehiculo
	,	fecha_tasacion
    ,	coste
    FROM nautilus.TASACION;
END //

DELIMITER ;


-- INVOCAR A UN PROCEDIMIENTO


CALL sp_muestra_historial() ;





INSERT INTO
    TRANSACCION (id_vehiculo, id_cliente, importe,fecha)
VALUES
    (1, 1, 13000.00, '2023-10-10'),
    (2, 2, 14000.00,'2022-10-10'),
    (3, 3, 19000.00, '1998-10-10');
    
    

-- ETL 
-- BASE DE TALLERISTAS 
CREATE DATABASE IF NOT EXISTS nautilus_taller_jessica;
DROP TABLE nautilus_taller_jessica.aggracion_table_original;
CREATE TABLE nautilus_taller_jessica.aggegracion_table_original(

		id_agg INT PRIMARY KEY NOT NULL AUTO_INCREMENT
	, cuenta VARCHAR(200)
    , email VARCHAR(200)
    , fecha_transaccion DATE
    , modelo VARCHAR(200) 
    , tipo_vehiculo VARCHAR(200)
    , status_taller	BOOL
    , fecha_ingesta_data  DATETIME DEFAULT(CURRENT_TIMESTAMP)

) ;


RENAME TABLE 
nautilus_taller_jessica.aggracion_table_original
	TO nautilus_taller_jessica.aggegracion_table_original;



DROP PROCEDURE IF EXISTS sp_elt_agg;

DELIMITER //
CREATE PROCEDURE sp_elt_agg(IN fecha_transaccion DATE)
BEGIN
	DECLARE year_transaccion INT;
    SET year_transaccion = YEAR(fecha_transaccion);

	INSERT INTO nautilus_taller_jessica.aggegracion_table_original
    (cuenta,email,fecha_transaccion,modelo,tipo_vehiculo,status_taller)
	SELECT
		CONCAT_WS(".",c.dni,c.cuenta)
	,	UPPER(c.email)
    ,	t.fecha
    ,	v.modelo
    ,	v.tipo_vehiculo
	,	fn_vehiculo_taller(v.id_vehiculo) 
    
     FROM nautilus.TRANSACCION AS t
     LEFT JOIN nautilus.CLIENTE AS c
		USING(id_cliente)
	LEFT JOIN nautilus.VEHICULO AS v
		USING(id_vehiculo) 
        
	WHERE YEAR(t.fecha) = year_transaccion;

END //

DELIMITER ;

CALL sp_elt_agg('2024-01-01') ;

SELECT * FROM nautilus_taller_jessica.aggegracion_table_original;



-- FILTRAR BAJO UN CAMPO:VALOR EN PARTICULAR DE UNA TABLA

SELECT COLUMN_NAME 
	FROM  information_schema.COLUMNS
WHERE 
TABLE_SCHEMA = 'nautilus'
AND TABLE_NAME = 'VEHICULO'
;

DROP PROCEDURE IF EXISTS sp_filter_by_string;

DELIMITER //
CREATE PROCEDURE sp_filter_by_string(
IN tab VARCHAR(241),
IN col VARCHAR(245)
)
BEGIN
	IF tab = '' OR col = '' THEN 
		SELECT 'NO ME PASES DATA VACIA'  AS msg_error FROM DUAL;
    ELSE
		-- DECLARE query VARCHAR(200);
		SET @query = CONCAT('SELECT * FROM nautilus.', tab, ' ORDER BY ', col);
		SELECT @query FROM DUAL;
		
		PREPARE query_value FROM @query;
		EXECUTE query_value ;
		DEALLOCATE PREPARE query_value;
	END IF;
END //

DELIMITER ;

CALL sp_filter_by_string ('','modelo');

