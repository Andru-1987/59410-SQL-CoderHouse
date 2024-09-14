-- USAR     LA BASE DE DATOS DE NAUTILUS;
-- https://github.com/Andru-1987/59410-SQL-CoderHouse/blob/main/bloque_5/nautilus_ddl_workshop.sql


USE nautilus;

-- FUNCTIONS
/*
CREATE
    [DEFINER = user]
    FUNCTION [IF NOT EXISTS] sp_name ([func_parameter[,...]])
    RETURNS type
    [characteristic ...] routine_body
    
    characteristic: {
    COMMENT 'string'
  | LANGUAGE SQL
  | [NOT] DETERMINISTIC
  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
  -- | SQL SECURITY { DEFINER | INVOKER }
}
*/

-- DELIMITER => UN SHIFTER DE FINALIZACION DE COMANDO 
/*DELIMITADOR ,
DILIMITADOR  //
COMPRA UN POLLO // SEIS HUEVOS
*/

DROP FUNCTION IF EXISTS fn_calculo ;

DELIMITER //

CREATE FUNCTION fn_calculo()
	RETURNS DOUBLE
    COMMENT 'hace un calculo de dos digitos y devuelve un valor flotante'
	DETERMINISTIC
BEGIN
	DECLARE valor_retorno DOUBLE;
    SET valor_retorno = 45 ;
    RETURN valor_retorno ;
END //

DELIMITER ;


-- INVOCAR UNA FUNCION 
-- QUERY --> DENTRO DE UNA QUERY

SELECT fn_calculo()
	FROM DUAL ; -- > DUAL ES UNA TABLA FICTICIA.


-- CREAME UNA FUNCTION QUE ME PERMITA SABER CUANTOS VEHICULOS TIENE EL CLIENTE X 

SELECT 
		COUNT(id_vehiculo) AS total_vehiculos
FROM nautilus.TRANSACCION 
    WHERE 
		id_cliente = x 
GROUP BY id_cliente;

 -- -> parametro (cliente): int  [READ SQL] -> valor RETURNS int
 
 DROP FUNCTION IF EXISTS nautilus.fn_total_vehiculos;
 
 DELIMITER //
 
 CREATE FUNCTION nautilus.fn_total_vehiculos(cliente INT)
	RETURNS INT
    COMMENT 'parametro (cliente): DATATYPE( INT )  CARACTERISTICA : [READ SQL DATA] -> valor  de RETURNS INT'
--   characteristic
	READS SQL DATA
BEGIN
	-- variables de un proceso
	
    DECLARE valor_retorno INT;

-- QUE PASARIA SI NO EXISTE EL ID_CLIENTE ???
--  APRENDER A USAR LA SENTENCIA SET
	SELECT 
		COUNT(id_vehiculo) INTO valor_retorno
	FROM nautilus.TRANSACCION 
		WHERE 
			id_cliente = cliente 
	GROUP BY id_cliente;
    /*	
		id_cliente  | Total_cliente
	-->	1 			|	20
        2 			| 	30
    */    
    RETURN valor_retorno;
    
END //

DELIMITER ;


-- INVOCAR LA FUNCTION 

SELECT fn_total_vehiculos(1) -- ARGUMENTO
FROM DUAL;
