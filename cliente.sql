drop table if exists cliente;

create table cliente(
numFactura char(5) primary key,
idCliente char(10) not null,
nomCliente varchar(64) not null,
telCliente varchar(15),
fechaNac date not null
);
