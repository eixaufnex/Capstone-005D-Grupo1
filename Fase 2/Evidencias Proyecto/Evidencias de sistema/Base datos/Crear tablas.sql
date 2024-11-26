--CREACIÓN DE TABLAS

-- USUARIO
CREATE TABLE USUARIO (
	firebase_id VARCHAR(50) PRIMARY KEY NOT NULL,
	username VARCHAR(50) NOT NULL, 
    rol VARCHAR(50) NOT NULL,
    estado INT NOT NULL,
    fecha_registro DATE NOT NULL
);

-- PERFIL
CREATE TABLE PERFIL(
    id_perfil INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    firebase_id VARCHAR(50) NOT NULL, --FK
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
	edad INT NOT NULL, 
    peso DECIMAL(5, 2) NULL,         
    estatura DECIMAL(5, 2) NULL,
	genero VARCHAR(50) NOT NULL,
    tipo_nivel VARCHAR(50) NOT NULL,
    foto_perfil TEXT NULL,
    biografia TEXT NULL,
    FOREIGN KEY (firebase_id) REFERENCES USUARIO(firebase_id) ON DELETE CASCADE
);

-- FEEDBACK
CREATE TABLE FEEDBACK(
    id_feedback INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    firebase_id VARCHAR(50) NOT NULL, --FK
    tipo_feedback VARCHAR(50) NOT NULL,
    contenido_feed VARCHAR(200) NOT NULL,
    fecha_envio_feed DATE NOT NULL,
    FOREIGN KEY (firebase_id) REFERENCES USUARIO(firebase_id) ON DELETE CASCADE
);

-- NOTIFICACION
CREATE TABLE NOTIFICACION(
    id_notificacion INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    firebase_id VARCHAR(50) NOT NULL, --FK
    tipo_notificacion VARCHAR(50) NOT NULL,
    mensaje_notificacion TEXT NOT NULL,
    fecha_notificacion DATE NOT NULL,
    FOREIGN KEY (firebase_id) REFERENCES USUARIO(firebase_id) ON DELETE CASCADE
);

-- OBJETIVO
CREATE TABLE OBJETIVO(
    id_objetivo INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    firebase_id VARCHAR(50) NOT NULL, --FK
    tipo_objetivo VARCHAR(50) NOT NULL,
    nombre_objetivo VARCHAR(50) NOT NULL,
    descripcion_objetivo TEXT NOT NULL,
	valor_inicial INT NULL,
	valor_actual INT NULL,
    valor_objetivo INT NULL,
    fecha_limite DATE NOT NULL,
    alcanzado VARCHAR(10) NOT NULL, 
    FOREIGN KEY (firebase_id) REFERENCES USUARIO(firebase_id) ON DELETE CASCADE
);

-- LOGRO GLOBAL
CREATE TABLE LOGRO_GLOBAL (
    id_logro_global INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- PK
    nombre_logro VARCHAR(50) NOT NULL,
    descripcion_logro TEXT NOT NULL
);

-- LOGRO OBTENIDO
CREATE TABLE LOGRO_OBTENIDO (
    id_logro_obtenido INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- PK
    firebase_id VARCHAR(50) NOT NULL, -- FK hacia USUARIO
    id_logro_global INT NOT NULL, -- FK hacia LOGRO_GLOBAL
    fecha_obtencion DATE  NULL,
    FOREIGN KEY (firebase_id) REFERENCES USUARIO(firebase_id) ON DELETE CASCADE,
    FOREIGN KEY (id_logro_global) REFERENCES LOGRO_GLOBAL(id_logro_global) ON DELETE CASCADE
);

-- GRUPO MUSCULAR
CREATE TABLE GRUPO_MUSCULAR(
    id_grupo_muscular INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    grupo_musculo VARCHAR(50) NOT NULL,
    descripcion_musculo TEXT NOT NULL
);

-- LISTA EJERCICIO
CREATE TABLE LISTA_EJERCICIO (
    id_lista_ejercicio INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    id_grupo_muscular INT NOT NULL, --FK
    nombre_ejercicio VARCHAR(50) NOT NULL,
    imagen_ejercicio TEXT NULL,
    emoji_ejercicio NVARCHAR(20) NULL,
    tipo_ejercicio VARCHAR(50) NOT NULL,
    dificultad_ejercicio VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_grupo_muscular) REFERENCES GRUPO_MUSCULAR(id_grupo_muscular) ON DELETE CASCADE
);

-- DETALLE EJERCICIO
CREATE TABLE DETALLE_EJERCICIO(
    id_detalle_ejercicio INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    id_lista_ejercicio INT NOT NULL,
    descripcion_ejercicio TEXT NOT NULL,
    instrucciones_ejercicio TEXT NOT NULL,
    FOREIGN KEY (id_lista_ejercicio) REFERENCES LISTA_EJERCICIO(id_lista_ejercicio) ON DELETE CASCADE
);

-- RUTINA
CREATE TABLE RUTINA (
    id_rutina INT IDENTITY(1,1) PRIMARY KEY NOT NULL, --PK
    firebase_id VARCHAR(50) NOT NULL, --FK
    nombre_rutina VARCHAR(50) NOT NULL,
    tipo_rutina VARCHAR(50) NULL,
    emoji NVARCHAR(20) NULL,
	dias_rutina TEXT NULL
    FOREIGN KEY (firebase_id) REFERENCES USUARIO(firebase_id) ON DELETE CASCADE
);

-- RUTINA EJERCICIO (INTERMEDIARIA)
CREATE TABLE RUTINA_EJERCICIO (
    id_rutina INT NOT NULL, 
    id_lista_ejercicio INT NOT NULL,
    PRIMARY KEY (id_rutina, id_lista_ejercicio),
    FOREIGN KEY (id_rutina) REFERENCES RUTINA(id_rutina) ON DELETE CASCADE,
    FOREIGN KEY (id_lista_ejercicio) REFERENCES LISTA_EJERCICIO(id_lista_ejercicio) ON DELETE CASCADE
);

--RUTINA DETALLADA
CREATE TABLE RUTINA_DETALLADA (
    id_rutina_detallada INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    id_rutina INT NOT NULL,
    id_lista_ejercicio INT NOT NULL,
    series INT NOT NULL,
    repeticiones INT NOT NULL,
    peso FLOAT NOT NULL,
    rpe INT NOT NULL,
    tiempo_ejercicio INT NULL,
    fecha_rutina DATE NULL,
    comentarios TEXT NULL,
    FOREIGN KEY (id_rutina, id_lista_ejercicio) REFERENCES RUTINA_EJERCICIO(id_rutina, id_lista_ejercicio) ON DELETE CASCADE
);

--PUBLICACIONES
CREATE TABLE PUBLICACIONES (
    id_publicacion INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- PK de la publicación
    firebase_id VARCHAR(50) NOT NULL, -- FK asociada al usuario en Firebase
    descripcion TEXT NULL, -- Texto o contenido de la publicación
    likes INT DEFAULT 0, -- Contador de likes, inicia en 0
    fecha_creacion DATETIME DEFAULT GETDATE(), -- Fecha y hora de creación de la publicación
    FOREIGN KEY (firebase_id) REFERENCES USUARIO(firebase_id) ON DELETE CASCADE, -- FK a la tabla USUARIO
);


