import {Router} from 'express';
import {getRutinas, 
        getRutina,
        getRutinaXUsuario,
        createRutina, 
        updateRutina, 
        deleteRutina} from '../controllers/rutina.controller.js';



     const router = Router()

     router.get('/rutina/usuario/:firebase_id', getRutinaXUsuario);

     //Obtener todos las rutinas
     router.get("/rutina", getRutinas);
     
     //Obtener rutina por id
     router.get("/rutina/:id", getRutina);
     
     //Creando rutina
     router.post("/rutina", createRutina);
     
     //Actualizando rutina
     router.put("/rutina/:id", updateRutina);
     
     //Eliminando rutina
     router.delete("/rutina/:id", deleteRutina);
     
     
     export default router;