-- 14.Mostrar todas las ciudades por país en las que predomina la renta de
-- películas de la categoría “Horror”. Es decir, hay más rentas que las otras
-- categorías.


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


-- TEST QUERY
select cntry2.COUNTRY_NAME country_, cty.CITY_NAME city, cate.CATEGORY_NAME, count(*) times_rented
from COUNTRY cntry2
        join CITY cty on cntry2.COUNTRY_CODE = cty.FK_COUNTRY_CODE
        join CLIENT cli on cty.CITY_CODE = cli.CLIENT_CITY_CODE
        join MOVIE_RENTAL rent on cli.CLIENT_CODE = rent.CLIENT_CODE
        join RENTAL_DETAIL rent_det on rent.RENTAL_CODE = rent_det.RENTAL_CODE
        join MOVIE mov on rent_det.MOVIE_CODE = mov.MOVIE_CODE
        join MOVIE_CATEGORY mov_cat on mov.MOVIE_CODE = mov_cat.MOVIE_CODE
        join CATEGORY cate on mov_cat.CATEGORY_CODE = cate.CATEGORY_CODE
where COUNTRY_NAME = 'Romania'
    and CITY_NAME = 'Bucuresti'
group by cty.CITY_NAME, cntry2.COUNTRY_NAME, cate.CATEGORY_NAME
order by times_rented;