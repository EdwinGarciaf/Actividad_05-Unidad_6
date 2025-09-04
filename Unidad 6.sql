drop table toys cascade constraints;
drop table bricks cascade constraints;
create table toys (
  toy_id     integer,
  toy_name   varchar2(20),
  toy_colour varchar2(10)
);

create table bricks (
  brick_id     integer,
  brick_colour varchar2(10),
  brick_shape  varchar2(10)
);

insert into toys values ( 1, 'Miss Snuggles', 'pink' ) ;
insert into toys values ( 2, 'Cuteasaurus', 'blue' ) ;
insert into toys values ( 3, 'Baby Turtle', 'green' ) ;

insert into bricks values ( 2, 'blue', 'cube' );
insert into bricks values ( 3, 'green', 'cube' );
insert into bricks values ( 4, 'blue', 'pyramid' );

commit;

SELECT * from bricks;
SELECT * from toys;

/* Uniones Cruzadas */

/* Una unión cruzada devuelve cada fila de la 
primera tabla que coincida con cada fila de la segunda. */

/* Usando la sintaxis de Oracle */

select *
from   toys, bricks;

select *
from   bricks, toys;

/* Sintaxis de ANSI (Recomendable) */

select *
from   toys
cross join bricks;

select *
from   bricks
cross join toys;

/* Inner Joins */

/* Una unión interna (o simplemente unión) vincula dos tablas. */

/* Oracle Sintaxis */

select *
from   toys, bricks
where  toy_id = brick_id;

/*ANSI Sintaxis */

select *
from   toys
inner  join bricks on toy_id = brick_id;

/* Unir con columnas que tiene valores repetidos */

select *
from   toys
join   bricks on toy_colour = brick_colour;

/* También se pueden unir desigualdades */

select *
from   toys join bricks on toy_colour <> brick_colour;

/* Ejercicio 5. - Try it */

/* Juguetes y ladrillos de unión interna
Donde el toy_id es mayor que el brick_id */

select *
from   toys
join   bricks on toy_id > brick_id;

/* Oracle Sintaxis */

select *
from   toys, bricks
where  toy_id > brick_id;

/* Uniones externas */

/*Una unión externa devuelve todas las 
filas de una tabla junto con las filas coincidentes de la otra.*/

/* La siguiente unión izquierda une juguetes y ladrillos según sus ID */

select *from   toys
left   outer join bricks
on     toy_id = brick_id;

select *from   toys
right  outer join bricks
on     toy_id = brick_id;

/* Sintaxis de Oracle se usa (+) */

select *
from   toys, bricks
where  toy_id = brick_id (+);

/*Para hacer lo mismo con la sintaxis de Oracle, 
mueva el signo más a las columnas de la tabla de juguetes:*/

select *
from   toys, bricks
where  toy_id (+) = brick_id;

/* 7. Filtrando Uniones */

/*Puede filtrar las filas devueltas por una unión en su cláusula where.*/

/*La siguiente operación une las tablas según su ID.*/

select *
from   toys
join   bricks on toy_id = brick_id
where  brick_colour = 'green';

/*Si filtra la tabla unida externamente en su cláusula where, 
convertirá la consulta en una unión interna. 

Y solo obtendrá una fila*/
/* ANSI */

select *
from   toys
left   join bricks
on     toy_id = brick_id
where  brick_colour = 'green';

/* Oracle */
select *
from   toys, bricks
where  toy_id (+) = brick_id
and    brick_colour = 'green';

/*Para solucionar esto, debe incluir los criterios de filtrado de 
la tabla externamente unida en la cláusula de unión*/

/* ANSI */

select *
from   toys
left   join bricks
on     toy_id = brick_id
and    brick_colour = 'green';

/* Oracle */

select *
from   toys, bricks
where  toy_id = brick_id (+)
and    brick_colour (+) = 'green';

/* Ejercicio 8 - Try it! */

/* - Todas las filas de ladrillos
   - Cualquier fila en juguetes con toy_id igual a brick_id y el toy_colour es azul*/

/* ANSI */

select *
from   bricks
left   join toys
on     brick_id = toy_id
and    toy_colour = 'blue';

/* Oracle */

select *
from   bricks, toys
where  toy_id (+) = brick_id
and    toy_colour (+) = 'blue';

/* Uniones externas Completas */

/* A veces, puede que quieras unir dos tablas para 
encontrar las filas coincidentes. */

/* Puedes hacer esto usando la sintaxis ANSI de la siguiente manera */

select *
from   toys
full   join bricks
on     toy_id = brick_id;

/* Escribir una unión externa completa con la sintaxis de Oracle es un poco complicado.
   Para combinar los resultados de estas, se utiliza "union all": */

select *
from   toys, bricks
where  toy_id = brick_id (+)
union all
select *
from   toys, bricks
where  toy_id (+) = brick_id
and    toy_id is null;

/* Al igual que las uniones cruzadas, es poco común usar esto. */