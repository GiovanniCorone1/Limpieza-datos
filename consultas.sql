-- Consultas Finales
-- Cantidad de eempleados por area
SELECT area , COUNT(*) as quantity_employee FROM limpieza
GROUP BY area
ORDER BY quantity_employee DESC;

-- Tabla final
SELECT id_employee , Name , last_name ,gender,email ,area ,salary , type ,finish_date FROM limpieza
WHERE finish_date <= CURDATE() AND finish_date IS NOT NULL 
ORDER BY finish_date DESC;
