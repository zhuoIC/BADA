delimiter //
drop function if exists esPar//
create function esPar (numero char(32))
returns tinyint(1)
READS SQL DATA
deterministic
comment 'Devuelve par si el numero es par e impar si es impar'
begin
	declare resultado tinyint(1);

	IF numero % 2 = 0 THEN
		SET resultado = '1';
	ELSE
		SET resultado = '0';
	END IF;
	IF CONVERT(numero, INTEGER) not like numero or numero is null THEN
		SET resultado = null;
	END IF;
	RETURN resultado;	
end //

drop procedure if exists insertar// 
create procedure insertar (numero char(32))
READS SQL DATA
comment 'Devuelve par si el numero es par e impar si es impar'
begin
	if esPar(numero) is not null then
		if esPar(numero) = 1 then
			INSERT INTO test.numeros ()values(numero, null);
		else
			INSERT INTO test.numeros ()values(null, numero);
		end if;
	end if;
end //

drop procedure if exists proc1//
create procedure proc1(IN p int)
comment 'Ej. de pa con parámetro de entrada'
begin
	set@x = p;
	set p = 2* p; -- Esta sentencia no sirve para nada
end//

drop procedure if exists proc2//
create procedure proc2(IN entrada int, OUT salida int) -- Es irrelevante el valor que se le introduce
comment 'Ej. de pa con parámetro de entrada'
begin
	set salida = 2*entrada; -- Esta sentencia sirve para algo
end//

drop procedure if exists nProvincias//
create procedure nProvincias(tabla varchar(32), out numero int)
begin
	declare ruta varchar(32);
	set ruta = concat(tabla,' ');
	select count(*) into numero from (select concat(tabla)) as t1;
end//

drop procedure if exists proc3//
create procedure proc3(INOUT p int)
comment 'Ej. de parámetro de entrada/salida' -- No recomendado. No hay control sobre ellos. Recomendado usar datos de entrada y de saldia por separado
begin
	set p = p * 2;
end//

drop procedure if exists proc4//
create procedure proc4()
comment 'Ej. de ámbito de alcance de variables'
begin
	declare x1 char(25) default 'fuera de ambito';
	begin
		declare x1 char(25) default 'dentro de ambito';
		select x1;
	end;
	select x1; -- Hay que organizarlo para que se guarde en un solo select
end//

drop procedure if exists proc5//
create procedure proc5(IN param1 int)
comment 'Ej. de uso del case'
begin
	CASE param1
		when 0 then
			insert into t values (-1);
		when 1 then
			insert into t values (param1);
		else
			insert into t values (param1 * 100);
	end case;
end//
-- 'mysqldump -u root -p --routines --databases test > test.dump' Para volcar la base de datos test con sus procedimientos

drop procedure if exists proc6//
create procedure proc6(in hasta int)
comment 'Ej. de uso del bucle loop'
begin
	declare contador int;
	set contador = hasta;
	salida: LOOP
		select concat('Valor contador: ', contador);
		set contador = contador -1;
		if contador <=0 then
			LEAVE salida;
		end if;
	END LOOP;
end//

drop procedure if exists proc7//
create procedure proc7(in hasta int)
comment 'Ej. de uso del bucle REPEAT ...UNTIL'
begin		
	declare contador int;
	set contador = hasta;
	REPEAT
		select concat('Valor contador: ', contador);
		set contador = contador -1;
	UNTIL contador <= 0 END REPEAT;
end//

drop procedure if exists proc8//
create procedure proc8(in hasta int)
comment 'Ej. de uso del bucle REPEAT ...UNTIL'
begin		
	declare contador int;
	set contador = hasta;
	WHILE contador > 0 DO
		select concat('Valor contador: ', contador);
		set contador = contador -1;
	END WHILE;
end//

drop function if exists esPrimo//
create function esPrimo (num varchar(32))
returns tinyint(1)
deterministic
begin
	declare contador varchar(32);
	declare resultado tinyint(1);
	if num < 2 then
		return 0;
	else
		set contador = 2;
		salida: LOOP
			IF CONVERT(num, INT) not like num or num is null then
				return null;
				LEAVE salida;
			end if;
			if contador = num or num = 2 then
				return 1;
				LEAVE salida;
			end if;
			if num % contador = 0 then
				return 0;
				LEAVE salida;
			end if;
			set contador = contador +1;
		END LOOP;
	end if;
end//

drop function if exists nPrimo//
create function nPrimo (nVeces varchar(32))
returns int
deterministic
begin
	declare contador int;
	declare primo int;
	declare numero int;
	declare nPrimo int;
	set numero = 1;
	set contador = 2;
	set primo = 2;
	IF CONVERT(nVeces, INT) not like nVeces or nVeces is null then
		return null;
	end if;
	REPEAT
		set numero = numero +1;
		if esPrimo(numero) = 1 then
			set nPrimo = nPrimo +1;
		end if;
		
	UNTIL nPrimo = nVeces END REPEAT;
	return numero;
end//

drop procedure if exists selectDVD//
create procedure selectDVD(codi smallint(6), titu varchar(40), arti varchar(30), elPais char(2), comp varchar(40), prec decimal (6,2), anio char (4), out resul tinyint(1))
comment 'Ej. de uso del bucle REPEAT ...UNTIL'
begin		
	declare filtro varchar(255) default '';
	set @orden = 'select codigo, titulo, artista, pais, compania, precio, anio from dvd';
	if codi is not null then
		set filtro = concat (' where codigo= ', codi);
	end if;
	if titu is not null then
		if filtro = '' then
			set filtro = concat (' where titulo rlike "', titu,'"');
		else
			set filtro = concat (' and titulo rlike "', titu,'"');
		end if;
	end if;
	if arti is not null then
		if filtro = '' then
			set filtro = concat (' where artista rlike "', arti,'"');
		else
			set filtro = concat (' and artista rlike "', arti,'"');
		end if;
	end if;
	if pais is not null then
		if filtro = '' then
			set filtro = concat (' where pais rlike "', pais,'"');
		else
			set filtro = concat (' and pais rlike "', pais,'"');
		end if;
	end if;
	if compania is not null then
		if filtro = '' then
			set filtro = concat (' where compania rlike "', compania,'"');
		else
			set filtro = concat (' and compania rlike "', compania,'"');
		end if;
	end if;
	if prec is not null then
		if filtro = '' then
			set filtro = concat (' where precio rlike ', prec);
		else
			set filtro = concat (' and precio rlike ', prec);
		end if;
	end if;
	if anio is not null then
		if filtro = '' then
			set filtro = concat (' where anio rlike ', anio);
		else
			set filtro = concat (' and anio rlike ', anio);
		end if;
	end if;
	set @orden = concat(@orden, filtro);
	select @orden;
	PREPARE sentencia FROM @orden; -- La prepara para su ejecucion. La precarga en memoria.
	EXECUTE sentencia;
	DEALLOCATE PREPARE sentencia;
end//

drop procedure if exists deleteDVD// -- A los usuarios solo hay que darle el permiso DELETE y controlado, nunca el TRUNCATE.
create procedure deleteDVD(in codDesde smallint, in codHasta smallint, out resul tinyint(1))
comment 'Eliminacion de registro por codigo'
begin
	declare filtro varchar(255) default '';
	SET @orden = 'delete from dvd';
	if codHasta is not null and codDesde is not null and codHasta > codDesde then
		set filtro = concat(' where codigo between ', codDesde, ' and ', codHasta);
	elseif codHasta is not null and codDesde is not null and codHasta < codDesde then
		set filtro = concat(' where codigo is null');
	elseif codHasta is not null and codDesde is null then
		set filtro = concat(' where codigo = ', codDesde);
	end if;
	set @orden = concat(@orden, filtro);
	select @orden;
	PREPARE sentencia FROM @orden;
	-- EXECUTE sentencia;
	DEALLOCATE PREPARE sentencia;
end//

drop procedure if exists updateDVD//
create procedure updateDVD (codi smallint(6), titu varchar(40), arti varchar(30), elPais char(2), comp varchar(40), prec decimal(6,2), elAnio char(4), out resul tinyint(1))
comment 'Actualización del registro identificado por codi'
begin	
	declare unAnio char(4);
	if elAnio <= year(now()) then
		set unAnio = elAnio;
	end if;
	update dvd
	set titulo = titu, 
	artista = arti,
	pais = elPais, 
	compania = comp, 
	precio = prec, 
	anio = unAnio 
	where codigo = codi;
	
	set resul = 0;
end//

drop procedure if exists insertDVD//
create procedure insertDVD (codi smallint(6), titu varchar(40), arti varchar(30), elPais char(2), comp varchar(40), prec decimal(6,2), elAnio char(4), out resul tinyint(1))
comment 'Actualización del registro identificado por codi'
begin	
	declare pkError condition for SQLSTATE '23000';
	declare encontrado int;
	declare paisError int;
	-- declare encontrado2 int;

	-- set encontrado2 = (select count(*) from dvd where codigo = codi);
	select count(*) into encontrado from dvd where codigo = codi;
	select count(*) into encontrado from pais where iso = elPais;
	if encontrado <> 0 then
		signal pkError
		SET MESSAGE_TEXT = 'Código de disco repetido', MYSQL_ERRNO= 1062;
	elseif paisError = 0 then
		signal pkError
		SET MESSAGE_TEXT = 'Código de pais incorrecto', MYSQL_ERRNO= 1452;
	else
		insert into dvd (codigo, titulo, artista, pais, compania, precio, anio) values (codi, titu, arti, elPais, comp, prec, elAnio);
	end if;
	
	set resul = 0;
end//

drop procedure if exists insertDVD2//
create procedure insertDVD2 (codi smallint(6), titu varchar(40), arti varchar(30), elPais char(2), comp varchar(40), prec decimal(6,2), elAnio char(4), out resul tinyint(1))
comment '. Resul (0) => Ok'
begin	
	
	declare pkError condition for SQLSTATE '23000';
	declare encontrado int;
	declare paisError int;
	-- declare encontrado2 int;

	-- set encontrado2 = (select count(*) from dvd where codigo = codi);
	select count(*) into encontrado from dvd where codigo = codi;
	select count(*) into encontrado from pais where iso = elPais;
	if encontrado <> 0 then
		signal pkError
		SET MESSAGE_TEXT = 'Código de disco repetido', MYSQL_ERRNO= 1062;
	elseif paisError = 0 then
		signal pkError
		SET MESSAGE_TEXT = 'Código de pais incorrecto', MYSQL_ERRNO= 1452;
	else
		insert into dvd (codigo, titulo, artista, pais, compania, precio, anio) values (codi, titu, arti, elPais, comp, prec, elAnio);
	end if;
	
	set resul = 0;
end//

delimiter ;
