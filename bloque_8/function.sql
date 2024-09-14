USE nautilus;

-- FUNCTION ,TE PASO EL CLIENTE Y EL AUTO -> SABER SI EL VEHICULO ESTA EN TALLER
-- fn_status_cliente
-- VEHICULO ESTA EN TALLER ? fn_vehiculo_taller
-- VEHICULO PERTENECE AL CLIENTE ? fn_vehiculo_pertenece 
-- VEHICULO ES UNICO POR CLIENTE? -> fn_cliente_vehiculo

-- SELECT id_cliente , fn_status_cliente(id_cliente) FROM CLIENTE;

SELECT 
	1 AS CLIENT_ID
,	fn_cliente_vehiculo(1) AS '+1_VEHICULO'
,	fn_vehiculo_pertenece(10,1) AS 'PERTENENCIA_VEHICULO'
,	fn_vehiculo_taller(10) AS 'ESTA_EN_TALLER'
FROM DUAL ;



DELIMITER //
CREATE FUNCTION fn_vehiculo_taller(vehiculo INT)
RETURNS BOOL
READS SQL DATA
BEGIN
	DECLARE existe BOOL ;
	SET existe = (
		SELECT
			IF(COUNT(id_vehiculo) = 0, FALSE, TRUE )
		FROM nautilus.TALLER_VEHICULO
		WHERE 
			id_vehiculo = vehiculo);
	RETURN existe;
END //


CREATE FUNCTION fn_vehiculo_pertenece(vehiculo INT, cliente INT)
RETURNS BOOL
READS SQL DATA
BEGIN
	DECLARE existe BOOL ;
    
	SET existe = (
		SELECT
			IF(COUNT(id_vehiculo) = 0, FALSE, TRUE )
		FROM nautilus.TRANSACCION
		WHERE 
			id_vehiculo = vehiculo AND id_cliente = cliente
            );
            
	RETURN existe;
END //



CREATE FUNCTION fn_cliente_vehiculo(cliente INT)
RETURNS BOOL
READS SQL DATA
BEGIN
	DECLARE existe BOOL ;
    
	SET existe = (
		SELECT
			IF(COUNT(id_vehiculo) = 1, TRUE, FALSE)
		FROM nautilus.TRANSACCION
		WHERE 
			id_cliente = cliente
		GROUP BY id_cliente
            );
            
	RETURN existe;
END //

DELIMITER ;
