-- 15.Mostrar el nombre del país, la ciudad y el promedio de rentas por ciudad. Por
-- ejemplo: si el país tiene 3 ciudades, se deben sumar todas las rentas de la
-- ciudad y dividirlo dentro de tres (número de ciudades del país).


-- get total of rentals by city [NOT FINISHED YET]
select distinct cntry.COUNTRY_NAME,
                c2.CITY_NAME,
                count(CITY_NAME)                                                       as num_rentas,
                SUM(COUNT(distinct COUNTRY_NAME)) over ()                              AS total_count,
                round(count(CITY_NAME) / SUM(COUNT(distinct COUNTRY_NAME)) over (), 2) as avg_rents_by_city
from COUNTRY cntry
        join CITY C2 on cntry.COUNTRY_CODE = C2.FK_COUNTRY_CODE
        join CLIENT C3 on C2.CITY_CODE = C3.CLIENT_CITY_CODE
        join MOVIE_RENTAL MR on C3.CLIENT_CODE = MR.CLIENT_CODE
where cntry.COUNTRY_NAME = 'United States'
group by cntry.COUNTRY_NAME, c2.CITY_NAME;


-- get number of cities of a country
select distinct COUNTRY_NAME, count(c2.CITY_NAME)
from COUNTRY
        join CITY C2 on COUNTRY.COUNTRY_CODE = C2.FK_COUNTRY_CODE
group by COUNTRY_NAME;