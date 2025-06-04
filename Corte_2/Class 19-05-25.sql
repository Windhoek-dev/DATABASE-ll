-- SINTAXIS
-- Crear un procedemiento almacenado que me sume dos números y devuelva el resultado
-- [<<etiqueta>>]
--declare
	-- declaracion variables
-- begin
	-- codigo
-- end

create or replace function suma(integer, integer) returns integer as $$
declare 
  numero1 ALIAS for $1;
  numero2 ALIAS for $2;
  resultado integer;
begin 
	resultado := numero1 + numero2;
    return resultado; 
end
$$ language plpgsql;

select suma(5,5);


create or replace function resta(numero1 integer, numero2 integer) returns integer as $$
declare 
  resultado integer;
begin 
	resultado := numero1 - numero2;
    return resultado; 
end
$$ language plpgsql;

select resta(10,5);


-- SINTAXIS
-- arg_modo
-- in 
-- out 
-- inout

-- create or replace function <nombre_funcion>([arg_modo][arg_nombre]arg_tipo [,...])
-- return tipo_de_datos as $$
-- declare 
-- begin 
-- end
-- $$ language plpgsql;

create or replace function imprimir_valor( param1 integer) returns integer as $$
declare 
   v integer := 15;
begin
	raise notice 'El valor de param1 es: %',param1;
    raise notice 'El valor de v es: %',v;
    return v;
end
$$language plpgsql;

select imprimir_valor(55);

-- Procedimiento que reciba dos valores enteros que realice la suma y la resta 
-- y los devuleva como parametros de salida.
create or replace function opera(v1 integer, v2 integer, inout suma int, inout resta int) as $$
begin
    raise notice 'inout suma: %',suma;
    raise notice 'inout resta: %',resta;
	suma :=  v1 + v2;
    resta := v1 - v2;
end
$$language plpgsql;

select opera(55, 20, 1, 1);

-- Concatenar
create or replace function concatenar(datos users) returns text as $$
begin 
	return datos.uid || '-' || datos.name || '-' || datos.email;
end
$$language plpgsql;

select concatenar(u.*) from users u;

-- retornar los datos de una tabla;
create or replace function sendtable() returns table(
 tid int,
 title varchar,
 summary text
) as $$
begin
	return query
		select t.tid, t.title, t.summary from tasks t where t.tid = 8;
end;
$$language plpgsql;

select sendtable();
select * from sendtable();

--- Introducción al lenguage PLSQL
--- := Operador de asignación
--- recuperar una fila de una tabla
-- select expresions into target from tabla;
-- select  into data_user from users;

--- Llamado de la funciones
-- select recuperar valores, funciones necesitan el select
-- llamar funcions sin recuperar valores
-- perfom .... muy utilizado en los procedimientos.
-- call

-- Envio mensajes
-- raise <<level>>
-- debug = Registro en base de datos no productivo;
-- notice = registro en la base de datos y envia el mensaje;
-- exception = registro termina una transccion;

-- Estructuras de Control
-- if expresion then
	--sentencia
-- else
	--sentencia
-- end if;

-- ALTER TABLE public.users ADD country varchar(100) NULL;

create or replace procedure view_user(iduser integer) as $$
declare
  reguser users%ROWTYPE;
  nombre varchar;
  fecha timestamp;
  retorno integer;
begin
	select * into reguser from users where uid = iduser;
    raise notice 'Traje el usuario: %',reguser.name;
   
    if( reguser.country = 'Colombia') then
    	raise notice 'Es colombian@';
    else
    	raise notice 'Otra nacionalidad';
    end if;
   
    fecha := reguser.register_date;
    raise notice 'Se registro en: %', fecha;
   
    retorno := imprimir_valor(5);
    raise notice 'Retornoar funcion: %', retorno;
   
    perform imprimir_valor(20);
end;
$$ language plpgsql;

call view_user(3);

-- Crear un procedimiento que permita listar las tareas con prioridad 2
-- si la tarea está pendiente enviar un mensaje echele ganas si esta
-- finalizada felicitar.
CREATE OR REPLACE PROCEDURE listar_tareas() AS $$
  DECLARE
  	 t_tasks tasks%ROWTYPE;
BEGIN
  SELECT * INTO t_tasks FROM tasks t JOIN priorities p ON t.pid = p.pid WHERE p.id = 2;
  FOR task IN t_tasks LOOP
  	IF t_task.status = 'pendiente' THEN
    	RAISE NOTICE 'echele ganas';
  	IF task.status = 'completada' THEN
    	RAISE NOTICE 'felicitaciones';
  	ELSE
    	RAISE NOTICE 'siga así';
  	END IF;
  END LOOP
END
$$ LANGUAGE plpgsql;
