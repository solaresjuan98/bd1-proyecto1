
/*
    20.Mostrar el porcentaje de lenguajes de películas más rentadas de cada ciudad
    durante el mes de julio del año 2005 de la siguiente manera: ciudad,
    lenguaje, porcentaje de renta.

 */
 
select distinct cty.CITY_NAME, l.LANGUAGE_NAME, '100%' as total_percentage
from CITY cty
    join CLIENT cli on cty.CITY_CODE = cli.CLIENT_CITY_CODE
    join MOVIE_RENTAL mov_rental on cli.CLIENT_CODE = mov_rental.CLIENT_CODE
    join RENTAL_DETAIL RD on mov_rental.RENTAL_CODE = RD.RENTAL_CODE
    join MOVIE M on RD.MOVIE_CODE = M.MOVIE_CODE
    join MOVIE_LANGUAGE ML on M.MOVIE_CODE = ML.MOVIE_CODE
    join LANGUAGE L on L.LANGUAGE_CODE = ML.LANGUAGE_CODE
where (select extract(MONTH from mov_rental.RENTAL_DATE)
    from DUAL) = 7
    and (select extract(year from mov_rental.RENTAL_DATE)
    from DUAL) = 2005;