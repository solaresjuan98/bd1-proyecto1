

create view Example_view as
SELECT distinct CNTRY.COUNTRY_NAME,
                c2.CLIENT_FIRST_NAME,
                c2.CLIENT_LAST_NAME,
                count(*)                                           rented_movies,
                sum(count(*)) over ( )                             total_cnt,
                round(100 * (count(*) / sum(count(*)) over ()), 2) percentage
FROM MOVIE_RENTAL
        JOIN CLIENT C2 on C2.CLIENT_CODE = MOVIE_RENTAL.CLIENT_CODE
        JOIN CITY CTY on CTY.CITY_CODE = c2.CLIENT_CITY_CODE
        JOIN COUNTRY CNTRY on CNTRY.COUNTRY_CODE = CTY.FK_COUNTRY_CODE
GROUP BY CNTRY.COUNTRY_NAME,
        c2.CLIENT_FIRST_NAME,
        c2.CLIENT_LAST_NAME;



create view max_and_min_rentals as
(
    select rental.CLIENT_CODE, count(*) as rented_movies
    from MOVIE_RENTAL rental
            join RENTAL_DETAIL RD on rental.RENTAL_CODE = RD.RENTAL_CODE
    group by rental.CLIENT_CODE
    order by count(*) desc
        fetch first 5 rows only
)
union
(
    select rental.CLIENT_CODE, count(*) as rented_movies
    from MOVIE_RENTAL rental
            join RENTAL_DETAIL RD on rental.RENTAL_CODE = RD.RENTAL_CODE
    group by rental.CLIENT_CODE
    order by count(*)
        fetch first 5 rows only
);

