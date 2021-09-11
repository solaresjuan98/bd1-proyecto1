--3. Mostrar el nombre y apellido del cliente y el nombre de la película de todos
-- aquellos clientes que hayan rentado una película y no la hayan devuelto y
-- donde la fecha de alquiler esté más allá de la especificada por la película.

/*
    Yo le reste la fecha de retorno con la fecha que se alquilo así me daba cuántos días tardo 
    Y luego si ese es mayor a la cantidad de días que se puede rentar lan
    pelicula es que está más allá de la especificada
*/


SELECT distinct CLIENT.CLIENT_FIRST_NAME,
                CLIENT.CLIENT_LAST_NAME,
                M.MOVIE_TITLE
FROM CLIENT
        join MOVIE_RENTAL MR on CLIENT.CLIENT_CODE = MR.CLIENT_CODE
        join RENTAL_DETAIL RD on MR.RENTAL_CODE = RD.RENTAL_CODE
        join MOVIE M on RD.MOVIE_CODE = M.MOVIE_CODE
where rd.RENT_DURATION < round((RD.RETURN_DATE - MR.RENTAL_DATE), 0);