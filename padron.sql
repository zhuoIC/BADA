use padron;
drop table if exists propiedad;
drop table if exists habitante;
drop table if exists vivienda;
drop table if exists municipio;

create table municipio(
	cp char(5),
	nombre varchar(50) not null,
	primary key (cp)
);

insert into municipio (cp, nombre) values ("29016", "Málaga - El Limonar");
insert into municipio (cp, nombre) values ("29017", "Málaga - Cruz Humilladero");
insert into municipio (cp, nombre) values ("29018", "Málaga - Teatinos");

create table vivienda(
	nrc char(20),
	direccion varchar(50) not null,
	municipio char(5) not null,
	primary key (nrc),
	foreign key (municipio) references municipio (cp) on update cascade on delete restrict
);

insert into vivienda values ("001", "Direccion vivienda 001", "29016");
insert into vivienda values ("002", "Direccion vivienda 002", "29017");
insert into vivienda values ("003", "Direccion vivienda 003", "29018");

create table habitante(
	id char(10) not null,	
	nombre varchar(50) not null,
	fnac date not null,
	dondeVive varchar(20) not null,
	cf char(10) not null,
	primary	key (id),
	foreign key (dondeVive) references vivienda(nrc) on update cascade on delete restrict,
	foreign key (cf) references habitante(id) on update cascade on delete restrict
);

insert into habitante values ("01", "HAB01", "1916-12-22", "002", "01");
insert into habitante values ("02", "HAB02", "1917-02-15", "002", "01");
insert into habitante values ("03", "HAB03", "1916-01-21", "002", "01");
insert into habitante values ("04", "HAB04", "1916-10-07", "001", "04");
insert into habitante values ("05", "HAB05", "1916-10-07", "003", "05");

create table propiedad(
	propietario char(10) not null,	
	vivienda varchar(20) not null,
	primary	key (propietario, vivienda),
	foreign key (propietario) references habitante(id) on update cascade on delete restrict,
	foreign key (vivienda) references vivienda(nrc) on update cascade on delete restrict
);

insert into propiedad values("01","002");
insert into propiedad values("02","003");
insert into propiedad values("04","001");
insert into propiedad values("05","001");



