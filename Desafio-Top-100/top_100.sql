--Crear base de datos
CREATE DATABASE peliculas;

--Entrar a la base de datos
\c peliculas

--Creas Tablas
CREATE TABLE peliculas(
	id int PRIMARY KEY,
	pelicula VARCHAR(100),
	año_estreno SMALLINT,
	director VARCHAR(100)
);
CREATE TABLE reparto(
	id_pelicula INT REFERENCES peliculas(id),
	nombre_actor VARCHAR(100)
);

--Cargar archivos
\copy peliculas FROM '/mnt/c/users/56951/desktop/desafios_sql/Desafio-Top-100/peliculas.csv' CSV HEADER
\copy reparto FROM '/mnt/c/users/56951/desktop/desafios_sql/Desafio-Top-100/reparto.csv' CSV HEADER

--Listar todos los actores de la pelicula "Titanic"
SELECT reparto.nombre_actor AS Reparto_Titanic FROM reparto INNER JOIN peliculas ON peliculas.id = reparto.id_pelicula WHERE peliculas.id = 2;

--Listar todos los titlos de las peliculas donde actue Harrison Ford
SELECT * FROM peliculas LEFT JOIN reparto ON peliculas.id = reparto.id_pelicula WHERE reparto.nombre_actor = 'Harrison Ford';

--Listar los 10 directores mas populares.
SELECT director, COUNT(director) FROM peliculas GROUP BY director ORDER BY COUNT(director) DESC LIMIT 10;

--Indicar cuantos actores distintos hay.
SELECT COUNT(nombre_actor) AS cantidad_actores FROM(SELECT nombre_actor FROM reparto GROUP BY nombre_actor) AS x;

--Indicar peliculas estrenadas entre 1990 y 1999
SELECT * FROM peliculas WHERE año_estreno BETWEEN 1990 AND 1999 ORDER BY año_estreno ASC;

--Listar el reparto de las peliculas lanzadas en el año 2001
SELECT reparto.nombre_actor AS reparto_peliculas_2001, peliculas.pelicula AS nombre_pelicula FROM reparto JOIN peliculas ON reparto.id_pelicula = peliculas.id WHERE año_estreno = 2001;

--Listar los actores de la pelicula mas nueva
SELECT reparto.nombre_actor, peliculas.año_estreno FROM reparto INNER JOIN peliculas ON reparto.id_pelicula = peliculas.id WHERE peliculas.año_estreno = (SELECT MAX(año_estreno) FROM PELICULAS);