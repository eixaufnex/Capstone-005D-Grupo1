import {Router} from 'express';
import {getList_ejercicios, 
        getList_ejercicio, 
        createList_ejercicio, 
        updateList_ejercicio, 
        deleteList_ejercicio} from '../controllers/list_ejercicio.controller.js';



const router = Router()

//Obtener todos las listas de ejercicio
router.get("/lista_ejercicio", getList_ejercicios);

//Obtener lista de ejercicio por id
router.get("/lista_ejercicio/:id", getList_ejercicio);

//Creando lista de ejercicio
router.post("/lista_ejercicio", createList_ejercicio);

//Actualizando lista de ejercicio
router.put("/lista_ejercicio/:id", updateList_ejercicio);

//Eliminando lista de ejercicio
router.delete("/lista_ejercicio/:id", deleteList_ejercicio);


export default router;