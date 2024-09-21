USE nautilus; 
-- idea de consecionaria -> Pablo

-- 2	views -> 
	-- En cuanto a las fechas
		-- cuantas transacciones se han realizado --> obtener de transacciones
        
    -- Costos del taller
		-- TALLER_COSTOS_POR_REPARACION_TIPO
		

CREATE VIEW 
	vw_transacciones_mes
    AS SELECT 
				YEAR(fecha) AS ANIO
			,	MONTH(fecha) AS MES
			,	SUM(importe) AS TOTAL
		FROM TRANSACCION
		GROUP BY 
			MONTH(fecha), YEAR(fecha)
		;
		
    
CREATE VIEW 
	vw_costo_por_taller
    AS
    SELECT
			data_agrupada.taller AS TALLER
		, 	CONCAT_WS( '-', YEAR(data_agrupada.fecha_reparacion),MONTH(data_agrupada.fecha_reparacion)) AS periodo 
        ,	SUM(data_agrupada.costo_reparacion) AS COSTO
        
    FROM (SELECT 
		t.cuit AS taller
    ,	v.modelo AS modelo_vehiculo
    ,	CASE 
		WHEN v.tipo_vehiculo LIKE "SUV" THEN 500
        WHEN v.tipo_vehiculo LIKE "SEDAN" THEN 450
        ELSE 600
        END AS costo_reparacion
    , tv.fecha_reparacion
    
    FROM nautilus.TALLER_VEHICULO AS tv
    JOIN nautilus.TALLER AS t
		-- ON tv.id_taller = t.id_taller 
        USING(id_taller)
    JOIN nautilus.VEHICULO AS v
		ON tv.id_vehiculo = v.id_vehiculo ) AS data_agrupada
	GROUP BY 
		CONCAT_WS( '-',
					YEAR(data_agrupada.fecha_reparacion),
                    MONTH(data_agrupada.fecha_reparacion)
			) 
        ,	data_agrupada.taller ;
        
        

-- 2 	functions ->
	-- function de tasacion donde me explique bajo el costo del vehiculo
		-- que categoria es : baja, media, alta gama
        
DROP FUNCTION IF EXISTS fn_gama_vehiculo ;

DELIMITER //
CREATE FUNCTION fn_gama_vehiculo(vehiculo INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE existencia BOOL ;
    DECLARE tipo_gama VARCHAR(50);
    
    SELECT 
		IF(COUNT(1) = 0, FALSE , TRUE)  INTO existencia
		FROM nautilus.VEHICULO 
    WHERE id_vehiculo = vehiculo ;
    
    IF existencia = 0 THEN 
			RETURN 'NO EXISTE';
    ELSE
		SELECT 
			CASE 
				WHEN tipo_vehiculo LIKE "SUV" THEN "MEDIA GAMA"
				WHEN tipo_vehiculo LIKE "SEDAN" THEN "BAJA GAMA"
				ELSE "ALTA GAMA"
			END INTO tipo_gama
		FROM nautilus.VEHICULO
        WHERE id_vehiculo = vehiculo ;
        
		RETURN tipo_gama;
	END IF;
END //
DELIMITER ;       

SELECT fn_gama_vehiculo(2) FROM DUAL;

    --  vehiculo 
		-- tipo de reparacion que se esta realizando 
		-- cuantos dias ha estado en el taller


DROP FUNCTION IF EXISTS fn_dias_taller;
DELIMITER //
CREATE FUNCTION 
	fn_dias_taller (vehiculo INT) RETURNS INT
    DETERMINISTIC
    READS SQL DATA
    BEGIN
		-- declaro las variables que necesito para validar
        --  existencia del vehiculo
        -- cuantos dias pasaron que se encuentra en el taller
        
		DECLARE cant_dias INT;
		DECLARE existencia BOOL;
		
        -- valido existencia, para no hacer el calculo 
        -- innecesariamente
		SELECT 
			IF(COUNT(1) = 0, FALSE , TRUE)  INTO existencia
			FROM nautilus.VEHICULO 
		WHERE id_vehiculo = vehiculo ;
        
        -- si no existe -> solamente un error
        IF existencia = 0 THEN 
        
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'VEHICULO NO EXISTE';
			RETURN 0; 
		ELSE
        -- genial! haceme el calculo
			SELECT 
				DATEDIFF(NOw(), fecha_reparacion) INTO cant_dias 
			FROM TALLER_VEHICULO
            WHERE id_vehiculo = vehiculo LIMIT 1; 
            
			RETURN  cant_dias ;
            
		END IF; 
    
    END //
DELIMITER ;
    
SELECT fn_dias_taller(20) FROM DUAL;


-- pasos 
-- IN id_vehiculo INT -> vehiculo VARCHAR(200)

SELECT 
modelo
FROM nautilus.VEHICULO
WHERE id_vehiculo = 2;

DROP FUNCTION IF EXISTS fn_busqueda_vehiculo ;

DELIMITER //
CREATE FUNCTION fn_busqueda_vehiculo(vehiculo INT)
RETURNS VARCHAR(200)
READS SQL DATA
BEGIN
	DECLARE valor_retorno VARCHAR(200);

	SELECT 
		modelo INTO valor_retorno
	FROM nautilus.VEHICULO
	WHERE id_vehiculo = vehiculo;
    
    RETURN valor_retorno;

END //
DELIMITER ;

SELECT fn_busqueda_vehiculo(2) FROM DUAL;

-- 2 	procedures -> 
	-- * procedimientos de modelo de negocio 
	-- * procedimiento de limpieza de registros 
	-- * procedimiento de manejo de data agrupada


CREATE TABLE riesgo_vehiculo_taller(
	id  INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    id_vehiculo INT ,
    dias_en_taller INT
);
	

DROP PROCEDURE IF EXISTS sp_moviento_vehiculo_prioridad;
-- SI EL VEHICULO TIENE > 5 dias -> entonces movelo a la tabla de riesgo
DELIMITER //
CREATE PROCEDURE sp_moviento_vehiculo_prioridad(
	IN vehiculo INT
)
BEGIN
	DECLARE cant_dias INT;
	SELECT fn_dias_taller(vehiculo) INTO cant_dias FROM DUAL;
	
    IF cant_dias > 5 THEN
		INSERT INTO riesgo_vehiculo_taller
        (id_vehiculo,dias_en_taller)
        VALUES(vehiculo,cant_dias);
		
        UPDATE TALLER_VEHICULO
			SET fecha_reparacion = NOw()
            WHERE
				id_vehiculo = vehiculo;
       
        SELECT 'SE HA INGRESADO EN LA TABLA DE RIESGO' AS msg FROM DUAL;
	END IF ;

END //

DELIMITER ;


CALL sp_moviento_vehiculo_prioridad(2);

    
SELECT * FROM  riesgo_vehiculo_taller;
SELECT * FROM  TALLER_VEHICULO WHERE id_vehiculo = 2;

-- 2 	triggers
	-- * trigger de validacion
    -- * trigger de log | auditoria
    

    