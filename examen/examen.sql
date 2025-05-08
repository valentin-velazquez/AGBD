-- 1-Cuántas canciones tiene el álbum unplugged?
-- 2-Mostrar los artistas que tienen 30 o más canciones ordenadas del que tiene más al que tiene menos.
-- 3-Insertar 6 canciones que elijan, con sus respectivos datos.(fijense en la estructura de la tabla que datos tiene que usar)
-- 4-Modificar el nombre de una canción insertada, y al segundo dato ingresado modificar los milisegundos.
-- 5-Borrar dos datos agregados y modificados con una sola sentencia de borrar.

-- act1
SELECT count(*) as canciones
FROM tracks t
INNER JOIN albums a on t.AlbumId = a.AlbumId
WHERE a.Title = 'Unplugged';



--act 2
SELECT r.name AS artista, count(T.TrackId) AS Total_de_las_canciones
FROM tracks t
INNER JOIN albums a on t.AlbumId = a.AlbumId
INNER JOIN artists r on r.ArtistId = a.ArtistId
GROUP by r.name
HAVING Total_de_las_canciones >= 30
ORDER BY Total_de_las_canciones DESC;


--act3 
INSERT INTO tracks(Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES('pipi', 1, 1, 1, 'valentin', 202020, 9090090, 2000),
('naranja', 1, 1, 1, 'valentin', 202020, 9090090, 2000),
('telo', 1, 1, 1, 'valentin', 202020, 9090090, 2000),
('papa', 1, 1, 1, 'valentin', 202020, 9090090, 2000);

--act4
UPDATE tracks
SET  name = 'cancion modificada', Milliseconds = '20'
WHERE name = 'naranja';



--act5
-- in significa dentro de
DELETE FROM tracks
WHERE Name in ('pipi', 'telo');












































































SELECT COUNT(*) AS cantidad_canciones
FROM Track t
JOIN Album a ON t.AlbumId = a.AlbumId
WHERE a.Title = 'Unplugged';














SELECT ar.Name AS Artista, COUNT(t.TrackId) AS TotalCanciones
FROM Track t
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
HAVING COUNT(t.TrackId) >= 30
ORDER BY TotalCanciones DESC;












INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES 
('Caminos del alma', 1, 1, 1, 'Carlos Rivera', 210000, 4000000, 0.99),
('Luz de madrugada', 1, 1, 1, 'Lucía Pérez', 180000, 3500000, 0.99),
('Noche estrellada', 1, 1, 1, 'Damián Suárez', 200000, 3700000, 0.99),
('Amanecer en vos', 1, 1, 1, 'María Gómez', 240000, 4200000, 0.99),
('Bajo el sol', 1, 1, 1, 'Juan Díaz', 190000, 3300000, 0.99),
('Tierra firme', 1, 1, 1, 'Laura López', 220000, 4100000, 0.99);









UPDATE Track
SET Name = 'Caminos del destino'
WHERE Name = 'Caminos del alma';

UPDATE Track
SET Milliseconds = 210000
WHERE Name = 'Luz de madrugada';







DELETE FROM Track
WHERE Name IN ('Caminos del destino', 'Luz de madrugada');

