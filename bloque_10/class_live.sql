
SELECT *
    -- Host, User
FROM
    mysql.user;
    
/*
CREATE USER [IF NOT EXISTS]
    user [auth_option] [, user [auth_option]] ...
  --  DEFAULT ROLE role [, role ] ...
  --  [REQUIRE {NONE | tls_option [[AND] tls_option] ...}]
  --  [WITH resource_option [resource_option] ...]
    [password_option | lock_option] ...
    [COMMENT 'comment_string' | ATTRIBUTE 'json_object']
*/
    
-- CREACION DE USUARIO
-- 177.0.0.1

CREATE USER 'miguel_man'@'%'
	IDENTIFIED BY 'choclo' ;
    
SELECT *
    -- Host, User
FROM
    mysql.user;
    
-- EN EL GUI acceder con el user
CREATE USER 'jessica_ba_wb'@'%'
	IDENTIFIED BY '1234'
    COMMENT 'ESTA USUARIO SOLO VA A ACCEDER POR MEDIO DE WORKBENCH'
    ;
-- UPDATE
ALTER USER 'jess'@'%'
  IDENTIFIED BY '4321'
  PASSWORD EXPIRE INTERVAL 180 DAY
  FAILED_LOGIN_ATTEMPTS 3 
  -- PASSWORD_LOCK_TIME 2
  ;

-- RENAME
RENAME USER 'jessica_ba_wb'@'%' TO 'jess'@'%';

DROP USER 'jess'@'%' , 'miguel_man'@'%';

-- GRANT

CREATE USER 'modesto'@'%'
  IDENTIFIED BY 'modesto';
  
SHOW GRANTS FOR 'modesto'@'%';

-- GRANT USAGE ON *.* TO `modesto`@`%`

GRANT ALL ON *.* TO 'modesto'@'%'; -- CASI PARECIDO A UN ADMIN 

GRANT ALL ON *.* TO 'modesto'@'%' WITH GRANT OPTION; -- UN ADMIN -> ROOT

FLUSH PRIVILEGES;

-- 

REVOKE ALL PRIVILEGES, GRANT OPTION
  FROM 'modesto'@'%';


-- ACCESO GRANULAR

GRANT ALL ON subtes.* TO 'modesto'@'%';

REVOKE ALL PRIVILEGES ON subtes.*
  FROM 'modesto'@'%';

GRANT SELECT, INSERT ON subtes.lineas TO 'modesto'@'%';
GRANT SELECT ON nautilus.vw_costo_por_taller TO 'modesto'@'%';

INSERT INTO subtes.lineas
VALUES (100,'X');

UPDATE subtes.lineas
SET linea = 'Z' WHERE id_linea =100;


SELECT USER();

GRANT SELECT(dni,cuenta) ON nautilus.CLIENTE TO 'modesto'@'%';


-- TCL

SELECT 
	* FROM nautilus.CLIENTE;
    
INSERT INTO nautilus.CLIENTE
(dni,cuenta,email) 
VALUES
('987123','galicia-876123', 'marcos@gmail.com');


START TRANSACTION;
	INSERT INTO nautilus.CLIENTE
		(dni,cuenta,email) 
		VALUES
		('1111111111','galicia-1111111', 'marcos_1111@gmail.com');
-- COMMIT;

SET SQL_SAFE_UPDATES= FALSE;
SET FOREIGN_KEY_CHECKS=0;

START TRANSACTION;
-- BORRADO
DELETE FROM nautilus.CLIENTE
-- WHERE partition_date=@variable_fecha
;
-- COMMIT; ESTO NO HA PASADO!
ROLLBACK ;




START TRANSACTION;
-- BORRADO
DELETE FROM nautilus.CLIENTE
WHERE id_cliente > 20
;


INSERT INTO nautilus.CLIENTE
	(dni,cuenta,email) 
	VALUES
	('2222222','galicia-333333', 'otro@gmail.com');
-- COMMIT; ESTO NO HA PASADO!

SAVEPOINT cliente_2 ;


DELETE FROM nautilus.CLIENTE
WHERE id_cliente > 20
;

ROLLBACK TO cliente_2;

ROLLBACK;


