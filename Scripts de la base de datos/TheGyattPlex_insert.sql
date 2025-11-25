--- Usar la base de datos
USE `The Gyatt Plex`;

-- 1. Insertar 10 'Film' (Películas)
INSERT INTO `Film` (`FilmID`, `Title`, `Director`, `Genre`, `Rating`, `Duration`, `Synopsis`, `IsActive`)
VALUES
(1, 'Dune: Part Two', 'Denis Villeneuve', 'Sci-Fi', 'PG-13', 166, 'Paul Atreides unites with Chani and the Fremen while on a warpath of revenge against the conspirators who destroyed his family.', 1),
(2, 'Oppenheimer', 'Christopher Nolan', 'Biographical Drama', 'R', 180, 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.', 1),
(3, 'Barbie', 'Greta Gerwig', 'Comedy', 'PG-13', 114, 'Barbie suffers a crisis that leads her to question her world and her existence.', 1),
(4, 'The Godfather', 'Francis Ford Coppola', 'Crime', 'R', 175, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 1),
(5, 'Spider-Man: Across the Spider-Verse', 'Joaquim Dos Santos', 'Animation', 'PG', 140, 'Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its very existence.', 1),
(6, 'Pulp Fiction', 'Quentin Tarantino', 'Crime', 'R', 154, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine.', 1),
(7, 'Forrest Gump', 'Robert Zemeckis', 'Drama', 'PG-13', 142, 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75.', 1),
(8, 'The Matrix', 'Lana Wachowski', 'Sci-Fi', 'R', 136, 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', 1),
(9, 'Interstellar', 'Christopher Nolan', 'Sci-Fi', 'PG-13', 169, 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.', 1),
(10, 'Joker', 'Todd Phillips', 'Drama', 'R', 122, 'In Gotham City, mentally troubled comedian Arthur Fleck is disregarded and mistreated by society.', 1);

-- 2. Insertar 5 'Theater' (Salas)
INSERT INTO `Theater` (`TheaterID`, `TheaterNumber`, `Capacity`)
VALUES
(1, 1, 120),  -- Sala 1 (Regular)
(2, 2, 120),  -- Sala 2 (Regular)
(3, 3, 200),  -- Sala 3 (IMAX)
(4, 4, 80),   -- Sala 4 (VIP)
(5, 5, 80);   -- Sala 5 (VIP)

-- 3. Insertar 5 'Customer' (Clientes)
INSERT INTO `Customer` (`CustomerID`, `FirstName`, `LastName`, `Email`, `DateOfBirth`)
VALUES
(101, 'Carlos', 'Ruiz', 'carlos.ruiz@email.com', '1990-05-10'),
(102, 'Elena', 'Morales', 'elena.m@email.com', '1985-11-30'),
(103, 'Javier', 'Soto', 'j.soto@email.com', '2002-01-25'),
(104, 'Lucia', 'Herrera', 'lucia.h@email.com', '1998-09-12'),
(105, 'Miguel', 'Perez', 'miguel.perez@email.com', '1993-03-17');

-- 4. Insertar 7 'Showing' (Funciones)
INSERT INTO `Showing` (`ShowingID`, `StartTime`, `Date`, `FilmID`, `TheaterID`)
VALUES
(1001, '17:00:00', '2025-10-25', 1, 3), -- Dune: Part Two en Sala 3 (IMAX)
(1002, '20:30:00', '2025-10-25', 1, 3), -- Dune: Part Two en Sala 3 (IMAX)
(1003, '18:00:00', '2025-10-25', 2, 1), -- Oppenheimer en Sala 1
(1004, '19:15:00', '2025-10-25', 5, 2), -- Spider-Verse en Sala 2
(1005, '21:00:00', '2025-10-25', 10, 4), -- Joker en Sala 4 (VIP)
(1006, '16:00:00', '2025-10-26', 3, 2), -- Barbie en Sala 2 (día siguiente)
(1007, '18:30:00', '2025-10-26', 9, 3); -- Interstellar en Sala 3 (IMAX, día siguiente)

-- 5. Insertar 10 'Ticket' (Boletos)
INSERT INTO `Ticket` (`TicketID`, `SeatNumber`, `Price`, `PurchaseDate`, `ShowingID`, `CustomerID`)
VALUES
(5001, 'G10', 150.00, '2025-10-23 10:05:00', 1001, 101), -- Carlos compra 2 boletos para Dune
(5002, 'G11', 150.00, '2025-10-23 10:05:00', 1001, 101),
(5003, 'D5', 85.50, '2025-10-23 11:20:00', 1003, 102), -- Elena compra 1 boleto para Oppenheimer
(5004, 'C1', 180.00, '2025-10-23 15:00:00', 1005, 103), -- Javier compra 2 boletos para Joker (VIP)
(5005, 'C2', 180.00, '2025-10-23 15:00:00', 1005, 103),
(5006, 'H1', 90.00, '2025-10-24 09:30:00', 1004, 104), -- Lucia compra 1 boleto para Spider-Verse
(5007, 'J12', 150.00, '2025-10-24 13:15:00', 1002, 105), -- Miguel compra 3 boletos para Dune (función de noche)
(5008, 'J13', 150.00, '2025-10-24 13:15:00', 1002, 105),
(5009, 'J14', 150.00, '2025-10-24 13:15:00', 1002, 105),
(5010, 'E7', 85.50, '2025-10-25 10:00:00', 1006, 101); -- Carlos compra 1 boleto para Barbie (día siguiente)