OPTIONS (SKIP=1)
LOAD DATA
INFILE 'BlockbusterData.csv' 
INTO TABLE temporal_table
fields terminated by ";"
optionally enclosed by '"'
(
    client_name,
    client_email,
    client_is_active,
    creation_date,
    favorite_store,
    client_address,
    zip_code_client,
    city_client,
    country_client,
    sale_date,
    return_date,
    mount_to_pay,
    pay_date,
    employee_name,
    employee_email,
    employee_is_active,
    employee_store,
    employee_username,
    employee_password,
    employee_address,
    employee_zip_code,
    employee_city,
    employee_country,
    store_name,
    store_manager,
    store_address,
    store_zip_code,
    store_city,
    store_country,
    movie_store,
    movie_name,
    movie_description,
    release_year,
    rent_days,
    rent_cost,
    movie_duration,
    cost_per_damage,
    classification,
    movie_language,
    movie_category,
    movie_actor
)