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