SELECT * FROM INHABITANT /*/ --SE VE TODOS LOS HABITANTES QUE EXISTEN--*/´
STATE = "friendly" /*/ BUSCAMOS LA COLUMNA LOS FRIENDLY*/
job LIKE '%smith'/*/ EL PORCENTAKE LO USAMOS PARA BUSCAR TODOS LOS TRNAJOS QUE TERMINEN EN SMITH*/



SELECT personid from inhabitant where name like "Stranger" and personid = "20"
/*/ lo que hace esto es que el nombre personid lo cambia al nombre strager y lo pone numero 20 en la tabla*/

select gold from INHABITANT where name LIKE "Stranger"
/*/ lo que hace esto es que al nombre strager le pregunta cuanto oro tinene disponible*/

select * from ITEM WHERE owner IS NULL
/*/ SE FIJA QUE ITEMS NO TIENEN DUEÑO*/

UPDATE ITEM SET owner = 20 where owner is null
/*/ le metimos a la lista item que los owner son igual a el valor del personaje */

select * from ITEM where owner = "20"
/*/ guardamos en la lista item todos los valores del owner de la posicion 20*/


SELECT * FROM INHABITANT where STATE = "friendly" and job = "dealer" OR job = "merchant"
/*/ EN LOS HABITANTES SELECCIONA QUIEN ES SU AMIGO Y PARA SELECCIONARLOS TIENEN QUE SER
 DEALER O MERCHANT*/

 update item SET owner = 15 where item= "ring" or ITEM =
"teapot" 
/*/le pasamos los items llamados ring y teapot a la posicion 15*/


update INHABITANT SET name = "valen" where name = "Stranger"
/*/update=actualizar los habitantes la lista de nombres y ponerle valen donde
el nombre es stranger*/

SELECT * FROM INHABITANT where job = "baker" ORDER BY gold DESC
/*/selecciona a todos los baker y los ordena de a las mejores panaderias mas oro*/

SELECT I.name from INHABITANT I INNER JOIN VILLAGE V
ON I.personid = V.chief where V.name = "Onionville"
/*/lo que hacemos aca es que definimos 2 name por que existe 2
a uno le ponemos I(inhabitant) y al otro V(village) y lo siguiente
es que sabiendo el nombre de la aldea averiguamos el nombre del jefe*/  

SELECT COUNT(*) FROM inhabitant, village WHERE village.villageid = inhabitant.villageid AND village.name = 'Onionville'

COUNT(*)

SELECT I.name from INHABITANT I INNER JOIN VILLAGE V
ON I.personid = V.chief where V.name = "Onionville"


ME QUEDO EN EL PROBLEMA DE SAN MARTI Y LAS MUJERES LEER LAS PAGINA 
DEL JOIN Y REPASAR NUEVAMENTE LOS CODIGOS, TAMBIEN TRATAR DE RAZONAR LOS PROBLEMAS.

