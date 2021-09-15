--  ===================================
/*
    5. Mostrar el apellido de todos los actores y la cantidad de actores que tienen
    ese apellido pero solo para los que comparten el mismo nombre por lo menos
    con dos actores.
*/


-- v1
select ACTOR.ACTOR_LAST_NAME, count(*)
from ACTOR,
    (select ACTOR_FIRST_NAME, ACTOR_LAST_NAME as actor_complete_name
    from ACTOR
    where (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son')
            from dual) >= 1
    order by ACTOR_FIRST_NAME) table2
where ACTOR.ACTOR_FIRST_NAME = table2.ACTOR_FIRST_NAME
having count(*) >= 2
group by ACTOR.ACTOR_LAST_NAME;

-- v2
select ACTOR_LAST_NAME, count(*) as num_of_actors
from ACTOR
where ACTOR_LAST_NAME in (
    select ACTOR_LAST_NAME as act_last_name
    from ACTOR
    where (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son')
        from dual) >= 1
)
having count(*) >= 2
group by ACTOR_LAST_NAME;


-- verification
select ACTOR.ACTOR_FIRST_NAME, ACTOR.ACTOR_LAST_NAME
from ACTOR,
    (select ACTOR_FIRST_NAME, ACTOR_LAST_NAME as actor_complete_name
    from ACTOR
    where (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son')
            from dual) >= 1) table2
where ACTOR.ACTOR_FIRST_NAME = table2.ACTOR_FIRST_NAME
group by ACTOR.ACTOR_FIRST_NAME, ACTOR.ACTOR_LAST_NAME;