use Yeeter;
insert into Usuario(correo, password, nombre, apellidos, fecha_nacimiento, username, biografia)
 values ('leo@uma.es', '1234', 'Leonardo', 'Bruno', '1990-01-01', 'leo2019', 'Ingeniero del software'),
 ('wan@uma.es', '1234', 'Juan', 'García Ruíz','1990-01-01', 'wan2010', 'Ingeniero del software y presidente de IAESTE informática'),
 ('pedro@uma.es', '1234', 'Pedro', 'Díaz', '1990-01-01', 'pedro2019', 'Ingeniero del software y del betis hasta la muerte!!'),
 ('parejo@uma.es', '1234', 'Jesús', 'Parejo', '1990-01-01', 'parejo2019', 'Ingeniero del software y lucentino'),
 ('alkasete@uma.es', '1234', 'Alejandro', 'Garau', '1990-01-01', 'alkasete', 'Un maricón de categoría'),
 ('pumuky@uma.es', '1234', 'Samuel', 'Jurado', '1990-01-01', 'pumuky12', 'El mendelson');



 insert into Amigos(idUsuario, idAmigo) values
 ((select id from Usuario where correo like 'leo%'), (select id from Usuario where correo like 'wan%')),
 ((select id from Usuario where correo like 'wan%'), (select id from Usuario where correo like 'leo%')),
 ((select id from Usuario where correo like 'leo%'), (select id from Usuario where correo like 'pedro%')),
 ((select id from Usuario where correo like 'pedro%'), (select id from Usuario where correo like 'leo%')),
 ((select id from Usuario where correo like 'leo%'), (select id from Usuario where correo like 'parejo%')),
 ((select id from Usuario where correo like 'parejo%'), (select id from Usuario where correo like 'leo%')),
 ((select id from Usuario where correo like 'leo%'), (select id from Usuario where correo like 'alkasete%')),
 ((select id from Usuario where correo like 'leo%'), (select id from Usuario where correo like 'pumuky%')),
 ((select id from Usuario where correo like 'pumuky%'), (select id from Usuario where correo like 'leo%'));
insert into Amigos(idUsuario, idAmigo) values
((select id from Usuario where correo like 'alkasete%'), (select id from Usuario where correo like 'wan%')),
((select id from Usuario where correo like 'wan%'), (select id from Usuario where correo like 'alkasete%')),
 ((select id from Usuario where correo like 'alkasete%'), (select id from Usuario where correo like 'leo%')),
 ((select id from Usuario where correo like 'alkasete%'), (select id from Usuario where correo like 'parejo%')),
 ((select id from Usuario where correo like 'parejo%'), (select id from Usuario where correo like 'alkasete%')),
 ((select id from Usuario where correo like 'alkasete%'), (select id from Usuario where correo like 'pumuky%')),
 ((select id from Usuario where correo like 'pumuky%'), (select id from Usuario where correo like 'alkasete%'));

insert into Amigos(idUsuario, idAmigo) values
	((select id from Usuario where correo like 'alkasete%'),(select id from Usuario where correo like 'pedro%'));



 insert into Grupo(nombre, descripcion, fecha_creacion, idCreador) values
 ('Devs In Pyjamas', 'Grupo de estudiantes de Ingeniería del software que realiza software.', '2018-09-01',
 (select id from Usuario where correo like 'pumuky%')),
 ('Yeeter Developers Group', 'Grupo para el desarrollo de la plataforma', '2019-01-20',
 (select id from Usuario where correo like 'alkasete%')),
 ("Just me lol", "literally just me", '2010-01-01', (select id from usuario where correo like 'alkasete%'));


insert into USUARIO_PERTENECE_GRUPO(idUsuario, idGrupo) values
	 ((select id from Usuario where correo like 'wan%'), (select id from grupo where nombre like 'Devs%')),
	 ((select id from Usuario where correo like 'pedro%'), (select id from grupo where nombre like 'Devs%')),
	 ((select id from Usuario where correo like 'leo%'), (select id from grupo where nombre like 'Devs%')),
	 ((select id from Usuario where correo like 'parejo%'), (select id from grupo where nombre like 'Devs%')),
	 ((select id from Usuario where correo like 'alkasete%'), (select id from grupo where nombre like 'Devs%')),
	 ((select id from Usuario where correo like 'pumuky%'), (select id from grupo where nombre like 'Devs%')),
     ((select id from Usuario where correo like 'wan%'), (select id from grupo where nombre like 'Yeeter%')),
	 ((select id from Usuario where correo like 'pedro%'), (select id from grupo where nombre like 'Yeeter%')),
	 ((select id from Usuario where correo like 'leo%'), (select id from grupo where nombre like 'Yeeter%')),
	 ((select id from Usuario where correo like 'parejo%'), (select id from grupo where nombre like 'Yeeter%')),
	 ((select id from Usuario where correo like 'alkasete%'), (select id from grupo where nombre like 'Yeeter%')),
	 ((select id from Usuario where correo like 'pumuky%'), (select id from grupo where nombre like 'Yeeter%')),
     ((select id from Usuario where correo like 'alkasete%'), (select id from grupo where nombre like 'Just%')),
     ((select id from Usuario where correo like 'pedro%'), (select id from grupo where nombre like 'Just%'))

;

insert into POST(contenido, fecha_publicacion, idAutor) values
	('Hola mundo!', '2019-01-20', (select id from usuario where correo like 'alkasete%')),
    ('Hola mundo! (me copio del @alkasete)', '2019-01-20', (select id from usuario where correo like 'pedro%')),
    ('JEJEJEJE EL ALKASET!!!', '2018-01-20', (select id from usuario where correo like 'alkasete%')),
    ('Comprobando como van las movidas de las fechas oWo', '2017-01-20', (select id from usuario where correo like 'pedro%')),
    ('Oleeee YEET 👌🏻😂💯', '2016-01-20', (select id from usuario where correo like 'wan%')),
    ('Madre mía Atenascumpo el cr7 del baloncesto', '2016-01-20', (select id from usuario where correo like 'wan%')),
    ('Literalmente vivimos... Da que pensar...', '2019-01-20', (select id from usuario where correo like 'parejo%')),
    ('POETWEET', '2016-01-20', (select id from usuario where correo like 'wan%'));
insert into POST(contenido, fecha_publicacion, idAutor, idGrupo) values
	('Hola grupo!!!', '2019-01-20', (select id from usuario where correo like 'alkasete%'), (select id from grupo where nombre like 'devs%')),
    ('Hola grupo!!!', '2019-01-20', (select id from usuario where correo like 'pedro%'), (select id from grupo where nombre like 'Yeeter%'));
insert into POST(contenido, fecha_publicacion, idAutor, idGrupo) values
('Comprobando que los emojis los soporta la BD 😂', '2010-01-20', (select id from usuario where correo like 'alkasete%'), (select id from grupo where nombre like 'Just%'));





# Realmente estas notificaciones son paria, no sirven para nada. Las notificaciones funcionan bien
# dentro de la aplicación. Esto es un prototipo de notificación. 
 insert into Notificaciones(contenido, link, idUsuario) values
 ('Wan ha comentado en tu post', 'WelcomeServlet', (select id from Usuario where correo like 'alkasete%')),
 ('Jesucristo te quiere añadir como amigo', 'WelcomeServlet', (select id from Usuario where correo like 'pedro%')),
 ('Paco maruenda ha comentado en tu perfil', 'WelcomeServlet', (select id from Usuario where correo like 'alkasete%')),
 ('JUANJOSE te quiere añadir como amigo', 'WelcomeServlet', (select id from Usuario where correo like 'alkasete%')),
 ('So excited to finally announce that I\'m sad', 'WelcomeServlet', (select id from Usuario where correo like 'alkasete%')),
 ('Pewdipie is now banned from sweden', 'WelcomeServlet', (select id from Usuario where correo like 'alkasete%'));


 insert into Mensaje(contenido, fecha, idEmisor, idReceptor) values
     ('Holaaa!!!', '2010-01-20', (select id from Usuario where correo like 'alkasete%'), ((select id from Usuario where correo like 'pedro%'))),
     ('Holaaa! qué tal? ✨', '2012-01-20', (select id from Usuario where correo like 'pedro%'), ((select id from Usuario where correo like 'alkasete%'))),
     ('Todo guay la verdad!! 😀', '2018-01-20', (select id from Usuario where correo like 'alkasete%'), ((select id from Usuario where correo like 'pedro%'))),
     ('Holaaa!!!', '2012-01-20', (select id from Usuario where correo like 'alkasete%'), ((select id from Usuario where correo like 'parejo%'))),
     ('Holaaa!!!', '2013-01-20', (select id from Usuario where correo like 'alkasete%'), ((select id from Usuario where correo like 'leo%'))),
     ('Holaaa!!!', '2014-01-20', (select id from Usuario where correo like 'alkasete%'), ((select id from Usuario where correo like 'wan%')));


insert into COMENTARIO(contenido, post, autor, fecha_publicacion) values 
	('Definitivamente, vivimos en una sociedad....',  (select id from Post where contenido like '%Literalmente vivimos...%'), 5, '2019-01-20'),
    ('Madre mía qué razón tienes... Fijo que se lleva un anillo!!!', (select id from Post where contenido like '%Atenascumpo%'), 5, '2019-01-20'),
    ('borra borra XD', (select id from post where contenido like 'POETWEET'), 5, '2018-03-20'),
    ('WEEDNESDAY lml', 2009, 5, '2018-03-20'),
    ('ASí es jefa, practico el ASMR', 2001, 5, '2019-02-02');
