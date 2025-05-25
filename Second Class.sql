We worked with materialized views and normal views
 
CREATE VIEW [nombre_vista] AS [Select]
 SELECT * FROM VIEW_NAME;


MATERIALIZED VIEWS
CREATE MATERIALIZED VIEW view_name
 [(Column_name)]
 AS query
 [WITH [NO] DATA];
 REFRESH MATERIALIZED VIEW [CONCURRENTLY] view_name
 WITH NO DATA


INDEX
 Data structure that allows much faster access to the table.
 Requires disk space, speeds up the search
 Does not change the table data
 The index must be modified when the table content is modified.
 it is recommended to search for specific data
 Primary table is an index
 is transparent to the user
 They are not useful when they are repeated fields

 CREATE INDEX nombre_indice ON nombre_tabla [USING metodo](
 nombre_columna[ASC|DESC][NULL{FIRST|LAST}]
 )
--- Eliminar
 DROP INDEX [CONCURRENTLY] nombre_indice [CASCADE|RESTRICT]
 CONCURRENTLY y CASCADE no se puede utilizar al mismo tiempo.
   
   
   create index user_name_idx on users(
 name
 )
