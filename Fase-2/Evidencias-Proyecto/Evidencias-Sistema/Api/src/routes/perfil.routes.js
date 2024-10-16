import {Router} from 'express';
import {getPerfiles, 
        getPerfil, 
        createPerfil, 
        updatePerfil, 
        deletePerfil} from '../controllers/perfil.controller.js';



const router = Router()

//Obtener todos los Perfiles
router.get("/perfil", getPerfiles);

//Obtener perfil por id
router.get("/perfil/:id", getPerfil);

//Creando perfil
router.post("/perfil", createPerfil);

//Actualizando perfil
router.put("/perfil/:id", updatePerfil);

//Eliminando perfil
router.delete("/perfil/:id", deletePerfil);


export default router;