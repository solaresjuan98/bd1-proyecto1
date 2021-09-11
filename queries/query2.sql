-- 2. Mostrar el nombre, apellido y pago total de todos los clientes que han rentado
-- películas por lo menos 40 veces
SELECT CLIENT_FIRST_NAME, CLIENT_LAST_NAME, count(*) as times_rented, sum(rd.RENT_COST) as total
FROM CLIENT
        JOIN MOVIE_RENTAL mr on CLIENT.CLIENT_CODE = mr.CLIENT_CODE
        JOIN RENTAL_DETAIL rd on mr.RENTAL_CODE = rd.RENTAL_CODE
having count(*) >= 40
group by CLIENT_FIRST_NAME, CLIENT_LAST_NAME;



--
