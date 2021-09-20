-- creating temp table
CREATE TABLE temporal_table
(
    client_name        varchar2(200),
    client_email       varchar2(200),
    client_is_active   varchar2(200),
    creation_date      varchar2(200),
    favorite_store     varchar2(200),
    client_address     varchar2(200),
    zip_code_client    varchar2(200),
    city_client        varchar2(200),
    country_client     varchar2(200),
    sale_date          varchar2(200),
    return_date        varchar2(200),
    mount_to_pay       varchar2(200),
    pay_date           varchar2(200),
    employee_name      varchar2(200),
    employee_email     varchar2(200),
    employee_is_active varchar2(200),
    employee_store     varchar2(200),
    employee_username  varchar2(200),
    employee_password  varchar2(200),
    employee_address   varchar2(200),
    employee_zip_code  varchar2(200),
    employee_city      varchar2(200),
    employee_country   varchar2(200),
    store_name         varchar2(200),
    store_manager      varchar2(200),
    store_address      varchar2(200),
    store_zip_code     varchar2(200),
    store_city         varchar2(200),
    store_country      varchar2(200),
    movie_store        varchar2(200),
    movie_name         varchar2(200),
    movie_description  varchar2(200),
    release_year       varchar2(200),
    rent_days          varchar2(200),
    rent_cost          varchar2(200),
    movie_duration     varchar2(200),
    cost_per_damage    varchar2(200),
    classification     varchar2(200),
    movie_language     varchar2(200),
    movie_category     varchar2(200),
    movie_actor        varchar2(200)
);


-- Deleting temporal table
drop table temporal_table;
