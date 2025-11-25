USE `the gyatt plex`;

-- ======================================================
-- SECCIÓN 1: INSERT (Crear nuevos registros)
-- ======================================================

-- Admin Function: Añadir una nueva película a la cartelera.
-- 'IsActive' se establece en 1 (Activo) por defecto.
INSERT INTO `Film` (`FilmID`, `Title`, `Director`, `Genre`, `Rating`, `Duration`, `Synopsis`, `IsActive`) 
VALUES 
(11, 'Nueva Película de Prueba', 'Director Famoso', 'Acción', 'R', 120, 'Una sinopsis de ejemplo.', 1);

-- User Function: Registrar un nuevo cliente.
INSERT INTO `Customer` (`CustomerID`, `FirstName`, `LastName`, `Email`, `DateOfBirth`) 
VALUES 
(106, 'Nuevo', 'Usuario', 'nuevo.usuario@email.com', '1999-12-01');

-- Admin Function: Programar una nueva función (showing).
-- Asigna una película (FilmID) a una sala (TheaterID) en una fecha/hora.
INSERT INTO `Showing` (`ShowingID`, `StartTime`, `Date`, `FilmID`, `TheaterID`) 
VALUES 
(1008, '20:00:00', '2025-11-01', 1, 2); 

-- User Function: Vender/Registrar un boleto.
-- NOW() se usa para estampar la fecha y hora exactas de la compra.
INSERT INTO `Ticket` (`TicketID`, `SeatNumber`, `Price`, `PurchaseDate`, `ShowingID`, `CustomerID`) 
VALUES 
(5011, 'A10', 95.50, NOW(), 1001, 103); 


-- ======================================================
-- SECCIÓN 2: UPDATE (Actualizar registros existentes)
-- ======================================================

-- Admin Function: Editar los detalles de una película existente.
UPDATE `Film` 
SET 
    `Rating` = 'PG-13',
    `Synopsis` = 'Sinopsis actualizada y corregida por el administrador.'
WHERE 
    `FilmID` = 10;

-- User Function: Actualizar el perfil del cliente (ej. cambiar email).
UPDATE `Customer`
SET
    `Email` = 'elena.morales.nuevo@email.com'
WHERE
    `CustomerID` = 102;


-- ======================================================
-- SECCIÓN 3: DELETE (Borrar registros)
-- ======================================================

-- "Borrado Físico" (Hard Delete)
-- Uso: Seguro para registros transaccionales que no tienen
-- dependencias de FK (ej. un boleto).
DELETE FROM `Ticket` 
WHERE `TicketID` = 5001;

-- -----------------------------------------------------
-- "Borrado Lógico" (Soft Delete) vs. Borrado Físico
-- -----------------------------------------------------

-- NOTA DE INTEGRIDAD REFERENCIAL:
-- No se debe usar un DELETE físico en tablas maestras como 'Film' 
-- si existen registros dependientes (en 'Showing'). 
-- El servidor rechazará el DELETE para proteger la integridad 
-- de los datos (evitando funciones o boletos huérfanos).

-- MEJOR PRÁCTICA: "Borrado Lógico"
-- El registro se marca como inactivo (IsActive = 0) pero permanece 
-- en la base de datos para mantener la integridad histórica 
-- de los boletos y funciones pasadas.

-- Implementación: El "borrado" desde la aplicación ejecuta este UPDATE.
UPDATE `Film`
SET 
    `IsActive` = 0  -- (0 = Inactivo)
WHERE 
    `FilmID` = 1;

    
-- Recordatorio de implementación:
-- Todos los SELECTs de la aplicación (ej. en _select.sql) que muestren
-- la cartelera, deben filtrar por 'IsActive = 1'
-- para ocultar los registros "borrados" lógicamente.

-- ======================================================
-- SECCIÓN 4: VERIFICACIÓN DE DATOS (SELECT)
-- ======================================================

-- Consultas simples para verificar el estado de las tablas 
-- después de ejecutar las operaciones de gestión (INSERT, UPDATE, DELETE).

-- Ver todas las películas (y verificar 'IsActive')
SELECT * FROM `Film`;

-- Ver todas las salas
SELECT * FROM `Theater`;

-- Ver todos los clientes
SELECT * FROM `Customer`;

-- Ver todas las funciones programadas
SELECT * FROM `Showing`;

-- Ver todos los boletos vendidos
SELECT * FROM `Ticket`;