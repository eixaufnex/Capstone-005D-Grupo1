import {Router} from 'express';
import {getObjetivoXUsuario,
        getObjetivos, 
        getObjetivo, 
        createObjetivo, 
        updateObjetivo, 
        deleteObjetivo} from '../controllers/objetivo.controller.js';



const router = Router()

//objetivo x usuario
router.get('/objetivo/usuario/:firebase_id', getObjetivoXUsuario);


//Obtener todos los objetivos
router.get("/objetivo", getObjetivos);

//Obtener objetivo por id
router.get("/objetivo/:id", getObjetivo);

//Creando objetivo
router.post("/objetivo", createObjetivo);

//Actualizando objetivo
router.put("/objetivo/:id", updateObjetivo);

//Eliminando objetivo
router.delete("/objetivo/:id", deleteObjetivo);


export default router;