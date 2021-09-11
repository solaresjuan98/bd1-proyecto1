-- 9. Mostrar el título de la película, el nombre y apellido del actor de todas
-- aquellas películas en las que uno o más actores actuaron en dos o más
-- películas.



-- =====================================================================
-- movies where there are more than one or two actors
select M.MOVIE_TITLE, COUNT(*) as number_of_actors
from MOVIE_ACTOR
        join ACTOR A2 on A2.ACTOR_CODE = MOVIE_ACTOR.ACTOR_CODE
        join MOVIE M on M.MOVIE_CODE = MOVIE_ACTOR.MOVIE_CODE
having count(*) > 1
group by M.MOVIE_TITLE;


-- ==== FINAL QUERY ====

select distinct a2.ACTOR_FIRST_NAME, a2.ACTOR_LAST_NAME, m.MOVIE_TITLE
from MOVIE_ACTOR
        join ACTOR A2 on A2.ACTOR_CODE = MOVIE_ACTOR.ACTOR_CODE
        join MOVIE M on M.MOVIE_CODE = MOVIE_ACTOR.MOVIE_CODE
where MOVIE_ACTOR.MOVIE_CODE in (select M.MOVIE_CODE
                                from MOVIE_ACTOR
                                        join ACTOR A2 on A2.ACTOR_CODE = MOVIE_ACTOR.ACTOR_CODE
                                        join MOVIE M on M.MOVIE_CODE = MOVIE_ACTOR.MOVIE_CODE
                                having count(*) >= 1
                                group by M.MOVIE_CODE)
and m.MOVIE_TITLE in (select M.MOVIE_TITLE
                        from MOVIE_ACTOR
                                join ACTOR A2 on A2.ACTOR_CODE = MOVIE_ACTOR.ACTOR_CODE
                                join MOVIE M on M.MOVIE_CODE = MOVIE_ACTOR.MOVIE_CODE
                        having count(*) >= 1
                        group by M.MOVIE_TITLE);
