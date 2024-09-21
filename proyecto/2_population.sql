-- Insert sample data into cliente
INSERT INTO
    CLIENTE (dni, cuenta, email)
VALUES
    (
        '12345678901',
        'ES7921000813610123456789',
        'cliente1@example.com'
    ),
    (
        '23456789012',
        'ES7921000813610123456790',
        'cliente2@example.com'
    ),
    (
        '34567890123',
        'ES7921000813610123456791',
        'cliente3@example.com'
    ),
    (
        '45678901234',
        'ES7921000813610123456792',
        'cliente4@example.com'
    ),
    (
        '56789012345',
        'ES7921000813610123456793',
        'cliente5@example.com'
    ),
    (
        '67890123456',
        'ES7921000813610123456794',
        'cliente6@example.com'
    ),
    (
        '78901234567',
        'ES7921000813610123456795',
        'cliente7@example.com'
    ),
    (
        '89012345678',
        'ES7921000813610123456796',
        'cliente8@example.com'
    ),
    (
        '90123456789',
        'ES7921000813610123456797',
        'cliente9@example.com'
    ),
    (
        '01234567890',
        'ES7921000813610123456798',
        'cliente10@example.com'
    );

-- Insert sample data into vehiculo
INSERT INTO
    VEHICULO (fecha_vehiculo, modelo, tipo_vehiculo)
VALUES
    ('2022-01-01', 'Toyota Corolla', 'Sedan'),
    ('2022-02-01', 'Ford Fiesta', 'Hatchback'),
    ('2022-03-01', 'Honda Civic', 'Sedan'),
    ('2022-04-01', 'Chevrolet Spark', 'Hatchback'),
    ('2022-05-01', 'BMW X5', 'SUV'),
    ('2022-06-01', 'Audi A4', 'Sedan'),
    ('2022-07-01', 'Mercedes-Benz C-Class', 'Sedan'),
    ('2022-08-01', 'Volkswagen Golf', 'Hatchback'),
    ('2022-09-01', 'Nissan Qashqai', 'SUV'),
    ('2022-10-01', 'Hyundai Tucson', 'SUV');

-- Insert sample data into taller
INSERT INTO
    TALLER (cuit, tipo_reparacion, comentarios_de_reparacion)
VALUES
    (
        '20304050607',
        'Engine Repair',
        'Replaced timing belt and water pump'
    ),
    (
        '30405060708',
        'Brake Service',
        'Replaced brake pads and rotors'
    ),
    (
        '40506070809',
        'Transmission Repair',
        'Rebuilt transmission'
    ),
    (
        '50607080910',
        'Oil Change',
        'Changed oil and filter'
    ),
    (
        '60708091011',
        'Tire Replacement',
        'Replaced all four tires'
    ),
    (
        '70809101112',
        'Battery Replacement',
        'Replaced battery and checked alternator'
    ),
    (
        '80910111213',
        'Suspension Repair',
        'Replaced shock absorbers'
    ),
    (
        '91011121314',
        'Air Conditioning Service',
        'Recharged AC system'
    ),
    (
        '10111213141',
        'Exhaust Repair',
        'Replaced muffler and exhaust pipe'
    ),
    ('11121314151', 'Paint Job', 'Full body repaint');




-- Insert sample data into tasacion
INSERT INTO
    TASACION (coste, tasador, id_vehiculo)
VALUES
    (15000.00, 'John Doe', 1),
    (12000.00, 'Jane Smith', 2),
    (18000.00, 'Jim Brown', 3),
    (20000.00, 'Jake White', 4),
    (25000.00, 'Jill Green', 5),
    (30000.00, 'Jerry Black', 6),
    (22000.00, 'Janet Blue', 7),
    (27000.00, 'Jason Red', 8),
    (23000.00, 'Jessica Yellow', 9),
    (26000.00, 'Jordan Purple', 10);

-- Insert sample data into transaccion
INSERT INTO
    TRANSACCION (id_vehiculo, id_cliente, importe)
VALUES
    (1, 1, 16000.00),
    (2, 2, 13000.00),
    (3, 3, 19000.00),
    (4, 4, 21000.00),
    (5, 5, 26000.00),
    (6, 6, 31000.00),
    (7, 7, 23000.00),
    (8, 8, 28000.00),
    (9, 9, 24000.00),
    (10, 10, 27000.00);

-- Insert sample data into taller_vehiculo
INSERT INTO
    TALLER_VEHICULO (id_taller, id_vehiculo)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);
 