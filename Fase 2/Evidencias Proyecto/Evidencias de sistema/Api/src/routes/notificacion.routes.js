import {Router} from 'express';
import {getnotificaciones, 
        getnotificacion, 
        createNotificacion, 
        updateNotificacion, 
        deleteNotificacion} from '../controllers/notificacion.controller.js';


const router = Router()

//Obtener todos las notificaciones
router.get("/notificacion", getnotificaciones);

//Obtener notificaciones por id
router.get("/notificacion/:id", getnotificacion);

//Creando notificaciones
router.post("/notificacion", createNotificacion);

//Actualizando notificaciones
router.put("/notificacion/:id", updateNotificacion);

//Eliminando notificaciones
router.delete("/notificacion/:id", deleteNotificacion);


export default router;