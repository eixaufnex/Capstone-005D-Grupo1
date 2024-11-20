import {Router} from 'express';
import {getDetalles_ejercicios, 
        getDetalle_ejercicio, 
        createDetalle_ejercicio, 
        updateDetalle_ejercicio, 
        deleteDetalle_ejercicio} from '../controllers/detalle_ejercicio.controller.js';



const router = Router()

//Obtener todos los detalles de ejercicio
router.get("/detalle_ejercicio", getDetalles_ejercicios);

//Obtener detalle de ejercicio por id
router.get("/detalle_ejercicio/:id", getDetalle_ejercicio);

//Creando detalle de ejercicio
router.post("/detalle_ejercicio", createDetalle_ejercicio);

//Actualizando detalle de ejercicio
router.put("/detalle_ejercicio/:id", updateDetalle_ejercicio);

//Eliminando detalle de ejercicio
router.delete("/detalle_ejercicio/:id", deleteDetalle_ejercicio);


export default router;