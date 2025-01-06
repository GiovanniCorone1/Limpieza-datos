-- Funciones de texto
-- Crearemos correos 
-- Probamos
SELECT name , CONCAT(substring_index(name," " , 1),"_",substring(last_name , 1 , 2),"_",upper(substring(type , 1 ,1)),
"@company.com") AS email FROM limpieza;
-- Creamos la columna
ALTER TABLE limpieza ADD COLUMN email VARCHAR(50);
-- Agregamos los email
UPDATE limpieza SET email=
CONCAT(substring_index(name," " , 1),"_",substring(last_name , 1 , 2),"_",upper(substring(type , 1 ,1)),
"@company.com");
