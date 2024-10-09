CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY NOT NULL, --PK
    username VARCHAR(50) NOT NULL,
	rol VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
	fecha_registro DATE NOT NULL

);


CREATE TABLE CUENTA (
	id_cuenta INT PRIMARY KEY NOT NULL, --PK
	id_usuario INT NOT NULL, --FK
	email VARCHAR(50) UNIQUE NOT NULL,
	user_password VARCHAR(50) NOT NULL,  
	FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);


CREATE TABLE PERFIL(
	id_perfil INT PRIMARY KEY NOT NULL, --PK
	id_usuario INT NOT NULL, --FK
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
    tipo_nivel VARCHAR(50) NOT NULL,
	foto_perfil IMAGE NULL,
	biografia VARCHAR(100) NULL,
	FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);


CREATE TABLE FEEDBACK(
	id_feedback INT PRIMARY KEY NOT NULL, --PK
	id_usuario INT NOT NULL, --FK
    tipo_feedback VARCHAR(50) NOT NULL,
	contenido_feed VARCHAR(200) NOT NULL,
	fecha_envio_feed DATE NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);


CREATE TABLE NOTIFICACION(
	id_notificacion INT PRIMARY KEY NOT NULL, --PK
	id_usuario INT NOT NULL, --FK
	tipo_notificacion VARCHAR(50) NOT NULL,
	mensaje_notificacion VARCHAR(100) NOT NULL,
	fecha_notificacion DATE NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);


CREATE TABLE OBJETIVO(
	id_objetivo INT PRIMARY KEY NOT NULL, --PK
	id_usuario INT NOT NULL, --FK
    tipo_objetivo VARCHAR(50) NOT NULL,
	nombre_objetivo VARCHAR(50) NOT NULL,
	descripcion_objetivo VARCHAR(200) NOT NULL,
	valor_objetivo INT NULL,
	fecha_limite DATE NOT NULL,
	alcanzado VARCHAR(10) NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);


CREATE TABLE LOGRO(
	id_logro INT PRIMARY KEY NOT NULL, --PK
	id_usuario INT NOT NULL, --FK
	nombre_logro VARCHAR(50) NOT NULL,
	descripcion_logro VARCHAR(200) NOT NULL,
	fecha_obtencion DATE NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);


CREATE TABLE RUTINA(
	id_rutina INT PRIMARY KEY NOT NULL, --PK
	id_usuario INT NOT NULL, --FK
	nombre_rutina VARCHAR(50) NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);


CREATE TABLE GRUPO_MUSCULAR(
	id_grupo_muscular INT PRIMARY KEY NOT NULL, --PK
	grupo_musculo VARCHAR(50) NOT NULL,
	descripcion_musculo VARCHAR(100) NOT NULL
);


CREATE TABLE LISTA_EJERCICIO(
	id_lista_ejercicio INT PRIMARY KEY NOT NULL, --PK
	id_grupo_muscular INT NOT NULL, --FK
	nombre_ejercicio VARCHAR(50) NOT NULL,
	imagen_ejercicio IMAGE NULL,
	FOREIGN KEY (id_grupo_muscular) REFERENCES GRUPO_MUSCULAR(id_grupo_muscular) ON DELETE CASCADE
);


CREATE TABLE RUTINA_DETALLADA(
	id_rutina_detallada INT PRIMARY KEY NOT NULL, --PK
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
	id_progreso INT PRIMARY KEY NOT NULL,
	id_rutina_detallada INT NOT NULL,
	comentarios_progreso VARCHAR(200) NOT NULL,
	FOREIGN KEY (id_rutina_detallada) REFERENCES RUTINA_DETALLADA(id_rutina_detallada) ON DELETE CASCADE
);


CREATE TABLE DETALLE_EJERCICIO(
	id_detalle_ejercicio INT PRIMARY KEY NOT NULL,
	id_lista_ejercicio INT NOT NULL,
	descripcion_ejercicio VARCHAR(200) NOT NULL,
	instrucciones_ejercicio VARCHAR(200) NOT NULL,
	FOREIGN KEY (id_lista_ejercicio) REFERENCES LISTA_EJERCICIO(id_lista_ejercicio) ON DELETE CASCADE
);