-- Inserting into countries table
INSERT INTO COUNTRY
    (COUNTRY_NAME)
    (select distinct COUNTRY_CLIENT
    from TEMPORAL_TABLE
    WHERE COUNTRY_CLIENT NOT IN ('-'))
UNION
    (
    select distinct STORE_COUNTRY
    from TEMPORAL_TABLE
    WHERE STORE_COUNTRY NOT IN ('-')
)
UNION
    (select distinct EMPLOYEE_COUNTRY
    from TEMPORAL_TABLE
    WHERE EMPLOYEE_COUNTRY NOT IN ('-'));


-- Insert into table CITY (from city_client)
INSERT INTO CITY
    (CITY_NAME, FK_COUNTRY_CODE)
    (SELECT distinct CITY_CLIENT, COUNTRY.COUNTRY_CODE
    FROM TEMPORAL_TABLE,
        COUNTRY
    where COUNTRY_CLIENT = COUNTRY.COUNTRY_NAME)
union
    (
    SELECT distinct STORE_CITY, COUNTRY_CODE
    FROM TEMPORAL_TABLE,
        COUNTRY
    WHERE STORE_COUNTRY = COUNTRY.COUNTRY_NAME
)
union
    (
    SELECT distinct EMPLOYEE_CITY, COUNTRY_CODE
    FROM TEMPORAL_TABLE,
        COUNTRY
    WHERE EMPLOYEE_COUNTRY = COUNTRY.COUNTRY_NAME
);

-- INSERT INTO CITY TABLE - FIXED
SELECT DISTINCT CITY_CLIENT, COUNTRY.COUNTRY_NAME
FROM TEMPORAL_TABLE,
    COUNTRY
WHERE TEMPORAL_TABLE.COUNTRY_CLIENT = COUNTRY.COUNTRY_NAME;

select CITY_NAME, COUNTRY_NAME
from CITY
    join COUNTRY C2 on C2.COUNTRY_CODE = CITY.FK_COUNTRY_CODE
where COUNTRY_NAME = 'United States';

/*
-- INSERT INTO ADDRESS TABLE
-- INSERT INTO ADDRESS (ADDRESS_NAME, FK_CITY_CODE)
SELECT distinct *
from ((
          SELECT distinct temporal.CLIENT_ADDRESS, ct.CITY_CODE
          FROM TEMPORAL_TABLE temporal
                   join COUNTRY cn on temporal.COUNTRY_CLIENT = cn.COUNTRY_NAME
                   join CITY ct ON temporal.CITY_CLIENT = ct.CITY_NAME
          where temporal.CLIENT_ADDRESS not in '-')
      UNION
      (
          SELECT distinct temporal.EMPLOYEE_ADDRESS, ct.CITY_CODE
          FROM TEMPORAL_TABLE temporal
                   join COUNTRY cn on temporal.EMPLOYEE_COUNTRY = cn.COUNTRY_NAME
                   join CITY ct ON temporal.EMPLOYEE_CITY = ct.CITY_NAME
          where temporal.EMPLOYEE_ADDRESS not in '-'
      )
      UNION
      (
          SELECT distinct temporal.STORE_ADDRESS, ct.CITY_CODE
          FROM TEMPORAL_TABLE temporal
                   join COUNTRY cn on temporal.STORE_COUNTRY = cn.COUNTRY_NAME
                   join CITY ct ON temporal.STORE_CITY = ct.CITY_NAME
          where temporal.STORE_ADDRESS not in '-'
      ));
*/

-- INSERT INTO STORE TABLE
SELECT *
FROM STORE;
INSERT INTO STORE
    (STORE.STORE_NAME, STORE.STORE_ADDRESS, STORE.CITY_CODE)
SELECT DISTINCT STORE_NAME, STORE_ADDRESS, ct.CITY_CODE
FROM TEMPORAL_TABLE temporal
    JOIN CITY ct on temporal.STORE_CITY = ct.CITY_NAME
WHERE NOT temporal.STORE_NAME IN ('-');


-- INSERT INTO CLIENT TABLE
INSERT INTO CLIENT
    (CLIENT_FIRST_NAME, CLIENT_LAST_NAME, CLIENT_ZIP_CODE, CLIENT_EMAIL, REGISTER_DATE, CLIENT_STATE,
    CLIENT_ADDRESS, CLIENT_CITY_CODE, FAVORITE_STORE_CODE)
SELECT distinct (SELECT REGEXP_SUBSTR(CLIENT_NAME, '[^ ]+', 1, 1)
    FROM DUAL) as client_first_name,
    (SELECT REGEXP_SUBSTR(CLIENT_NAME, '[^ ]+', 1, 2)
    FROM DUAL) as client_last_name,
    temporal.ZIP_CODE_CLIENT,
    temporal.CLIENT_EMAIL,
    TO_DATE(temporal.CREATION_DATE, 'DD/MM/YYYY HH24:MI'),
    temporal.CLIENT_IS_ACTIVE,
    temporal.CLIENT_ADDRESS,
    ct.CITY_CODE,
    st.STORE_CODE
FROM TEMPORAL_TABLE temporal
    JOIN CITY ct ON temporal.CITY_CLIENT = ct.CITY_NAME
    join STORE st ON temporal.FAVORITE_STORE = st.STORE_NAME
    join COUNTRY cn on cn.COUNTRY_NAME = temporal.COUNTRY_CLIENT
        and ct.FK_COUNTRY_CODE = cn.COUNTRY_CODE;


-- INSERTING INTO CLASSIFICATION TABLE
INSERT INTO CLASSIFICATION
    (CLASSIFICATION_NAME)
SELECT DISTINCT CLASSIFICATION
FROM TEMPORAL_TABLE
WHERE CLASSIFICATION
NOT IN '-';

-- INSERTING INTO CATEGORY TABLE
INSERT INTO CATEGORY
    (CATEGORY_NAME)
SELECT DISTINCT MOVIE_CATEGORY
FROM TEMPORAL_TABLE
WHERE CLASSIFICATION
NOT IN '-';

-- INSERTING INTO LANGUAGE TABLE
INSERT INTO LANGUAGE
    (LANGUAGE_NAME)
SELECT DISTINCT MOVIE_LANGUAGE
FROM TEMPORAL_TABLE
WHERE TEMPORAL_TABLE.MOVIE_LANGUAGE
NOT IN '-';

-- INSERTING INTO MOVIES TABLE
INSERT INTO MOVIE
    (MOVIE_TITLE, MOVIE_DESCRIPTION, MOVIE_DURATION, RELEASE_YEAR, RENT_TIME, RENT_COST, PENALTY_COST)
SELECT DISTINCT MOVIE_NAME,
    MOVIE_DESCRIPTION,
    MOVIE_DURATION,
    RELEASE_YEAR,
    RENT_DAYS,
    RENT_COST,
    COST_PER_DAMAGE
FROM TEMPORAL_TABLE,
    CLASSIFICATION,
    CATEGORY,
    LANGUAGE
WHERE TEMPORAL_TABLE.CLASSIFICATION = CLASSIFICATION.CLASSIFICATION_NAME
    AND TEMPORAL_TABLE.MOVIE_CATEGORY = CATEGORY.CATEGORY_NAME
    AND TEMPORAL_TABLE.MOVIE_LANGUAGE = LANGUAGE.LANGUAGE_NAME
    AND TEMPORAL_TABLE.MOVIE_NAME
NOT IN '-';


-- INSERTING INTO ACTOR TABLES
INSERT INTO ACTOR
    (ACTOR_FIRST_NAME, ACTOR_LAST_NAME)
SELECT DISTINCT (SELECT REGEXP_SUBSTR(MOVIE_ACTOR, '[^ ]+', 1, 1)
    FROM DUAL) as actor_first_name,
    (SELECT REGEXP_SUBSTR(MOVIE_ACTOR, '[^ ]+', 1, 2)
    FROM DUAL) as actor_last_name
FROM TEMPORAL_TABLE
WHERE MOVIE_ACTOR
NOT IN '-';

select *
from ACTOR;


-- INSERTING INTO MOVIE_DETAIL
INSERT INTO MOVIE_ACTOR
    (MOVIE_CODE, ACTOR_CODE)
SELECT distinct MOVIE.MOVIE_CODE, ACTOR.ACTOR_CODE
FROM TEMPORAL_TABLE,
    ACTOR,
    MOVIE
WHERE TEMPORAL_TABLE.MOVIE_ACTOR = ACTOR.ACTOR_FIRST_NAME || ' ' || ACTOR.ACTOR_LAST_NAME
    AND TEMPORAL_TABLE.MOVIE_NAME = MOVIE.MOVIE_TITLE;

-- INSERTING INTO MOVIE_LANGUAGE
INSERT INTO MOVIE_LANGUAGE
    (MOVIE_CODE, LANGUAGE_CODE)
SELECT distinct MOVIE.MOVIE_CODE, LANGUAGE.LANGUAGE_CODE
FROM TEMPORAL_TABLE,
    LANGUAGE,
    MOVIE
WHERE TEMPORAL_TABLE.MOVIE_LANGUAGE = LANGUAGE.LANGUAGE_NAME
    AND TEMPORAL_TABLE.MOVIE_NAME = MOVIE.MOVIE_TITLE;
commit;

-- INSERT INTO MOVIE_INVENTORY TABLE
INSERT INTO MOVIE_INVENTORY
    (MOVIE_CODE, STORE_CODE, QUANTITY)
select distinct MOVIE.MOVIE_CODE, STORE.STORE_CODE, count(*)
FROM TEMPORAL_TABLE,
    MOVIE,
    STORE
WHERE TEMPORAL_TABLE.MOVIE_NAME = MOVIE.MOVIE_TITLE
    AND TEMPORAL_TABLE.MOVIE_STORE = STORE.STORE_NAME
group by MOVIE.MOVIE_CODE, STORE.STORE_CODE;

-- INSERTING INTO EMPLOYEES
INSERT INTO EMPLOYEE
    (EMPLOYEE_FIRST_NAME, EMPLOYEE_LAST_NAME, EMPLOYEE_ADDRESS, EMPLOYEE_EMAIL, EMPLOYEE_USERNAME,
    EMPLOYEE_PASSWORD,
    EMPLOYEE_STATE, STORE_CODE)
SELECT DISTINCT (SELECT REGEXP_SUBSTR(EMPLOYEE_NAME, '[^ ]+', 1, 1)
    FROM DUAL) as first_name,
    (SELECT REGEXP_SUBSTR(EMPLOYEE_NAME, '[^ ]+', 1, 2)
    FROM DUAL) as last_name,
    EMPLOYEE_ADDRESS,
    EMPLOYEE_EMAIL,
    EMPLOYEE_USERNAME,
    EMPLOYEE_PASSWORD,
    EMPLOYEE_IS_ACTIVE,
    STORE.STORE_CODE
FROM TEMPORAL_TABLE,
    STORE
where TEMPORAL_TABLE.EMPLOYEE_STORE = STORE.STORE_NAME
    AND EMPLOYEE_NAME
not in '-';


-- INSERT INTO MOVIE_RENTAL TABLE
INSERT INTO MOVIE_RENTAL
    (RENTAL_DATE, PAY_DATE, CLIENT_CODE, EMPLOYEE_CODE, MOUNT_TO_PAY)
select distinct TO_DATE(temporal.SALE_DATE, 'DD/MM/YYYY HH24:MI') AS RENTAL_DATE,
    TO_DATE(temporal.PAY_DATE, 'DD/MM/YYYY HH24:MI')  AS PAY_DATE,
    c.CLIENT_CODE,
    e.EMPLOYEE_CODE,
    temporal.MOUNT_TO_PAY
from TEMPORAL_TABLE temporal
    join CLIENT c ON temporal.CLIENT_NAME = c.CLIENT_FIRST_NAME || ' ' || c.CLIENT_LAST_NAME
    join EMPLOYEE e ON temporal.EMPLOYEE_NAME = e.EMPLOYEE_FIRST_NAME || ' ' || e.EMPLOYEE_LAST_NAME;


-- INSERT INTO TABLE RENTAL_DETAIL
INSERT INTO RENTAL_DETAIL
    (RENTAL_CODE, MOVIE_CODE, RETURN_DATE, RENT_COST, RENT_DURATION)
SELECT DISTINCT mr.RENTAL_CODE,
    m.MOVIE_CODE,
    TO_DATE(temporal.RETURN_DATE, 'DD/MM/YYYY HH24:MI') as return_date,
    temporal.RENT_COST,
    temporal.RENT_DAYS
FROM TEMPORAL_TABLE temporal
    join MOVIE_RENTAL MR on temporal.SALE_DATE = to_char(mr.RENTAL_DATE, 'DD/MM/YYYY HH24:MI')
    join MOVIE_RENTAL MR2 on temporal.SALE_DATE = to_char(mr2.PAY_DATE, 'DD/MM/YYYY HH24:MI')
    join MOVIE m on temporal.MOVIE_NAME = m.MOVIE_TITLE
where temporal.SALE_DATE
not in '-'
  and temporal.PAY_DATE not in '-'
  and temporal.RETURN_DATE not in '-';


-- INSERT INTO CATEGORY_DETAIL
INSERT INTO MOVIE_CATEGORY
    (MOVIE_CODE, CATEGORY_CODE)
SELECT distinct MOVIE_CODE, CATEGORY_CODE
FROM TEMPORAL_TABLE,
    MOVIE,
    CATEGORY
WHERE TEMPORAL_TABLE.MOVIE_NAME = MOVIE.MOVIE_TITLE
    AND TEMPORAL_TABLE.MOVIE_CATEGORY = CATEGORY.CATEGORY_NAME;

SELECT DISTINCT STORE_MANAGER, STORE.STORE_CODE
FROM TEMPORAL_TABLE,
    STORE
WHERE TEMPORAL_TABLE.STORE_MANAGER
NOT IN '-';

