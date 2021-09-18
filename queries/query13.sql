/*
    13.Mostrar el nombre del país, nombre del cliente y número de películas
    rentadas de todos los clientes que rentaron más películas por país. Si el
    número de películas máximo se repite, mostrar todos los valores que
    representa el máximo.
*/

select mov_rental.CLIENT_CODE,
    clnt.CLIENT_FIRST_NAME,
    clnt.CLIENT_LAST_NAME,
    cntry.COUNTRY_NAME,
    count(*) as rentals
from MOVIE_RENTAL mov_rental
    join CLIENT clnt on clnt.CLIENT_CODE = mov_rental.CLIENT_CODE
    join CITY cty on cty.CITY_CODE = clnt.CLIENT_CITY_CODE
    join COUNTRY cntry on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
group by mov_rental.CLIENT_CODE, clnt.CLIENT_FIRST_NAME, clnt.CLIENT_LAST_NAME, cntry.COUNTRY_NAME;

select COUNTRY_NAME as country, max(rentals) as max_rentals
from (
         select mov_rental.CLIENT_CODE,
        clnt.CLIENT_FIRST_NAME,
        clnt.CLIENT_LAST_NAME,
        cntry.COUNTRY_NAME,
        count(*) as rentals
    from MOVIE_RENTAL mov_rental
        join CLIENT clnt on clnt.CLIENT_CODE = mov_rental.CLIENT_CODE
        join CITY cty on cty.CITY_CODE = clnt.CLIENT_CITY_CODE
        join COUNTRY cntry on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
    group by mov_rental.CLIENT_CODE, clnt.CLIENT_FIRST_NAME, clnt.CLIENT_LAST_NAME, cntry.COUNTRY_NAME
     )
group by COUNTRY_NAME;


-- final query
select t1.country, t2.CLIENT_FIRST_NAME, t2.CLIENT_LAST_NAME, t1.max_rentals
from (
        select COUNTRY_NAME as country, max(rentals) as max_rentals
    from (
        select mov_rental.CLIENT_CODE,
            clnt.CLIENT_FIRST_NAME,
            clnt.CLIENT_LAST_NAME,
            cntry.COUNTRY_NAME,
            count(*) as rentals
        from MOVIE_RENTAL mov_rental
            join CLIENT clnt on clnt.CLIENT_CODE = mov_rental.CLIENT_CODE
            join CITY cty on cty.CITY_CODE = clnt.CLIENT_CITY_CODE
            join COUNTRY cntry on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
        group by mov_rental.CLIENT_CODE, clnt.CLIENT_FIRST_NAME, clnt.CLIENT_LAST_NAME, cntry.COUNTRY_NAME
    )
    group by COUNTRY_NAME) t1,
    (select mov_rental.CLIENT_CODE,
        clnt.CLIENT_FIRST_NAME,
        clnt.CLIENT_LAST_NAME,
        cntry.COUNTRY_NAME,
        count(*) as rentals
    from MOVIE_RENTAL mov_rental
        join CLIENT clnt on clnt.CLIENT_CODE = mov_rental.CLIENT_CODE
        join CITY cty on cty.CITY_CODE = clnt.CLIENT_CITY_CODE
        join COUNTRY cntry on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
    group by mov_rental.CLIENT_CODE, clnt.CLIENT_FIRST_NAME, clnt.CLIENT_LAST_NAME, cntry.COUNTRY_NAME) t2
where t2.rentals = t1.max_rentals
    and t2.COUNTRY_NAME = t1.country
order by t1.country;