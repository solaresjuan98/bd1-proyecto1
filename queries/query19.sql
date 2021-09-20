/*
        19. Mostrar el número de mes, de la fecha de renta de la película, nombre y
        apellido de los clientes que más películas han rentado y las que menos en
        una sola consulta.
*/

(
    select cli.CLIENT_FIRST_NAME,
        cli.CLIENT_LAST_NAME,
        mov_rental.RENTAL_DATE,
        (SELECT extract(MONTH FROM mov_rental.RENTAL_DATE)
        FROM DUAL) as month_rent
from MOVIE_RENTAL mov_rental
        join CLIENT cli on cli.CLIENT_CODE = mov_rental.CLIENT_CODE
where mov_rental.CLIENT_CODE = (select rental.CLIENT_CODE
--, count(*) as rented_movies
from MOVIE_RENTAL rental
        join RENTAL_DETAIL RD on rental.RENTAL_CODE = RD.RENTAL_CODE
group by rental.CLIENT_CODE
order by count(*) desc
fetch first 1 rows only)
)
union
(
    select cli.CLIENT_FIRST_NAME,
        cli.CLIENT_LAST_NAME,
        mov_rental.RENTAL_DATE,
        (SELECT extract(MONTH FROM mov_rental.RENTAL_DATE)
        FROM DUAL) as month_rent
from MOVIE_RENTAL mov_rental
        join CLIENT cli on cli.CLIENT_CODE = mov_rental.CLIENT_CODE
where mov_rental.CLIENT_CODE = (select rental.CLIENT_CODE
from MOVIE_RENTAL rental
        join RENTAL_DETAIL RD on rental.RENTAL_CODE = RD.RENTAL_CODE
group by rental.CLIENT_CODE
order by count(*)
fetch first 1 rows only)
);