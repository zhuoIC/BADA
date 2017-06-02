create database tabacalera;
use tabacalera

drop table if exists licencia;
drop table if exists tabaco;
drop table if exists telefonos;
drop table if exists estanco;

create table estanco(
	nombre varchar(25),
	calle varchar(35),
	primary key (nombre));

create table telefonos(
	estanco varchar(25),
	telefono varchar(10),
	primary key (estanco),
	foreign key (estanco) references estanco(nombre));
	
create table tabaco(
	marca varchar(25),
	licencia varchar(35),
	hoja varchar(15),
	%nicotina decimal,
	%alquitran decimal,
	primary key (marca),
	foreign key (estanco) references estanco(nombre));

create table vende(
	estanco varchar(25),
	tabaco varchar(25),
	primary key (estanco, tabaco),
	foreign key (estanco) references estanco(nombre),
	foreign key (tabaco) references tabaco(marca));

create table licencia(
	nombre varchar(35),
	pais char(3),
	primary key (nombre),
	foreign key (nombre) references tabaco(licencia));
