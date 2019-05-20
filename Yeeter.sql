drop database if exists Yeeter;
create schema Yeeter;
use Yeeter;

drop table if exists USUARIO;
create table USUARIO (
    id int AUTO_INCREMENT primary key,
    correo varchar(255) unique not null,
    password varchar(64) not null,
    nombre varchar(255) not null,
    apellidos varchar(255) not null,
    fecha_nacimiento date not null,
    username varchar(64) unique not null,
    biografia varchar(564)
)ENGINE = InnoDB;

drop table if exists GRUPO;
create table GRUPO (
    id int AUTO_INCREMENT primary key,
    nombre varchar(255) not null,
    descripcion varchar(255),
    fecha_creacion timestamp not null,
    idCreador int not null,
    FOREIGN KEY (idCreador) REFERENCES USUARIO(id)
)ENGINE = InnoDB;

drop table if exists POST;
create table POST (
    id int AUTO_INCREMENT primary key,
    contenido varchar(255) not null,
    fecha_publicacion timestamp not null,
    idAutor int not null,
    idGrupo int,
    FOREIGN KEY (idAutor) REFERENCES USUARIO(id),
    FOREIGN KEY (idGrupo) REFERENCES GRUPO(id)
)ENGINE = InnoDB;

drop table if exists MENSAJE;
create table MENSAJE (
    id int AUTO_INCREMENT primary key,
    contenido varchar(255) not null,
    fecha datetime not null,
    idEmisor int not null,
    idReceptor int not null,
    constraint idEmisor_FK
    foreign key (idEmisor) references USUARIO(id),
    constraint idReceptor_FK
    foreign key (idReceptor) references USUARIO(id)
)ENGINE = InnoDB;

drop table if exists NOTIFICACIONES;
create table NOTIFICACIONES (
    id int AUTO_INCREMENT primary key,
    contenido varchar(255) not null,
    link varchar(255) not null,
    notificacionLeida bit not null default false,
    idUsuario int not null,
    FOREIGN KEY (idUsuario) REFERENCES USUARIO(id)
)ENGINE = InnoDB;

create table COMENTARIO (
	id int auto_increment primary key,
    contenido varchar(1024) not null,
    autor int not null,
    post int not null,
    fecha_publicacion timestamp not null,
    constraint Comentario_Autor_FK
    foreign key (autor) references USUARIO(id),
    constraint Post_FK
    foreign key (post) references Post(id)
)ENGINE = InnoDB;

drop table if exists PETICION_AMISTAD;
create table PETICION_AMISTAD(
    usuarioEmisor int not null,
    usuarioReceptor int not null,
    mensaje varchar(255),
    PRIMARY KEY (usuarioEmisor, usuarioReceptor),
    constraint PeticionAmistad_Emisor
        Foreign Key (usuarioEmisor)
        references USUARIO (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    constraint PeticionAmistad_Receptor
        foreign key (usuarioReceptor)
        references USUARIO (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE = InnoDB;


drop table if exists AMIGOS;
create table AMIGOS(
    idUsuario int not null,
    idAmigo int not null,
    primary key (idUsuario, idAmigo),
    constraint idUsuario_FK
        Foreign key (idUsuario)
        references USUARIO (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    constraint idAmigo_FK
        Foreign key (idAmigo)
        references USUARIO (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE = InnoDB;

drop TABLE if EXISTS USUARIO_PERTENECE_GRUPO;
CREATE TABLE USUARIO_PERTENECE_GRUPO(
  idUsuario int not null,
  idGrupo int not null,
  PRIMARY KEY(idUsuario,idGrupo),
  CONSTRAINT idUsuario_FK1
  Foreign key (idUsuario)
  references USUARIO (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
constraint idGrupo_FK
  Foreign key (idGrupo)
  references GRUPO (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  )ENGINE = InnoDB;




-- id inicial de los objetos que se van a introducir en la BD
ALTER TABLE USUARIO AUTO_INCREMENT=0;
ALTER TABLE GRUPO AUTO_INCREMENT=1000;
ALTER TABLE POST AUTO_INCREMENT=2000;
ALTER TABLE MENSAJE AUTO_INCREMENT=3000;
ALTER TABLE NOTIFICACIONES AUTO_INCREMENT=4000;
alter table COMENTARIO Auto_increment=10000;
