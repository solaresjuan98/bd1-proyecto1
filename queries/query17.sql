/*17.Mostrar la lista de ciudades de Estados Unidos y el número de rentas de
películas para las ciudades que obtuvieron más rentas que la ciudad
“Dayton”.*/

SELECT DISTINCT CITY.CITY_NAME, count(*) as city_count
FROM CITY
    JOIN COUNTRY C2 on C2.COUNTRY_CODE = CITY.FK_COUNTRY_CODE
    join ADDRESS A2 on CITY.CITY_CODE = A2.FK_CITY_CODE
    join CLIENT C3 on A2.ADDRESS_CODE = C3.ADDRESS_CODE
    join RENTAL_BILL RB on C3.CLIENT_CODE = RB.CLIENT_CODE
where COUNTRY_NAME = 'United States'
having count(*) > (
    SELECT count(*) as city_count
FROM CITY
    JOIN COUNTRY C2 on C2.COUNTRY_CODE = CITY.FK_COUNTRY_CODE
    join ADDRESS A2 on CITY.CITY_CODE = A2.FK_CITY_CODE
    join CLIENT C3 on A2.ADDRESS_CODE = C3.ADDRESS_CODE
    join RENTAL_BILL RB on C3.CLIENT_CODE = RB.CLIENT_CODE
where COUNTRY_NAME = 'United States'
    AND CITY_NAME = 'Dayton'
)
group by CITY.CITY_NAME;


