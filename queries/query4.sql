--4. Mostrar el nombre y apellido (en una sola columna) de los actores que
-- contienen la palabra “SON” en su apellido, ordenados por su primer nombre.

select ACTOR_FIRST_NAME || ' ' || ACTOR_LAST_NAME as actor_complete_name
from ACTOR
where (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son')
from dual) >= 1;