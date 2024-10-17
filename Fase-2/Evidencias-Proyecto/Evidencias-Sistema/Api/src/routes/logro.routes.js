import {Router} from 'express';
import {getLogros, 
        getLogro, 
        createLogro, 
        updateLogro, 
        deleteLogro} from '../controllers/logro.controller.js';



const router = Router()

//Obtener todos los logros
router.get("/logro", getLogros);

//Obtener logro por id
router.get("/logro/:id", getLogro);

//Creando logro
router.post("/logro", createLogro);

//Actualizando logro
router.put("/logro/:id", updateLogro);

//Eliminando logro
router.delete("/logro/:id", deleteLogro);


export default router;