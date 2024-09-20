-- Eliminar la base de datos si ya existe y crearla nuevamente
DROP DATABASE IF EXISTS centro_medico;
CREATE DATABASE centro_medico;

USE centro_medico;

-- Crear la tabla 'paciente'
CREATE TABLE paciente (
    id_paciente INT NOT NULL AUTO_INCREMENT,
    mail VARCHAR(200) UNIQUE,
    PRIMARY KEY (id_paciente)
);

-- Crear la tabla 'horario'
CREATE TABLE horario (
    id_horario INT NOT NULL AUTO_INCREMENT,
    rango VARCHAR(100),
    PRIMARY KEY (id_horario)
);

-- Crear la tabla 'turnos'
CREATE TABLE turnos (
    id_turno INT NOT NULL AUTO_INCREMENT,
    id_horario INT,
    id_paciente INT,
    especialista VARCHAR(200),
    status_turno ENUM('CONFIRMADO', 'CANCELADO', 'NO DISPONIBLE'),
    fecha_turno DATE DEFAULT(CURRENT_DATE),
    PRIMARY KEY (id_turno),
    FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente),
    FOREIGN KEY (id_horario) REFERENCES horario (id_horario)
);

-- Insertar datos en la tabla 'horario'
INSERT INTO horario (rango) VALUES
    ('8am - 9am'),
    ('9am - 10am'),
    ('10am - 11am'),
    ('11am - 12am'),
    ('12am - 1pm'),
    ('1pm - 2pm'),
    ('2pm - 3pm'),
    ('4pm - 5pm'),
    ('5pm - 6pm'),
    ('6pm - 7pm');

-- Insertar datos en la tabla 'paciente'
INSERT INTO paciente (mail) VALUES
    ('john.doe@example.com'),
    ('jane.smith@example.com'),
    ('alice.jones@example.com'),
    ('bob.brown@example.com'),
    ('charlie.black@example.com'),
    ('david.white@example.com'),
    ('eva.green@example.com'),
    ('frank.red@example.com'),
    ('grace.blue@example.com'),
    ('harry.yellow@example.com');

-- Insertar datos en la tabla 'turnos'
INSERT INTO turnos (id_horario, id_paciente, especialista, status_turno, fecha_turno) VALUES
    (1, 1, 'Dr. Smith', 'CONFIRMADO', '2023-10-01'),
    (2, 2, 'Dr. Johnson', 'CANCELADO', '2023-10-02'),
    (3, 3, 'Dr. Williams', 'NO DISPONIBLE', '2023-10-03'),
    (4, 4, 'Dr. Brown', 'CONFIRMADO', '2023-10-04'),
    (5, 5, 'Dr. Jones', 'CANCELADO', '2023-10-05'),
    (6, 6, 'Dr. Miller', 'NO DISPONIBLE', '2023-10-06'),
    (7, 7, 'Dr. Davis', 'CONFIRMADO', '2023-10-07'),
    (8, 8, 'Dr. Garcia', 'CANCELADO', '2023-10-08'),
    (9, 9, 'Dr. Rodriguez', 'NO DISPONIBLE', '2023-10-09'),
    (10, 10, 'Dr. Martinez', 'CONFIRMADO', '2023-10-10'),
    (1, 1, 'Dr. Hernandez', 'CANCELADO', '2023-10-11'),
    (2, 2, 'Dr. Lopez', 'NO DISPONIBLE', '2023-10-12'),
    (3, 3, 'Dr. Gonzalez', 'CONFIRMADO', '2023-10-13'),
    (4, 4, 'Dr. Wilson', 'CANCELADO', '2023-10-14'),
    (5, 5, 'Dr. Anderson', 'NO DISPONIBLE', '2023-10-15'),
    (6, 6, 'Dr. Thomas', 'CONFIRMADO', '2023-10-16'),
    (7, 7, 'Dr. Taylor', 'CANCELADO', '2023-10-17'),
    (8, 8, 'Dr. Moore', 'NO DISPONIBLE', '2023-10-18'),
    (9, 9, 'Dr. Jackson', 'CONFIRMADO', '2023-10-19'),
    (10, 10, 'Dr. Martin', 'CANCELADO', '2023-10-20');

-- Consultar la disponibilidad de un turno
SELECT
    IF(COUNT(1) = 0, "DISPONIBLE", "NO DISPONIBLE") AS TURNO
FROM turnos
WHERE 
    especialista = 'Dr. Smith'
    AND fecha_turno = '2023-10-01'
    AND id_horario = (SELECT id_horario FROM horario WHERE rango = '8am - 9am')
    AND id_paciente = (SELECT id_paciente FROM paciente WHERE mail = 'john.doe@example.com')
    AND status_turno = 1;

-- Eliminar la función si ya existe
DROP FUNCTION IF EXISTS centro_medico.fn_tiene_turno;

-- Crear la función para verificar la disponibilidad de un turno
DELIMITER //
CREATE FUNCTION centro_medico.fn_tiene_turno(
    paciente VARCHAR(100),
    turno VARCHAR(100),
    doctor VARCHAR(100),
    dia DATE
) RETURNS VARCHAR(200)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE disponibilidad VARCHAR(200);
    
    SELECT
        IF(COUNT(1) = 0, "DISPONIBLE", "NO DISPONIBLE") INTO disponibilidad
    FROM turnos
    WHERE 
        especialista = doctor
        AND fecha_turno = dia
        AND id_horario = (SELECT id_horario FROM horario WHERE rango = turno)
        AND id_paciente = (SELECT id_paciente FROM paciente WHERE mail = paciente)
        AND status_turno = 1;
        
    RETURN disponibilidad;
END //
DELIMITER ;

-- Probar la función
SELECT fn_tiene_turno('john.doe@example.com', '8am - 9am', 'Dr. Smith', '2023-10-01') AS tiene_turno FROM DUAL;

-- Probar la función para todos los pacientes
SELECT mail, fn_tiene_turno(mail, '8am - 9am', 'Dr. Smith', '2023-10-01') AS no_tiene_turno FROM paciente;



-- version mejorada de la funcion
-- Eliminar la función si ya existe
DROP FUNCTION IF EXISTS centro_medico.fn_tiene_turno;

-- Crear la función mejorada para verificar la disponibilidad de un turno
DELIMITER //
CREATE FUNCTION centro_medico.fn_tiene_turno_mejorado(
    paciente_email VARCHAR(100),
    horario_rango VARCHAR(100),
    especialista_nombre VARCHAR(100),
    fecha DATE
) RETURNS VARCHAR(200)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE disponibilidad VARCHAR(200);
    DECLARE paciente_id INT;
    DECLARE horario_id INT;

    -- Obtener id del paciente
    SELECT id_paciente INTO paciente_id
    FROM paciente
    WHERE mail = paciente_email;

    -- Verificar si el paciente existe
    IF paciente_id IS NULL THEN
        RETURN CONCAT('Error: No se encontró el paciente con email: ', paciente_email);
    END IF;

    -- Obtener id del horario
    SELECT id_horario INTO horario_id
    FROM horario
    WHERE rango = horario_rango;

    -- Verificar si el horario existe
    IF horario_id IS NULL THEN
        RETURN CONCAT('Error: No se encontró el horario con rango: ', horario_rango);
    END IF;

    -- Verificar la disponibilidad del turno
    SELECT
        IF(COUNT(1) = 0, 'DISPONIBLE', 'NO DISPONIBLE') INTO disponibilidad
    FROM turnos
    WHERE 
        id_paciente = paciente_id
        AND id_horario = horario_id
        AND especialista = especialista_nombre
        AND fecha_turno = fecha
        AND status_turno = 'CONFIRMADO';

    RETURN disponibilidad;
END //
DELIMITER ;

-- Probar la función mejorada
SELECT fn_tiene_turno_mejorado('john.doe@example.com', '8am - 9am', 'Dr. Smith', '2023-10-01') AS tiene_turno FROM DUAL;

-- Probar la función para todos los pacientes
SELECT mail, fn_tiene_turno_mejorado(mail, '8am - 9am', 'Dr. Smith', '2023-10-01') AS disponibilidad FROM paciente;
