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
SELECT * FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN rental r ON i.inventory_id = r.inventory_id 
whe
/* no terminado */

