-- 8. Mostrar todas las categorías de películas en las que la diferencia promedio
-- entre el costo de reemplazo de la película y el precio de alquiler sea superior
-- a 17

SELECT C2.CATEGORY_NAME, round(AVG(MOVIE.PENALTY_COST - MOVIE.RENT_COST), 2) avg_difference
FROM MOVIE
        JOIN MOVIE_CATEGORY mc ON MOVIE.MOVIE_CODE = mc.MOVIE_CODE
        JOIN CATEGORY C2 ON C2.CATEGORY_CODE = mc.CATEGORY_CODE
having round(AVG(MOVIE.PENALTY_COST - MOVIE.RENT_COST), 2) > 17
group by C2.CATEGORY_NAME;