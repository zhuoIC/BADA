-- 7.Datos del equipo y del capitán para equipos que hayan ganado más de dos partidos como visitantes.
select concat(j.apellido, ', ', j.nombre) as nombre, e.nombre as equipo, e.ciudad from jugador j join equipo e on e.id = j.equipo where j.id = j.capitan and e.id in (select evisitante from partido where substring_index(resultado, '-', 1) < substring_index(resultado, '-', -1) group by evisitante having count(*)> 2);
-- 8.Mostrar los equipos que no han jugado ningún partido como locales.
-- Sin exists
select * from equipo where id not in (select evisitante from partido);
-- Con exists
select * from equipo e where not exists (select * from partido p where p.evisitante = e.id);
