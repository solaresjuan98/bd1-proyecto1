-- 6. Mostrar el nombre y apellido de los actores que participaron en una película
-- que involucra un “Cocodrilo” y un “Tiburón” junto con el año de lanzamiento
-- de la película, ordenados por el apellido del actor en forma ascendente


select A.ACTOR_FIRST_NAME, A.ACTOR_LAST_NAME, MOVIE.RELEASE_YEAR
from MOVIE
    join MOVIE_DETAIL MD on MOVIE.MOVIE_CODE = MD.MOVIE_CODE
    join ACTOR A on A.ACTOR_CODE = MD.ACTOR_CODE
where instr(MOVIE_DESCRIPTION, 'Crocodile') >= 1
    AND INSTR(MOVIE_DESCRIPTION, 'Shark') >= 1
order by A.ACTOR_LAST_NAME;


-- ============ HELP ============


select MOVIE_DESCRIPTION
from MOVIE
where INSTR(MOVIE_DESCRIPTION, 'Shark') >= 1
    and INSTR(MOVIE_DESCRIPTION, 'Crocodile') >= 1;