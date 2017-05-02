--Ejercicio 17
select ciu.*, co.* from (select * from clientes where ciudad = 'madrid') as ciu join (select * from concesionario where ciudad = 'madrid') as co;

