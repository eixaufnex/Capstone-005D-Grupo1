import {Router} from 'express';
import {getFeedbacks, 
        getFeedback, 
        createFeedback, 
        updateFeedback, 
        deleteFeedback} from '../controllers/feedback.controller.js';



const router = Router()

//Obtener todos los feedbacks
router.get("/feedback", getFeedbacks);

//Obtener feedback por id
router.get("/feedback/:id", getFeedback);

//Creando feedback
router.post("/feedback", createFeedback);

//Actualizando feedback
router.put("/feedback/:id", updateFeedback);

//Eliminando feedback
router.delete("/feedback/:id", deleteFeedback);


export default router;