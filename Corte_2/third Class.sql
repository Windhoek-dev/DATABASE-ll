Transactions
 A transaction is a unit of work made up of different tasks whose final result must be
 must be executed all or none of them.
 It is used when several operations are required, if everything goes well it is executed if any of them fail
 nothing is executed
 Problem with inconsistent data - Transactions avoid this
 Are isolated - do not see each other with other transactions
 Characteristics
 Atomicity: All transactions are considered as one single transaction
 Consistency: Never leaves inconsistent data
 Isolation: Dirty data is isolated and prevents users from accessing it until it is confirmed or validated.
 Confirmed or validated
 Durability: The data will be permanent and the data is accessible.

--Sintaxis
 BEGIN;
  SENTENCIAS SQL
 ROLLBACK;
 COMMIT;
--- Tienen un inicio
--- Dos posibles finales si tiene exito o no
---Autocommit = activo, cada vez que ejecutemos una sentencia depende del cliente SET AUTOCOMMIT = 0

 Ejemplo 1: Crear tarea con etiquetas y comentario (todo junto)

 BEGIN;-- 1. Insertar tarea
 INSERT INTO tareas (titulo, descripcion, fecha_limite, usuario_i
 d, prioridad_id)
 VALUES ('Preparar presentación', 'Presentación para el cliente', 
'2025-05-25', 1, 2)-- Supón que devuelve id = 10, entonces insertamos etiquetas-- 2. Etiquetas para la tarea (ID 10)
 INSERT INTO tareas_etiquetas (tarea_id, etiqueta_id)
VALUES (10, 1), (10, 3);  -- urgente y trabajo-- 3. Comentario inicial
 INSERT INTO comentarios (contenido, tarea_id, usuario_id)
 VALUES ('Recuerda incluir los gráficos actualizados.', 10, 1);
 COMMIT;

Ejemplo 2: Transacción con error y rollback
BEGIN;-- Intentar insertar una tarea con un usuario que no existe (usua
 rio_id = 9999)
 INSERT INTO tareas (titulo, descripcion, fecha_limite, usuario_i
 d, prioridad_id)
 VALUES ('Tarea fallida', 'Esta no debería guardarse', '2025-06-0
 1', 9999, 1);-- Este paso no se ejecutará porque el anterior fallará (clave fo
 ránea)
 INSERT INTO comentarios (contenido, tarea_id, usuario_id)
 VALUES ('Comentario que no debería existir', 9999, 1);
 ROLLBACK;  -- Deshace todo porque hubo error-- Resultado: No se insertó nada


Temporary Tables
 Two types of tables
 Session level: exist for the lifetime of the session.
 Transaction level: exist during a transaction
 Postgres automatically deletes temporary tables.
 Is visible only for the session that has been started

 CREATE {TEMPORARY | TEMP } TABLE nombre_tabla
 [(column_name[...])]
 [ON COMMIT {PRESERVE ROWS | DELETE ROWS | DROP}]

 CREATE TEMPORARY TABLE temporal1{
  tuno_id int,
  tuno_ data varchar(255)
 } ON COMMIT DELETE ROWS
 insert into temporal1
 (tuno_id, tuno_data)
 values(1, 'Dato 1 temporal 1')
 insert into temporal1
 (tuno_id, tuno_data)
 values(2, 'Dato 2 temporal 1')

Ejercicio crear una tabla temporal con las tareas y muestre las prioridades con su nombre
  
CREATE TEMPORARY TABLE temporal_sql
 ON COMMIT PRESERVE rows
 as
 SELECT t.tid, t.title, t.status, p.p_name FROM task as t, priorit
 ies as p
 WHERE t.pid = p.pid
 ORDER BY t.title AS
 with data;
