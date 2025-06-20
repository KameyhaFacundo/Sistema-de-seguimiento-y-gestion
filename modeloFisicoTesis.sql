--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      Nicolás
-- Project :      ModeloBDTesis.DM1
-- Author :       Nicolás
--
-- Date Created : Friday, June 20, 2025 18:08:12
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Actividades 
--

CREATE TABLE Actividades(
    IdActividad      CHAR(10)        NOT NULL,
    IdTutor          CHAR(10)        NOT NULL,
    IdPCD            CHAR(10),
    IdProfesional    CHAR(10),
    IdReporte        CHAR(10),
    Actividad        VARCHAR(15)     NOT NULL,
    Descripción      VARCHAR(200),
    FechaInicio      DATE            NOT NULL,
    FechaFin         TIME,
    HoraFin          TIMESTAMP,
    estado           VARCHAR(15)     DEFAULT pendiente NOT NULL,
    FechaCreacion    DATETIME        NOT NULL,
    Actualizado      DATETIME,
    PRIMARY KEY (IdActividad)
)ENGINE=MYISAM
;



-- 
-- TABLE: Especialidades 
--

CREATE TABLE Especialidades(
    idEspecialidad    CHAR(10)       NOT NULL,
    Especialidad      VARCHAR(15)    NOT NULL,
    PRIMARY KEY (idEspecialidad)
)ENGINE=MYISAM
;



-- 
-- TABLE: InstanciaActividad 
--

CREATE TABLE InstanciaActividad(
    idInstanciaActividad    CHAR(10)       NOT NULL,
    fecha                   DATETIME,
    estado                  VARCHAR(10),
    IdActividad             CHAR(10)       NOT NULL,
    PRIMARY KEY (idInstanciaActividad)
)ENGINE=MYISAM
;



-- 
-- TABLE: Notificaciones 
--

CREATE TABLE Notificaciones(
    idNotificaciones        CHAR(10)    NOT NULL,
    IdTutores               CHAR(10)    NOT NULL,
    Titulo                  CHAR(10),
    Mensaje                 CHAR(10),
    Tipo                    CHAR(10),
    Estado                  CHAR(10),
    Creado                  CHAR(10),
    Leido                   CHAR(10),
    Prioridad               CHAR(10),
    idInstanciaActividad    CHAR(10),
    PRIMARY KEY (idNotificaciones, IdTutores)
)ENGINE=MYISAM
;



-- 
-- TABLE: PersonaDiscapacidad 
--

CREATE TABLE PersonaDiscapacidad(
    IdPCD           CHAR(10)       NOT NULL,
    Edad            INT,
    Discapacidad    VARCHAR(30),
    PRIMARY KEY (IdPCD)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProfesionalConEspecialidad 
--

CREATE TABLE ProfesionalConEspecialidad(
    IdProfesional     CHAR(10)       NOT NULL,
    idEspecialidad    CHAR(10)       NOT NULL,
    CentroMedico      VARCHAR(50),
    Matricula         VARCHAR(15)    NOT NULL,
    PRIMARY KEY (IdProfesional, idEspecialidad)
)ENGINE=MYISAM
;



-- 
-- TABLE: Profesionales 
--

CREATE TABLE Profesionales(
    IdProfesional    CHAR(10)    NOT NULL,
    PRIMARY KEY (IdProfesional)
)ENGINE=MYISAM
;



-- 
-- TABLE: Reportes 
--

CREATE TABLE Reportes(
    IdReporte        CHAR(10)    NOT NULL,
    IdProfesional    CHAR(10)    NOT NULL,
    Titulo           CHAR(10),
    Descripcion      CHAR(10),
    PRIMARY KEY (IdReporte)
)ENGINE=MYISAM
;



-- 
-- TABLE: Terapia 
--

CREATE TABLE Terapia(
    IdProfesional         CHAR(10)        NOT NULL,
    IdPCD                 CHAR(10)        NOT NULL,
    IdActividad           CHAR(10),
    Descripcion           VARCHAR(120)    NOT NULL,
    FechaInicioTerapia    TIME            NOT NULL,
    FechaFinTerapia       DATETIME,
    PRIMARY KEY (IdProfesional, IdPCD)
)ENGINE=MYISAM
;



-- 
-- TABLE: TutorConPCD 
--

CREATE TABLE TutorConPCD(
    IdTutor       CHAR(10)       NOT NULL,
    IdPCD         CHAR(10)       NOT NULL,
    Parentezco    VARCHAR(15)    NOT NULL,
    PRIMARY KEY (IdTutor, IdPCD)
)ENGINE=MYISAM
;



-- 
-- TABLE: Tutores 
--

CREATE TABLE Tutores(
    IdTutor                CHAR(10)       NOT NULL,
    TutorDeApellido        VARCHAR(15),
    TutorDeNombre          VARCHAR(30),
    TutorDeDNI             VARCHAR(13),
    TutorDeEdad            INT,
    TutorDeDiscapacidad    VARCHAR(20),
    PRIMARY KEY (IdTutor)
)ENGINE=MYISAM
;



-- 
-- TABLE: Usuarios 
--

CREATE TABLE Usuarios(
    IdTutores            CHAR(10)       NOT NULL,
    CorreoElectronico    CHAR(10)       NOT NULL,
    Password             CHAR(10)       NOT NULL,
    TipoDeUsuario        VARCHAR(14)    NOT NULL,
    DNI                  CHAR(10),
    Apellido             CHAR(10)       NOT NULL,
    Nombre               CHAR(10)       NOT NULL,
    Telefono             CHAR(10)       NOT NULL,
    Domicilio            CHAR(10),
    PRIMARY KEY (IdTutores)
)ENGINE=MYISAM
;



-- 
-- TABLE: Actividades 
--

ALTER TABLE Actividades ADD CONSTRAINT RefProfesionales16 
    FOREIGN KEY (IdProfesional)
    REFERENCES Profesionales(IdProfesional)
;

ALTER TABLE Actividades ADD CONSTRAINT RefReportes20 
    FOREIGN KEY (IdReporte)
    REFERENCES Reportes(IdReporte)
;

ALTER TABLE Actividades ADD CONSTRAINT RefPersonaDiscapacidad25 
    FOREIGN KEY (IdPCD)
    REFERENCES PersonaDiscapacidad(IdPCD)
;

ALTER TABLE Actividades ADD CONSTRAINT RefTutores26 
    FOREIGN KEY (IdTutor)
    REFERENCES Tutores(IdTutor)
;


-- 
-- TABLE: InstanciaActividad 
--

ALTER TABLE InstanciaActividad ADD CONSTRAINT RefActividades33 
    FOREIGN KEY (IdActividad)
    REFERENCES Actividades(IdActividad)
;


-- 
-- TABLE: Notificaciones 
--

ALTER TABLE Notificaciones ADD CONSTRAINT RefUsuarios27 
    FOREIGN KEY (IdTutores)
    REFERENCES Usuarios(IdTutores)
;

ALTER TABLE Notificaciones ADD CONSTRAINT RefInstanciaActividad34 
    FOREIGN KEY (idInstanciaActividad)
    REFERENCES InstanciaActividad(idInstanciaActividad)
;


-- 
-- TABLE: PersonaDiscapacidad 
--

ALTER TABLE PersonaDiscapacidad ADD CONSTRAINT RefUsuarios4 
    FOREIGN KEY (IdPCD)
    REFERENCES Usuarios(IdTutores)
;


-- 
-- TABLE: ProfesionalConEspecialidad 
--

ALTER TABLE ProfesionalConEspecialidad ADD CONSTRAINT RefProfesionales8 
    FOREIGN KEY (IdProfesional)
    REFERENCES Profesionales(IdProfesional)
;

ALTER TABLE ProfesionalConEspecialidad ADD CONSTRAINT RefEspecialidades9 
    FOREIGN KEY (idEspecialidad)
    REFERENCES Especialidades(idEspecialidad)
;


-- 
-- TABLE: Profesionales 
--

ALTER TABLE Profesionales ADD CONSTRAINT RefUsuarios2 
    FOREIGN KEY (IdProfesional)
    REFERENCES Usuarios(IdTutores)
;


-- 
-- TABLE: Reportes 
--

ALTER TABLE Reportes ADD CONSTRAINT RefProfesionales21 
    FOREIGN KEY (IdProfesional)
    REFERENCES Profesionales(IdProfesional)
;


-- 
-- TABLE: Terapia 
--

ALTER TABLE Terapia ADD CONSTRAINT RefProfesionales29 
    FOREIGN KEY (IdProfesional)
    REFERENCES Profesionales(IdProfesional)
;

ALTER TABLE Terapia ADD CONSTRAINT RefPersonaDiscapacidad30 
    FOREIGN KEY (IdPCD)
    REFERENCES PersonaDiscapacidad(IdPCD)
;

ALTER TABLE Terapia ADD CONSTRAINT RefActividades32 
    FOREIGN KEY (IdActividad)
    REFERENCES Actividades(IdActividad)
;


-- 
-- TABLE: TutorConPCD 
--

ALTER TABLE TutorConPCD ADD CONSTRAINT RefTutores6 
    FOREIGN KEY (IdTutor)
    REFERENCES Tutores(IdTutor)
;

ALTER TABLE TutorConPCD ADD CONSTRAINT RefPersonaDiscapacidad7 
    FOREIGN KEY (IdPCD)
    REFERENCES PersonaDiscapacidad(IdPCD)
;


-- 
-- TABLE: Tutores 
--

ALTER TABLE Tutores ADD CONSTRAINT RefUsuarios3 
    FOREIGN KEY (IdTutor)
    REFERENCES Usuarios(IdTutores)
;


