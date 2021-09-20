-- 18.Mostrar el nombre, apellido y fecha de retorno de película a la tienda de todos
-- los clientes que hayan rentado más de 2 películas que se encuentren en
-- lenguaje Inglés en donde el empleado que se las vendió ganará más de 15
-- dólares en sus rentas del día en la que el cliente rentó la película.

select distinct mega_table.CLIENT_FIRST_NAME, mega_table.CLIENT_LAST_NAME, to_char(RETURN_DATE, 'dd-mm-yyyy')
from (
         select distinct table_1.CLIENT_FIRST_NAME, table_1.CLIENT_LAST_NAME, table_1.r_date1
         from (
                  select cli.CLIENT_FIRST_NAME,
                         cli.CLIENT_LAST_NAME,
                         to_char(mov_rental.RENTAL_DATE, 'dd-mm-yyyy') r_date1,
                         count(*) as                                   times_rented
                  from CLIENT cli
                           join MOVIE_RENTAL mov_rental on cli.CLIENT_CODE = mov_rental.CLIENT_CODE
                           join RENTAL_DETAIL rent_detail on mov_rental.RENTAL_CODE = rent_detail.RENTAL_CODE
                           join MOVIE mov on mov.MOVIE_CODE = rent_detail.MOVIE_CODE
                  group by cli.CLIENT_FIRST_NAME, cli.CLIENT_LAST_NAME, mov_rental.RENTAL_DATE
                  having count(*) > 2
                  order by times_rented
              ) table_1
                  join (
             select distinct emp.EMPLOYEE_CODE,
                             to_char(mov_rental.RENTAL_DATE, 'dd-mm-yyyy') r_date,
                             sum(rental_det.RENT_COST) as                  total_earned
             from EMPLOYEE emp
                      join MOVIE_RENTAL mov_rental on emp.EMPLOYEE_CODE = mov_rental.EMPLOYEE_CODE
                      join RENTAL_DETAIL rental_det on mov_rental.RENTAL_CODE = rental_det.RENTAL_CODE
             having sum(rental_det.RENT_COST) > 15
             group by emp.EMPLOYEE_CODE, to_char(mov_rental.RENTAL_DATE, 'dd-mm-yyyy')
         ) table_2 on table_1.r_date1 = table_2.r_date
         group by table_1.CLIENT_FIRST_NAME, table_1.CLIENT_LAST_NAME, table_1.r_date1
     ) mega_table
         join MOVIE_RENTAL mov_rental on mega_table.r_date1 = to_char(mov_rental.RENTAL_DATE, 'dd-mm-yyyy')
         join RENTAL_DETAIL RD on mov_rental.RENTAL_CODE = RD.RENTAL_CODE;