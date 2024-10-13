--CONSULTAS SQL
select * from usuario;


SELECT 
    U.id_usuario,
    U.username AS 'Nombre Usuario',
   -- R.id_rutina,
    R.nombre_rutina AS 'Nombre Rutina',
    --RD.id_rutina_detallada,
    RD.series AS 'Cant. series',
    RD.repeticiones AS 'Cant. Repeticiones',
    RD.peso AS 'Peso',
    RD.descanso AS 'Descanso SEG',
  --  LE.id_lista_ejercicio,
    LE.nombre_ejercicio AS 'Nombre Ejercicio'
FROM USUARIO U
JOIN RUTINA R ON U.id_usuario = R.id_usuario
JOIN RUTINA_DETALLADA RD ON R.id_rutina = RD.id_rutina
JOIN LISTA_EJERCICIO LE ON RD.id_lista_ejercicio = LE.id_lista_ejercicio;



SELECT 
    GM.id_grupo_muscular,
    GM.grupo_musculo AS 'Grupo Muscular',
    GM.descripcion_musculo AS 'Descripción Musculo',
    --LE.id_lista_ejercicio,
    LE.nombre_ejercicio AS 'Nombre Ejercicio',
    LE.imagen_ejercicio AS 'Imagen Ejercicio',
    --DE.id_detalle_ejercicio,
    DE.descripcion_ejercicio AS 'Descripción Ejercicio',
    DE.instrucciones_ejercicio AS 'Instrucciones Ejercicio'
FROM GRUPO_MUSCULAR GM
JOIN LISTA_EJERCICIO LE ON GM.id_grupo_muscular = LE.id_grupo_muscular
JOIN DETALLE_EJERCICIO DE ON LE.id_lista_ejercicio = DE.id_lista_ejercicio;




SELECT 
    GM.id_grupo_muscular,
    GM.grupo_musculo AS 'Grupo Muscular',
    GM.descripcion_musculo AS 'Descripción Musculo',
    --LE.id_lista_ejercicio,
    LE.nombre_ejercicio AS 'Nombre Ejercicio',
    LE.imagen_ejercicio AS 'Imagen Ejercicio',
    --DE.id_detalle_ejercicio,
    DE.descripcion_ejercicio AS 'Descripción Ejercicio',
    DE.instrucciones_ejercicio AS 'Instrucciones Ejercicio'
FROM GRUPO_MUSCULAR GM
JOIN LISTA_EJERCICIO LE ON GM.id_grupo_muscular = LE.id_grupo_muscular
JOIN DETALLE_EJERCICIO DE ON LE.id_lista_ejercicio = DE.id_lista_ejercicio
WHERE GM.id_grupo_muscular = 2;


--BORRADO DE TABLAS
DROP TABLE dbo.PROGRESO;
DROP TABLE dbo.RUTINA_DETALLADA;
DROP TABLE dbo.DETALLE_EJERCICIO;
DROP TABLE dbo.LISTA_EJERCICIO;
DROP TABLE dbo.GRUPO_MUSCULAR;
DROP TABLE dbo.RUTINA;
DROP TABLE dbo.LOGRO;
DROP TABLE dbo.OBJETIVO;
DROP TABLE dbo.NOTIFICACION;
DROP TABLE dbo.FEEDBACK;
DROP TABLE dbo.PERFIL;
DROP TABLE dbo.USUARIO;

USE PR_CAPSTONE

--CREACIÓN DE TABLAS
CREATE TABLE USUARIO (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
	email VARCHAR(50) UNIQUE NOT NULL,
    user_password VARCHAR(50) NOT NULL,  
    rol VARCHAR(50) NOT NULL DEFAULT 'Usuario',
    estado INT NOT NULL DEFAULT 1,
    fecha_registro DATE NOT NULL
);

CREATE TABLE PERFIL(
    id_perfil INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    id_usuario INT NOT NULL, --FK
	username VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    tipo_nivel VARCHAR(50) NOT NULL,
    foto_perfil IMAGE NULL,
    biografia TEXT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

CREATE TABLE FEEDBACK(
    id_feedback INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    id_usuario INT NOT NULL, --FK
    tipo_feedback VARCHAR(50) NOT NULL,
    contenido_feed VARCHAR(200) NOT NULL,
    fecha_envio_feed DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

CREATE TABLE NOTIFICACION(
    id_notificacion INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    id_usuario INT NOT NULL, --FK
    tipo_notificacion VARCHAR(50) NOT NULL,
    mensaje_notificacion VARCHAR(100) NOT NULL,
    fecha_notificacion DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

--agregar el valor objetivo, valor actual
CREATE TABLE OBJETIVO(
    id_objetivo INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    id_usuario INT NOT NULL, --FK
    tipo_objetivo VARCHAR(50) NOT NULL,
    nombre_objetivo VARCHAR(50) NOT NULL,
    descripcion_objetivo TEXT NOT NULL,
    valor_objetivo INT NULL,
    fecha_limite DATE NOT NULL,
    alcanzado VARCHAR(10) NOT NULL, 
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

CREATE TABLE LOGRO(
    id_logro INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    id_usuario INT NOT NULL, --FK
    nombre_logro VARCHAR(50) NOT NULL,
    descripcion_logro TEXT NOT NULL,
    fecha_obtencion DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

CREATE TABLE RUTINA(
    id_rutina INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    id_usuario INT NOT NULL, --FK
    nombre_rutina VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

CREATE TABLE GRUPO_MUSCULAR(
    id_grupo_muscular INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    grupo_musculo VARCHAR(50) NOT NULL,
    descripcion_musculo TEXT NOT NULL
);

CREATE TABLE LISTA_EJERCICIO(
    id_lista_ejercicio INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    id_grupo_muscular INT NOT NULL, --FK
    nombre_ejercicio VARCHAR(50) NOT NULL,
    imagen_ejercicio IMAGE NULL,
    FOREIGN KEY (id_grupo_muscular) REFERENCES GRUPO_MUSCULAR(id_grupo_muscular) ON DELETE CASCADE
);

CREATE TABLE RUTINA_DETALLADA(
    id_rutina_detallada INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    id_lista_ejercicio INT NOT NULL, --FK
    id_rutina INT NOT NULL, --FK
    series INT NOT NULL,
    repeticiones INT NOT NULL,
    peso FLOAT NOT NULL,
    descanso INT NULL,
    fecha_rutina DATE NOT NULL, 
    FOREIGN KEY (id_lista_ejercicio) REFERENCES LISTA_EJERCICIO(id_lista_ejercicio) ON DELETE CASCADE,
    FOREIGN KEY (id_rutina) REFERENCES RUTINA(id_rutina) ON DELETE CASCADE
);

CREATE TABLE PROGRESO(
    id_progreso INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    id_rutina_detallada INT NOT NULL,
    comentarios_progreso VARCHAR(200) NOT NULL,
    FOREIGN KEY (id_rutina_detallada) REFERENCES RUTINA_DETALLADA(id_rutina_detallada) ON DELETE CASCADE
);

CREATE TABLE DETALLE_EJERCICIO(
    id_detalle_ejercicio INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    id_lista_ejercicio INT NOT NULL,
    descripcion_ejercicio TEXT NOT NULL,
    instrucciones_ejercicio VARCHAR(200) NOT NULL,
    FOREIGN KEY (id_lista_ejercicio) REFERENCES LISTA_EJERCICIO(id_lista_ejercicio) ON DELETE CASCADE
);


SELECT * FROM USUARIO;
SELECT * FROM PERFIL;
SELECT * FROM FEEDBACK;
SELECT * FROM NOTIFICACION;
SELECT * FROM OBJETIVO;
SELECT * FROM LOGRO;
SELECT * FROM RUTINA;
SELECT * FROM GRUPO_MUSCULAR;
SELECT * FROM LISTA_EJERCICIO;
SELECT * FROM RUTINA_DETALLADA;
SELECT * FROM PROGRESO;
SELECT * FROM DETALLE_EJERCICIO;


DELETE USUARIO;
DELETE PERFIL;
DELETE FEEDBACK;
DELETE NOTIFICACION;
DELETE OBJETIVO;
DELETE LOGRO;
DELETE RUTINA;
DELETE GRUPO_MUSCULAR;
DELETE LISTA_EJERCICIO;
DELETE RUTINA_DETALLADA;
DELETE PROGRESO;
DELETE DETALLE_EJERCICIO;


SELECT * FROM USUARIO;


--	POBLADO DE TABLAS.
--USUARIO
INSERT INTO USUARIO(  email, user_password, rol, estado, fecha_registro)
VALUES( 'emailprueba1@gmail.com', '123456', 'Admin', 1,GETDATE()); --USUARIO 1
INSERT INTO USUARIO(  email, user_password,rol, estado, fecha_registro)
VALUES( 'emailprueba2@gmail.com', '654321', 'Cliente', 1,GETDATE()); --USUARIO 2
INSERT INTO USUARIO(  email, user_password, rol, estado, fecha_registro)
VALUES( 'emailprueba3@gmail.com', '567452', 'Cliente', 1,GETDATE()); --USUARIO 3
INSERT INTO USUARIO(  email, user_password, rol, estado, fecha_registro)
VALUES( 'emailprueba4@gmail.com', '123433', 'Cliente', 1,GETDATE()); --USUARIO 4
INSERT INTO USUARIO(  email, user_password, rol, estado, fecha_registro)
VALUES( 'emailprueba5@gmail.com', '123445', 'Cliente', 1,GETDATE()); --USUARIO 5
INSERT INTO USUARIO(  email, user_password, rol, estado, fecha_registro)
VALUES('emailprueba6@gmail.com', '31242412', 'Cliente', 1,GETDATE()); --USUARIO 6


--PERFIL
INSERT INTO PERFIL( id_usuario, username, nombre, apellido, tipo_nivel, foto_perfil, biografia)
VALUES(1, 'prueba1', 'Lucas', 'Montiel', 'Principiante', NULL, 'Esto es una prueba de una biografia de prueba.') --USUARIO 1
INSERT INTO PERFIL( id_usuario, username, nombre, apellido, tipo_nivel, foto_perfil, biografia)
VALUES(2, 'prueba2', 'Sofia', 'Cardenas', 'Intermedio', NULL, 'Esto es una prueba de una biografia de prueba.') --USUARIO 2
INSERT INTO PERFIL( id_usuario, username, nombre, apellido, tipo_nivel, foto_perfil, biografia)
VALUES(3, 'prueba3', 'Javier', 'Reyes', 'Avanzado', NULL, 'Esto es una prueba de una biografia de prueba.') --USUARIO 3
INSERT INTO PERFIL( id_usuario, username, nombre, apellido, tipo_nivel, foto_perfil, biografia)
VALUES(4, 'prueba4', 'Valeria', 'Ponce', 'Intermedio', NULL, 'Esto es una prueba de una biografia de prueba.') --USUARIO 4
INSERT INTO PERFIL( id_usuario, username, nombre, apellido, tipo_nivel, foto_perfil, biografia)
VALUES(5, 'prueba5', 'Matias', 'Villanueva', 'Principiante', NULL, 'Esto es una prueba de una biografia de prueba.') --USUARIO 5

--FEEDBACK
INSERT INTO FEEDBACK( id_usuario, tipo_feedback, contenido_feed, fecha_envio_feed)
VALUES(1, 'Recomendación', 'relleno de cualquier cosa', '09-10-2024') --USUARIO 1
INSERT INTO FEEDBACK( id_usuario, tipo_feedback, contenido_feed, fecha_envio_feed)
VALUES(2, 'Sugerencia', 'relleno de cualquier cosa', '09-10-2024') --USUARIO 2
INSERT INTO FEEDBACK( id_usuario, tipo_feedback, contenido_feed, fecha_envio_feed)
VALUES(3, 'Valoración', 'relleno de cualquier cosa', '09-10-2024') --USUARIO 3
INSERT INTO FEEDBACK( id_usuario, tipo_feedback, contenido_feed, fecha_envio_feed)
VALUES(4, 'Agradecimiento', 'relleno de cualquier cosa', '09-10-2024') --USUARIO 4
INSERT INTO FEEDBACK( id_usuario, tipo_feedback, contenido_feed, fecha_envio_feed)
VALUES(5, 'Error-Problema', 'relleno de cualquier cosa', '09-10-2024') --USUARIO 5

--NOTIFICACION
INSERT INTO NOTIFICACION( id_usuario, tipo_notificacion, mensaje_notificacion, fecha_notificacion)
VALUES(1, 'Motivación', 'algo motivador', '09-10-2024') --USUARIO 1
INSERT INTO NOTIFICACION( id_usuario, tipo_notificacion, mensaje_notificacion, fecha_notificacion)
VALUES(1, 'Recordatorio', 'algo motivador', '09-10-2024') --USUARIO 1
INSERT INTO NOTIFICACION( id_usuario, tipo_notificacion, mensaje_notificacion, fecha_notificacion)
VALUES(2, 'Motivación', 'algo motivador', '09-10-2024') --USUARIO 2

--OBJETIVO
INSERT INTO OBJETIVO( id_usuario, tipo_objetivo, nombre_objetivo, descripcion_objetivo, valor_objetivo, fecha_limite, alcanzado)
VALUES(1, 'Dieta','proxima dieta', 'Bajar de peso', 70, '09-11-2024', 'progreso') --USUARIO 1
INSERT INTO OBJETIVO( id_usuario, tipo_objetivo, nombre_objetivo, descripcion_objetivo, valor_objetivo, fecha_limite, alcanzado)
VALUES(2, 'Disciplina','Focus ejercicio','Hacer 5 dias ejercicio', 70, '09-11-2024', 'progreso') --USUARIO 2
INSERT INTO OBJETIVO( id_usuario, tipo_objetivo, nombre_objetivo, descripcion_objetivo, valor_objetivo, fecha_limite, alcanzado)
VALUES(3, 'Nueva meta','Flash', 'Correr 10km', 70, '09-11-2024', 'progreso') --USUARIO 3


--LOGRO
INSERT INTO LOGRO( id_usuario, nombre_logro, descripcion_logro, fecha_obtencion)
VALUES(1, 'logro1', 'Conseguí tal cosa', '10-10-2024') --USUARIO 1
INSERT INTO LOGRO( id_usuario, nombre_logro, descripcion_logro, fecha_obtencion)
VALUES(2, 'logro2', 'Conseguí tal cosa', '10-10-2024') --USUARIO 2
INSERT INTO LOGRO( id_usuario, nombre_logro, descripcion_logro, fecha_obtencion)
VALUES(3, 'logro3', 'Conseguí tal cosa', '10-10-2024') --USUARIO 3
INSERT INTO LOGRO( id_usuario, nombre_logro, descripcion_logro, fecha_obtencion)
VALUES(4, 'logro4', 'Conseguí tal cosa', '10-10-2024') --USUARIO 4
INSERT INTO LOGRO( id_usuario, nombre_logro, descripcion_logro, fecha_obtencion)
VALUES(5, 'logro5', 'Conseguí tal cosa', '10-10-2024') --USUARIO 5

--RUTINA
INSERT INTO RUTINA( id_usuario, nombre_rutina)
VALUES(1, 'Pecho, Triceps, Hombro') --USUARIO 1
INSERT INTO RUTINA( id_usuario, nombre_rutina)
VALUES(2, 'Espalda, Biceps') --USUARIO 2
INSERT INTO RUTINA( id_usuario, nombre_rutina)
VALUES(3, 'Dia de piernas') --USUARIO 3
INSERT INTO RUTINA( id_usuario, nombre_rutina)
VALUES(4, 'Trote diario') --USUARIO 4
INSERT INTO RUTINA( id_usuario, nombre_rutina)
VALUES(5, 'Pecho, Espalda') --USUARIO 5

--GRUPO MUSCULAR --> PONER MÁS DE UN GRUPO MUSCULAR, DEJARLO DEFINIDOS DE ANTES
INSERT INTO GRUPO_MUSCULAR( grupo_musculo, descripcion_musculo)
VALUES( 'Pectoral', 'Parte superior del torso')
INSERT INTO GRUPO_MUSCULAR( grupo_musculo, descripcion_musculo)
VALUES( 'Bíceps', 'Parte frontal del brazo superior')
INSERT INTO GRUPO_MUSCULAR( grupo_musculo, descripcion_musculo)
VALUES( 'Tríceps', 'Parte posterior del brazo superior')
INSERT INTO GRUPO_MUSCULAR( grupo_musculo, descripcion_musculo)
VALUES( 'Dorsales', 'Parte media y baja de la espalda')
INSERT INTO GRUPO_MUSCULAR( grupo_musculo, descripcion_musculo)
VALUES( 'Cuádriceps', 'Parte frontal del muslo')

--LISTA EJERCICIOS
INSERT INTO LISTA_EJERCICIO( id_grupo_muscular, nombre_ejercicio, imagen_ejercicio)
VALUES(1, 'Press banca', NULL)
INSERT INTO LISTA_EJERCICIO( id_grupo_muscular, nombre_ejercicio, imagen_ejercicio)
VALUES(2, 'Curl Martillo', NULL)
INSERT INTO LISTA_EJERCICIO( id_grupo_muscular, nombre_ejercicio, imagen_ejercicio)
VALUES(2, 'Curl Biceps', NULL)
INSERT INTO LISTA_EJERCICIO( id_grupo_muscular, nombre_ejercicio, imagen_ejercicio)
VALUES(3, 'Press frances', NULL)
INSERT INTO LISTA_EJERCICIO( id_grupo_muscular, nombre_ejercicio, imagen_ejercicio)
VALUES(3, 'Extension de triceps', NULL)
INSERT INTO LISTA_EJERCICIO( id_grupo_muscular, nombre_ejercicio, imagen_ejercicio)
VALUES(4, 'Remo Unilateral', NULL)
INSERT INTO LISTA_EJERCICIO( id_grupo_muscular, nombre_ejercicio, imagen_ejercicio)
VALUES(5, 'Extension de pierna', NULL)



--RUTINA DETALLADA
INSERT INTO RUTINA_DETALLADA(id_lista_ejercicio, id_rutina, series, repeticiones, peso, descanso, fecha_rutina)
VALUES(1,1, 3, 12, 40, 120, '09-10-2024')
INSERT INTO RUTINA_DETALLADA(id_lista_ejercicio, id_rutina, series, repeticiones, peso, descanso, fecha_rutina)
VALUES(4,1, 3, 12, 10, 120, '09-10-2024')
INSERT INTO RUTINA_DETALLADA(id_lista_ejercicio, id_rutina, series, repeticiones, peso, descanso, fecha_rutina)
VALUES(5,1, 3, 12, 7.5, 120, '09-10-2024')


--PROGRESO
INSERT INTO PROGRESO(id_rutina_detallada, comentarios_progreso)
VALUES(1, 'Muy animado')
INSERT INTO PROGRESO( id_rutina_detallada, comentarios_progreso)
VALUES(2, 'Tengo más resistencia')
INSERT INTO PROGRESO( id_rutina_detallada, comentarios_progreso)
VALUES(3, 'No me senti comodo haciendo ejercicio')



--DETALLE EJERCICIO
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio)
VALUES(1, 'descripción press banca', ' instrucciones press banca')
INSERT INTO DETALLE_EJERCICIO( id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio)
VALUES(2, 'descripción Curl Martillo', ' instrucciones Curl Martillo')
INSERT INTO DETALLE_EJERCICIO( id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio)
VALUES(3, 'descripción Curl Biceps', ' instrucciones Curl Biceps')
INSERT INTO DETALLE_EJERCICIO( id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio)
VALUES(4, 'descripción Press Frances', ' instrucciones Press Frances')
INSERT INTO DETALLE_EJERCICIO( id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio)
VALUES(5, 'descripción Extension de triceps', ' instrucciones Extension de Triceps')
INSERT INTO DETALLE_EJERCICIO( id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio)
VALUES(6, 'descripción Remo Unilateral', ' instrucciones Remo Unilateral')
INSERT INTO DETALLE_EJERCICIO( id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio)
VALUES(7, 'descripción Extension de pierna', ' instrucciones Extension de pierna')


