import { Router } from 'express';
import {
    getRutinasDetalladasConEjercicios,
    getRutina_detallada,
    createRutina_detallada,
    updateRutina_detallada,
    deleteRutina_detallada
} from '../controllers/rutina_detallada.controller.js';

const router = Router();



// Obtener una rutina detallada por ID
router.get("/rutinas_detalladas/:id", getRutina_detallada);

// Crear una nueva rutina detallada
router.post("/rutinas_detalladas", createRutina_detallada);

// Actualizar una rutina detallada por ID
router.put("/rutinas_detalladas/:id", updateRutina_detallada);

// Eliminar una rutina detallada por ID
router.delete("/rutinas_detalladas/:id", deleteRutina_detallada);

// Obtener todas las rutinas detalladas con los ejercicios asociados
router.get("/rutinas_detalladas_ejercicios", getRutinasDetalladasConEjercicios);

export default router;
