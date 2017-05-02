delimiter //

create procedure fechaYAleatorio()
not deterministic
begin
	current_date(), rand;
end //

delimiter ;
