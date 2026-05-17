------------Q1 Extract numeric characters at the beginning of mixed_value.

SELECT mixed_value,
REGEXP_SUBSTR(mixed_value, '^[0-9]+') AS result
FROM regex_practice;
----------Q2 Extract numeric characters at the end of mixed_value.

SELECT mixed_value,
REGEXP_SUBSTR(mixed_value, '[0-9]+$') AS result
FROM regex_practice;
------------Q3 Extract only the first single character from mixed_value.

SELECT mixed_value,
REGEXP_SUBSTR(mixed_value, '^.') AS result
FROM regex_practice;
---------Q4 Extract only the last single character from mixed_value.

SELECT mixed_value,
REGEXP_SUBSTR(mixed_value, '.$') AS result
FROM regex_practice;
-------------Q5 Extract exactly two consecutive digits from mixed_value.

SELECT mixed_value,
REGEXP_SUBSTR(mixed_value, '[0-9]{2}') AS result
FROM regex_practice;
---------Q6 Extract exactly one numeric character from mixed_value.

SELECT mixed_value,
REGEXP_SUBSTR(mixed_value, '[0-9]') AS result
FROM regex_practice;
------------Q7 Extract the country code from phone.

SELECT phone,
REGEXP_SUBSTR(phone, '[0-9]+') AS country_code
FROM regex_practice;
----------Q8 Extract numeric portion present between alphabets in mixed_value.

SELECT mixed_value,
REGEXP_SUBSTR(mixed_value, '[0-9]+') AS result
FROM regex_practice;
----------Q9 Extract text before @ from email.

SELECT email,
REGEXP_SUBSTR(email, '^[^@]+') AS username
FROM regex_practice;
-------Q10 Extract text after @ including domain.

SELECT email,
REGEXP_SUBSTR(email, '@(.+)$') AS result
FROM regex_practice;
-------Q11 Extract domain name without @.

SELECT email,
REGEXP_SUBSTR(email, '[^@]+$') AS domain_name
FROM regex_practice;
-------Q12 Extract text after the last dot in email.

SELECT email,
REGEXP_SUBSTR(email, '[^.]+$') AS extension
FROM regex_practice;
--------Q13 Extract only continuous alphabetic characters from mixed_value.

SELECT mixed_value,
REGEXP_SUBSTR(mixed_value, '[A-Za-z]+') AS result
FROM regex_practice;
-------Q14 Extract only continuous numeric characters from mixed_value.

SELECT mixed_value,
REGEXP_SUBSTR(mixed_value, '[0-9]+') AS result
FROM regex_practice;
-------Q15 Extract first three characters from full_text.

SELECT full_text,
REGEXP_SUBSTR(full_text, '^...') AS result
FROM regex_practice;
---------Q16 Extract last two characters from full_text.

SELECT full_text,
REGEXP_SUBSTR(full_text, '..$') AS result
FROM regex_practice;
-----Q17 Extract employee number between alphabetic prefix and first underscore.

SELECT full_text,
REGEXP_SUBSTR(full_text, '[0-9]+') AS emp_number
FROM regex_practice;
--------Q18 Extract country code at the end of full_text.

SELECT full_text,
REGEXP_SUBSTR(full_text, '[0-9]+$') AS country_code
FROM regex_practice;
-------Q19 Extract alphabetic text between two underscores.

SELECT full_text,
REGEXP_SUBSTR(full_text, '_[A-Za-z]+_') AS result
FROM regex_practice;

If you want only the text without underscores:

SELECT full_text,
TRIM('_' FROM REGEXP_SUBSTR(full_text, '_[A-Za-z]+_')) AS result
FROM regex_practice;
---------Q20 Extract numeric characters immediately after + in phone.

SELECT phone,
REGEXP_SUBSTR(phone, '(?<=\\+)[0-9]+') AS country_code
FROM regex_practice;

If lookbehind is not supported:

SELECT phone,
SUBSTRING(phone, 2, INSTR(phone, '-')-2) AS country_code
FROM regex_practice;
