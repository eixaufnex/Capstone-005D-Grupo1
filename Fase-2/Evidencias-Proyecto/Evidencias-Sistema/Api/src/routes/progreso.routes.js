import {Router} from 'express';
import {getProgresos, 
        getProgreso, 
        createProgreso, 
        updateProgreso, 
        deleteProgreso} from '../controllers/progreso.controller.js';



const router = Router()

//Obtener todos los progresos
router.get("/progreso", getProgresos);

//Obtener progreso por id
router.get("/progreso/:id", getProgreso);

//Creando progreso
router.post("/progreso", createProgreso);

//Actualizando progreso
router.put("/progreso/:id", updateProgreso);

//Eliminando progreso
router.delete("/progreso/:id", deleteProgreso);


export default router;