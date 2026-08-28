DROP DATABASE IF EXISTS bd_colegios;
CREATE DATABASE IF NOT EXISTS bd_colegios;
USE bd_colegios;


-- =========================
-- TABLA ROL
-- =========================

CREATE TABLE rol (
                     id_rol INT AUTO_INCREMENT PRIMARY KEY,
                     tipo_usuario VARCHAR(50) NOT NULL UNIQUE,
                     estado BOOLEAN DEFAULT TRUE,
                     descripcion VARCHAR(100)
);

INSERT INTO rol (tipo_usuario, estado, descripcion)
VALUES
    ('SUPER_ADMIN', true, 'rol para el desarrollador'),
    ('ADMIN', true, 'rol arriba del director, aunque comparten muchas cosas'),
    ('MAESTRO', true, 'rol unicamente para los maestros'),
    ('ALUMNO', true, 'unicamente para el alumno'),
    ('DIRECTOR', true, 'para el director del establecimiento');



-- =========================
-- TABLA USUARIO
-- =========================
CREATE TABLE usuario (
                         id_usuario INT AUTO_INCREMENT PRIMARY KEY,
                         nombre_usuario VARCHAR(40) NOT NULL UNIQUE,
                         nombre VARCHAR(50) NOT NULL,
                         apellido VARCHAR(50) NOT NULL,
                         email VARCHAR(100) NOT NULL UNIQUE,
                         telefono VARCHAR(25),
                         activo TINYINT(1) DEFAULT 1 NOT NULL,
                         fecha_nacimiento DATE NOT NULL,
                         contrasenia VARCHAR(255) NOT NULL

);


-- =========================
-- TABLA USUARIO ROL
-- =========================
CREATE TABLE usuario_rol (
                             id_usuario_rol INT AUTO_INCREMENT PRIMARY KEY,

                             fk_id_usuario INT NOT NULL,
                             fk_id_rol INT NOT NULL,

                             UNIQUE (fk_id_usuario, fk_id_rol),

                             FOREIGN KEY (fk_id_usuario)
                                 REFERENCES usuario(id_usuario),

                             FOREIGN KEY (fk_id_rol)
                                 REFERENCES rol(id_rol)
);




-- =========================
-- TABLA PAGOS
-- =========================
CREATE TABLE pagos (
                       id_pago INT AUTO_INCREMENT PRIMARY KEY,
                       activo BOOLEAN NOT NULL DEFAULT TRUE,
                       tipo_pago VARCHAR(50) NOT NULL
);

INSERT INTO pagos (activo, tipo_pago)
VALUES
    (1, 'Efectivo'),
    (1, 'Transferencia');


CREATE TABLE pago_extra (
                              id_pago_extra INT AUTO_INCREMENT PRIMARY KEY,
                              tipo_pago VARCHAR(100) NOT NULL NOT NULL,
                              pago_vigente BOOLEAN DEFAULT TRUE
);

INSERT INTO pago_extra (tipo_pago)
VALUES
    ('INSCRIPCIONES'),
    ('EXCURSIONES'),
    ('CARNET'),
    ('EXAMENES'),
    ('OTROS');

-- =========================================
-- TABLA DETALLE PAGO
-- =========================================
CREATE TABLE detalle_pago
(
    id_detalle_pago INT AUTO_INCREMENT PRIMARY KEY,

    total DECIMAL(10,2) NOT NULL,
    descripcion VARCHAR(100),

    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,

    pagado TINYINT(1) DEFAULT 0,

    fk_id_usuario INT NOT NULL,
    fk_id_pago INT NOT NULL,
    fk_id_pago_extra INT NULL,

    FOREIGN KEY (fk_id_usuario)
        REFERENCES usuario(id_usuario),

    FOREIGN KEY (fk_id_pago)
        REFERENCES pagos(id_pago),

    FOREIGN KEY (fk_id_pago_extra)
        REFERENCES pago_extra(id_pago_extra)

);


-- =========================================
-- TABLA DE DETALLE MESES
-- =========================================

create table detalle_mes
(
    id_mes int auto_increment primary key,

    nombre_mes varchar(20) not null,
    anio int not null,

    fecha_inicio date,
    fecha_fin date,

    activo tinyint(1) default 1,

    unique(nombre_mes, anio)
);

insert into detalle_mes
(nombre_mes, anio, fecha_inicio, fecha_fin)
values
    ('Enero', 2026, '2026-01-01', '2026-01-31'),
    ('Febrero', 2026, '2026-02-01', '2026-02-28'),
    ('Marzo', 2026, '2026-03-01', '2026-03-31'),
    ('Abril', 2026, '2026-04-01', '2026-04-30'),
    ('Mayo', 2026, '2026-05-01', '2026-05-31'),
    ('Junio', 2026, '2026-06-01', '2026-06-30'),
    ('Julio', 2026, '2026-07-01', '2026-07-31'),
    ('Agosto', 2026, '2026-08-01', '2026-08-31'),
    ('Septiembre', 2026, '2026-09-01', '2026-09-30'),
    ('Octubre', 2026, '2026-10-01', '2026-10-31'),
    ('Noviembre', 2026, '2026-11-01', '2026-11-30'),
    ('Diciembre', 2026, '2026-12-01', '2026-12-31');



-- =========================================
-- TABLA DETALLE PAGO MES
-- =========================================

create table detalle_pago_mes(
                                 id_detalle_pago_mes int auto_increment primary key,
                                 fk_id_mes int,
                                 fk_id_detalle_pago int,

                                 FOREIGN KEY (fk_id_mes) REFERENCES detalle_mes(id_mes),
                                 FOREIGN KEY (fk_id_detalle_pago) REFERENCES detalle_pago(id_detalle_pago)
);

-- =========================
-- TABLA MAESTRO
-- =========================
CREATE TABLE maestro (
                         id_maestro INT AUTO_INCREMENT PRIMARY KEY,
                         codigo_empleado VARCHAR(20) UNIQUE,
                         fk_id_usuario INT NOT NULL UNIQUE,
                         FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario)
);


-- =========================
-- TABLA MATERIA
-- =========================
create table materia(
                        id_materia INT PRIMARY KEY AUTO_INCREMENT,
                        nombre_materia VARCHAR(200) UNIQUE NOT NULL
);


-- =========================
-- TABLA MAESTRO MATERIA
-- =========================
create table maestro_materia(
                                id_maestro_materia int primary key auto_increment,
                                fk_id_maestro INT NOT NULL ,
                                fk_id_materia INT NOT NULL ,

                                UNIQUE(fk_id_maestro,fk_id_materia),

                                FOREIGN KEY (fk_id_materia) REFERENCES materia(id_materia),
                                FOREIGN KEY (fk_id_maestro) REFERENCES maestro(id_maestro)
);



-- =========================
-- TABLA ENCARGADO
-- =========================
CREATE TABLE encargado (
                           id_encargado INT AUTO_INCREMENT PRIMARY KEY,
                           nombre VARCHAR(50) NOT NULL,
                           apellido VARCHAR(50) NOT NULL,
                           tipo_familiar VARCHAR(50) NOT NULL,
                           telefono VARCHAR(25) NOT NULL,
                           email VARCHAR(100) NOT NULL UNIQUE
);


-- =========================
-- TABLA ALUMNO
-- =========================
CREATE TABLE alumno (
                        id_alumno INT AUTO_INCREMENT PRIMARY KEY,
                        codigo_alumno VARCHAR(30) NOT NULL UNIQUE,
                        genero VARCHAR(15) NOT NULL,
                        activo TINYINT(1) DEFAULT 1 NOT NULL,
                        fk_id_usuario INT NOT NULL,

                        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- =========================
-- TABLA ALUMNO_ENCARGADO
-- =========================
CREATE TABLE alumno_encargado (
                                  id_alumno_encargado INT AUTO_INCREMENT PRIMARY KEY,
                                  parentesco VARCHAR(50) NOT NULL,
                                  principal TINYINT(1) DEFAULT 0 NOT NULL,
                                  fk_id_alumno INT NOT NULL,
                                  fk_id_encargado INT NOT NULL,

                                  UNIQUE (fk_id_alumno, fk_id_encargado),

                                  FOREIGN KEY (fk_id_alumno) REFERENCES alumno(id_alumno),
                                  FOREIGN KEY (fk_id_encargado) REFERENCES encargado(id_encargado)
);

-- =========================
-- TABLA GRADO
-- =========================
create table grado(
                      id_grado INT PRIMARY KEY AUTO_INCREMENT,
                      grado VARCHAR(40) UNIQUE NOT NULL
);

INSERT INTO grado VALUES
                      (1, 'CUARTO'), (2, 'QUINTO');
-- =========================
-- TABLA especialidad
-- =========================
create table especialidad(
                             id_especialidad INT PRIMARY KEY AUTO_INCREMENT,
                             nombre_especialidad VARCHAR(30) UNIQUE NOT NULL
);

insert into especialidad VALUES
                             (1,'COMPUTACION'),
                             (2, 'MECANICA');

-- =========================
-- TABLA SECCION
-- =========================
create table seccion(
                        id_seccion INT PRIMARY KEY AUTO_INCREMENT,
                        seccion VARCHAR(3) UNIQUE NOT NULL
);

insert into seccion values
                        (1, 'A'),
                        (2, 'B'),
                        (3, 'C');



-- =========================
-- TABLA CICLO ESCOLAR
-- =========================
create table ciclo_escolar(
                              id_ciclo_escolar INT PRIMARY KEY AUTO_INCREMENT,
                              anio INT UNIQUE,
                              activo BOOLEAN DEFAULT TRUE
);

insert into ciclo_escolar values (1, 2026, true), (2, 2027, true), (3,2028, true);




-- =========================
-- TABLA GRADO ACADEMICO
-- =========================
create table grado_academico(
                                id_grado_academico INT PRIMARY KEY AUTO_INCREMENT,
                                fk_id_grado INT NOT NULL ,
                                fk_id_especialidad INT NOT NULL ,
                                fk_id_seccion INT NOT NULL ,
                                fk_id_ciclo_escolar INT NOT NULL ,
                                activo boolean DEFAULT true,

                                FOREIGN KEY (fk_id_grado) REFERENCES grado(id_grado) ,
                                FOREIGN KEY (fk_id_especialidad) REFERENCES especialidad(id_especialidad),
                                FOREIGN KEY (fk_id_seccion) REFERENCES seccion(id_seccion),
                                FOREIGN KEY (fk_id_ciclo_escolar) REFERENCES ciclo_escolar(id_ciclo_escolar),

                                    CONSTRAINT uk_grado_especialidad_seccion
                                    UNIQUE(fk_id_grado, fk_id_especialidad, fk_id_seccion, fk_id_ciclo_escolar)
);

INSERT INTO grado_academico (fk_id_grado, fk_id_especialidad, fk_id_seccion, fk_id_ciclo_escolar) VALUES
(1, 1, 1, 1), (1, 1, 2, 1), (1, 1, 3, 1), (1, 2, 1, 1), (1, 2, 2, 1), (1, 2, 3, 1), (2, 1, 1, 1), (2, 1, 2, 1), (2, 1, 3, 1), (2, 2, 1, 1), (2, 2, 2, 1), (2, 2, 3, 1);

-- =========================
-- INSCRIPCION
-- =========================
CREATE TABLE inscripcion(
	id_inscripcion INT PRIMARY KEY AUTO_INCREMENT,
    fk_id_grado_academico INT NOT NULL,
    fk_id_alumno INT NOT NULL, 
    inscripcion_activa BOOLEAN DEFAULT TRUE, 
    fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    
    FOREIGN KEY (fk_id_grado_academico) REFERENCES grado_academico (id_grado_academico),
    FOREIGN KEY (fk_id_alumno) REFERENCES alumno (id_alumno)
);


-- =========================
-- NOTA
-- =========================
  CREATE TABLE grado_academico_materia (
    id_grado_academico_materia INT PRIMARY KEY AUTO_INCREMENT,

    fk_id_grado_academico INT NOT NULL,
    fk_id_materia INT NOT NULL,

    FOREIGN KEY (fk_id_grado_academico)
        REFERENCES grado_academico(id_grado_academico),

    FOREIGN KEY (fk_id_materia)
        REFERENCES materia(id_materia),

    UNIQUE (fk_id_grado_academico, fk_id_materia)
);



-- =========================
-- TABLA BIMESTRE
-- =========================
CREATE TABLE bimestre (
                          id_bimestre INT AUTO_INCREMENT PRIMARY KEY,
                          nombre_bimestre VARCHAR(25) NOT NULL,
                          fecha_inicio DATE NOT NULL,
                          fecha_finalizacion DATE NOT NULL,
                          activo TINYINT(1) DEFAULT 1 NOT NULL,
                          fk_id_ciclo_escolar INT,

                          FOREIGN KEY (fk_id_ciclo_escolar) REFERENCES ciclo_escolar(id_ciclo_escolar)
);

-- =========================
-- NOTA
-- =========================
CREATE TABLE nota(
	id_nota INT PRIMARY KEY AUTO_INCREMENT,
    fk_id_bimestre INT NOT NULL,
    fk_id_materia INT NOT NULL,
    fk_id_alumno INT NOT NULL,
    nota DOUBLE,
    descripcion VARCHAR(100),
    
    FOREIGN KEY (fk_id_bimestre) REFERENCES bimestre(id_bimestre),
    FOREIGN KEY (fk_id_materia) REFERENCES materia(id_materia),
    FOREIGN KEY (fk_id_alumno) REFERENCES alumno(id_alumno)
  );

INSERT INTO materia (nombre_materia) VALUES
('Lengua y Literatura 4'),
('Matemáticas 4'),
('Ciencias Sociales y Formación Ciudadana 4'),
('Física'),
('Educación Física'),
('Expresión Artística'),
('Filosofía'),
('Comunicación y Lenguaje L3 (Inglés Técnico) 4'),
('Computación Aplicada'),
('Laboratorio I'),
('Sistemas e Instalación de Software'),
('Contabilidad');

INSERT INTO materia (nombre_materia) VALUES
('Lengua y Literatura 5'),
('Matemáticas 5'),
('Estadística Descriptiva'),
('Ciencias Sociales y Formación Ciudadana 5'),
('Química'),
('Biología'),
('Ética Profesional y Relaciones Humanas'),
('Comunicación y Lenguaje L3 (Inglés Técnico) 5'),
('Producción de Contenidos Digitales'),
('Laboratorio II'),
('Reparación y Soporte Técnico'),
('Seminario'),
('Práctica Supervisada');
  
INSERT INTO grado_academico_materia 
    (fk_id_grado_academico, fk_id_materia)
SELECT 
    ga.id_grado_academico,
    m.id_materia
FROM grado_academico ga
CROSS JOIN materia m
WHERE ga.fk_id_grado = 1
  AND ga.fk_id_especialidad = 1
  AND ga.fk_id_ciclo_escolar = 1
  AND m.nombre_materia IN (
      'Lengua y Literatura 4',
      'Matemáticas 4',
      'Ciencias Sociales y Formación Ciudadana 4',
      'Física',
      'Educación Física',
      'Expresión Artística',
      'Filosofía',
      'Comunicación y Lenguaje L3 (Inglés Técnico) 4',
      'Computación Aplicada',
      'Laboratorio I',
      'Sistemas e Instalación de Software',
      'Contabilidad'
  );
  
  INSERT INTO grado_academico_materia 
    (fk_id_grado_academico, fk_id_materia)
SELECT 
    ga.id_grado_academico,
    m.id_materia
FROM grado_academico ga
CROSS JOIN materia m
WHERE ga.fk_id_grado = 2
  AND ga.fk_id_especialidad = 1
  AND ga.fk_id_ciclo_escolar = 1
  AND m.nombre_materia IN (
      'Lengua y Literatura 5',
      'Matemáticas 5',
      'Estadística Descriptiva',
      'Ciencias Sociales y Formación Ciudadana 5',
      'Química',
      'Biología',
      'Ética Profesional y Relaciones Humanas',
      'Comunicación y Lenguaje L3 (Inglés Técnico) 5',
      'Producción de Contenidos Digitales',
      'Laboratorio II',
      'Reparación y Soporte Técnico',
      'Seminario',
      'Práctica Supervisada'
  );