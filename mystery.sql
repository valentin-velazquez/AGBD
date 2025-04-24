select * from crime_scene_report where date = 20180115 and city = "SQL City" 
/*selecciona las personas que estan en la columna esa con el año y la ciudad*/

SELECT * FROM person where address_street_name = "Franklin Ave" and name LIKE "Annabel%"

/*id	name	     license_id	address_number	address_street_name	ssn
16371	Annabel Miller	490173	    103	            Franklin Ave	318771143*/

SELECT * FROM person 
WHERE address_street_name like "Northwestern%" ORDER BY address_number DESC limit 1

/*id	name	     license_id	address_number	address_street_name	ssn
14887	Morty Schapiro	118009	   4919	       Northwestern Dr	         111564949*/



SELECT * FROM person p
INNER JOIN drivers_license dl ON p.license_id = dl.id 
WHERE p.license_id = 118009
/*lo que hace esto es que te tira todos los datos de la lista juntos, poniendo la license id.
 se puede abrebiar poniendole letras adelante*/
 /*id	 name	 license_id	 address_number	address_street_name	ssn	 id	   age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
14887 Morty Schapiro	118009	4919	Northwestern Dr	 111564949	118009	64	 84	   blue	white	male	00NU00	Mercedes-Benz	E-Class*/

SELECT * FROM person p
INNER JOIN interview iw ON p.id = iw.person_id 
WHERE p.id = 14887
/*me tira los datos de la lista interview cuando yo le doy el id de la lista person*/



SELECT * FROM get_fit_now_member
WHERE id like "48Z%" ORDER BY membership_start_date asc limit 1
/* lo que hace esto es que del id del principio de la tarjeta lo busca y deja el miembro que
desde hace mas tiempo esta.*/






/*ACTIVIDAD 1*/
SELECT f.title, a.address, c.city, c_t.country FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN store s ON i.store_id = s.store_id 
INNER JOIN address a ON s.address_id = a.address_id 
INNER JOIN city c ON a.city_id = c.city_id 
INNER JOIN country c_t ON c.country_id = c_t. country_id
WHERE  f.title = 'ACADEMY DINOSAUR'
/*Título de la película a elección, dirección, ciudad y país del local de todos los ejemplares que están sin devolver.*/



/*ACTVIDAD 2*/
SELECT f.title, c.name, l.name, f.rating, f.length FROM film f
INNER JOIN film_category f_c ON f.film_id = f_c.film_id 
INNER JOIN category c ON f_c.category_id = c.category_id 
INNER JOIN language l ON f.language_id = l.language_id 
where length between 60 and 120
/*Mostrar título, categoría, idioma, rating y duración de las películas que estén entre 1 hs y 2 hs.
*/




/*ACTIVIDAD 3*/
SELECT s.first_name, s.last_name, a.address, c.city, c_t.country  FROM staff s
INNER JOIN address a ON s.address_id = a.address_id 
INNER JOIN city c ON a.city_id = c.city_id 
INNER JOIN country c_t ON c.country_id = c_t.country_id 
/*Mostrar nombre, apellido y dirección (con ciudad y país) de los encargados del local.*/


/*ACTIVIDAD 4*/
SELECT title,min(return_date), max(return_date) FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN rental r ON i.inventory_id = r.inventory_id 
/*muestra el nombre de una pelicula con la fecha(min)minima y la(mas maxima) de entrega.*/



/*ACTIVIDAD 5*/
/*inner join sirve para unir 2 tablas, lo comparas cuando hay el mismo nombre repetido en la otra tabla*/
/*si se pueden unir todas las tablas
film se une con film_category por film_id
film_category se une con category por category_id
film se une con languaje por languaje_id
fil se une con film_actor por film_id
film_actor se une con actor por actor_id
film se une con inventory por film_id
film_id se une con film_text por film_id
inventory se une con rental por inventory_id
rental se une con payment por staff_id
payment se une con staff por staff_id
staff se une con store por store_id
store se une con customer por store_id
customer se une con address por address_id
address se une con con city por city_id 
city se une con country por country_id
*/



/*ACTIVIDAD 6*/
SELECT count(*) rating/*para contar por ejemplo los titulos*/
FROM film f
GROUP BY rating
/*Cuantas peliculas hay en rating*/

/*ACTIVIDAD 7*/
SELECT count(*) as cant_pelicula, ca.name  
FROM film f
INNER JOIN film_category c ON f.film_id = c.film_id 
INNER JOIN category ca ON c.category_id = ca.category_id 
GROUP BY ca.name
/*muestra la cantidad de peliculas que hay en cada categoria*/

/*ACTIVIDAD 8*/
SELECT a.first_name,a.last_name,count(a.actor_id) as cant_actor, f.title 
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id 
INNER JOIN actor a ON fa.actor_id = a.actor_id 
GROUP BY f.film_id
ORDER by cant_actor desc limit 10
/*lo que hace es que selecciona el nombre y apellido de la lista actor, selecciona todos los id de los 
actoresy imprime el titulo de la pelicula luego usamos innejoin para juntar las listas despues agrupamos
los id de film y ordenamos la cantidad de actores de mayor a menor.*/


/*ACTIVIDAD 9*/
SELECT a.address, c.city, co.country,count(i.inventory_id)
FROM inventory i
INNER JOIN store s ON i.store_id = s.store_id 
INNER JOIN address a ON s.address_id = a.address_id 
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id  
GROUP by a.address
/*¿Cuántos ejemplares (inventory) en total hay en cada local?  Como no hay nombre del local,
 poner en su lugar la dirección incluyendo ciudad y país además de la cantidad*/
 


 /*ACTIVIDAD 10*/
 SELECT a.address, c.city, co.country,count(f.film_id)
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN store s ON i.store_id = s.store_id 
INNER JOIN address a ON s.address_id = a.address_id 
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id  
GROUP by a.address


/*ACTIVIDAD 11*/
SELECT AVG(f.rental_duration * f.rental_rate ) AS costo_promedio, c.name
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id 
INNER JOIN category c ON fc.category_id = c.category_id 
GROUP by c.name
/*lo que hace esto es que usa ek avg para sacar el promedio de la multiplicacion que hicimos
y le damos un nombre, accedemoos a las otras tablas con el inner join y en el primer renglon ponemos c.name
para imprimir el nombre de la categoria de las peliculas y luego usamos el group by para agrupar las filas*/


/*ACTIVIDAD 12*/
SELECT f.rental_duration as dias, f.rental_rate cost_dias, (f.rental_duration * f.rental_rate) as cost_total, min(return_date) as fecha_min, max(rental_date) as fecha_max  
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title = 'ALABAMA DEVIL'
/**/



/*ACTIVIDAD 13*/
SELECT f.title, f.length, c.name  
FROM film f
INNER JOIN film_category fc on f.film_id = fc.film_id
INNER JOIN category c on fc.category_id = c.category_id
ORDER by length desc

/*ACTIVIDAD 14*/
--Nombre de las peliculas que arranquen‘’w’’ con al menos 5 actores
SELECT f.title, a.first_name, count(a.actor_id) as cant_Actor
FROM film f
INNER JOIN film_actor fa on f.film_id = fa.film_id
INNER JOIN actor a on fa.actor_id = a.actor_id
WHERE title like "W%"
GROUP BY f.film_id               --separa por grupo 
HAVING  cant_Actor >=5                         --sirve para filtar unicamente campos contados(AVG,SUM,COUNT)
ORDER BY cant_Actor asc 

/*ACTIVIDAD 15*/
 --Calcular la suma total de los pagos (amount) con nombre y apellido de cada cliente.
SELECT c.first_name, c.last_name, sum(p.amount) as cant_pago
FROM customer c
INNER JOIN payment p on c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name               --separa por grupo 
ORDER by cant_pago ASC


/*ACTIVIDAD 16*/
-- Nombre de la pelicula, duración y nombre del actor de las peliculas más cortas.
SELECT f.title, f.length as pelisCortas, a.first_name
FROM film f
INNER JOIN film_actor fa on f.film_id = fa.film_id
INNER JOIN actor a on fa.actor_id = a.actor_id
WHERE f.length < 100
ORDER BY f.length ASC


/*ACTIVIDAD 17*/
--apellido del cliente con su ciudad, pais, direccion, sus alquileres y pagos, ordenado los pagos de menor a mayor.
SELECT f.title, f.length as pelisCortas, a.first_name
FROM customer c
INNER JOIN address a on c.film_id = a.film_id
INNER JOIN city ct on a.actor_id = ct.actor_id
INNER JOIN country co on ct.actor_id = co.actor_id
INNER JOIN rental r on c.actor_id = co.actor_id
WHERE f.length < 100
ORDER BY f.length ASC
/*no terminado */






SELECT AVG(), rating from film
GROUP by rating

/* SELECT rental_duration * rental_date AS resultado avg(resultado)
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id 
INNER JOIN category c ON fc.category_id = c.category_id 
GROUP by film
*/