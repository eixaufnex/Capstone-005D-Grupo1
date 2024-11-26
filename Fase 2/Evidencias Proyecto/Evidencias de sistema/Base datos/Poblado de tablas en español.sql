-- POBLADO DE TABLAS

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--NOTIFICACION (se reemplaza el firebaseid)
--Triste
INSERT INTO NOTIFICACION( firebase_id, tipo_notificacion, mensaje_notificacion, fecha_notificacion) VALUES
('firebase_id', 'Triste', 'Recuerda que está bien sentirse así a veces. Permítete sentir y sanar, y recuerda que siempre hay luz al final del túnel.', '09-10-2024'),
('firebase_id', 'Normal', 'Hoy es un buen día para seguir adelante. Aprovecha cada momento y busca las pequeñas alegrías en tu rutina diaria.', '09-10-2024'),
('firebase_id', 'Bien', '¡Genial! Estás haciendo un gran trabajo. Sigue así y no olvides celebrar cada uno de tus logros, por pequeños que sean.', '09-10-2024'),
('firebase_id', 'Superbién', '¡Fantástico! Tu energía positiva es contagiosa. Sigue brillando y compartiendo tu alegría con los demás. ¡El mundo necesita más personas como tú!', '09-10-2024'),
('firebase_id', 'Recordatorio', 'algo motivador', '09-10-2024');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--LOGROS GLOBALES
INSERT INTO LOGRO_GLOBAL (nombre_logro, descripcion_logro)
VALUES 
('Primera Rutina', 'Crea o agrega tu primera Rutina'),
('Primer Objetivo', 'Crea tu primer Objetivo'),
('Primera Publicación', 'Crea tu primera Publicación'),
('Primer Like', 'Da tu primer like a una publicación de alguien');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--GRUPO MUSCULAR --> Español
INSERT INTO GRUPO_MUSCULAR(grupo_musculo, descripcion_musculo) VALUES
('Pectoral', 'Parte superior del torso, músculos del pecho'),
('Bíceps', 'Parte frontal del brazo superior, responsables de la flexión del codo'),
('Tríceps', 'Parte posterior del brazo superior, responsables de la extensión del codo'),
('Dorsales', 'Parte media y baja de la espalda, principales músculos para el jalón'),
('Trapecio', 'Músculos de la parte superior de la espalda y cuello'),
('Deltoides', 'Hombros, músculos que cubren la articulación del hombro'),
('Cuádriceps', 'Parte frontal del muslo, responsables de la extensión de la rodilla'),
('Isquiotibiales', 'Parte posterior del muslo, responsables de la flexión de la rodilla'),
('Glúteos', 'Músculos principales de la cadera, responsables de la extensión y abducción de la pierna'),
('Abdominales', 'Parte frontal del torso, incluye el recto abdominal y los oblicuos'),
('Oblicuos', 'Músculos laterales del abdomen, responsables de la rotación del torso'),
('Erectores espinales', 'Músculos a lo largo de la columna, responsables de la extensión y estabilidad de la espalda'),
('Gemelos', 'Músculos de la parte posterior de la pierna, responsables de la flexión plantar del pie'),
('Caderas', 'Músculos de la región pélvica, responsables de la movilidad de la cadera'),
('Antebrazos', 'Músculos de la parte inferior del brazo, responsables del agarre y la flexión/extensión de la muñeca'),
('Cuerpo completo', 'Músculos que abarcan ejercicios que involucran múltiples grupos musculares');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--LISTA EJERCICIOS
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, emoji_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(1, 'Press banca', 'https://fitcron.com/wp-content/uploads/2021/03/01221301-Barbell-Wide-Bench-Press_Chest_720.gif', N'🏋️‍', 'Fuerza', 'Intermedio'),
(1, 'Aperturas con mancuernas', 'https://fitcron.com/wp-content/uploads/2021/03/03081301-Dumbbell-Fly_Chest-FIX_720.gif', N'🏋️‍', 'Fuerza', 'Principiante'),
(2, 'Curl Martillo', 'https://fitcron.com/wp-content/uploads/2021/04/02981301-Dumbbell-Cross-Body-Hammer-Curl_Forearms_720.gif', N'🏋️‍', 'Fuerza', 'Avanzado'),
(2, 'Curl Bíceps', 'https://fitcron.com/wp-content/uploads/2021/04/16701301-Dumbbell-One-Arm-Standing-Curl_Upper-Arms_720.gif', N'🏋️‍', 'Fuerza', 'Intermedio'),
(3, 'Press francés', 'https://fitcron.com/wp-content/uploads/2021/03/00601301-Barbell-Lying-Triceps-Extension-Skull-Crusher_Triceps-SFIX_720.gif', N'🏋️‍', 'Fuerza', 'Intermedio'),
(3, 'Extensión de tríceps', 'https://fitcron.com/wp-content/uploads/2021/04/03621301-Dumbbell-One-Arm-Triceps-Extension-on-bench_Upper-Arms_720.gif', N'🏋️‍', 'Fuerza', 'Principiante'),
(4, 'Remo Unilateral', 'https://fitcron.com/wp-content/uploads/2021/04/02921301-Dumbbell-Bent-over-Row_back_Back_720.gif', N'🏋️‍', 'Fuerza', 'Principiante'),
(4, 'Dominadas', 'https://fitcron.com/wp-content/uploads/2021/04/18661301-Wide-Grip-Pull-Up-on-Dip-Cage_Back_720.gif', N'🏋️‍', 'Fuerza', 'Avanzado'),
(7, 'Extensión de pierna', 'https://fitcron.com/wp-content/uploads/2021/04/05851301-Lever-Leg-Extension_Thighs_720.gif', N'🏋️‍', 'Fuerza', 'Principiante'),
(7, 'Prensa de pierna', 'https://fitcron.com/wp-content/uploads/2021/04/15751301-Sled-45%C2%B0-Narrow-Stance-Leg-Press_Thighs_720.gif', N'🏋️‍', 'Fuerza', 'Intermedio'),
(8, 'Peso muerto rumano', 'https://fitcron.com/wp-content/uploads/2021/04/00851301-Barbell-Romanian-Deadlift_Hips_720.gif', N'🏋️‍', 'Fuerza', 'Intermedio'),
(9, 'Hip thrust', 'https://fitcron.com/wp-content/uploads/2021/04/10601301-Barbell-Hip-Thrust_Hips_720.gif', N'🏋️‍', 'Fuerza', 'Avanzado'),
(10, 'Plancha abdominal', 'https://fitcron.com/wp-content/uploads/2021/04/04631301-Front-Plank_waist-FIX_720.gif', N'🏋️‍', 'Fuerza', 'Intermedio'),
(15, 'Curl de muñeca', 'https://fitcron.com/wp-content/uploads/2021/03/03641301-Dumbbell-One-arm-Wrist-Curl_Forearm-SFIX_720.gif', N'🏋️‍', 'Fuerza', 'Principiante');

-- Ejercicios cardiovasculares
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(7, 'Correr', 'https://i.pinimg.com/originals/37/1a/d4/371ad4137ee381e717e5e65113ffe4b9.gif', 'Cardiovascular', 'Intermedio'),
(7, 'Ciclismo', 'https://i.pinimg.com/originals/a7/ba/d1/a7bad1af3dc134bcee4a75412271c48d.gif', 'Cardiovascular', 'Intermedio'),
(8, 'Escaladora', 'https://fitcron.com/wp-content/uploads/2021/03/23111301-Walking-on-Stepmill_Thighs_720.gif', 'Cardiovascular', 'Principiante'),
(9, 'Saltar la cuerda', 'https://cloudfront-us-east-1.images.arcpublishing.com/metroworldnews/ZPV6IYBM3ZC5JGLUJ77G564RHY.gif', 'Cardiovascular', 'Avanzado'),
(16, 'Natación', 'https://i.pinimg.com/originals/fa/b8/47/fab8474a3787b6a851a65936748bc8ec.gif', 'Cardiovascular', 'Avanzado');

-- Ejercicios de elongación
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(7, 'Estiramiento de cuádriceps', 'https://mundoentrenamiento.com/wp-content/uploads/2023/03/estiramientos-cuadriceps.jpeg', 'Elongación', 'Principiante'),
(14, 'Estiramiento de cadera', 'https://cms2.vitapp.com/wp-content/uploads/2019/11/La-pose-del-tria%CC%81ngulo.gif', 'Elongación', 'Intermedio'),
(9, 'Puente para glúteos', 'https://cdn.shopify.com/s/files/1/0982/0194/files/glutebridge_2048x2048.gif?v=1650467771', 'Elongación', 'Intermedio'),
(8, 'Estiramiento de isquiotibiales', 'https://www.atmosferasport.es/img/cms/blog/estiaextenio.png', 'Elongación', 'Principiante'),
(4, 'Estiramiento de dorsales', 'https://columnaactiva.com/admin/uploads/img_61377215e4fec_241182251_123569980013036_8822539333660343188_n.jpg', 'Elongación', 'Intermedio'),
(12, 'Estiramiento de columna', 'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2023/06/02/14/11/cat-stretch-8col-2563650-005.jpg', 'Elongación', 'Avanzado');

-- Ejercicios de flexibilidad
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(10, 'Rotación de torso', 'https://www.realovirtual.com/pictures/2021/04/deca/deca_movimiento_cadera.gif', 'Flexibilidad', 'Principiante'),
(12, 'Rotación de columna', 'https://img.wtvideo.com/images/article/list/21408_1.jpg', 'Flexibilidad', 'Intermedio'),
(9, 'Estiramiento de glúteos', 'https://www.entrenamientos.com/media/cache/exercise_375/uploads/exercise/estiramiento-gluteo-isquitibial-superior-init-pos-5627.jpeg', 'Flexibilidad', 'Intermedio'),
(1, 'Aperturas para pecho', 'https://www.entrenamientos.com/media/cache/exercise_375/uploads/exercise/aperturas-hombros-banda-elastica-init-pos-5155.png', 'Flexibilidad', 'Principiante'),
(14, 'Flexión lateral de cadera', 'https://www.entrenamientos.com/media/cache/exercise_375/uploads/exercise/flexion-lateral-de-tronco-con-mancuerna-init-pos-4779.png', 'Flexibilidad', 'Avanzado'),
(3, 'Estiramiento de tríceps', 'https://www.entrenamientos.com/media/cache/exercise_375/uploads/exercise/estiramiento-de-triceps-detras-de-la-cabeza-8438.png', 'Flexibilidad', 'Principiante');

-- Ejercicios de deporte en equipo (grupo muscular cuerpo completo)
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(16, 'Fútbol', 'https://as01.epimg.net/masdeporte/imagenes/2021/08/18/reportajes/1629287252_471087_1632935001_noticiareportajes_grande.jpg', 'Deporte en equipo', 'Intermedio'),
(16, 'Baloncesto', 'https://cdn.vox-cdn.com/thumbor/46rp_6Tb025DqcqUvQw076nqPyY=/1400x1050/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/25551536/2164077239.jpg', 'Deporte en equipo', 'Avanzado'),
(16, 'Voleibol', 'https://cdn.britannica.com/95/190895-050-955A908C/volleyball-match-Italy-Russia-Milan-Volleyball-World.jpg', 'Deporte en equipo', 'Principiante'),
(16, 'Rugby', 'https://journey.app/blog/wp-content/uploads/2022/01/ruck_reglas_del_rugby-1024x593.jpg', 'Deporte en equipo', 'Avanzado'),
(16, 'Hockey', 'https://img.olympics.com/images/image/private/t_s_16_9_g_auto/t_s_w960/f_auto/primary/r3ivyidaipxicsw4yrnt', 'Deporte en equipo', 'Intermedio');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--DETALLE EJERCICIO

--fuerza
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
(1, 'El press banca es un ejercicio compuesto que trabaja principalmente el pectoral mayor, los deltoides y los tríceps.', 
    '1. Acuéstate sobre un banco plano y asegúrate de que tus pies estén firmemente apoyados en el suelo. 
     2. Sostén la barra con un agarre ligeramente más ancho que el ancho de los hombros. 
     3. Baja la barra lentamente hasta que toque ligeramente tu pecho. 
     4. Empuja la barra hacia arriba hasta que tus brazos estén completamente extendidos. 
     5. Repite según el número de repeticiones.'),
(2, 'Las aperturas con mancuerna son un ejercicio de aislamiento que trabaja principalmente los músculos pectorales, ayudando a mejorar la flexibilidad y la fuerza del pecho.', 
    '1. Acuéstate sobre un banco plano sosteniendo una mancuerna en cada mano. 
     2. Extiende los brazos hacia arriba con una ligera flexión en los codos. 
     3. Abre los brazos hacia los lados de manera controlada, manteniendo el codo ligeramente doblado. 
     4. Lleva las mancuernas de vuelta a la posición inicial sin tocarse. 
     5. Repite según el número de repeticiones.'),
(3, 'El curl martillo es un ejercicio que se enfoca en el desarrollo del braquiorradial y el bíceps.', 
    '1. Sostén una mancuerna en cada mano con un agarre neutro (las palmas mirando hacia adentro). 
     2. Mantén los codos cerca del torso mientras levantas las mancuernas hacia tus hombros. 
     3. Baja las mancuernas de manera controlada a la posición inicial. 
     4. Repite según el número de repeticiones.'),
(4, 'El curl bíceps es un ejercicio clásico que desarrolla fuerza y volumen en los bíceps.', 
    '1. Sostén una barra o mancuernas con las palmas hacia arriba (agarre supino). 
     2. Mantén los codos pegados al torso y flexiona los brazos levantando el peso hacia los hombros. 
     3. Baja el peso lentamente hasta la posición inicial. 
     4. Repite según el número de repeticiones.'),
(5, 'El press francés es un ejercicio que se centra en trabajar el tríceps.', 
    '1. Acuéstate en un banco plano y sostén una barra con un agarre cerrado. 
     2. Extiende los brazos hacia arriba y baja la barra hacia tu frente con un movimiento controlado. 
     3. Vuelve a extender los brazos hacia la posición inicial. 
     4. Repite según el número de repeticiones.'),
(6, 'La extensión de tríceps es un ejercicio aislado para trabajar el músculo tríceps.', 
    '1. Sostén una mancuerna con ambas manos detrás de la cabeza. 
     2. Extiende los brazos hacia arriba, asegurándote de que los codos permanezcan cerca de la cabeza. 
     3. Baja la mancuerna detrás de la cabeza de forma controlada. 
     4. Repite según el número de repeticiones.'),
(7, 'El remo unilateral es un ejercicio compuesto que fortalece los dorsales, trapecios y deltoides posteriores.', 
    '1. Coloca una rodilla y una mano sobre un banco para apoyarte. 
     2. Sostén una mancuerna en la mano contraria y deja el brazo extendido hacia abajo. 
     3. Levanta la mancuerna hacia el costado del torso, manteniendo el codo pegado al cuerpo. 
     4. Baja la mancuerna de manera controlada a la posición inicial. 
     5. Repite según el número de repeticiones y cambia de lado.'),
(8, 'Las dominadas son un ejercicio compuesto que trabaja principalmente la espalda, los bíceps y los músculos del core, mejorando la fuerza superior del cuerpo.', 
    '1. Agarra la barra con un agarre en pronación (palmas hacia adelante) ligeramente más ancho que los hombros. 
     2. Cuelga de la barra con los brazos completamente extendidos y los pies fuera del suelo. 
     3. Tira de tu cuerpo hacia arriba hasta que tu barbilla pase por encima de la barra. 
     4. Baja lentamente hasta la posición inicial con los brazos extendidos. 
     5. Repite según el número de repeticiones.'),
(9, 'La extensión de pierna es un ejercicio aislado que trabaja los cuádriceps.', 
    '1. Siéntate en una máquina de extensión de piernas y coloca los pies debajo del rodillo. 
     2. Extiende las piernas completamente hasta que estén rectas. 
     3. Baja las piernas lentamente a la posición inicial. 
     4. Repite según el número de repeticiones.'),
(10, 'La prensa de pierna es un ejercicio compuesto que trabaja principalmente los cuádriceps, los glúteos y los isquiotibiales, ayudando a mejorar la fuerza de las piernas.', 
    '1. Siéntate en la máquina de prensa de pierna y coloca los pies en la plataforma, separados al ancho de los hombros. 
     2. Asegúrate de que tus rodillas estén alineadas con los pies y no se desplacen hacia dentro o fuera. 
     3. Empuja la plataforma hacia arriba hasta que tus piernas estén casi completamente extendidas, sin bloquear las rodillas. 
     4. Baja la plataforma lentamente hasta que tus rodillas formen un ángulo de 90 grados. 
     5. Repite según el número de repeticiones.'),
(11, 'El peso muerto rumano es un ejercicio de fuerza que trabaja principalmente los isquiotibiales y glúteos.', 
    '1. Sostén una barra con un agarre ligeramente más ancho que el ancho de los hombros. 
     2. Mantén las piernas ligeramente flexionadas y baja la barra hacia el suelo, manteniendo la espalda recta. 
     3. Sube la barra de manera controlada a la posición inicial, contrayendo los glúteos al final del movimiento. 
     4. Repite según el número de repeticiones.'),
(12, 'El hip thrust es un ejercicio diseñado para fortalecer los glúteos.', 
    '1. Siéntate en el suelo con la parte superior de la espalda apoyada en un banco y una barra sobre las caderas. 
     2. Eleva las caderas hacia arriba hasta que el cuerpo forme una línea recta desde los hombros hasta las rodillas. 
     3. Baja las caderas de manera controlada sin que toquen el suelo. 
     4. Repite según el número de repeticiones.'),
(13, 'La plancha abdominal es un ejercicio isométrico que fortalece el núcleo, incluyendo abdominales, oblicuos y erectores espinales.', 
    '1. Colócate en posición de plancha, apoyándote sobre los antebrazos y las puntas de los pies. 
     2. Asegúrate de mantener el cuerpo en línea recta desde la cabeza hasta los pies, evitando hundir las caderas. 
     3. Contrae los abdominales y mantén la posición durante el tiempo indicado. 
     4. Relájate y repite según el número de series.'),
(14, 'El curl de muñeca es un ejercicio que fortalece los músculos del antebrazo, específicamente los flexores de la muñeca.', 
    '1. Siéntate en un banco y sostén una barra con un agarre supino (palmas hacia arriba). 
     2. Coloca los antebrazos sobre tus muslos con las muñecas extendiéndose más allá de las rodillas. 
     3. Baja la barra lentamente, dejando que las muñecas se extiendan completamente. 
     4. Eleva la barra contrayendo los músculos del antebrazo. 
     5. Repite según el número de repeticiones.');

--Cardiovascular
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
(15, 'Correr es un ejercicio cardiovascular que mejora la resistencia, quema calorías y fortalece los músculos de las piernas.', 
    '1. Calienta durante 5-10 minutos caminando o trotando lentamente. 
     2. Corre a un ritmo moderado manteniendo una postura erguida y los brazos relajados. 
     3. Respira de manera regular y profunda para mantener un buen ritmo. 
     4. Finaliza con una caminata para enfriar el cuerpo y estira los músculos al terminar.'),
(16, 'Ciclismo es una actividad de bajo impacto que fortalece los músculos de las piernas y mejora la capacidad cardiovascular.', 
    '1. Ajusta la altura del asiento para que tus rodillas estén ligeramente flexionadas al pedalear. 
     2. Pedalea a un ritmo constante, manteniendo la espalda recta y los codos ligeramente flexionados. 
     3. Cambia la resistencia para simular subidas y bajadas según tu nivel de entrenamiento. 
     4. Enfría con pedaleo suave durante 5-10 minutos y estira después.'),
(17, 'La escaladora es una máquina que simula el movimiento de subir escaleras, trabajando glúteos, cuádriceps e isquiotibiales.', 
    '1. Coloca los pies en los escalones y ajusta la velocidad de la máquina a un nivel cómodo. 
     2. Sube escalones manteniendo una postura recta y las manos apoyadas ligeramente en los pasamanos. 
     3. Usa las piernas para realizar el movimiento, evitando depender de los brazos para apoyarte. 
     4. Al terminar, reduce la velocidad gradualmente para enfriar.'),
(18, 'Saltar la cuerda es un ejercicio completo que mejora la coordinación, quema calorías y fortalece las piernas y el core.', 
    '1. Sostén la cuerda con ambas manos y colócala detrás de tus pies. 
     2. Gira la cuerda hacia adelante con un movimiento suave de las muñecas. 
     3. Salta ligeramente para que la cuerda pase por debajo de tus pies, manteniendo el ritmo constante. 
     4. Continúa durante el tiempo deseado y aumenta la velocidad gradualmente para mayor intensidad.'),
(19, 'La natación es un ejercicio de cuerpo completo que mejora la capacidad cardiovascular y fortalece múltiples grupos musculares.', 
    '1. Elige un estilo de natación que se ajuste a tu nivel, como crol, espalda, pecho o mariposa. 
     2. Mantén una respiración rítmica y utiliza todo el cuerpo para realizar el movimiento. 
     3. Alterna intervalos de velocidad con nado más relajado para mayor eficiencia. 
     4. Finaliza con una vuelta de nado suave para enfriar y estira al salir del agua.');

--elongacion
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
(20, 'El estiramiento de cuádriceps mejora la flexibilidad de la parte frontal del muslo y reduce la tensión muscular.', 
    '1. De pie, dobla una pierna hacia atrás y agarra el tobillo con la mano del mismo lado. 
     2. Mantén las rodillas juntas y lleva el talón hacia los glúteos. 
     3. Sostén la posición durante 20-30 segundos sin arquear la espalda. 
     4. Cambia de pierna y repite.'),
(21, 'El estiramiento de cadera libera tensión en los músculos de la pelvis y mejora la movilidad articular.', 
    '1. Siéntate en el suelo con una pierna extendida hacia adelante y la otra doblada con la planta del pie hacia el interior del muslo contrario. 
     2. Inclina el torso hacia la pierna extendida y lleva las manos hacia el pie. 
     3. Mantén la posición durante 20-30 segundos. 
     4. Cambia de lado y repite.'),
(22, 'El puente para glúteos estira y activa los músculos de los glúteos, ayudando a mejorar la postura y el equilibrio.', 
    '1. Acuéstate boca arriba con las rodillas dobladas y los pies apoyados en el suelo. 
     2. Eleva las caderas hacia arriba, formando una línea recta desde los hombros hasta las rodillas. 
     3. Mantén la posición durante 10-15 segundos antes de bajar lentamente. 
     4. Repite varias veces.'),
(23, 'El estiramiento de isquiotibiales aumenta la flexibilidad de la parte trasera del muslo y previene lesiones.', 
    '1. De pie, coloca una pierna estirada sobre una superficie elevada como un banco o escalón. 
     2. Inclina el torso hacia adelante desde las caderas, manteniendo la espalda recta. 
     3. Sostén la posición durante 20-30 segundos y cambia de pierna.'),
(24, 'El estiramiento de dorsales ayuda a aliviar la tensión en la parte superior y media de la espalda.', 
    '1. De pie o sentado, entrelaza las manos frente a ti y estira los brazos hacia adelante. 
     2. Inclina ligeramente el torso hacia adelante, llevando los omóplatos hacia afuera. 
     3. Mantén la posición durante 20-30 segundos.'),
(25, 'El estiramiento de columna mejora la flexibilidad y reduce la rigidez en la zona lumbar y torácica.', 
    '1. Acuéstate boca arriba con las rodillas dobladas y los pies apoyados en el suelo. 
     2. Gira las rodillas hacia un lado mientras mantienes los hombros en contacto con el suelo. 
     3. Sostén la posición durante 20-30 segundos y cambia de lado.');

--flexibilidad
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
(26, 'La rotación de torso mejora la flexibilidad del tronco y ayuda a reducir la rigidez muscular en la parte superior del cuerpo.', 
    '1. Siéntate en el suelo con las piernas cruzadas o en una silla con los pies planos en el suelo. 
     2. Gira lentamente el torso hacia un lado, llevando una mano hacia el muslo opuesto. 
     3. Mantén la posición durante 15-20 segundos y vuelve al centro. 
     4. Repite hacia el otro lado.'),
(27, 'La rotación de columna promueve la flexibilidad en la zona lumbar y alivia la tensión acumulada.', 
    '1. Acuéstate boca arriba con los brazos extendidos en forma de "T". 
     2. Lleva las rodillas dobladas hacia un lado mientras mantienes los hombros en contacto con el suelo. 
     3. Sostén la posición durante 20-30 segundos y cambia al otro lado.'),
(28, 'El estiramiento de glúteos mejora la flexibilidad de la cadera y reduce la tensión en los músculos de la parte baja del cuerpo.', 
    '1. Acuéstate boca arriba y cruza una pierna sobre la otra, colocando el tobillo sobre la rodilla opuesta. 
     2. Agarra el muslo de la pierna inferior con ambas manos y tira suavemente hacia tu pecho. 
     3. Mantén la posición durante 20-30 segundos y cambia de lado.'),
(29, 'Las aperturas para pecho aumentan la flexibilidad de los músculos pectorales y mejoran la postura.', 
    '1. Colócate de pie en una puerta con los brazos extendidos y las manos apoyadas en el marco. 
     2. Da un paso hacia adelante con un pie mientras permites que el pecho se estire. 
     3. Sostén la posición durante 20-30 segundos.'),
(30, 'La flexión lateral de cadera mejora la movilidad de la cintura y fortalece los músculos laterales.', 
    '1. Siéntate o párate con la espalda recta y las piernas juntas. 
     2. Inclina el torso hacia un lado, extendiendo el brazo opuesto por encima de la cabeza. 
     3. Mantén la posición durante 15-20 segundos y repite hacia el otro lado.'),
(31, 'El estiramiento de tríceps libera la tensión en la parte posterior del brazo y mejora la movilidad del hombro.', 
    '1. Lleva un brazo por encima de la cabeza y dobla el codo para tocar la parte superior de la espalda. 
     2. Usa la otra mano para presionar suavemente el codo hacia abajo. 
     3. Mantén la posición durante 20-30 segundos y cambia de brazo.');

--deporte en equipo
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
(32, 'El fútbol es un deporte en equipo que mejora la resistencia cardiovascular, la coordinación y fortalece todo el cuerpo.', 
    '1. Forma un equipo y organiza un juego en un campo adecuado. 
     2. Corre, dribla y pasa el balón mientras trabajas en conjunto con tu equipo para anotar goles. 
     3. Mantén una comunicación constante con tus compañeros y sigue las reglas del juego. 
     4. Finaliza con estiramientos para evitar lesiones.'),
(33, 'El baloncesto desarrolla habilidades como la velocidad, la coordinación y la agilidad, mientras fortalece los músculos de todo el cuerpo.', 
    '1. Participa en un juego de equipo en una cancha adecuada. 
     2. Practica pases, tiros y dribles mientras te mueves por la cancha. 
     3. Defiende y ataca estratégicamente para ayudar a tu equipo a anotar puntos. 
     4. Estira al terminar el juego para relajar los músculos.'),
(34, 'El voleibol es un deporte en equipo que mejora la coordinación, el equilibrio y fortalece el core, brazos y piernas.', 
    '1. Forma un equipo y juega en una cancha con red. 
     2. Practica golpes básicos como saques, remates y bloqueos. 
     3. Trabaja en equipo para mantener la pelota en juego y ganar puntos. 
     4. Realiza estiramientos al finalizar para evitar tensión muscular.'),
(35, 'El rugby es un deporte intenso que combina fuerza, resistencia y estrategia, trabajando todo el cuerpo.', 
    '1. Participa en un juego en un campo adecuado con un balón ovalado. 
     2. Corre, pasa y taclea mientras sigues las reglas específicas del rugby. 
     3. Mantén una buena comunicación con tu equipo para lograr avances en el campo. 
     4. Enfría y estira después del juego para evitar lesiones.'),
(36, 'El hockey es un deporte en equipo que mejora la resistencia cardiovascular, la coordinación y la agilidad.', 
    '1. Juega en una cancha adecuada con un palo de hockey y una pelota o disco. 
     2. Practica pases, tiros y defensa mientras colaboras con tu equipo. 
     3. Sigue las reglas del juego para evitar infracciones y optimizar el desempeño del equipo. 
     4. Finaliza con ejercicios de estiramiento para relajar los músculos.');



