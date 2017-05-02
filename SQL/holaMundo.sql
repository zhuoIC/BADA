delimiter //
drop procedure if exists holaMundo//
create definer = current_user procedure holaMundo()
comment 'Ejemplo de clase'
sql security invoker
reads sql data
begin
	select 'hola Mundo desde mariadb';
	insert into equipo (id, nombre, idcapitan, ciudad, web_oficial, puntos) values('8', 'Fuenlabrada de melilla', null, 'Melilla', null, 10);


end//

delimiter ;
