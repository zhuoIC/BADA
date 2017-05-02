delimiter //

create function estado(valor char(1))
returns varchar(20)
READS SQL DATA
deterministic
comment 'valor = "P" -> caducado, valor = "0" -> activo, valor = "N" -> nuevo'
begin
	declare estado varchar(20);
	IF valor = 'P' THEN
		SET estado = 'caducado';
	ELSEIF valor= '0' THEN
		SET estado = 'activo';
	ELSEIF valor= 'N' THEN
		SET estado = 'nuevo';
	ELSE
		SET estado = 'desconocido';
	END IF;
	RETURN estado;
end //
delimiter ;
