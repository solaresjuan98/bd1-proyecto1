-- 15.Mostrar el nombre del país, la ciudad y el promedio de rentas por ciudad. Por
-- ejemplo: si el país tiene 3 ciudades, se deben sumar todas las rentas de la
-- ciudad y dividirlo dentro de tres (número de ciudades del país).

select table_1.COUNTRY_NAME,
        table_1.CITY_NAME,
        table_1.rentals_num,
        table_2.total_cities,
        round((table_1.rentals_num / table_2.total_cities), 3) avg_rent_rate
from (
         select cntry.COUNTRY_NAME, cty.CITY_NAME, count(*) rentals_num
        from COUNTRY cntry
                join CITY cty on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
                join CLIENT cli on cty.CITY_CODE = cli.CLIENT_CITY_CODE
                join MOVIE_RENTAL MR on cli.CLIENT_CODE = MR.CLIENT_CODE
        group by cntry.COUNTRY_NAME, cty.CITY_NAME
) table_1
        join (
    select COUNTRY_NAME, count(*) total_cities
        from COUNTRY cntry
                join CITY cty on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
        group by COUNTRY_NAME
) table_2 on table_1.COUNTRY_NAME = table_2.COUNTRY_NAME
group by table_1.COUNTRY_NAME, table_1.CITY_NAME, table_1.rentals_num, table_2.total_cities
order by table_1.COUNTRY_NAME;


