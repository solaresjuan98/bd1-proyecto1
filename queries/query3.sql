--3. Mostrar el nombre y apellido del cliente y el nombre de la película de todos
-- aquellos clientes que hayan rentado una película y no la hayan devuelto y
-- donde la fecha de alquiler esté más allá de la especificada por la película.
SELECT PAY_DATE, RETURN_DATE
FROM RENTAL_BILL
         JOIN DETAIL_BILL DB on RENTAL_BILL.RENTAL_CODE = DB.RENTAL_CODE
WHERE PAY_DATE < DB.RETURN_DATE;
