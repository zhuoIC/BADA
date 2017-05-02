delimiter //

drop trigger if exists bi_equipo//
create trigger bi_equipo before update on equipo
for each row
begin
	if new.web_oficial is not null then
		if new.web_oficial not rlike '^http://'	then	
			set new.web_oficial = concat ('http:/', new.web_oficial);
		end if;
	else
		set new.web_oficial = '<desconocido';
	end if;
end //

delimiter ;
