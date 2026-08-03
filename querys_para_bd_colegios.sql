CREATE DATABASE IF NOT EXISTS bd_ined_cuchilla;
USE bd_ined_cuchilla;

select * from usuario;
select * from alumno;
select * from rol;
select * from grado where seccion = 'B';
delete from grado where grado.id_grado = 8;
select * from grado;

update grado
set especialidad = 'MECANICA'
WHERE grado.id_grado = 6;

select * from usuario;


select * from usuario u INNER JOIN alumno a ON u.id_usuario = a.fk_id_usuario;

SELECT u.nombre, u.nombre_usuario, a.genero FROM usuario u INNER JOIN alumno a ON u.id_usuario = a.fk_id_usuario WHERE u.nombre_usuario = 'A123XYZ';

select * from usuario where usuario.nombre  = 'CARLOS ANDRÉS';
select * from usuario where usuario.id_usuario =2;

select * from rol;

INSERT INTO usuario_rol (fk_id_usuario, fk_id_rol) VALUES (1, 4);
select * from usuario_rol;


select u.nombre_usuario, u.nombre, u.telefono, u.email, r.tipo_usuario from usuario u
    INNER JOIN usuario_rol ur ON u.id_usuario = ur.fk_id_usuario
    INNER JOIN rol r ON ur.fk_id_rol = r.id_rol
                                                 where r.tipo_usuario = 'MAESTRO';

select u.nombre, u.apellido, u.telefono, u.email, a.codigo_alumno, g.especialidad, g.nombre_grado, g.seccion from usuario u
INNER JOIN usuario_rol ur ON u.id_usuario = ur.fk_id_usuario
INNER JOIN rol r ON ur.fk_id_rol = r.id_rol
INNER JOIN alumno a ON u.id_usuario = a.fk_id_usuario
INNER JOIN grado g ON a.fk_id_grado = g.id_grado
where r.tipo_usuario = 'ALUMNO' AND u.nombre LIKE '%';

select u.nombre, u.email, r.tipo_usuario from usuario u
        INNER JOIN usuario_rol ur ON u.id_usuario = ur.fk_id_usuario
        INNER JOIN rol r ON ur.fk_id_rol = r.id_rol;





select * from ROL;

select * from usuario where id_usuario = 1;

select * from usuario;
select * from alumno;
select * from grado;
select * from maestro;
select * from pagos;
SELECT * FROM detalle_mes;

insert into maestro values (8,'COD-8', 1);

update usuario
set usuario.activo = false where usuario.id_usuario = 30;

select u.nombre_usuario,
                       p.tipo_pago,
                     de.pagado,
                      dm.id_mes,
                      dm.nombre_mes
                from usuario u INNER JOIN detalle_pago de
                                          ON u.id_usuario = de.fk_id_usuario
                               INNER JOIN detalle_pago_mes dpm
                                         ON de.id_detalle_pago = dpm.fk_id_detalle_pago
                               INNER JOIN detalle_mes dm
                                          ON dpm.fk_id_mes = dm.id_mes
                               INNER JOIN pagos p
                                          ON de.fk_id_pago = p.id_pago where u.id_usuario = 1;