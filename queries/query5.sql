/*
    5. Mostrar el apellido de todos los actores y la cantidad de actores que tienen
    ese apellido pero solo para los que comparten el mismo nombre por lo menos
    con dos actores.
*/

select ACTOR_FIRST_NAME || ' ' || ACTOR_LAST_NAME as actor_complete_name
from ACTOR
where (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son')
from dual) >= 1;

select ACTOR_LAST_NAME as actor_complete_name, count(*)
from ACTOR
where (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son')
from dual) >= 1
group by ACTOR_LAST_NAME;

select ACTOR_FIRST_NAME as actor_complete_name, count(*)
from ACTOR
where (SELECT INSTR(ACTOR.ACTOR_FIRST_NAME, 'son')
from dual) >= 1
group by ACTOR_FIRST_NAME;


--  ===================================
/*
    5. Mostrar el apellido de todos los actores y la cantidad de actores que tienen
    ese apellido pero solo para los que comparten el mismo nombre por lo menos
    con dos actores.
*/



SELECT ACTOR_LAST_NAME, COUNT(*)
FROM ACTOR
--WHERE (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son') from dual) >= 1
HAVING COUNT(*) >= 2
GROUP BY ACTOR_LAST_NAME;

