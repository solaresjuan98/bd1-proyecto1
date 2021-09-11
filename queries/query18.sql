-- 18.Mostrar el nombre, apellido y fecha de retorno de película a la tienda de todos
-- los clientes que hayan rentado más de 2 películas que se encuentren en
-- lenguaje Inglés en donde el empleado que se las vendió ganará más de 15
-- dólares en sus rentas del día en la que el cliente rentó la película.

select distinct client.CLIENT_CODE, client.CLIENT_FIRST_NAME, client.CLIENT_LAST_NAME, count(*)
from CLIENT client
         join MOVIE_RENTAL rental on CLIENT.CLIENT_CODE = rental.CLIENT_CODE
         join RENTAL_DETAIL RD on rental.RENTAL_CODE = RD.RENTAL_CODE
         join MOVIE M on M.MOVIE_CODE = RD.MOVIE_CODE
         join MOVIE_LANGUAGE ML on M.MOVIE_CODE = ML.MOVIE_CODE
         join LANGUAGE L on L.LANGUAGE_CODE = ML.LANGUAGE_CODE
having count(*) > 2
group by client.CLIENT_CODE, client.CLIENT_FIRST_NAME, client.CLIENT_LAST_NAME, L.LANGUAGE_CODE, L.LANGUAGE_NAME;
;

select CLIENT_CODE, count(*)
from MOVIE_RENTAL
group by CLIENT_CODE;


select *
from LANGUAGE;