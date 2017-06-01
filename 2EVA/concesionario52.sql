delimiter //
drop procedure if exists soloConcesionario//
create procedure soloConcesionario(in concesionario varchar(4))
comment 'Ej. de cursor que recorre todos los jugadores dado el equipo del parámetro'
begin
	declare vdni varchar(4);
	declare vnombre varchar(37);
	declare hayDatos bool default true;
	declare infiel bool default false;
	declare c1 cursor for select distinct dni from ventas where cifc = concesionario;
	declare continue HANDLER for NOT FOUND SET haydatos = false; -- Lanza el error pero sigue la instruccion. EXIT HANDLER finaliza el procedimiento.

	open c1;
	while hayDatos DO
		 -- Ejecuta el cursor y devuelve la primera fila
		fetch c1 into vdni;
		if (hayDatos) then
			if ((select count(*) from ventas where cifc <> concesionario and dni = vdni) <= 0) then
				select concat(apellido, ', ', nombre) as nombre from clientes where dni = vdni;
			end if;
		end if;
	END WHILE;
	close c1;
end//


delimiter ;
