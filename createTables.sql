/*
    CREATING TABLES COUNTRY, CITY, AND ADDRESS
*/

CREATE TABLE COUNTRY
(
    country_code NUMBER GENERATED ALWAYS AS IDENTITY,
    country_name VARCHAR2(150) NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (country_code)
);

CREATE TABLE CITY
(
    city_code       NUMBER GENERATED ALWAYS AS IDENTITY,
    city_name       VARCHAR2(30) NOT NULL,
    fk_country_code NUMBER       NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (city_code),
    CONSTRAINT fk_country
        FOREIGN KEY (fk_country_code) REFERENCES COUNTRY (country_code)
);

CREATE TABLE ADDRESS
(
    address_code NUMBER GENERATED ALWAYS AS IDENTITY,
    address_name VARCHAR2(50) NOT NULL,
    fk_city_code NUMBER       NOT NULL,
    CONSTRAINT address_pk PRIMARY KEY (address_code),
    CONSTRAINT fk_city
        FOREIGN KEY (fk_city_code) REFERENCES CITY (city_code)

);

CREATE TABLE STORE
(
    store_code      NUMBER GENERATED ALWAYS AS IDENTITY,
    store_name      VARCHAR2(150) NOT NULL,
    fk_address_code NUMBER        NOT NULL,
    CONSTRAINT store_pk PRIMARY KEY (store_code),
    CONSTRAINT fk_address
        FOREIGN KEY (fk_address_code) REFERENCES ADDRESS (address_code)
);


CREATE TABLE CLIENT
(
    client_code         NUMBER GENERATED ALWAYS AS IDENTITY,
    client_first_name   VARCHAR2(50) NOT NULL,
    client_last_name    VARCHAR2(50) NOT NULL,
    client_zip_code     NUMBER       NOT NULL,
    client_email        VARCHAR2(50),
    register_date       DATE,
    client_state        VARCHAR2(30),
    address_code        NUMBER       NOT NULL,
    favorite_store_code NUMBER       NOT NULL,
    CONSTRAINT client_pk PRIMARY KEY (client_code),
    CONSTRAINT fk_address_code
        FOREIGN KEY (address_code) REFERENCES ADDRESS (address_code),
    CONSTRAINT fk_favorite_store_code
        FOREIGN KEY (favorite_store_code) REFERENCES STORE (store_code)
);


-- ---------------------------------
CREATE TABLE CLASSIFICATION
(
    classification_code NUMBER GENERATED ALWAYS AS IDENTITY,
    classification_name VARCHAR2(30),
    CONSTRAINT classification_code_pk PRIMARY KEY (classification_code)
);

CREATE TABLE CATEGORY
(
    category_code NUMBER GENERATED ALWAYS AS IDENTITY,
    category_name VARCHAR2(30) NOT NULL,
    CONSTRAINT category_code_pk PRIMARY KEY (category_code)
);

CREATE TABLE LANGUAGE
(
    language_code NUMBER GENERATED ALWAYS AS IDENTITY,
    language_name VARCHAR2(30) NOT NULL,
    CONSTRAINT language_code_pk PRIMARY KEY (language_code)
);


CREATE TABLE ACTOR
(
    actor_code       NUMBER GENERATED ALWAYS AS IDENTITY,
    actor_first_name VARCHAR2(50) NOT NULL,
    actor_last_name  VARCHAR2(50) NOT NULL,
    CONSTRAINT actor_code PRIMARY KEY (actor_code)
);

CREATE TABLE MOVIE
(
    movie_code          NUMBER GENERATED ALWAYS AS IDENTITY,
    movie_title         VARCHAR2(30),
    movie_description   VARCHAR2(250),
    movie_duration      NUMBER NOT NULL,
    release_year        NUMBER NOT NULL,
    rent_time           NUMBER NOT NULL,
    rent_cost           NUMBER NOT NULL,
    penalty_cost        NUMBER,
    classification_code NUMBER NOT NULL,
    category_code       NUMBER NOT NULL,
    language_code       NUMBER NOT NULL,
    CONSTRAINT movie_code_pk PRIMARY KEY (movie_code),
    CONSTRAINT fk_classification
        FOREIGN KEY (classification_code) REFERENCES CLASSIFICATION (classification_code),
    CONSTRAINT fk_category
        FOREIGN KEY (category_code) REFERENCES CATEGORY (category_code),
    CONSTRAINT fk_language
        FOREIGN KEY (language_code) REFERENCES LANGUAGE (language_code)
);

ALTER TABLE MOVIE
    MODIFY movie_description varchar2(250);

CREATE TABLE MOVIE_DETAIL
(
    movie_code NUMBER NOT NULL,
    actor_code NUMBER NOT NULL,
    CONSTRAINT fk_movie
        FOREIGN KEY (movie_code) REFERENCES MOVIE (movie_code),
    CONSTRAINT fk_actor
        FOREIGN KEY (actor_code) REFERENCES ACTOR (actor_code)
);

CREATE TABLE STORE_INVENTORY
(
    movie_code          NUMBER NOT NULL,
    store_code          NUMBER NOT NULL,
    available_inventory NUMBER NOT NULL,
    CONSTRAINT fk_movie_inv
        FOREIGN KEY (movie_code) REFERENCES MOVIE (movie_code),
    CONSTRAINT fk_store_inv
        FOREIGN KEY (store_code) REFERENCES STORE (store_code)
);

-- ---------------------------

CREATE TABLE EMPLOYEE
(
    employee_code       NUMBER GENERATED ALWAYS AS IDENTITY,
    employee_first_name VARCHAR2(50) NOT NULL,
    employee_last_name  VARCHAR2(50) NOT NULL,
    employee_address    VARCHAR2(50) NOT NULL,
    employee_email      VARCHAR2(50) NOT NULL,
    employee_state      VARCHAR2(50) NOT NULL,
    employee_username   VARCHAR2(50) NOT NULL,
    employee_password   VARCHAR2(50) NOT NULL,
    store_code          NUMBER       NOT NULL,
    CONSTRAINT employee_code_pk PRIMARY KEY (employee_code),
    CONSTRAINT fk_store_code
        FOREIGN KEY (store_code) REFERENCES STORE (store_code)
);

--- RENT BILL
CREATE TABLE RENTAL_BILL
(
    rental_code   NUMBER GENERATED ALWAYS AS IDENTITY,
    rental_date   DATE   NOT NULL,
    pay_date      DATE   NOT NULL,
    client_code   NUMBER NOT NULL,
    employee_code NUMBER NOT NULL,
    CONSTRAINT rental_bill_code_pk PRIMARY KEY (rental_code),
    CONSTRAINT fk_bill_client_code
        FOREIGN KEY (client_code) REFERENCES CLIENT (client_code),
    CONSTRAINT fk_bill_employee_code
        FOREIGN KEY (employee_code) REFERENCES EMPLOYEE (employee_code)
);

-- MASTER - DETAIL BILL
CREATE TABLE DETAIL_BILL
(
    rental_code NUMBER NOT NULL,
    movie_code  NUMBER NOT NULL,
    return_date DATE,
    rent_cost   NUMBER NOT NULL,
    CONSTRAINT rental_code_fk
        FOREIGN KEY (rental_code) REFERENCES RENTAL_BILL (rental_code),
    CONSTRAINT movie_code_fk
        FOREIGN KEY (movie_code) REFERENCES MOVIE (movie_code)
);



