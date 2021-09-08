/* 10.Mostrar el nombre y apellido (en una sola columna) de todos los actores y
clientes cuyo primer nombre sea el mismo que el primer nombre del actor con
ID igual a 8. No debe retornar el nombre del actor con ID igual a 8
dentro de la consulta. No puede utilizar el nombre del actor como una
constante, únicamente el ID proporcionado. */


    select CLIENT_FIRST_NAME || ' ' || CLIENT.CLIENT_LAST_NAME AS COMPLETE_NAME
    from CLIENT
    where CLIENT.CLIENT_FIRST_NAME = (SELECT ACTOR_FIRST_NAME
    FROM ACTOR
    WHERE ACTOR_CODE = 8)
UNION
    SELECT ACTOR_FIRST_NAME || ' ' || ACTOR.ACTOR_LAST_NAME
    FROM ACTOR
    where ACTOR_FIRST_NAME = (SELECT ACTOR_FIRST_NAME
        FROM ACTOR
        WHERE ACTOR_CODE = 8)
        AND ACTOR.ACTOR_CODE
NOT IN 8;

