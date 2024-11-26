import {Router} from 'express';
import {getPerfiles, 
        getPerfil, 
        getPerfilxfirebase,
        createPerfil, 
        updatePerfil, 
        deletePerfil} from '../controllers/perfil.controller.js';



const router = Router()

//Obtener todos los Perfiles
router.get("/perfil", getPerfiles);

//Obtener perfil por id
router.get("/perfil/:id", getPerfil);

//Obtener perfil por firebase
router.get("/perfil/usuario/:firebase_id", getPerfilxfirebase);

//Creando perfil
router.post("/perfil", createPerfil);

//Actualizando perfil
router.put("/perfil/usuario/:firebase_id", updatePerfil);

//Eliminando perfil
router.delete("/perfil/:id", deletePerfil);


export default router;