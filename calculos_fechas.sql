-- Calculos con fechas
-- Años laborando de los empleados
ALTER TABLE limpieza ADD COLUMN labor_time INT ;
-- Calculo los años laborados
SELECT name , star_date, fecha,
	IF (finish_date is null,timestampdiff(YEAR,star_date,curdate()),timestampdiff(YEAR,star_date,fecha)) AS "años trabajando"
    FROM limpieza;
