-- Probamos :sin el UTC
SELECT finish_date , str_to_date(finish_date ,"%Y-%m-%d %H:%i:%s") AS fecha FROM limpieza;
-- Solo fecha
SELECT finish_date , date_format(str_to_date(finish_date ,"%Y-%m-%d"),"%Y-%m-%d") AS fecha FROM limpieza;
-- Solo la hora 
SELECT finish_date , date_format(finish_date,"%H:%i:%s") AS hora FROM limpieza;

-- Agregamos una columna que sera como mi copia de seguridad de finish_date
ALTER TABLE limpieza ADD COLUMN date_backup text;
-- copiamos los datos a la nueva columna
UPDATE limpieza SET date_backup = finish_date;

-- Hacemos el cambio(de text a date)
UPDATE limpieza SET finish_date = str_to_date(finish_date ,"%Y-%m-%d %H:%i:%s UTC")
WHERE finish_date <> ''; 

-- Separamos el finish date en dos columnas (fecha y horario)
ALTER TABLE limpieza
	ADD COLUMN fecha date,
    ADD COLUMN hora time;
-- Actualizamos los valores de las nueva columnas con los de finish_date
UPDATE limpieza 
SET fecha = date(finish_date) ,/* solo lo de tipo date*/
	hora = time(finish_date)
WHERE finish_date IS NOT NULL AND finish_date <> '';

-- Ponemos los espacios vacios con null para que evitar de nos de algun error
UPDATE limpieza SET finish_date=null WHERE finish_date="";
-- Cambiamos a tipo de dato datetime
ALTER TABLE limpieza MODIFY finish_date DATETIME;