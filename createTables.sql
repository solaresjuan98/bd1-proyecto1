/*
    CREATING TABLES COUNTRY, CITY, AND ADDRESS
*/


CREATE TABLE COUNTRY
(
    country_code NUMBER GENERATED ALWAYS AS IDENTITY,
    country_name VARCHAR2(30) NOT NULL,
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
