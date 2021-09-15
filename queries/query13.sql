/*
    13.Mostrar el nombre del país, nombre del cliente y número de películas
    rentadas de todos los clientes que rentaron más películas por país. Si el
    número de películas máximo se repite, mostrar todos los valores que
    representa el máximo.
*/


SELECT distinct CNTRY.COUNTRY_NAME,
                c2.CLIENT_FIRST_NAME,
                count(*)
FROM MOVIE_RENTAL
        JOIN CLIENT C2 on C2.CLIENT_CODE = MOVIE_RENTAL.CLIENT_CODE
        JOIN CITY CTY on CTY.CITY_CODE = c2.CLIENT_CITY_CODE
        JOIN COUNTRY CNTRY on CNTRY.COUNTRY_CODE = CTY.FK_COUNTRY_CODE
GROUP BY CNTRY.COUNTRY_NAME,
        c2.CLIENT_FIRST_NAME;
--c2.CLIENT_LAST_NAME;



-- query 1
SELECT distinct CNTRY.COUNTRY_NAME,
                c2.CLIENT_FIRST_NAME,
                c2.CLIENT_LAST_NAME,
                count(*)
FROM MOVIE_RENTAL
         JOIN CLIENT C2 on C2.CLIENT_CODE = MOVIE_RENTAL.CLIENT_CODE
         JOIN CITY CTY on CTY.CITY_CODE = c2.CLIENT_CITY_CODE
         JOIN COUNTRY CNTRY on CNTRY.COUNTRY_CODE = CTY.FK_COUNTRY_CODE
GROUP BY CNTRY.COUNTRY_NAME,
         c2.CLIENT_FIRST_NAME,
         c2.CLIENT_LAST_NAME;



-- query 2
select COUNTRY_NAME, max(rented_movies) as max_num_rented_movies_client
from Example_view
--join CLIENT C2 on EXAMPLE_VIEW.CLIENT_FIRST_NAME = C2.CLIENT_FIRST_NAME
group by COUNTRY_NAME;

select *
from COUNTRY;


-- final query
SELECT distinct CNTRY.COUNTRY_NAME,
                c2.CLIENT_FIRST_NAME,
                c2.CLIENT_LAST_NAME,
                count(*)
FROM MOVIE_RENTAL
         JOIN CLIENT C2 on C2.CLIENT_CODE = MOVIE_RENTAL.CLIENT_CODE
         JOIN CITY CTY on CTY.CITY_CODE = c2.CLIENT_CITY_CODE
         JOIN COUNTRY CNTRY on CNTRY.COUNTRY_CODE = CTY.FK_COUNTRY_CODE
         JOIN EXAMPLE_VIEW EV on CNTRY.COUNTRY_NAME = EV.COUNTRY_NAME
--where CNTRY.COUNTRY_NAME = ev.COUNTRY_NAME
having count(*) in (
    select max(rented_movies) as max_num_rented_movies
    from Example_view
    group by COUNTRY_NAME
)
GROUP BY CNTRY.COUNTRY_NAME,
         c2.CLIENT_FIRST_NAME,
         c2.CLIENT_LAST_NAME;


