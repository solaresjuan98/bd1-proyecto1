SELECT REGEXP_SUBSTR('Hello world !', '[^ ]+', 1, 1) as palabra_1
    , REGEXP_SUBSTR('Hello world !', '[^ ]+', 1, 2) as palabra_2
    , REGEXP_SUBSTR('Hello world !', '[^ ]+', 1, 3) as palabra_3

FROM DUAL;

SELECT REGEXP_SUBSTR('Hello world !', '[^ ]+', 1, 1) as palabra_1
FROM DUAL;

SELECT (SELECT REGEXP_SUBSTR(CLIENT_NAME, '[^ ]+', 1, 1)
    FROM DUAL) AS NOMBRE,
    (SELECT REGEXP_SUBSTR(CLIENT_NAME, '[^ ]+', 1, 2)
    FROM DUAL) AS APELLIDO
FROM CLIENT;


-- specific subrstring in a string
select INSTR('sonso', 'son') as subcadena
from dual;

