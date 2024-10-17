import {Router} from 'express';
import {getGrupos_muscular, 
    getGrupo_muscular, 
    createGrupo_muscular, 
    updateGrupo_muscular, 
    deleteGrupo_muscular} from '../controllers/gr_muscular.controller.js';


const router = Router()

//Obtener todos los grupos musculares
router.get("/grupo_muscular", getGrupos_muscular);

//Obtener grupo muscular por id
router.get("/grupo_muscular/:id", getGrupo_muscular);

//Creando grupo muscular
router.post("/grupo_muscular", createGrupo_muscular);

//Actualizando grupo muscular
router.put("/grupo_muscular/:id", updateGrupo_muscular);

//Eliminando grupo muscular
router.delete("/grupo_muscular/:id", deleteGrupo_muscular);


export default router;