import {Router} from 'express';
import {getRutinas_detalladas, 
        getRutina_detallada, 
        createRutina_detallada, 
        updateRutina_detallada, 
        deleteRutina_detallada} from '../controllers/rutina_detallada.controller.js';

const router = Router()

//Obtener todos las rutinas detalladas
router.get("/rutina_detallada", getRutinas_detalladas);
    
//Obtener rutina detallada por id
router.get("/rutina_detallada/:id", getRutina_detallada);
    
//Creando rutina detallada
router.post("/rutina_detallada", createRutina_detallada);
    
//Actualizando rutina detallada
router.put("/rutina_detallada/:id", updateRutina_detallada);
    
//Eliminando rutina detallada
router.delete("/rutina_detallada/:id", deleteRutina_detallada);
    
    
export default router;