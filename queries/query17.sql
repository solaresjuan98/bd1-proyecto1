/*17.Mostrar la lista de ciudades de Estados Unidos y el número de rentas de
películas para las ciudades que obtuvieron más rentas que la ciudad
“Dayton”.*/

SELECT CITY.CITY_NAME, count(*) as city_count
FROM CITY
        join COUNTRY CN on CN.COUNTRY_CODE = CITY.FK_COUNTRY_CODE
        join CLIENT CL on CL.CLIENT_CITY_CODE = CITY.CITY_CODE
        join MOVIE_RENTAL MR on CL.CLIENT_CODE = MR.CLIENT_CODE
where COUNTRY_NAME = 'United States'
HAVING count(*) > (
    SELECT count(*) as city_count
    FROM CITY
            join COUNTRY C2 on C2.COUNTRY_CODE = CITY.FK_COUNTRY_CODE
            join CLIENT C3 on CITY.CITY_CODE = C3.CLIENT_CITY_CODE
            join MOVIE_RENTAL M on C3.CLIENT_CODE = M.CLIENT_CODE
    where C2.COUNTRY_NAME = 'United States'
    and CITY_NAME = 'Dayton'
)
group by CITY.CITY_NAME;


