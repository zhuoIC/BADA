create database if not exists liga;

use liga;

drop table if exists equipo;

create table equipo(
	id smallint primary key,
	nombre varchar(25) not null,
	ciudad varchar(50) not null,
	web_oficial varchar(255),
	puntos smallint
);

drop table if exists jugador;

create table jugador(
	id smallint primary key,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	altura decimal(3,2),
	capitan smallint references jugador (id) on update cascade,
	puesto varchar(50),
	fecha_alta date,
	salario int default 0,
	equipo smallint references equipo (id) on update cascade
);

drop table if exists partido;

create table partido(
	elocal smallint references equipo (id) on update cascade,
	evisitante smallint references equipo (id) on update cascade,
	resultado char(7) null,
	fecha date not null,
	arbitro smallint not null,
	primary key (fecha, elocal, evisitante)
);

insert into equipo values (1,"Regal Barcelona","Barcelona","www.fcbarcelona.es/baloncesto",10);
insert into equipo values (2,"Real Madrid","Madrid","http://www.realmadrid.com/cs/Satellite/es/1193040472450/SubhomeEquipo/Baloncesto.htm",9);
insert into equipo values (3,"P.E. Valencia","Valencia","http://valenciabasket.com",11);
insert into equipo values (4,"Caja Laboral","Vitoria","http://www.baskonia.com/es",22);
insert into equipo values (5,"Gran Canaria","Las Palmas","http://www.cbgrancanaria.net",14);
insert into equipo values (6,"CAI Zaragoza","Zaragoza","http://www.basketzaragoza.net",23);

insert into jugador values (1,"Juan Carlos","Navarro",1.91,1,"Escolta","2010-01-10",130000,1);
insert into jugador values (2,"Felipe","Reyes",2.04,2,"Pivot","2009-02-20",120000,2);
insert into jugador values (3,"Victor","Claver",2.08,3,"Alero","2009-03-08",90000,3);
insert into jugador values (4,"Rafa","Martinez",1.91,4,"Escolta","2010-11-11",51000,3);
insert into jugador values (5,"Fernando","San Emeterio",1.99,5,"Alero","2008-09-22",130000,4);
insert into jugador values (6,"Mirza","Teletovic",2.06,5,"Pivot","2010-05-13",60000,4);
insert into jugador values (7,"Sergio","Llull",1.90,2,"Escolta","2011-10-29",70000,2);
insert into jugador values (8,"Victor","Sada",1.92,1,"Base","2012-01-01",100000,1);
insert into jugador values (9,"Carlos","Suarez",2.03,2,"Alero","2010-02-19",80000,2);
insert into jugador values (10,"Xavi","Rey",2.09,10,"Pivot","2011-10-12",95000,5);
insert into jugador values (11,"Carlos","Cabezas",1.86,10,"Base","2008-01-21",105000,6);
insert into jugador values (12,"Pablo","Aguilar",2.03,10,"Alero","2012-06-14",47000,6);
insert into jugador values (13,"Rafa","Hettsheimer",2.08,10,"Pivot","2011-04-15",53000,6);
insert into jugador values (14,"Sitapha","Savané",2.01,10,"Pivot","2011-07-27",60000,5);

insert into partido values (1,2,"100-101","2011-10-10",4);
insert into partido values (2,3,"90-91","2011-11-17",5);
insert into partido values (3,4,"88-77","2011-11-23",6);
insert into partido values (1,6,"66-78","2011-11-30",6);
insert into partido values (2,4,"92-90","2012-01-12",7);
insert into partido values (4,5,"79-83","2012-01-19",3);
insert into partido values (3,6,"91-88","2012-02-22",3);
insert into partido values (5,4,"90-66","2012-04-27",2);
insert into partido values (6,5,"110-70","2012-05-30",1);



