delimiter //
drop event if exists copiaSeguridadPartidos //
create event copiaSeguridadPartidos
on schedule EVERY 1 WEEK 
STARTS '2017-09-03 22:00'
ENDS '2018-06-30'
comment 'Volcado de seguridad de partidos jugados cada domingo a las 22:00h'
DO
BEGIN
	declare ultimaFecha date;
	create table if not exists partidoTmp (elocal smallint (6), evisitante smallint(6), resultado char(7), fecha date, arbitro smallint(6));
	insert into partidoTmp select elocal, evisitante, resultado, fecha, arbitro from partido where fecha > (select max(fecha) from partidoTmp);
END //

delimiter //
drop event if exists sueldoDiez //
create event sueldoDiez
on schedule EVERY 1 MINUTE 
STARTS current_timestamp
ENDS current_timestamp + interval 5 minute
comment 'Aumenta el sueldo cada minuto'
DO
BEGIN
	update jugador set salario = salario * 1.1;
END //

delimiter ;
