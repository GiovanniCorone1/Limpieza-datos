use limpieza_mysql;
/*----------- limpieza de datos ------*/

/*Stored procedure para visualizar nuestra database*/
DELIMITER //
CREATE PROCEDURE limpieza()
BEGIN 
	SELECT * FROM limpieza ;
END //
DELIMITER ;

-- 1.Renombramos el nombre de los atributos de la columna
ALTER TABLE limpieza CHANGE COLUMN `ï»¿Id?empleado` `id_employee` VARCHAR(20);
ALTER TABLE limpieza CHANGE COLUMN `gÃ©nero` `Gender` VARCHAR(20);
ALTER Table limpieza CHANGE COLUMN Apellido last_name VARCHAR(50);

-- 2.Identificar valores duplicados
SELECT id_employee , COUNT(*) AS cantidad_duplicados FROM limpieza
GROUP BY id_employee
HAVING count(*) > 1;

-- 3.Eliminar espacios en blanco al final e inicio de los nombres y apellidos 
-- a. Vemos si hay espacios en blanco
SELECT name FROM limpieza
WHERE length(name) - length(trim(name))>0 ;
-- b. Probamos como se quitaria esos espacios
SELECT name , trim(name) FROM limpieza
WHERE length(name) - length(trim(name))>0 ;
-- c.Actualizamos la tabla
UPDATE limpieza SET name = TRIM(name)
WHERE length(name) - length(trim(name))>0;

-- Lo mismo con el apellido
UPDATE limpieza SET apellido = trim(apellido)
WHERE length(apellido) - length(trim(apellido))>0;

-- Espacio en blancos entre palabras
-- Seleccionamos los espacios en blancos 
SELECT area FROM limpieza 
WHERE area REGEXP '\\S{2,}';
-- Probamos como borrar espacios en blancos 
SELECT area , TRIM(regexp_replace(area,'\\s+',' ')) AS "area limpia" FROM limpieza;
-- Actualizamos la tabla con la columna modificada
UPDATE limpieza SET area = TRIM(regexp_replace(area,'\\s+',' '));

-- 4.Buscar y reemplazar: 
-- Prueba
SELECT gender , 
CASE 
	WHEN gender="hombre" THEN "male"
    WHEN gender="mujer" THEN "woman"
	ELSE "others"
END AS "gender actualizado"
FROM limpieza;
-- Reemplazamos
UPDATE limpieza SET gender = CASE 
	WHEN gender="hombre" THEN "male"
    WHEN gender="mujer" THEN "woman"
	ELSE "others"
END;

-- type representa el tipo de contrato 1(remote) y 0(hybridic)
-- es INT lo cambiamos a text 
ALTER TABLE limpieza MODIFY type text;
-- vemos como seria el cambio
SELECT type , 
CASE
	WHEN type = "0" THEN "hybridic"
    WHEN type ="1" THEN "remote"
    ELSE "other"
END AS ejemplo
FROM limpieza;
-- reemplazamos
UPDATE limpieza SET type =
CASE
	WHEN type = "0" THEN "hybridic"
    WHEN type ="1" THEN "remote"
    ELSE "other"
END ;

-- Probamos
SELECT salary ,
CAST(TRIM(REPLACE(REPLACE(salary , "$",""),",","")) AS DECIMAL(10,2)) as "new salary" FROM limpieza;
-- Actualizamos
UPDATE limpieza 
SET salary = CAST(TRIM(REPLACE(REPLACE(salary , "$",""),",","")) AS DECIMAL(10,2));
-- Cambiamos el de text a int
ALTER TABLE limpieza MODIFY COLUMN salary INT NULL;