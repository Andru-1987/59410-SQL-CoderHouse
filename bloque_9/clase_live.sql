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