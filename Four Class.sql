 Procedures 
         
 It is a function that is stored inside the database.
 Extend database functions
 Are linked to a database
 They are written in different languages pl/Psql, phpsql, pythonpsql must be installed.
 PL/Psl

 Advantages of the stored procedure
 Runs inside the database engine, better performance.
 Logic inside the database front end is simpler.
 Avoid duplication of code.

Crear un procedimiento almacenado que sume dos números y devuelva el resultado.
CREATE OR REPLACE FUNCTION suma(integer, integer) RETURNS intege
 r AS $$
 DECLARE
 numero1 ALIAS FOR $1
 numero2 ALIAS FOR $2
 resultado INTEGER
 BEGIN
  resultado := numero1 + numero2
  RETURN resultado;
 END;
 $$ LANGUAGE plpgsql;
 Select sumar(1,2)

 CREATE OR REPLACE FUNCTION suma(numero1 integer, numero2 integer) 
RETURNS integer AS $$
 DECLARE
 resultado INTEGER
 BEGIN
  resultado := numero1 + numero2
  RETURN resultado;
 END;
 $$ LANGUAGE plpgsql;
 Select sumar(1,2)


 SINTAXIS PROCEDIMIENTOS ALMACENADOS
 CREATE [OR REPLACE] FUNCTION
  nombre_funcion([[argmodo][argnombre] argtipo [,...])
 RETURN tipo AS $$
    * argmodo como va a trabajar el argumento = (IN, OUT o INOUT)
 entrada, salida o bidireccional por defecto es entrada.
    * argnombre del parameto
    * argtipo el tipo de dato


[DECLARE]
 [declaraciones de variables]
 BEGIN
  codigo
 END; 
$$ LANGUAGE plpgsql
  | IMMUTABLE | STABLE | VOLATILE
      INMUTABLE = No se puede alterar la base de datos y no puede 
hacer consultas
      STABLE = No puede alterar la base de datos pero hacer consu
 ltas
      VOLATILE = Alterar y hacer consultas es por defecto
  | CALLED ON NULL INPUT | RETURNS NULL ON NULL INPUT | STRICT
      CALLED ON NULL INPUT = es el valor por defecto. se ejecuta 
sin los argumentos son nulos
      RETURNS NULL ON NULL INPUT / STRICT = retorna nulo si algun
 o de los argumentos son nulos
  | [EXTERNAL] SECURITY INVOKER | [EXTERNAL] SECURITY DEFINER
      SECURITY INVOKER = Es por defecto con que privilegios se va 
a ejecutar el procedimiento - en este toma los privilegios de qui
 en lo llama
      SECURITY DEFINER = Toma los privilegios de quien lo creo
  | COST execution_cost
  | ROWS result_rows

| SET configuration_parameter { TO value | = value | FROM CURR
 ENT }



 Estructura CASE
 Esctructura de Repetición
 Estructuras de Repetición
 CASE expresion
 WHEN expresion [, expresion[]] THEN
  sentencias 1;
 WHEN expresion [, expresion[]] THEN
  sentencias 2;
 WHEN expresion [, expresion[]] THEN
  sentencias 2;
 [ELSE
  sentencias 4
 ]
 END CASE;

 LOOP - EXIT
 Se ejecutan hasta que encuentre la sentencia exit
 LOOP
  setencias;
 END LOOP;
 EXIT [etiqueta] WHEN expresion 


 WHILE expresion LOOP
  sentencias;
 END LOOP;-- debe existir una manera de de retornar e false la expresion pa
 ra parar el while


 FOR nombre IN [REVERSE] expresion..expresion LOOP
  sentencias;

END LOOP;

 FOREACH nombre [SLICE numero] IN ARRAY arreglo LOOP
 sentencias;
 END LOOP;
