use Yeeter;


## Feed de los usuarios (aka todos los posts de amigos, grupos y posts tuyos (no hay repetidos bc teoría de conjuntos baby))
select * from (
select * from Post where idAutor = (select id from usuario where correo like 'alkasete%')

union

select * from Post where idGrupo in (Select Grupo.id from Grupo Left Join USUARIO_PERTENECE_GRUPO ON Grupo.id = USUARIO_PERTENECE_GRUPO.idGrupo Left Join
 Usuario ON Usuario.id = USUARIO_PERTENECE_GRUPO.idUsuario where usuario.id = (select id from usuario where correo like 'alkasete%'))

 union

 select * from Post where idAutor in (select idAmigo from Amigos left join usuario on amigos.idAmigo = Usuario.id))
 xd order by xd.fecha_publicacion desc
 ;


select * from (
select * from Post where idAutor = (select id from usuario where correo like 'alkasete%')

union

select * from Post where idGrupo in (Select Grupo.id from Grupo Left Join USUARIO_PERTENECE_GRUPO ON Grupo.id = USUARIO_PERTENECE_GRUPO.idGrupo Left Join
 Usuario ON Usuario.id = USUARIO_PERTENECE_GRUPO.idUsuario where usuario.id = (select id from usuario where correo like 'alkasete%'))

 union

 select * from Post where idAutor in (select idAmigo from Amigos left join usuario on amigos.idAmigo = Usuario.id))
 xd order by xd.fecha_publicacion desc
 ;

# grupos a los que pertenece un usuario.
Select * from Grupo Left Join USUARIO_PERTENECE_GRUPO ON Grupo.id = USUARIO_PERTENECE_GRUPO.idGrupo Left Join
 Usuario ON Usuario.id = USUARIO_PERTENECE_GRUPO.idUsuario where usuario.id = (select id from usuario where correo like 'alkasete%');
 Select * from Grupo left join USUARIO_PERTENECE_GRUPO on grupo.id = USUARIO_PERTENECE_GRUPO.idGrupo where USUARIO_PERTENECE_GRUPO.idUsuario = 5;


 select * from Post where idAutor in (select idAmigo from Amigos where (select id from Usuarios where email like 'alkasete%') = Usuario.id);

  select * from Amigos inner join Usuario on Amigos.idUsuario = Usuario.id;
  select * from Amigos inner join Usuario on Amigos.idAmigo = Usuario.id;




  select * from Notificaciones inner join usuario on Notificaciones.idUsuario = usuario.id;


  select * from Mensaje where (idEmisor = 5 and idReceptor = 3) or (idReceptor = 5 and idEmisor = 3);
  
  
  select * from Usuario;

select * from Peticion_amistad;