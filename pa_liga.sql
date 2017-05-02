delimiter //
drop procedure if exists listaPorEquipo//
create procedure listaPorEquipo(in elEquipo int)
comment 'Ej. de cursor que recorre todos los jugadores dado el equipo del parámetro'
begin
	declare vid int;
	declare vnombre varchar(102);
	declare valtura decimal(3,2);
	declare vnomEquipo varchar(25);
	declare vciudad varchar(50);
	declare vpuntos varchar(6);
	declare hayDatos bool default true;
	declare c1 cursor for select id, concat(apellido, ', ', nombre), altura from jugador where equipo = elEquipo;
	declare c2 cursor for select nombre, ciudad, puntos from equipo where id = elEquipo;
	declare continue HANDLER for NOT FOUND SET haydatos = false; -- Lanza el error pero sigue la instruccion. EXIT HANDLER finaliza el procedimiento.

	open c1;
	while hayDatos DO
		 -- Ejecuta el cursor y devuelve la primera fila
		fetch c1 into vid, vnombre, valtura;
		if (hayDatos) then
			select vid, vnombre, valtura;
		end if;
	END WHILE;
	close c1;
	
	set hayDatos = true;
	open c2;
	while hayDatos DO
		 -- Ejecuta el cursor y devuelve la primera fila
		fetch c2 into vnomEquipo, vciudad, vpuntos;
		if (hayDatos) then
			select vnomEquipo, vciudad, vpuntos;
		end if;
	END WHILE;
	close c2;
end//


delimiter ;
