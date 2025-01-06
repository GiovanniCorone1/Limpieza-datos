-- Formatos de fecha
-- Probamos
SELECT star_date ,
CASE 
	WHEN star_date LIKE '%/%' THEN date_format(str_to_date(star_date,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN star_date LIKE '%-%' THEN date_format(str_to_date(star_date,'%m-%d-%Y'),'%Y-%m-%d')
	ELSE null
END AS "new birth date"
FROM limpieza;
-- Actualizamos
UPDATE limpieza 
SET star_date= CASE 
	WHEN star_date LIKE '%/%' THEN date_format(str_to_date(star_date,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN star_date LIKE '%-%' THEN date_format(str_to_date(star_date,'%m-%d-%Y'),'%Y-%m-%d')
	ELSE null
END ;
-- Cambiamos el tipo de dato 
ALTER TABLE limpieza MODIFY star_date DATE;

-- Para el atributo birth_date
-- Probamos
SELECT birth_date ,
CASE 
	WHEN birth_date LIKE '%/%' THEN date_format(str_to_date(birth_date,"%m/%d/%Y"),"%Y-%m-%d")
    WHEN birth_date LIKE '%-%' THEN date_format(str_to_date(birth_date,"%m-%d-%Y"),"%Y-%m-%d")
    ELSE null
END AS "new birth date"
FROM limpieza;
-- Actualizamos
UPDATE limpieza SET birth_date=
CASE 
	WHEN birth_date LIKE '%/%' THEN date_format(str_to_date(birth_date,"%m/%d/%Y"),"%Y-%m-%d")
    WHEN birth_date LIKE '%-%' THEN date_format(str_to_date(birth_date,"%m-%d-%Y"),"%Y-%m-%d")
    ELSE null
END ;
-- Cambiamos el tipo de dato
ALTER TABLE limpieza MODIFY birth_date DATE;
Call limpieza();
DESCRIBE limpieza;