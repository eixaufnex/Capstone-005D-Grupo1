import { Router } from 'express';
import {
    getLogrosGlobales,
    getLogrosObtenidosPorUsuario,
    createLogroGlobal,
    obtenerLogro,
    updateLogroGlobal,
    deleteLogroGlobal
} from '../controllers/logro.controller.js';

const router = Router();

// Obtener todos los logros globales
router.get("/logros-globales", getLogrosGlobales);

// Obtener logros obtenidos por un usuario específico
router.get("/logros-obtenidos/:firebase_id", getLogrosObtenidosPorUsuario);

// Crear un nuevo logro global
router.post("/logros-globales", createLogroGlobal);

// Marcar un logro como obtenido por un usuario
router.post("/logros-obtenidos", obtenerLogro);

// Actualizar un logro global
router.put("/logros-globales/:id", updateLogroGlobal);

// Eliminar un logro global
router.delete("/logros-globales/:id", deleteLogroGlobal);

export default router;
