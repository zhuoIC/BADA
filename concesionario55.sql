select distinct dni from clientes where not exists (select * from ventas v1 where dni in (select dni from clientes where nombre = "LUIS" and apellido = "GARCIA") and not exists (select * from ventas v2 where v2.codcoche = v1.codcoche and clientes.dni = v2.dni));

delimiter //
drop procedure if exists clienteCopion//
create procedure clienteCopion(in nomCliente varchar(10), in apeCliente varchar(25))
comment 'Ej. de clientes que han comprado al menos los mismos coches que nomCliente'
begin
	declare fin1 bool  default false;
	declare fin2 bool  default false; -- Se declara solo para cerrar más de 1 
	declare vcodcoche varchar(3);
	declare candidato varchar(4);
	declare descartado bool default false;

	declare c1 cursor for select distinct dni from clientes;
	declare c2 cursor for select distinct codcoche from ventas where dni in (select dni from clientes where nombre = nomCliente and apellido = apeCliente);

	declare continue HANDLER for NOT FOUND SET fin1 = true; -- Lanza el error pero sigue la instruccion. EXIT HANDLER finaliza el procedimiento.
	create temporary table ClienteCopion (dni varchar(4));
	open c1;
	repeat
		fetch c1 into candidato;
		if not fin1 then
			set fin2 = fin1;
			open c2;
			repeat
				fetch c2 into vcodcoche;
				if not exists (select * from ventas where dni = candidato  and codcoche = vcodcoche) then
					set descartado = true;
				end if;
			until fin1 or descartado end repeat;	
			close c2;
			if not descartado then
				insert into ClienteCopion values (candidato);
			end if;
			set descartado = false;
			set fin1 = fin2;
		end if;
	until fin1 end repeat;
	close c1;
	select * from ClienteCopion;
	drop table ClienteCopion;
	
end//


delimiter ;
