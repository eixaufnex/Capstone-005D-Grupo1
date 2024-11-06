import {Router} from 'express'
import {getUsuarios, 
        getUsuario, 
        createUsuario, 
        updateUsuario, 
        deleteUsuario} from '../controllers/usuario.controllers.js';

const router = Router()

//Obtener todos los usuarios
router.get("/usuario", getUsuarios);

//Obtener usuario por id
router.get("/usuario/:firebase_id", getUsuario);

//Creando usuario
router.post("/usuario", createUsuario);

//Actualizando usuario
router.put("/usuario/:firebase_id", updateUsuario);

//Eliminando usuario
router.delete("/usuario/:firebase_id", deleteUsuario);


export default router;