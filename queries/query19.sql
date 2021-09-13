/*
    19. Mostrar el número de mes, de la fecha de renta de la película, nombre y
        apellido de los clientes que más películas han rentado y las que menos en
        una sola consulta.
*/


SELECT DISTINCT extract(month from (rental.RENTAL_DATE)) month_number,
                C2.CLIENT_FIRST_NAME,
                C2.CLIENT_LAST_NAME,
                M.MOVIE_TITLE
                --count(C2.CLIENT_CODE)
FROM MOVIE_RENTAL rental
        JOIN CLIENT C2 on C2.CLIENT_CODE = rental.CLIENT_CODE
        JOIN RENTAL_DETAIL RD on rental.RENTAL_CODE = RD.RENTAL_CODE
        JOIN MOVIE M on RD.MOVIE_CODE = M.MOVIE_CODE
where rental.CLIENT_CODE in (select CLIENT_CODE from max_and_min_rentals)
GROUP BY rental.CLIENT_CODE,
        C2.CLIENT_FIRST_NAME,
        C2.CLIENT_LAST_NAME,
        rental.RENTAL_DATE,
        M.MOVIE_TITLE;

