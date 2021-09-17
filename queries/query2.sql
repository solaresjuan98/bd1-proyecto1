-- 2. Mostrar el nombre, apellido y pago total de todos los clientes que han rentado
-- películas por lo menos 40 veces
select distinct cli.CLIENT_FIRST_NAME, cli.CLIENT_LAST_NAME, sum(MOUNT_TO_PAY)
from MOVIE_RENTAL mov_rental
        join CLIENT cli on cli.CLIENT_CODE = mov_rental.CLIENT_CODE
having count(*) >= 40
group by cli.CLIENT_FIRST_NAME, cli.CLIENT_LAST_NAME;



--
