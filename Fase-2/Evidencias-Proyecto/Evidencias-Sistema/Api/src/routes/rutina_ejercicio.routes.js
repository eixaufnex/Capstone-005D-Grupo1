import { Router } from 'express';
import { addEjerciciosToRutina, 
    getEjerciciosByRutina, 
    deleteEjercicioFromRutina} from '../controllers/rutina_ejercicio.controller.js';

const router = Router();

// Agregar ejercicios a una rutina
router.post('/rutina_ejercicio/agregar', addEjerciciosToRutina);

// Obtener los ejercicios de una rutina por su id
router.get('/rutina/:id/ejercicios', getEjerciciosByRutina);

router.delete('/rutina/:id_rutina/ejercicio/:id_lista_ejercicio', deleteEjercicioFromRutina);


export default router;
