
SELECT
    IF(COUNT(1) = 0, "DISPONIBLE", "NO DISPONIBLE") AS TURNO
FROM turnos
WHERE 
    especialista = 'Dr. Smith'
    AND fecha_turno = '2023-10-01'
    AND id_horario = (SELECT id_horario FROM horario WHERE rango = '8am - 9am')
    AND id_paciente = (SELECT id_paciente FROM paciente WHERE mail = 'john.doe@example.com')
    AND status_turno = 1;



WITH horario_rango AS(
    -- rangos de horarios de buscqueda
    SELECT id_horario 
        FROM horario 
    WHERE rango IN ('8am - 9am')
),
paciente_seleccionado AS (
    -- pacientes a analizar
    SELECT id_paciente 
        FROM paciente 
    WHERE mail IN ('john.doe@example.com')
),
usuario_seleccion AS(
    -- tabla intermedia de logica de busqueda
    SELECT 
        hr.id_horario,
        ps.id_paciente
    FROM horario_rango as hr,paciente_seleccionado AS ps

)
-- mostrado de datos con la logica pedida para el analisis
SELECT
    IF(COUNT(1) = 0, "DISPONIBLE", "NO DISPONIBLE") AS TURNO
FROM turnos AS t
JOIN usuario_seleccion AS us
    ON (t.id_horario = us.id_horario AND t.id_paciente = us.id_paciente)
WHERE 
        especialista = 'Dr. Smith'
    AND fecha_turno = '2023-10-01';

