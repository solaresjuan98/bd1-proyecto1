-- movies where more than two actors appeared
select m.MOVIE_TITLE, count(*)
from MOVIE_DETAIL
    join MOVIE M on M.MOVIE_CODE = MOVIE_DETAIL.MOVIE_CODE
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_DETAIL.ACTOR_CODE
having count(*) >= 2
group by m.MOVIE_TITLE;



--- ===================================================0


-- 9. Mostrar el título de la película, el nombre y apellido del actor de todas
-- aquellas películas en las que uno o más actores actuaron en dos o más
-- películas.


select M.MOVIE_TITLE, A2.ACTOR_FIRST_NAME, A2.ACTOR_LAST_NAME
from MOVIE_DETAIL
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_DETAIL.ACTOR_CODE
    join MOVIE M on M.MOVIE_CODE = MOVIE_DETAIL.MOVIE_CODE
having count(*) >= 1
--between 1 and 2
group by M.MOVIE_TITLE, A2.ACTOR_FIRST_NAME, A2.ACTOR_LAST_NAME;



-- =====================================================================
-- movies where there are more than one or two actors
select M.MOVIE_TITLE, COUNT(*) as number_of_movies
from MOVIE_DETAIL
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_DETAIL.ACTOR_CODE
    join MOVIE M on M.MOVIE_CODE = MOVIE_DETAIL.MOVIE_CODE
having count(*) > 1
group by M.MOVIE_TITLE;

-- =====================================================================
-- get actors by single movie
select M.MOVIE_TITLE, A2.ACTOR_FIRST_NAME, A2.ACTOR_LAST_NAME
from MOVIE_DETAIL
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_DETAIL.ACTOR_CODE
    join MOVIE M on M.MOVIE_CODE = MOVIE_DETAIL.MOVIE_CODE
having count(*) between 1 and 2
group by M.MOVIE_TITLE, A2.ACTOR_FIRST_NAME, A2.ACTOR_LAST_NAME;

select count(*)
from MOVIE_DETAIL
where MOVIE_CODE = 459;

-- =====================================================================

SELECT A2.ACTOR_CODE, COUNT(*) AS NUMBER_OF_MOVIES
FROM MOVIE_DETAIL
    JOIN MOVIE M on M.MOVIE_CODE = MOVIE_DETAIL.MOVIE_CODE
    JOIN ACTOR A2 on A2.ACTOR_CODE = MOVIE_DETAIL.ACTOR_CODE
where
GROUP BY A2.ACTOR_CODE;

-- movies where more than two actors appeared
select m.MOVIE_TITLE, MOVIE_DETAIL.ACTOR_CODE
from MOVIE_DETAIL
    join MOVIE M on M.MOVIE_CODE = MOVIE_DETAIL.MOVIE_CODE
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_DETAIL.ACTOR_CODE
having count(*) >= 2
group by m.MOVIE_TITLE, MOVIE_DETAIL.ACTOR_CODE;



select M.MOVIE_TITLE, A2.ACTOR_FIRST_NAME, A2.ACTOR_LAST_NAME
from MOVIE_DETAIL
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_DETAIL.ACTOR_CODE
    join MOVIE M on M.MOVIE_CODE = MOVIE_DETAIL.MOVIE_CODE
having count(*) >= 2
group by m.MOVIE_TITLE, A2.ACTOR_FIRST_NAME, A2.ACTOR_LAST_NAME;

select count(*)
from MOVIE_DETAIL
where ACTOR_CODE = 348;


select m.MOVIE_CODE, m.MOVIE_TITLE, count(*)
from MOVIE_DETAIL
    join MOVIE M on M.MOVIE_CODE = MOVIE_DETAIL.MOVIE_CODE
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_DETAIL.ACTOR_CODE
having count(*) >= 2
group by m.MOVIE_CODE, m.MOVIE_TITLE;
