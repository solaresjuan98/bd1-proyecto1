/*
1. Mostrar la cantidad de copias que existen en el inventario para la película
“Sugar Wonka”.
*/

select SUM(QUANTITY) as number_of_movies
from MOVIE_INVENTORY
         join MOVIE M on M.MOVIE_CODE = MOVIE_INVENTORY.MOVIE_CODE
where m.MOVIE_TITLE = 'SUGAR WONKA';