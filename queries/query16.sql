-- 16.Mostrar el nombre del país y el porcentaje de rentas de películas de la
-- categoría “Sports”.

SELECT DISTINCT C4.COUNTRY_NAME,
                COUNT(*)                                           times_rented,
                sum(count(*)) over ()                              total_sports_rented_movies,
                round(100 * (count(*) / sum(count(*)) over ()), 2) percentage
FROM MOVIE_RENTAL
        JOIN CLIENT C2 on C2.CLIENT_CODE = MOVIE_RENTAL.CLIENT_CODE
        JOIN CITY C3 on C3.CITY_CODE = C2.CLIENT_CITY_CODE
        JOIN COUNTRY C4 on C4.COUNTRY_CODE = C3.FK_COUNTRY_CODE
        JOIN RENTAL_DETAIL RD ON MOVIE_RENTAL.RENTAL_CODE = RD.RENTAL_CODE
        JOIN MOVIE M on RD.MOVIE_CODE = M.MOVIE_CODE
        JOIN MOVIE_CATEGORY MC on M.MOVIE_CODE = MC.MOVIE_CODE
        JOIN CATEGORY C5 on C5.CATEGORY_CODE = MC.CATEGORY_CODE
WHERE C5.CATEGORY_NAME = 'Sports'
GROUP BY C4.COUNTRY_NAME;

-- QUERY 
SELECT DISTINCT --C4.COUNTRY_NAME,
                COUNT(*)                                           grp_count
                -- sum(count(*)) over ()                              total_count,
                -- round(100 * (count(*) / sum(count(*)) over ()), 2) percentage
FROM MOVIE_RENTAL
        JOIN CLIENT C2 on C2.CLIENT_CODE = MOVIE_RENTAL.CLIENT_CODE
        JOIN CITY C3 on C3.CITY_CODE = C2.CLIENT_CITY_CODE
        JOIN COUNTRY C4 on C4.COUNTRY_CODE = C3.FK_COUNTRY_CODE
        JOIN RENTAL_DETAIL RD ON MOVIE_RENTAL.RENTAL_CODE = RD.RENTAL_CODE
        JOIN MOVIE M on RD.MOVIE_CODE = M.MOVIE_CODE
        JOIN MOVIE_CATEGORY MC on M.MOVIE_CODE = MC.MOVIE_CODE
        JOIN CATEGORY C5 on C5.CATEGORY_CODE = MC.CATEGORY_CODE
WHERE C5.CATEGORY_NAME = 'Sports';



-- get count of movies with categories
select distinct c2.CATEGORY_NAME ,count(*) num_of_rentals
    from MOVIE
        join RENTAL_DETAIL RD on MOVIE.MOVIE_CODE = RD.MOVIE_CODE
        join MOVIE_CATEGORY mc on MOVIE.MOVIE_CODE = mc.MOVIE_CODE
        join CATEGORY C2 on C2.CATEGORY_CODE = mc.CATEGORY_CODE
group by c2.CATEGORY_NAME order by num_of_rentals;
