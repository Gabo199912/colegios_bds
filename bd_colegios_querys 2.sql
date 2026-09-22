use bd_colegios;
select * from usuario where activo = true;
delete from usuario where id_usuario = 8;

select * from rol;
select * from usuario;

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

-- -------------------------------------PARTE DE PAGOS--------------------------------
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
                    ON de.fk_id_pago = p.id_pago;
                    
select * from usuario where usuario.nombre = 'byron fernando';

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

select * from usuario;
select * from grado_academico;

select * from ciclo_escolar;

insert into ciclo_escolar values (2,2027,true), (3,2028,true);



-- -------------------------------------PARTE DE ALUMNOS--------------------------------
-- BUSCAR LOS GRADOS ACADEMICOS. 
 SELECT
	ga.id_grado_academico,
	g.grado,
	e.nombre_especialidad AS nombreEspecialidad,
	s.seccion as especialidad 
 from grado_academico ga 
	INNER JOIN especialidad e
		ON ga.fk_id_especialidad = e.id_especialidad
	INNER JOIN seccion s
		ON ga.fk_id_seccion = s.id_seccion
	INNER JOIN grado g
		ON ga.fk_id_grado = g.id_grado where grado = 'CUARTO' AND nombre_especialidad = 'COMPUTACION';
        
        
SELECT
	ga.id_grado_academico,
	g.grado,
    s.seccion,
	e.nombre_especialidad AS nombreEspecialidad,
	s.seccion as especialidad 
 from grado_academico ga 
	INNER JOIN especialidad e
		ON ga.fk_id_especialidad = e.id_especialidad
	INNER JOIN seccion s
		ON ga.fk_id_seccion = s.id_seccion
	INNER JOIN grado g
		ON ga.fk_id_grado = g.id_grado
    where grado = 'CUARTO' AND nombre_especialidad = 'COMPUTACION' AND seccion = 'A';
    
SELECT
	ga.id_grado_academico,
    ga.fk_id_grado,
    ga.fk_id_especialidad,
    ga.fk_id_seccion,
    ga.fk_id_ciclo_escolar,
    ga.activo
    from grado_academico ga 
	INNER JOIN especialidad e
		ON ga.fk_id_especialidad = e.id_especialidad
	INNER JOIN seccion s
		ON ga.fk_id_seccion = s.id_seccion
	INNER JOIN grado g
		ON ga.fk_id_grado = g.id_grado
    where grado = 'CUARTO' AND nombre_especialidad = 'COMPUTACION' AND seccion = 'A';
        
        
select a.id_alumno, a.codigo_alumno, u.nombre, u.apellido, u.email from usuario u 
	INNER JOIN alumno a 
		ON u.id_usuario = a.fk_id_usuario
	INNER JOIN usuario_rol ur ON u.id_usuario = ur.fk_id_usuario
    INNER JOIN rol r ON ur.fk_id_rol = r.id_rol where r.tipo_usuario = 'ALUMNO' order by id_alumno;
    
    
-- VALIDAR A QUE GRADO ESTA ASIGNADO CADA ALUMNO
SELECT usuario.id_usuario,
	   usuario.nombre_usuario,
	   usuario.email,
       alumno.codigo_alumno,
       grado.grado,
       especialidad.nombre_especialidad,
       seccion.seccion
       FROM usuario 
	inner join alumno
		on usuario.id_usuario = alumno.fk_id_usuario
	inner join inscripcion
		on alumno.id_alumno = inscripcion.fk_id_alumno
	inner join grado_academico
		on grado_academico.id_grado_academico = inscripcion.fk_id_grado_academico
	inner join grado
		on grado_academico.fk_id_grado = grado.id_grado
	inner join especialidad
		on grado_academico.fk_id_especialidad = especialidad.id_especialidad
	inner join seccion
		on grado_academico.fk_id_seccion = seccion.id_seccion order by usuario.id_usuario;
        
        
select grado_academico.id_grado_academico,
	   ciclo_escolar.anio,
       ciclo_escolar.activo
		from grado_academico
	inner join ciclo_escolar
		on grado_academico.fk_id_ciclo_escolar = ciclo_escolar.id_ciclo_escolar;
        
        select * from inscripcion;
    
    
select * from usuario inner join alumno 
on usuario.id_usuario = alumno.fk_id_usuario
inner join inscripcion on alumno.id_alumno = inscripcion.fk_id_alumno
inner join grado_academico on inscripcion.fk_id_grado_academico = grado_academico.id_grado_academico;
    
-- v-------------------------------------PARTE DE MATERIAS--------------------------------
-- BUSCAR LOS DATOS SOLICITADOS COMO MATEERIA Y SECCION .
select * from grado where grado.grado like '%cuarto%';

select grado_academico.id_grado_academico,
	   grado.grado,
	   especialidad.nombre_especialidad as nombreEspecialidad,
       seccion.seccion
       from grado_academico 
	inner join grado 
		on grado_academico.fk_id_grado = grado.id_grado
	inner join especialidad 
		on grado_academico.fk_id_especialidad = especialidad.id_especialidad
	inner join seccion
		on grado_academico.fk_id_seccion = seccion.id_seccion
	where especialidad.nombre_especialidad = 'computacion' and grado.grado = 'cuarto';
    
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
        



    



