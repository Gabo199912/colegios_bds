DROP DATABASE IF EXISTS bd_ined_cuchilla;
CREATE DATABASE IF NOT EXISTS bd_ined_cuchilla;
USE bd_ined_cuchilla;

-- =========================
-- TABLA ROL
-- =========================
CREATE TABLE rol (
                     id_rol INT AUTO_INCREMENT PRIMARY KEY,
                     tipo_usuario VARCHAR(50) NOT NULL,
                     estado TINYINT(1) DEFAULT 1 NOT NULL
);

INSERT INTO rol (tipo_usuario, estado)
VALUES
    ('SUPER_ADMIN', true),
    ('ADMIN', true),
    ('MAESTRO', true),
    ('ALUMNO', true);

-- =========================
-- TABLA GRADO
-- =========================
CREATE TABLE grado (
                       id_grado INT AUTO_INCREMENT PRIMARY KEY,
                       nombre_grado VARCHAR(50) NOT NULL,
                       especialidad VARCHAR(100) NOT NULL,
                       seccion CHAR(1) NOT NULL
);

INSERT INTO grado (grado.nombre_grado, grado.especialidad, grado.seccion)
VALUES ( '5TO', 'COMPUTACION', 'B'),
       ( '5TO', 'COMPUTACION', 'A'),
       ( '5TO', 'MECANICA', 'A'),
       ( '5TO', 'MECANICA', 'B'),
       ( '4TO', 'COMPUTACION', 'A'),
       ( '4TO', 'COMPUTACION', 'B'),
       ( '4TO', 'MECANICA', 'A'),
       ( '4TO', 'MECANICA', 'B');
-- =========================
-- TABLA ENCARGADO
-- =========================
CREATE TABLE encargado (
                           id_encargado INT AUTO_INCREMENT PRIMARY KEY,
                           nombre VARCHAR(50) NOT NULL,
                           apellido VARCHAR(50) NOT NULL,
                           tipo_familiar VARCHAR(50) NOT NULL,
                           telefono VARCHAR(25) NOT NULL,
                           email VARCHAR(100) NOT NULL
);



-- =========================
-- TABLA BIMESTRE
-- =========================
CREATE TABLE bimestre (
                          id_bimestre INT AUTO_INCREMENT PRIMARY KEY,
                          nombre_bimestre VARCHAR(25) NOT NULL,
                          fecha_inicio DATE NOT NULL,
                          fecha_finalizacion DATE NOT NULL,
                          activo TINYINT(1) DEFAULT 1 NOT NULL
);

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
-- TABLA MAESTRO
-- =========================
CREATE TABLE maestro (
                         id_maestro INT AUTO_INCREMENT PRIMARY KEY,
                         codigo_empleado VARCHAR(20) UNIQUE,
                         fk_id_usuario INT NOT NULL,
                         FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================
-- TABLA MATERIAS
-- =========================
CREATE TABLE materias (
                          id_materia INT AUTO_INCREMENT PRIMARY KEY,
                          nombre_materia VARCHAR(50) NOT NULL UNIQUE,
                          fk_id_maestro INT, -- Aquí permitimos que un maestro sea el dueño de la materia
                          FOREIGN KEY (fk_id_maestro) REFERENCES maestro(id_maestro)
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
                        fk_id_grado INT NOT NULL,

                        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario),
                        FOREIGN KEY (fk_id_grado) REFERENCES grado(id_grado)
);

-- =========================
-- TABLA ALUMNO_MATERIA (N:M)
-- =========================
CREATE TABLE alumno_materia (
                                id_alumno_materia INT AUTO_INCREMENT PRIMARY KEY,
                                fk_id_alumno INT NOT NULL,
                                fk_id_materia INT NOT NULL,

                                UNIQUE (fk_id_alumno, fk_id_materia),

                                FOREIGN KEY (fk_id_alumno) REFERENCES alumno(id_alumno),
                                FOREIGN KEY (fk_id_materia) REFERENCES materias(id_materia)
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
-- TABLA PAGOS
-- =========================
CREATE TABLE pagos (
                       id_pago INT AUTO_INCREMENT PRIMARY KEY,
                       activo TINYINT(1) NOT NULL,
                       tipo_pago VARCHAR(50) NOT NULL
);

INSERT INTO pagos (activo, tipo_pago)
VALUES
    (1, 'Efectivo'),
    (1, 'Transferencia');
-- =========================================
-- TABLA DE MESES
-- =========================================

create table detalle_mes
(
    id_mes int auto_increment primary key,

    nombre_mes varchar(20) not null,
    anio int not null,

    fecha_inicio date,
    fecha_fin date,

    estado tinyint(1) default 1,

    unique(nombre_mes, anio)
);


-- =========================
-- TABLA DETALLE_PAGO
-- =========================
CREATE TABLE detalle_pago
(
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,

    total DECIMAL(10,2) NOT NULL,
    descripcion VARCHAR(100),

    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,

    pagado TINYINT(1) DEFAULT 0,

    fk_id_usuario INT NOT NULL,
    fk_id_pago INT NOT NULL,

    FOREIGN KEY (fk_id_usuario)
        REFERENCES usuario(id_usuario),

    FOREIGN KEY (fk_id_pago)
        REFERENCES pagos(id_pago)
);



-- =========================================
-- TABLA INTERMEDIA
-- RELACION MUCHOS A MUCHOS
-- =========================================

create table detalle_pago_mes
(
    id_detalle_pago_mes int auto_increment primary key,

    fk_id_detalle int not null,
    fk_id_mes int not null,

    unique(fk_id_detalle, fk_id_mes),

    foreign key (fk_id_detalle)
        references detalle_pago(id_detalle)
        on delete cascade,

    foreign key (fk_id_mes)
        references detalle_mes(id_mes)
        on delete cascade
);

-- =========================================
-- INSERTAR MESES DE EJEMPLO
-- =========================================

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

-- =========================
-- TABLA NOTAS
-- =========================
CREATE TABLE notas (
                       id_notas INT AUTO_INCREMENT PRIMARY KEY,
                       nota DOUBLE NOT NULL,
                       descripcion VARCHAR(100),
                       fk_id_alumno INT NOT NULL,
                       fk_id_materia INT NOT NULL,
                       fk_id_grado INT NOT NULL,
                       fk_bimestre INT NOT NULL,

                       UNIQUE (fk_id_alumno, fk_id_materia, fk_bimestre),

                       FOREIGN KEY (fk_id_alumno) REFERENCES alumno(id_alumno),
                       FOREIGN KEY (fk_id_materia) REFERENCES materias(id_materia),
                       FOREIGN KEY (fk_id_grado) REFERENCES grado(id_grado),
                       FOREIGN KEY (fk_bimestre) REFERENCES bimestre(id_bimestre)
);