use bd_colegios;
select * from usuario where activo = true;
delete from usuario where id_usuario = 8;
select * from usuario;

select * from rol;

select usuario.nombre_usuario,
       usuario.nombre,
       usuario.apellido,
       usuario.email,
       usuario.telefono,
       usuario.fecha_nacimiento,
       rol.tipo_usuario
       from usuario INNER JOIN usuario_rol
    ON usuario.id_usuario = usuario_rol.fk_id_usuario
      INNER JOIN rol ON usuario_rol.fk_id_rol = rol.id_rol where rol.tipo_usuario = 'SUPER_ADMIN';

select usuario.nombre_usuario,
       rol.tipo_usuario
    from usuario
    INNER JOIN usuario_rol
        ON usuario.id_usuario = usuario_rol.fk_id_usuario
    INNER JOIN rol
        ON usuario_rol.fk_id_rol = rol.id_rol where rol.tipo_usuario = 'ALUMNO';

select rol.id_rol,
       rol.tipo_usuario
from usuario INNER JOIN usuario_rol
    ON usuario.id_usuario = usuario_rol.fk_id_usuario
INNER JOIN rol ON usuario_rol.fk_id_rol = rol.id_rol WHERE usuario.nombre_usuario = 'Maria';

select * from usuario_rol where fk_id_usuario = 2;

select * from pagos;
select * from detalle_mes;
select * from detalle_pago;
select * from detalle_pago_mes;

select * from detalle_mes where detalle_mes.id_mes = 1;
select * from usuario;


-- para validar meses pagados por usuario
select u.nombre,
        p.tipo_pago,
        de.fecha_pago,
        (de.total / (SELECT COUNT(*)
        FROM detalle_pago_mes dpm2
        WHERE dpm2.fk_id_detalle_pago = de.id_detalle_pago)) AS total_por_mes,
        de.fecha_pago,
        dm.nombre_mes
from usuario u INNER JOIN detalle_pago de
                    ON u.id_usuario = de.fk_id_usuario
                INNER JOIN detalle_pago_mes dpm
                    ON de.id_detalle_pago = dpm.fk_id_detalle_pago
                INNER JOIN detalle_mes dm
                    ON dpm.fk_id_mes = dm.id_mes
                INNER JOIN pagos p
                    ON de.fk_id_pago = p.id_pago where u.id_usuario = 1;

-- VALIDAR MESES PAGADOS POR USUARIO
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
                          
select usuario.nombre_usuario,
	   detalle_mes.nombre_mes
	   from usuario 
	inner join detalle_pago 
		on detalle_pago.fk_id_usuario = usuario.id_usuario
	inner join detalle_mes where detalle_pago_mes.pagado = true;
    
    select  detalle_mes.nombre_mes
		from usuario 
			inner join detalle_pago 
				on usuario.id_usuario = detalle_pago.fk_id_usuario
			inner join detalle_pago_mes 
				on detalle_pago.id_detalle_pago = detalle_pago_mes.fk_id_detalle_pago
			inner join detalle_mes 
				on detalle_pago_mes.fk_id_mes = detalle_mes.id_mes
			where usuario.nombre_usuario = 'Gabo';
            
-- FIN DE VALIDAR MESES PAGADOS POR USUARIO
            

-- VALIDAR PAGADOS EXTRA POR USUARIO
	select * from pago_extra;
    
    select * from detalle_pago 
		inner join usuario 
			on detalle_pago.fk_id_usuario = usuario.id_usuario
            where usuario.nombre_usuario = 'Gabo';
            
            select * from detalle_pago;
            select * from usuario;
    

-- FIN VALIDAR PAGADOS EXTRA POR USUARIO

            
            select * from usuario;
		
    select * from detalle_pago;
    select * from detalle_pago_mes;

select * from materia order by id_materia;

select  materia.id_materia,
		grado.grado,
		seccion.seccion,
        especialidad.nombre_especialidad,
        materia.nombre_materia
 from grado_academico_materia 
	inner join materia 
		on grado_academico_materia.fk_id_materia = materia.id_materia
    inner join grado_academico 
		on grado_academico_materia.fk_id_grado_academico = grado_academico.id_grado_academico
	inner join grado
		on grado_academico.fk_id_grado = grado.id_grado
	inner join seccion 
		on grado_academico.fk_id_seccion = seccion.id_seccion
	inner join especialidad
		on grado_academico.fk_id_especialidad = especialidad.id_especialidad
        order by id_materia;
        
        select * from grado_academico_materia;
        
select * from alumno 
	inner join inscripcion 
		on alumno.id_alumno = inscripcion.fk_id_alumno
	inner join grado_academico 
		on inscripcion.fk_id_grado_academico = grado_academico.id_grado_academico
	inner join grado_academico_materia
		on grado_academico.id_grado_academico = grado_academico_materia.fk_id_grado_academico;
        
select * from usuario;