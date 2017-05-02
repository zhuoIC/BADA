-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER //

DROP PROCEDURE IF EXISTS `setupEstadistica` //
CREATE DEFINER=`root`@`localhost` PROCEDURE `setupEstadistica`()
COMMENT 'Inicializar la tabla Estadística con los valore actuales'
BEGIN
	declare vLoc int;
	declare vVis int;
	declare vGanaLocal bool;
	declare fin bool default false;
	declare c1 cursor for
	SELECT p.elocal, p.evisitante, p.mVisitante < p.mLocal from 
	(select elocal, evisitante, cast(substring_index(resultado, '-', 1) as integer) as mLocal,
	cast(substring_index(resultado, '-', -1) as integer) as mVisitante 
	from partido) as p where mLocal <> mVisitante;
	declare continue handler for not found set fin = 1;
	
	truncate estadistica;
	insert into estadistica (idEquipo) select distinct id from equipo;

	open c1;
	while not fin do
		fetch c1 into vLoc, vVis, vGanaLocal;
		if not fin then
			if	vGanaLocal then
				update estadistica set vLocal = vLocal + 1, vTotal = vTotal + 1 where idEquipo = vLoc;
			else
				update estadistica set vVisitante = vVisitante + 1, vTotal = vTotal + 1 where idEquipo = vVis;
			end if;
			
		end if;
	end while;
	close c1;
END //
delimiter ;
