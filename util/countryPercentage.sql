SELECT DISTINCT C4.COUNTRY_NAME,
                COUNT(*)                                           grp_count,
                sum(count(*)) over ()                              total_count,
                round(100 * (count(*) / sum(count(*)) over ()), 2) percentage
FROM MOVIE_RENTAL
        JOIN CLIENT C2 on C2.CLIENT_CODE = MOVIE_RENTAL.CLIENT_CODE
        JOIN CITY C3 on C3.CITY_CODE = C2.CLIENT_CITY_CODE
        JOIN COUNTRY C4 on C4.COUNTRY_CODE = C3.FK_COUNTRY_CODE
GROUP BY C4.COUNTRY_NAME;