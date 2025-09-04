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


/* 3.- Cross Joins */

/* Sintaxis de Oracle */

select *
from   toys, bricks;

/* Sintaxis ANSI */

select *
from   toys
cross join bricks;


/* 4.- Inner Joins */
/*  Una unión interna (o simplemente unión) vincula dos tablas. 
    Solo devuelve las filas que cumplen las condiciones de unión en ambas tablas. */

/* Sintaxis de Oracle */

select *
from   toys, bricks
where  toy_id = brick_id;

/* Sintaxis ANSI */

select *
from   toys
inner  join bricks
on     toy_id = brick_id;

/* Ejercicio 5.- Try It!*/

/*  toys y bricks de unión interna
    Donde el toy_id es mayor que el brick_id */

select *
from   toys
join   bricks
on toy_id > brick_id;

/* 6. Outer Joins */

/* Una unión externa devuelve todas las filas de una tabla junto con las filas coincidentes de la otra. */

/* Sintaxis Oracle */

/* Se utiliza el signo (+) */

select *
from   toys, bricks
where  toy_id = brick_id (+);

/* Sintaxis ANSI */
/* Se indica el sentido hacia cual se quiere hacer */

select *from   toys
left   outer join bricks
on     toy_id = brick_id;

/* Para obtener todas las filas de los bloques, puede cambiar de una unión izquierda a una derecha. */

/* Sintaxis ANSI */

select *
from   toys
right  join bricks
on     toy_id = brick_id;

select *
from   bricks
left   join toys
on     toy_id = brick_id;

/* Sintaxis Oracle */ 

select *
from   toys, bricks
where  toy_id (+) = brick_id;

/* 7.- Filtering Joins */

/*  Puede filtrar las filas devueltas por una unión en su cláusula 'where'.
    la siguiente operación une las tablas según su ID. */

select *
from   toys
join   bricks
on     toy_id = brick_id
where  brick_colour = 'green';

/*  Si filtra la tabla unida externamente en su cláusula where, 
    convertirá la consulta en una unión interna.*/

/* Sintaxis ANSI */
select *
from   toys
left   join bricks
on     toy_id = brick_id
where  brick_colour = 'green';

/* Sintaxis Oracle */ 
select *
from   toys, bricks
where  toy_id (+) = brick_id
and    brick_colour = 'green';

/*  Para solucionar esto, debe incluir los criterios de filtrado de la tabla 
    externamente unida en la cláusula de unión.*/

/* Sintaxis ANSI */
select *
from   toys
left   join bricks
on     toy_id = brick_id
and    brick_colour = 'green';

/* Sintaxis Oracle */ 
select *
from   toys, bricks
where  toy_id = brick_id (+)
and    brick_colour (+) = 'green';

/* Ejercicio 8.- Try it!*/

/* 
    Todas las filas de ladrillos
    Cualquier fila en juguetes con toy_id igual a brick_id y el toy_colour es azul */

/* Sintaxis ANSI */
select *
from   bricks
left   join toys
on     brick_id = toy_id
and    toy_colour = 'blue';

/* 9.- Full Outer Joins */

/* Sintaxis ANSI */

select *
from   toys
full   join bricks
on     toy_id = brick_id;

/* Sintaxis Oracle */

select *
from   toys, bricks
where  toy_id = brick_id (+)
union all
select *
from   toys, bricks
where  toy_id (+) = brick_id
and    toy_id is null;