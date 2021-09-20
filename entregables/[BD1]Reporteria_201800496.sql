-- Query #1
select SUM(QUANTITY) as number_of_movies
from MOVIE_INVENTORY
    join MOVIE M on M.MOVIE_CODE = MOVIE_INVENTORY.MOVIE_CODE
where m.MOVIE_TITLE = 'SUGAR WONKA';


-- Query #2
select distinct cli.CLIENT_FIRST_NAME, cli.CLIENT_LAST_NAME, sum(MOUNT_TO_PAY)
from MOVIE_RENTAL mov_rental
    join CLIENT cli on cli.CLIENT_CODE = mov_rental.CLIENT_CODE
having count(*) >= 40
group by cli.CLIENT_FIRST_NAME, cli.CLIENT_LAST_NAME;


-- Query #3
SELECT distinct CLIENT.CLIENT_FIRST_NAME,
    CLIENT.CLIENT_LAST_NAME,
    M.MOVIE_TITLE
FROM CLIENT
    join MOVIE_RENTAL MR on CLIENT.CLIENT_CODE = MR.CLIENT_CODE
    join RENTAL_DETAIL RD on MR.RENTAL_CODE = RD.RENTAL_CODE
    join MOVIE M on RD.MOVIE_CODE = M.MOVIE_CODE
where rd.RENT_DURATION < round((RD.RETURN_DATE - MR.RENTAL_DATE), 0);


-- Query #4
select ACTOR_FIRST_NAME || ' ' || ACTOR_LAST_NAME as actor_complete_name
from ACTOR
where (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son')
from dual) >= 1
order by ACTOR_FIRST_NAME;


-- Query #5

-- v1
select ACTOR.ACTOR_LAST_NAME, count(*)
from ACTOR,
    (select ACTOR_FIRST_NAME, ACTOR_LAST_NAME as actor_complete_name
    from ACTOR
    where (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son')
    from dual) >= 1
    order by ACTOR_FIRST_NAME) table2
where ACTOR.ACTOR_FIRST_NAME = table2.ACTOR_FIRST_NAME
having count(*) >= 2
group by ACTOR.ACTOR_LAST_NAME;

-- v2
select ACTOR_LAST_NAME, count(*) as num_of_actors
from ACTOR
where ACTOR_LAST_NAME in (
    select ACTOR_LAST_NAME as act_last_name
from ACTOR
where (SELECT INSTR(ACTOR.ACTOR_LAST_NAME, 'son')
from dual) >= 1
)
having count(*) >= 2
group by ACTOR_LAST_NAME;


-- Query #6

select A.ACTOR_FIRST_NAME, A.ACTOR_LAST_NAME, MOVIE.RELEASE_YEAR
from MOVIE
    join MOVIE_ACTOR ma on MOVIE.MOVIE_CODE = ma.MOVIE_CODE
    join ACTOR A on A.ACTOR_CODE = ma.ACTOR_CODE
where instr(MOVIE_DESCRIPTION, 'Crocodile') >= 1
    AND INSTR(MOVIE_DESCRIPTION, 'Shark') >= 1
order by A.ACTOR_LAST_NAME;


-- Query #7
SELECT CATEGORY.CATEGORY_NAME, COUNT(*) number_of_movies
FROM CATEGORY
    JOIN MOVIE_CATEGORY mc on CATEGORY.CATEGORY_CODE = mc.CATEGORY_CODE
    JOIN MOVIE M on M.MOVIE_CODE = mc.MOVIE_CODE
HAVING count(*) between 55 and 65
group by CATEGORY.CATEGORY_NAME
order by number_of_movies DESC;


-- Query #8
SELECT C2.CATEGORY_NAME, round(AVG(MOVIE.PENALTY_COST - MOVIE.RENT_COST), 2) avg_difference
FROM MOVIE
    JOIN MOVIE_CATEGORY mc ON MOVIE.MOVIE_CODE = mc.MOVIE_CODE
    JOIN CATEGORY C2 ON C2.CATEGORY_CODE = mc.CATEGORY_CODE
having round(AVG(MOVIE.PENALTY_COST - MOVIE.RENT_COST), 2) > 17
group by C2.CATEGORY_NAME;


-- Query #9
select distinct a2.ACTOR_FIRST_NAME, a2.ACTOR_LAST_NAME, m.MOVIE_TITLE
from MOVIE_ACTOR
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_ACTOR.ACTOR_CODE
    join MOVIE M on M.MOVIE_CODE = MOVIE_ACTOR.MOVIE_CODE
where MOVIE_ACTOR.MOVIE_CODE in (select M.MOVIE_CODE
from MOVIE_ACTOR
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_ACTOR.ACTOR_CODE
    join MOVIE M on M.MOVIE_CODE = MOVIE_ACTOR.MOVIE_CODE
having count(*) >= 1
group by M.MOVIE_CODE
)
and m.MOVIE_TITLE in
(select M.MOVIE_TITLE
from MOVIE_ACTOR
    join ACTOR A2 on A2.ACTOR_CODE = MOVIE_ACTOR.ACTOR_CODE
    join MOVIE M on M.MOVIE_CODE = MOVIE_ACTOR.MOVIE_CODE
having count(*) >= 1
group by M.MOVIE_TITLE);


-- Query #10
    select CLIENT_FIRST_NAME || ' ' || CLIENT.CLIENT_LAST_NAME AS COMPLETE_NAME
    from CLIENT
    where CLIENT.CLIENT_FIRST_NAME = (SELECT ACTOR_FIRST_NAME
    FROM ACTOR
    WHERE ACTOR_CODE = 8)
UNION
    SELECT ACTOR_FIRST_NAME || ' ' || ACTOR.ACTOR_LAST_NAME
    FROM ACTOR
    where ACTOR_FIRST_NAME = (SELECT ACTOR_FIRST_NAME
        FROM ACTOR
        WHERE ACTOR_CODE = 8)
        AND ACTOR.ACTOR_CODE
NOT IN 8;

select names, last_names
FROM (
                        select ACTOR_FIRST_NAME as names, ACTOR_LAST_NAME as last_names
        from ACTOR
    union
        select CLIENT_FIRST_NAME as names, CLIENT_LAST_NAME as last_names
        from CLIENT
    )
    inner join
    (
        select ACTOR.ACTOR_FIRST_NAME as actor_name, ACTOR.ACTOR_LAST_NAME as last_name_act
    from ACTOR
    where ACTOR.ACTOR_FIRST_NAME LIKE 'Matthew'
        and ACTOR.ACTOR_LAST_NAME LIKE 'Johansson'
    ) on names = actor_name
where last_names <> last_name_act;


-- Query #11
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


-- Query #12
-- ///////////////////////////////////////////////////

-- Query #13
select t1.country, t2.CLIENT_FIRST_NAME, t2.CLIENT_LAST_NAME, t1.max_rentals
from (
        select COUNTRY_NAME as country, max(rentals) as max_rentals
    from (
        select mov_rental.CLIENT_CODE,
            clnt.CLIENT_FIRST_NAME,
            clnt.CLIENT_LAST_NAME,
            cntry.COUNTRY_NAME,
            count(*) as rentals
        from MOVIE_RENTAL mov_rental
            join CLIENT clnt on clnt.CLIENT_CODE = mov_rental.CLIENT_CODE
            join CITY cty on cty.CITY_CODE = clnt.CLIENT_CITY_CODE
            join COUNTRY cntry on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
        group by mov_rental.CLIENT_CODE, clnt.CLIENT_FIRST_NAME, clnt.CLIENT_LAST_NAME, cntry.COUNTRY_NAME
    )
    group by COUNTRY_NAME) t1,
    (select mov_rental.CLIENT_CODE,
        clnt.CLIENT_FIRST_NAME,
        clnt.CLIENT_LAST_NAME,
        cntry.COUNTRY_NAME,
        count(*) as rentals
    from MOVIE_RENTAL mov_rental
        join CLIENT clnt on clnt.CLIENT_CODE = mov_rental.CLIENT_CODE
        join CITY cty on cty.CITY_CODE = clnt.CLIENT_CITY_CODE
        join COUNTRY cntry on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
    group by mov_rental.CLIENT_CODE, clnt.CLIENT_FIRST_NAME, clnt.CLIENT_LAST_NAME, cntry.COUNTRY_NAME) t2
where t2.rentals = t1.max_rentals
    and t2.COUNTRY_NAME = t1.country
order by t1.country;

-- Query #14
select distinct totals_table.COUNTRY_NAME, totals_table.CITY_NAME, CATEGORY_NAME, totals_table.times_ren
from (
         select table_1.CITY_NAME, table_1.COUNTRY_NAME, max(table_1.times) as times_ren
    from (
                  select cty.CITY_NAME, COUNTRY.COUNTRY_NAME, cate.CATEGORY_NAME as category, count(*) as times
        from COUNTRY
            join CITY cty on COUNTRY.COUNTRY_CODE = cty.FK_COUNTRY_CODE
            join CLIENT cli on cty.CITY_CODE = cli.CLIENT_CITY_CODE
            join MOVIE_RENTAL rent on cli.CLIENT_CODE = rent.CLIENT_CODE
            join RENTAL_DETAIL rent_det on rent.RENTAL_CODE = rent_det.RENTAL_CODE
            join MOVIE mov on rent_det.MOVIE_CODE = mov.MOVIE_CODE
            join MOVIE_CATEGORY mov_cat on mov.MOVIE_CODE = mov_cat.MOVIE_CODE
            join CATEGORY cate on mov_cat.CATEGORY_CODE = cate.CATEGORY_CODE
        group by cty.CITY_NAME, COUNTRY.COUNTRY_NAME, cate.CATEGORY_NAME
              ) table_1
    group by table_1.CITY_NAME, table_1.COUNTRY_NAME
    order by table_1.CITY_NAME, table_1.COUNTRY_NAME desc
     ) totals_table

    join (
    select cty.CITY_NAME city, cntry2.COUNTRY_NAME country_, cate.CATEGORY_NAME, count(*) times_rented
    from COUNTRY cntry2
        join CITY cty on cntry2.COUNTRY_CODE = cty.FK_COUNTRY_CODE
        join CLIENT cli on cty.CITY_CODE = cli.CLIENT_CITY_CODE
        join MOVIE_RENTAL rent on cli.CLIENT_CODE = rent.CLIENT_CODE
        join RENTAL_DETAIL rent_det on rent.RENTAL_CODE = rent_det.RENTAL_CODE
        join MOVIE mov on rent_det.MOVIE_CODE = mov.MOVIE_CODE
        join MOVIE_CATEGORY mov_cat on mov.MOVIE_CODE = mov_cat.MOVIE_CODE
        join CATEGORY cate on mov_cat.CATEGORY_CODE = cate.CATEGORY_CODE
    group by cty.CITY_NAME, cntry2.COUNTRY_NAME, cate.CATEGORY_NAME
) totals_table2
    on totals_table.COUNTRY_NAME = totals_table2.country_
        and totals_table.CITY_NAME = totals_table2.city
        and totals_table.times_ren = totals_table2.times_rented
where CATEGORY_NAME = 'Horror'
    and totals_table2.CATEGORY_NAME = 'Horror'
order by totals_table.COUNTRY_NAME;


-- Query #15
select table_1.COUNTRY_NAME,
        table_1.CITY_NAME,
        table_1.rentals_num,
        table_2.total_cities,
        round((table_1.rentals_num / table_2.total_cities), 3) avg_rent_rate
from (
         select cntry.COUNTRY_NAME, cty.CITY_NAME, count(*) rentals_num
        from COUNTRY cntry
                join CITY cty on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
                join CLIENT cli on cty.CITY_CODE = cli.CLIENT_CITY_CODE
                join MOVIE_RENTAL MR on cli.CLIENT_CODE = MR.CLIENT_CODE
        group by cntry.COUNTRY_NAME, cty.CITY_NAME
) table_1
        join (
    select COUNTRY_NAME, count(*) total_cities
        from COUNTRY cntry
                join CITY cty on cntry.COUNTRY_CODE = cty.FK_COUNTRY_CODE
        group by COUNTRY_NAME
) table_2 on table_1.COUNTRY_NAME = table_2.COUNTRY_NAME
group by table_1.COUNTRY_NAME, table_1.CITY_NAME, table_1.rentals_num, table_2.total_cities
order by table_1.COUNTRY_NAME;

-- Query #16
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


-- Query #17
SELECT CITY.CITY_NAME, count(*) as city_count
FROM CITY
        join COUNTRY CN on CN.COUNTRY_CODE = CITY.FK_COUNTRY_CODE
        join CLIENT CL on CL.CLIENT_CITY_CODE = CITY.CITY_CODE
        join MOVIE_RENTAL MR on CL.CLIENT_CODE = MR.CLIENT_CODE
where COUNTRY_NAME = 'United States'
HAVING count(*) > (
    SELECT count(*) as city_count
    FROM CITY
        join COUNTRY C2 on C2.COUNTRY_CODE = CITY.FK_COUNTRY_CODE
        join CLIENT C3 on CITY.CITY_CODE = C3.CLIENT_CITY_CODE
        join MOVIE_RENTAL M on C3.CLIENT_CODE = M.CLIENT_CODE
where C2.COUNTRY_NAME = 'United States'
    and CITY_NAME = 'Dayton'
)
group by CITY.CITY_NAME;


-- Query #18



-- Query #19

(
    select cli.CLIENT_FIRST_NAME,
        cli.CLIENT_LAST_NAME,
        mov_rental.RENTAL_DATE,
        (SELECT extract(MONTH FROM mov_rental.RENTAL_DATE)
        FROM DUAL) as month_rent
from MOVIE_RENTAL mov_rental
        join CLIENT cli on cli.CLIENT_CODE = mov_rental.CLIENT_CODE
where mov_rental.CLIENT_CODE = (select rental.CLIENT_CODE
--, count(*) as rented_movies
from MOVIE_RENTAL rental
        join RENTAL_DETAIL RD on rental.RENTAL_CODE = RD.RENTAL_CODE
group by rental.CLIENT_CODE
order by count(*) desc
fetch first 1 rows only)
)
union
(
    select cli.CLIENT_FIRST_NAME,
        cli.CLIENT_LAST_NAME,
        mov_rental.RENTAL_DATE,
        (SELECT extract(MONTH FROM mov_rental.RENTAL_DATE)
        FROM DUAL) as month_rent
from MOVIE_RENTAL mov_rental
        join CLIENT cli on cli.CLIENT_CODE = mov_rental.CLIENT_CODE
where mov_rental.CLIENT_CODE = (select rental.CLIENT_CODE
from MOVIE_RENTAL rental
        join RENTAL_DETAIL RD on rental.RENTAL_CODE = RD.RENTAL_CODE
group by rental.CLIENT_CODE
order by count(*)
fetch first 1 rows only)
);


-- Query #20
select distinct cty.CITY_NAME, l.LANGUAGE_NAME, '100%' as total_percentage
from CITY cty
    join CLIENT cli on cty.CITY_CODE = cli.CLIENT_CITY_CODE
    join MOVIE_RENTAL mov_rental on cli.CLIENT_CODE = mov_rental.CLIENT_CODE
    join RENTAL_DETAIL RD on mov_rental.RENTAL_CODE = RD.RENTAL_CODE
    join MOVIE M on RD.MOVIE_CODE = M.MOVIE_CODE
    join MOVIE_LANGUAGE ML on M.MOVIE_CODE = ML.MOVIE_CODE
    join LANGUAGE L on L.LANGUAGE_CODE = ML.LANGUAGE_CODE
where (select extract(MONTH from mov_rental.RENTAL_DATE)
    from DUAL) = 7
    and (select extract(year from mov_rental.RENTAL_DATE)
    from DUAL) = 2005;




