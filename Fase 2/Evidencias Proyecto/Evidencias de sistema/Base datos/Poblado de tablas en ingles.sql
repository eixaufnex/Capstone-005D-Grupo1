--GRUPO MUSCULAR 
INSERT INTO GRUPO_MUSCULAR(grupo_musculo, descripcion_musculo) VALUES
('Pectoral', 'Upper part of the torso, chest muscles'),
('Biceps', 'Front part of the upper arm, responsible for elbow flexion'),
('Triceps', 'Back part of the upper arm, responsible for elbow extension'),
('Lats', 'Middle and lower part of the back, main muscles for pulling movements'),
('Trapeze', 'Muscles of the upper back and neck'),
('Deltoids', 'Shoulders, muscles that cover the shoulder joint'),
('Quadriceps', 'Front part of the thigh, responsible for knee extension'),
('Hamstrings', 'Back part of the thigh, responsible for knee flexion'),
('Glutes', 'Main muscles of the hips, responsible for leg extension and abduction'),
('Abdominals', 'Front part of the torso, includes the rectus abdominis and obliques'),
('Obliques', 'Lateral abdominal muscles, responsible for torso rotation'),
('Spinal Erectors', 'Muscles along the spine, responsible for back extension and stability'),
('Calves', 'Muscles on the back of the leg, responsible for plantar flexion of the foot'),
('Hips', 'Muscles in the pelvic region, responsible for hip mobility'),
('Forearms', 'Muscles of the lower arm, responsible for grip and wrist flexion/extension'),
('Full Body', 'Muscles involved in exercises engaging multiple muscle groups');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--LISTA DE EJERCICIO
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, emoji_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(17, 'Bench Press', 'https://fitcron.com/wp-content/uploads/2021/03/01221301-Barbell-Wide-Bench-Press_Chest_720.gif', N'????', 'Strength', 'Intermediate'),
(17, 'Dumbbell Fly', 'https://fitcron.com/wp-content/uploads/2021/03/03081301-Dumbbell-Fly_Chest-FIX_720.gif', N'????', 'Strength', 'Beginner'),
(18, 'Hammer Curl', 'https://fitcron.com/wp-content/uploads/2021/04/02981301-Dumbbell-Cross-Body-Hammer-Curl_Forearms_720.gif', N'????', 'Strength', 'Advanced'),
(18, 'Biceps Curl', 'https://fitcron.com/wp-content/uploads/2021/04/16701301-Dumbbell-One-Arm-Standing-Curl_Upper-Arms_720.gif', N'????', 'Strength', 'Intermediate'),
(19, 'French Press', 'https://fitcron.com/wp-content/uploads/2021/03/00601301-Barbell-Lying-Triceps-Extension-Skull-Crusher_Triceps-SFIX_720.gif', N'????', 'Strength', 'Intermediate'),
(19, 'Triceps Extension', 'https://fitcron.com/wp-content/uploads/2021/04/03621301-Dumbbell-One-Arm-Triceps-Extension-on-bench_Upper-Arms_720.gif', N'????', 'Strength', 'Beginner'),
(20, 'One-Arm Row', 'https://fitcron.com/wp-content/uploads/2021/04/02921301-Dumbbell-Bent-over-Row_back_Back_720.gif', N'????', 'Strength', 'Beginner'),
(20, 'Pull-Ups', 'https://fitcron.com/wp-content/uploads/2021/04/18661301-Wide-Grip-Pull-Up-on-Dip-Cage_Back_720.gif', N'????', 'Strength', 'Advanced'),
(23, 'Leg Extension', 'https://fitcron.com/wp-content/uploads/2021/04/05851301-Lever-Leg-Extension_Thighs_720.gif', N'????', 'Strength', 'Beginner'),
(23, 'Leg Press', 'https://fitcron.com/wp-content/uploads/2021/04/15751301-Sled-45%C2%B0-Narrow-Stance-Leg-Press_Thighs_720.gif', N'????', 'Strength', 'Intermediate'),
(24, 'Romanian Deadlift', 'https://fitcron.com/wp-content/uploads/2021/04/00851301-Barbell-Romanian-Deadlift_Hips_720.gif', N'????', 'Strength', 'Intermediate'),
(25, 'Hip Thrust', 'https://fitcron.com/wp-content/uploads/2021/04/10601301-Barbell-Hip-Thrust_Hips_720.gif', N'????', 'Strength', 'Advanced'),
(26, 'Plank', 'https://fitcron.com/wp-content/uploads/2021/04/04631301-Front-Plank_waist-FIX_720.gif', N'????', 'Strength', 'Intermediate'),
(31, 'Wrist Curl', 'https://fitcron.com/wp-content/uploads/2021/03/03641301-Dumbbell-One-arm-Wrist-Curl_Forearm-SFIX_720.gif', N'????', 'Strength', 'Beginner');

-- Cardiovascular Exercises
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(23, 'Running', 'https://i.pinimg.com/originals/37/1a/d4/371ad4137ee381e717e5e65113ffe4b9.gif', 'Cardiovascular', 'Intermediate'),
(23, 'Cycling', 'https://i.pinimg.com/originals/a7/ba/d1/a7bad1af3dc134bcee4a75412271c48d.gif', 'Cardiovascular', 'Intermediate'),
(24, 'Stair Climber', 'https://fitcron.com/wp-content/uploads/2021/03/23111301-Walking-on-Stepmill_Thighs_720.gif', 'Cardiovascular', 'Beginner'),
(26, 'Jump Rope', 'https://cloudfront-us-east-1.images.arcpublishing.com/metroworldnews/ZPV6IYBM3ZC5JGLUJ77G564RHY.gif', 'Cardiovascular', 'Advanced'),
(32, 'Swimming', 'https://i.pinimg.com/originals/fa/b8/47/fab8474a3787b6a851a65936748bc8ec.gif', 'Cardiovascular', 'Advanced');

-- Stretching Exercises
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(23, 'Quadriceps Stretch', 'https://mundoentrenamiento.com/wp-content/uploads/2023/03/estiramientos-cuadriceps.jpeg', 'Stretching', 'Beginner'),
(30, 'Hip Stretch', 'https://cms2.vitapp.com/wp-content/uploads/2019/11/La-pose-del-tria%CC%81ngulo.gif', 'Stretching', 'Intermediate'),
(25, 'Glute Bridge', 'https://cdn.shopify.com/s/files/1/0982/0194/files/glutebridge_2048x2048.gif?v=1650467771', 'Stretching', 'Intermediate'),
(24, 'Hamstring Stretch', 'https://www.atmosferasport.es/img/cms/blog/estiaextenio.png', 'Stretching', 'Beginner'),
(20, 'Lats Stretch', 'https://columnaactiva.com/admin/uploads/img_61377215e4fec_241182251_123569980013036_8822539333660343188_n.jpg', 'Stretching', 'Intermediate'),
(28, 'Spinal Stretch', 'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2023/06/02/14/11/cat-stretch-8col-2563650-005.jpg', 'Stretching', 'Advanced');

-- Flexibility Exercises
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(26, 'Torso Rotation', 'https://www.realovirtual.com/pictures/2021/04/deca/deca_movimiento_cadera.gif', 'Flexibility', 'Beginner'),
(28, 'Spine Rotation', 'https://img.wtvideo.com/images/article/list/21408_1.jpg', 'Flexibility', 'Intermediate'),
(25, 'Glute Stretch', 'https://www.entrenamientos.com/media/cache/exercise_375/uploads/exercise/estiramiento-gluteo-isquitibial-superior-init-pos-5627.jpeg', 'Flexibility', 'Intermediate'),
(17, 'Chest Openers', 'https://www.entrenamientos.com/media/cache/exercise_375/uploads/exercise/aperturas-hombros-banda-elastica-init-pos-5155.png', 'Flexibility', 'Beginner'),
(30, 'Lateral Hip Flexion', 'https://www.entrenamientos.com/media/cache/exercise_375/uploads/exercise/flexion-lateral-de-tronco-con-mancuerna-init-pos-4779.png', 'Flexibility', 'Advanced'),
(19, 'Triceps Stretch', 'https://www.entrenamientos.com/media/cache/exercise_375/uploads/exercise/estiramiento-de-triceps-detras-de-la-cabeza-8438.png', 'Flexibility', 'Beginner');

-- Team Sports (Full Body Group)
INSERT INTO LISTA_EJERCICIO(id_grupo_muscular, nombre_ejercicio, imagen_ejercicio, tipo_ejercicio, dificultad_ejercicio) VALUES
(32, 'Soccer', 'https://as01.epimg.net/masdeporte/imagenes/2021/08/18/reportajes/1629287252_471087_1632935001_noticiareportajes_grande.jpg', 'Team Sport', 'Intermediate'),
(32, 'Basketball', 'https://cdn.vox-cdn.com/thumbor/46rp_6Tb025DqcqUvQw076nqPyY=/1400x1050/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/25551536/2164077239.jpg', 'Team Sport', 'Advanced'),
(32, 'Volleyball', 'https://cdn.britannica.com/95/190895-050-955A908C/volleyball-match-Italy-Russia-Milan-Volleyball-World.jpg', 'Team Sport', 'Beginner'),
(32, 'Rugby', 'https://journey.app/blog/wp-content/uploads/2022/01/ruck_reglas_del_rugby-1024x593.jpg', 'Team Sport', 'Advanced'),
(32, 'Hockey', 'https://img.olympics.com/images/image/private/t_s_16_9_g_auto/t_s_w960/f_auto/primary/r3ivyidaipxicsw4yrnt', 'Team Sport', 'Intermediate');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
-- Strength Exercises
(37, 'The bench press is a compound exercise that primarily targets the pectoral muscles, deltoids, and triceps.',
    '1. Lie on a flat bench and ensure your feet are firmly on the ground. 
     2. Hold the barbell with a grip slightly wider than shoulder-width apart. 
     3. Lower the barbell slowly until it lightly touches your chest. 
     4. Push the barbell upward until your arms are fully extended. 
     5. Repeat for the desired number of repetitions.'),
(38, 'Dumbbell fly is an isolation exercise that primarily targets the pectoral muscles, improving chest flexibility and strength.',
    '1. Lie on a flat bench holding a dumbbell in each hand. 
     2. Extend your arms upward with a slight bend at the elbows. 
     3. Open your arms to the sides in a controlled manner, keeping the elbows slightly bent. 
     4. Bring the dumbbells back to the starting position without touching them. 
     5. Repeat for the desired number of repetitions.'),
(39, 'Hammer curl focuses on developing the brachioradialis and biceps.',
    '1. Hold a dumbbell in each hand with a neutral grip (palms facing inward). 
     2. Keep your elbows close to your torso while lifting the dumbbells toward your shoulders. 
     3. Lower the dumbbells in a controlled manner to the starting position. 
     4. Repeat for the desired number of repetitions.'),
(40, 'Biceps curl is a classic exercise for building strength and size in the biceps.',
    '1. Hold a barbell or dumbbells with an underhand grip (palms facing up). 
     2. Keep your elbows close to your torso and curl the weights toward your shoulders. 
     3. Slowly lower the weights to the starting position. 
     4. Repeat for the desired number of repetitions.'),
(41, 'The French press targets the triceps muscles.',
    '1. Lie on a flat bench holding a barbell with a narrow grip. 
     2. Extend your arms upward and lower the barbell toward your forehead in a controlled motion. 
     3. Return to the starting position by extending your arms. 
     4. Repeat for the desired number of repetitions.'),
(42, 'Triceps extension is an isolation exercise for targeting the triceps muscle.',
    '1. Hold a dumbbell with both hands behind your head. 
     2. Extend your arms upward, keeping your elbows close to your head. 
     3. Lower the dumbbell behind your head in a controlled manner. 
     4. Repeat for the desired number of repetitions.'),
(43, 'One-arm row is a compound exercise that strengthens the lats, traps, and rear deltoids.',
    '1. Place one knee and one hand on a bench for support. 
     2. Hold a dumbbell in the opposite hand with your arm extended downward. 
     3. Pull the dumbbell toward the side of your torso, keeping your elbow close to your body. 
     4. Lower the dumbbell in a controlled manner to the starting position. 
     5. Repeat for the desired number of repetitions, then switch sides.'),
(44, 'Pull-ups are a compound exercise that primarily work the back, biceps, and core, enhancing upper body strength.',
    '1. Grab the bar with an overhand grip slightly wider than shoulder-width apart. 
     2. Hang from the bar with your arms fully extended and feet off the ground. 
     3. Pull your body upward until your chin passes above the bar. 
     4. Lower yourself slowly to the starting position with arms extended. 
     5. Repeat for the desired number of repetitions.'),
(45, 'Leg extension is an isolation exercise that targets the quadriceps.',
    '1. Sit on a leg extension machine and place your feet under the roller. 
     2. Extend your legs fully until they are straight. 
     3. Lower your legs slowly to the starting position. 
     4. Repeat for the desired number of repetitions.'),
(46, 'Leg press is a compound exercise that primarily targets the quadriceps, glutes, and hamstrings, improving leg strength.',
    '1. Sit on the leg press machine and place your feet shoulder-width apart on the platform. 
     2. Ensure your knees align with your feet and do not cave inward or outward. 
     3. Push the platform upward until your legs are almost fully extended without locking the knees. 
     4. Lower the platform slowly until your knees form a 90-degree angle. 
     5. Repeat for the desired number of repetitions.'),
(47, 'Romanian deadlift is a strength exercise that primarily targets the hamstrings and glutes.',
    '1. Hold a barbell with a grip slightly wider than shoulder-width. 
     2. Keep your legs slightly bent and lower the barbell toward the ground, maintaining a straight back. 
     3. Raise the barbell in a controlled manner to the starting position, squeezing the glutes at the top. 
     4. Repeat for the desired number of repetitions.'),
(48, 'Hip thrust is an exercise designed to strengthen the glutes.',
    '1. Sit on the ground with your upper back resting on a bench and a barbell over your hips. 
     2. Lift your hips upward until your body forms a straight line from shoulders to knees. 
     3. Lower your hips in a controlled manner without touching the ground. 
     4. Repeat for the desired number of repetitions.'),
(49, 'Plank is an isometric exercise that strengthens the core, including abdominals, obliques, and spinal erectors.',
    '1. Get into a plank position, resting on your forearms and toes. 
     2. Keep your body in a straight line from head to feet, avoiding sagging hips. 
     3. Tighten your abs and hold the position for the designated time. 
     4. Relax and repeat for the desired sets.'),
(50, 'Wrist curl is an exercise that strengthens the forearm muscles, specifically the wrist flexors.',
    '1. Sit on a bench and hold a barbell with an underhand grip (palms facing up). 
     2. Rest your forearms on your thighs with wrists extending beyond your knees. 
     3. Lower the barbell slowly, letting your wrists fully extend. 
     4. Raise the barbell by contracting your forearm muscles. 
     5. Repeat for the desired number of repetitions.');

-- Cardiovascular Exercises
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
(51, 'Running is a cardiovascular exercise that improves endurance, burns calories, and strengthens the leg muscles.',
    '1. Warm up for 5-10 minutes by walking or jogging slowly. 
     2. Run at a moderate pace while maintaining an upright posture and relaxed arms. 
     3. Breathe regularly and deeply to sustain your rhythm. 
     4. Cool down by walking and stretching muscles afterward.'),
(52, 'Cycling is a low-impact activity that strengthens leg muscles and improves cardiovascular fitness.',
    '1. Adjust the seat height so your knees are slightly bent when pedaling. 
     2. Pedal at a steady pace, keeping your back straight and elbows slightly bent. 
     3. Change resistance to simulate hills and flat roads depending on your training level. 
     4. Cool down with light pedaling for 5-10 minutes and stretch afterward.'),
(53, 'The stair climber simulates stair climbing, working the glutes, quadriceps, and hamstrings.',
    '1. Place your feet on the steps and adjust the machine to a comfortable speed. 
     2. Climb the steps while maintaining an upright posture, lightly holding the handrails. 
     3. Use your legs for movement and avoid leaning heavily on your arms. 
     4. Gradually reduce speed to cool down at the end.'),
(54, 'Jump rope is a full-body exercise that improves coordination, burns calories, and strengthens legs and core.',
    '1. Hold the rope with both hands and position it behind your feet. 
     2. Swing the rope forward using a smooth wrist motion. 
     3. Jump lightly to let the rope pass under your feet, maintaining a steady rhythm. 
     4. Continue for the desired duration and gradually increase speed for greater intensity.'),
(55, 'Swimming is a full-body exercise that enhances cardiovascular fitness and strengthens multiple muscle groups.',
    '1. Choose a swimming style suited to your level, such as freestyle, backstroke, breaststroke, or butterfly. 
     2. Maintain rhythmic breathing and use your whole body to execute the movements. 
     3. Alternate speed intervals with relaxed swimming for greater efficiency. 
     4. Finish with gentle strokes to cool down and stretch after exiting the water.');

-- Stretching Exercises
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
(56, 'Quadriceps stretch improves flexibility in the front of the thigh and reduces muscle tension.',
    '1. Stand and bend one leg backward, holding the ankle with the same-side hand. 
     2. Keep your knees close together and bring the heel toward your glutes. 
     3. Hold the position for 20-30 seconds without arching your back. 
     4. Switch legs and repeat.'),
(57, 'Hip stretch releases tension in the pelvis muscles and improves joint mobility.',
    '1. Sit on the floor with one leg extended forward and the other bent with the sole facing the opposite thigh. 
     2. Lean your torso toward the extended leg and reach toward the foot with your hands. 
     3. Hold the position for 20-30 seconds. 
     4. Switch sides and repeat.'),
(58, 'Glute bridge stretches and activates the glute muscles, improving posture and balance.',
    '1. Lie on your back with knees bent and feet flat on the floor. 
     2. Lift your hips upward, forming a straight line from shoulders to knees. 
     3. Hold the position for 10-15 seconds before lowering slowly. 
     4. Repeat multiple times.'),
(59, 'Hamstring stretch increases flexibility in the back of the thigh and prevents injuries.',
    '1. Stand and place one leg straight on an elevated surface such as a bench or step. 
     2. Lean your torso forward from the hips, keeping your back straight. 
     3. Hold the position for 20-30 seconds and switch legs.'),
(60, 'Lats stretch helps relieve tension in the upper and middle back.',
    '1. Stand or sit, interlace your hands in front of you, and stretch your arms forward. 
     2. Slightly lean your torso forward, spreading your shoulder blades apart. 
     3. Hold the position for 20-30 seconds.'),
(61, 'Spinal stretch improves flexibility and reduces stiffness in the lumbar and thoracic regions.',
    '1. Lie on your back with knees bent and feet flat on the floor. 
     2. Rotate your knees to one side while keeping your shoulders in contact with the floor. 
     3. Hold the position for 20-30 seconds and switch sides.');

-- Flexibility Exercises
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
(62, 'Torso rotation improves trunk flexibility and reduces muscle stiffness in the upper body.',
    '1. Sit on the floor cross-legged or on a chair with feet flat on the ground. 
     2. Slowly rotate your torso to one side, placing one hand on the opposite thigh. 
     3. Hold the position for 15-20 seconds and return to the center. 
     4. Repeat on the other side.'),
(63, 'Spine rotation promotes lumbar flexibility and relieves accumulated tension.',
    '1. Lie on your back with arms extended in a "T" shape. 
     2. Rotate your bent knees to one side while keeping shoulders on the ground. 
     3. Hold the position for 20-30 seconds and switch sides.'),
(64, 'Glute stretch improves hip flexibility and reduces tension in the lower body muscles.',
    '1. Lie on your back and cross one leg over the other, placing the ankle on the opposite knee. 
     2. Grab the thigh of the lower leg with both hands and gently pull toward your chest. 
     3. Hold the position for 20-30 seconds and switch sides.'),
(65, 'Chest openers increase flexibility in the pectoral muscles and improve posture.',
    '1. Stand in a doorway with your arms extended, hands resting on the frame. 
     2. Step forward with one foot while allowing your chest to stretch. 
     3. Hold the position for 20-30 seconds.'),
(66, 'Lateral hip flexion improves waist mobility and strengthens lateral muscles.',
    '1. Sit or stand with a straight back and legs together. 
     2. Lean your torso to one side, extending the opposite arm overhead. 
     3. Hold the position for 15-20 seconds and repeat on the other side.'),
(67, 'Triceps stretch relieves tension in the back of the arm and improves shoulder mobility.',
    '1. Raise one arm overhead and bend the elbow to touch your upper back. 
     2. Use the opposite hand to gently press the elbow downward. 
     3. Hold the position for 20-30 seconds and switch arms.');

-- Team Sports
INSERT INTO DETALLE_EJERCICIO(id_lista_ejercicio, descripcion_ejercicio, instrucciones_ejercicio) VALUES
(68, 'Soccer is a team sport that improves cardiovascular endurance, coordination, and strengthens the whole body.',
    '1. Form a team and play a game on a suitable field. 
     2. Run, dribble, and pass the ball while working with your team to score goals. 
     3. Maintain constant communication with teammates and follow the game rules. 
     4. Finish with stretching to prevent injuries.'),
(69, 'Basketball develops skills like speed, coordination, and agility while strengthening the whole body.',
    '1. Participate in a team game on a proper court. 
     2. Practice passing, shooting, and dribbling while moving around the court. 
     3. Defend and attack strategically to help your team score points. 
     4. Stretch after the game to relax muscles.'),
(70, 'Volleyball is a team sport that improves coordination, balance, and strengthens the core, arms, and legs.',
    '1. Form a team and play on a court with a net. 
     2. Practice basic moves such as serves, spikes, and blocks. 
     3. Work together to keep the ball in play and score points. 
     4. Stretch after the game to avoid muscle tension.'),
(71, 'Rugby is an intense sport combining strength, endurance, and strategy, engaging the whole body.',
    '1. Participate in a game on a suitable field with an oval ball. 
     2. Run, pass, and tackle while following specific rugby rules. 
     3. Communicate well with your team to make progress on the field. 
     4. Cool down and stretch after the game to avoid injuries.'),
(72, 'Hockey is a team sport that enhances cardiovascular endurance, coordination, and agility.',
    '1. Play on a suitable field with a hockey stick and a ball or puck. 
     2. Practice passing, shooting, and defending while collaborating with your team. 
     3. Follow game rules to avoid fouls and optimize team performance. 
     4. Finish with stretching exercises to relax muscles.');
