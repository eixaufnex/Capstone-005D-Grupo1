import { Router } from 'express';
import {
    getPublicaciones,
    getPublicacionesByUser,
    createPublicacion,
    likePublicacion,
    unlikePublicacion,
    deletePublicacion,
    hasUserLiked // Importa la nueva función
} from '../controllers/publicacion.controller.js';

const router = Router();

// Obtener todas las publicaciones
router.get("/publicacion", getPublicaciones);

// Obtener publicaciones de un usuario específico
router.get("/publicacion/usuario/:firebase_id", getPublicacionesByUser);

// Crear una nueva publicación
router.post("/publicacion", createPublicacion);

// Dar like a una publicación
router.post("/publicacion/:id_publicacion/like", likePublicacion);

// Quitar like a una publicación
router.post("/publicacion/:id_publicacion/unlike", unlikePublicacion);

// Verificar si el usuario ha dado like a una publicación específica
router.get("/publicacion/:id_publicacion/has_liked/:firebase_id", hasUserLiked);

// Eliminar una publicación
router.delete("/publicacion/:id_publicacion", deletePublicacion);

export default router;
