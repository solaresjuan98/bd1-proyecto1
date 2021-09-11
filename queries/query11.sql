--- ===================================================
-- 11. Mostrar el país y el nombre del cliente que más películas rentó así como
-- también el porcentaje que representa la cantidad de películas que rentó con
-- respecto al resto de clientes del país.
SELECT
    distinct CNTRY.COUNTRY_NAME,
    c2.CLIENT_FIRST_NAME,
    c2.CLIENT_LAST_NAME,
    --count(*)                                           grp_count,
    --sum(count(*)) over ( )                             total_cnt,
    round(100 * (count(*) / sum(count(*)) over ()), 2) percentage
FROM
    MOVIE_RENTAL
    JOIN CLIENT C2 on C2.CLIENT_CODE = MOVIE_RENTAL.CLIENT_CODE
    JOIN CITY CTY on CTY.CITY_CODE = c2.CLIENT_CITY_CODE
    JOIN COUNTRY CNTRY on CNTRY.COUNTRY_CODE = CTY.FK_COUNTRY_CODE
where
    CNTRY.COUNTRY_NAME = (
    select
    COUNTRY_NAME
from
    (
        SELECT
        distinct c2.CLIENT_CODE,
        CNTRY.COUNTRY_NAME,
        count(*) times_rented,
        sum(count(*)) over () total_count,
        round(100 * (count(*) / sum(count(*)) over ()), 2) percentage
    FROM
        MOVIE_RENTAL
        JOIN CLIENT C2 on C2.CLIENT_CODE = MOVIE_RENTAL.CLIENT_CODE
        JOIN CITY CTY on CTY.CITY_CODE = c2.CLIENT_CITY_CODE
        JOIN COUNTRY CNTRY on CNTRY.COUNTRY_CODE = CTY.FK_COUNTRY_CODE
    GROUP BY
        c2.CLIENT_CODE,
        CNTRY.COUNTRY_NAME
    ORDER BY
        times_rented desc
FETCH FIRST
        1 ROWS ONLY
    )
) -- select country from the client that has rented more movies from the country
GROUP BY
CNTRY.COUNTRY_NAME,
c2.CLIENT_FIRST_NAME,
c2.CLIENT_LAST_NAME;