use cursos;

drop table if exists requisitos;
drop table if exists asistentes;
drop table if exists edicion;
drop table if exists empleado;
drop table if exists curso;

create table curso(
	idCurso smallint unsigned not null,
	nombre varchar(30) not null,
	coste MEDIUMINT unsigned not null,
	descr varchar(50) not null,
	horas smallint unsigned not null,
	primary key(idCurso)
);

create table empleado(
	idEmpleado smallint unsigned not null,
	nombre varchar(30) not null,
	direccion varchar(50) not null,
	nif char(15) not null,
	genero char(1) not null default 'F',
	tlf char(15) not null,
	fNac date not null,
	capacitado tinyint(1) default 0,	
	primary key (idEmpleado),
	unique key (nombre)
);

create table edicion(
	curso smallint unsigned not null,
	fecha date not null,
	horario char(1) default 'T',
	lugar char(10),
	profesor smallint unsigned not null,
	primary key (curso, fecha),
	foreign key (curso) references curso(idCurso) on update cascade,
	foreign key (profesor) references empleado(idEmpleado) on update cascade
);

create table asistentes(
	empleado smallint unsigned not null,
	cursoEd smallint unsigned not null,
	fechaEd date not null,
	primary key (empleado, cursoEd, fechaEd),
	foreign key (empleado) references empleado(idEmpleado) on update cascade,
	foreign key (cursoEd, fechaEd) references edicion(curso, fecha) on update cascade
);


create table requisitos(
	codCurso smallint unsigned not null,
	cursoRequerido smallint unsigned not null,
	foreign key (codCurso) references curso(idCurso) on update cascade,
	foreign key (cursoRequerido) references curso(idCurso) on update cascade
);
