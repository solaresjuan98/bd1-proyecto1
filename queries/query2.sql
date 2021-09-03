-- 2. Mostrar el nombre, apellido y pago total de todos los clientes que han rentado
-- películas por lo menos 40 veces
SELECT CLIENT_FIRST_NAME, CLIENT_LAST_NAME,count(*) as times_rented, sum(db.RENT_COST) as total
FROM CLIENT
    JOIN RENTAL_BILL RB on CLIENT.CLIENT_CODE = RB.CLIENT_CODE
    JOIN DETAIL_BILL DB on RB.RENTAL_CODE = DB.RENTAL_CODE
having count(*) >= 40
group by CLIENT_FIRST_NAME, CLIENT_LAST_NAME;
