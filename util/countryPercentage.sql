SELECT distinct CNTRY.COUNTRY_NAME,
    count(*)                                           grp_count,
    sum(count(*)) over ( )                             total_cnt,
    round(100 * (count(*) / sum(count(*)) over ()), 2) percentage
FROM RENTAL_BILL
    JOIN CLIENT C2 on C2.CLIENT_CODE = RENTAL_BILL.CLIENT_CODE
    JOIN ADDRESS A2 on A2.ADDRESS_CODE = C2.ADDRESS_CODE
    JOIN CITY CTY on CTY.CITY_CODE = A2.FK_CITY_CODE
    JOIN COUNTRY CNTRY on CNTRY.COUNTRY_CODE = CTY.FK_COUNTRY_CODE
GROUP BY COUNTRY_NAME
ORDER BY grp_count desc
FETCH FIRST 1 ROWS ONLY;