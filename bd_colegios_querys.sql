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
      INNER JOIN rol ON usuario_rol.fk_id_rol = rol.id_rol where rol.tipo_usuario = 'ADMIN';

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
        
        
        
        select * from materia 
        inner join grado_academico_materia 
			on materia.id_materia = grado_academico_materia.fk_id_materia
		inner join grado_academico 
			on grado_academico.id_grado_academico = grado_academico_materia.fk_id_grado_academico
		inner join inscripcion 
			on inscripcion.fk_id_grado_academico = grado_academico.id_grado_academico;
            
            
SELECT 
    a.id_alumno,
    a.codigo_alumno,
    CONCAT(u.nombre, ' ', u.apellido) AS nombre_alumno,
    g.grado AS grado,
    e.nombre_especialidad AS especialidad,
    s.seccion AS seccion,
    ce.anio AS ciclo_escolar,
    m.nombre_materia AS materia
FROM alumno a
INNER JOIN usuario u 
    ON u.id_usuario = a.fk_id_usuario
INNER JOIN inscripcion i 
    ON i.fk_id_alumno = a.id_alumno
INNER JOIN grado_academico ga 
    ON ga.id_grado_academico = i.fk_id_grado_academico
INNER JOIN grado g 
    ON g.id_grado = ga.fk_id_grado
INNER JOIN especialidad e 
    ON e.id_especialidad = ga.fk_id_especialidad
INNER JOIN seccion s 
    ON s.id_seccion = ga.fk_id_seccion
INNER JOIN ciclo_escolar ce 
    ON ce.id_ciclo_escolar = ga.fk_id_ciclo_escolar
INNER JOIN grado_academico_materia gam 
    ON gam.fk_id_grado_academico = ga.id_grado_academico
INNER JOIN materia m 
    ON m.id_materia = gam.fk_id_materia
WHERE i.inscripcion_activa = TRUE
ORDER BY 
    a.id_alumno, 
    m.nombre_materia;
    
    SELECT 
    i.id_inscripcion,
    i.fk_id_grado_academico AS ga_en_inscripcion,
    i.inscripcion_activa,
    ga.id_grado_academico AS ga_en_tabla,
    ga.activo AS ga_activo
FROM inscripcion i
LEFT JOIN grado_academico ga 
    ON ga.id_grado_academico = i.fk_id_grado_academico;


