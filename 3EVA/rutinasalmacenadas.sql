delimiter //

drop function if exists diaSemana//
create function diaSemana (nDia integer)
returns char(10)
deterministic
begin
	declare dia char(10);
	CASE nDia
		when 1 then
			set dia = 'Lunes';
		when 2 then
			set dia = 'Martes';
		when 3 then
			set dia = 'Miercoles';
		when 4 then
			set dia = 'Jueves';
		when 5 then
			set dia = 'Viernes';
		when 6 then
			set dia = 'Sábado';
		when 7 then
			set dia = 'Domingo';
		else
			set dia = null;
	end case;
	RETURN dia;
end//

drop function if exists maxTres//
create function maxTres (n1 integer, n2 integer, n3 integer)
returns integer
deterministic
begin
	declare mayor integer;
	if convert(n1, integer) not like n1 or convert(n2, integer) not like n2 or convert(n3, integer) not like n3 then
		return null;
	end if;
	if n1 > n2 then
		if n1 > n3 then
			set mayor = n1;
		elseif n3 > n1 then
			set mayor = n3;
		else
			set mayor = null;
		end if;
	elseif n2 > n3 then
		if n2 > n1 then
			set mayor = n2;
		elseif n1 > n2 then
			set mayor = n1;
		else 
			set mayor = null;
		end if;
	elseif n3 > n1 then
		if n3 > n2 then
			set mayor = n3;
		elseif n2 > n3 then
			set mayor = n2;
		else 
			set mayor = null;
		end if;
	else
		set mayor = null;	
	end if;
	RETURN mayor;
end//

drop function if exists esPalindromo//
create function esPalindromo (texto varchar(50))
returns tinyint(1)
deterministic
begin
	if texto = reverse(texto) then
		return 1;
	else
		return 0;
	end if;	
end//


/*
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
*/
delimiter ;
