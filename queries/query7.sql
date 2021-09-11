-- 7. Mostrar el nombre de la categoría y el número de películas por categoría de
-- todas las categorías de películas en las que hay entre 55 y 65 películas.
-- Ordenar el resultado por número de películas de forma descendente

-- SELECT CATEGORY_NAME, COUNT(*) as number_of_movies
-- FROM CATEGORY
--     JOIN MOVIE M on CATEGORY.CATEGORY_CODE = M.CATEGORY_CODE
-- HAVING count(*) BETWEEN 55 AND 65
-- GROUP BY CATEGORY_NAME
-- ORDER BY number_of_movies DESC;


SELECT CATEGORY.CATEGORY_NAME, COUNT(*) number_of_movies
FROM CATEGORY
        JOIN MOVIE_CATEGORY mc on CATEGORY.CATEGORY_CODE = mc.CATEGORY_CODE
        JOIN MOVIE M on M.MOVIE_CODE = mc.MOVIE_CODE
HAVING count(*) between 55 and 65
group by CATEGORY.CATEGORY_NAME
order by number_of_movies DESC;
