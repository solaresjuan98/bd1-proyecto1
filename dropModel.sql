-- -- Inserting into countries table
-- INSERT INTO COUNTRY
--     (COUNTRY_NAME)
--     (select distinct COUNTRY_CLIENT
--     from TEMPORAL_TABLE
--     WHERE COUNTRY_CLIENT NOT IN ('-'))
-- UNION
--     (
--     select distinct STORE_COUNTRY
--     from TEMPORAL_TABLE
--     WHERE STORE_COUNTRY NOT IN ('-')
-- )
-- UNION
--     (select distinct EMPLOYEE_COUNTRY
--     from TEMPORAL_TABLE
--     WHERE EMPLOYEE_COUNTRY NOT IN ('-'));


-- -- Insert into table CITY (from city_client)
-- INSERT INTO CITY
--     (CITY_NAME, FK_COUNTRY_CODE)
--     (SELECT distinct CITY_CLIENT, COUNTRY.COUNTRY_CODE
--     FROM TEMPORAL_TABLE,
--         COUNTRY
--     where COUNTRY_CLIENT = COUNTRY.COUNTRY_NAME)
-- union
--     (
--     SELECT distinct STORE_CITY, COUNTRY_CODE
--     FROM TEMPORAL_TABLE,
--         COUNTRY
--     WHERE STORE_COUNTRY = COUNTRY.COUNTRY_NAME
-- )
-- union
--     (
--     SELECT distinct EMPLOYEE_CITY, COUNTRY_CODE
--     FROM TEMPORAL_TABLE,
--         COUNTRY
--     WHERE EMPLOYEE_COUNTRY = COUNTRY.COUNTRY_NAME
-- );


-- INSERT INTO ADDRESS
--     (ADDRESS_NAME, FK_CITY_CODE)
--     (SELECT DISTINCT CLIENT_ADDRESS, CITY_CODE
--     FROM TEMPORAL_TABLE,
--         CITY
--     WHERE CITY_CLIENT = CITY.CITY_NAME
--         AND CLIENT_ADDRESS NOT IN '-'
--     )
-- UNION
--     (
--     SELECT DISTINCT STORE_ADDRESS, CITY_CODE
--     FROM TEMPORAL_TABLE,
--         CITY
--     WHERE STORE_CITY = CITY.CITY_NAME
--         AND STORE_ADDRESS NOT IN '-'
-- )
-- UNION
--     (
--     SELECT DISTINCT EMPLOYEE_ADDRESS, CITY_CODE
--     FROM TEMPORAL_TABLE,
--         CITY
--     WHERE EMPLOYEE_CITY = CITY.CITY_NAME
--         AND EMPLOYEE_ADDRESS NOT IN '-'
-- )


-- drop model
drop table DETAIL_BILL;
drop table RENTAL_BILL;
drop table CLIENT;
drop table EMPLOYEE;
drop table MOVIE_DETAIL;
drop table ACTOR;

select * from ALL_TABLES where OWNER = 'BASES1P1' order by TABLE_NAME;


-- DELETE
/*
    drop table DETAIL_BILL;
    drop table RENTAL_BILL;
    drop table EMPLOYEE;
    drop table STORE_INVENTORY;
    drop table MANAGER;
    drop table STORE;
    drop table ADDRESS;
 */

