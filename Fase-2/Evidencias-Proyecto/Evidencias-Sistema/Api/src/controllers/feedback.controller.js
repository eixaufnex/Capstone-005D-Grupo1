import { getConnection } from "../database/connection.js";
import sql from 'mssql';



//obtener todos los feedback
export const getFeedbacks = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM FEEDBACK;')
    res.json(result.recordset)

};


//obtener un feedback por id
export const getFeedback = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_feedback', sql.Int, req.params.id)
    .query('SELECT * FROM FEEDBACK WHERE id_feedback = @id_feedback');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Feedback no encontrado"});
    }
    return res.json(result.recordset[0])
};



// Crear un feedback
export const createFeedback = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try{
        //Verificar si el feedback ya existe NO SE SI ESTA BIEN
        const existingFeedback = await pool
            .request()
            .input('contenido_feed', sql.VarChar, req.body.contenido_feed)
            .query("SELECT COUNT(*) AS count FROM FEEDBACK WHERE contenido_feed = @contenido_feed");
        
        if (existingFeedback.recordset[0].count > 0){
            return res.status(400).json({ message: 'El feed ya está en uso'});
        }

        // Si no existe, proceder a crear el nuevo Feedback
        const result = await pool
            .request()
            .input('tipo_feedback', sql.VarChar, req.body.tipo_feedback)
            .input('contenido_feed', sql.VarChar, req.body.contenido_feed)
            .input('fecha_envio_feed', sql.Date, req.body.fecha_envio_feed)
            .input('id_usuario', sql.Int, req.body.id_usuario)
            .query("INSERT INTO FEEDBACK (tipo_feedback, contenido_feed, fecha_envio_feed, id_usuario) VALUES (@tipo_feedback, @contenido_feed, @fecha_envio_feed, @id_usuario); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);
        
        res.status(201).json({
            id_feedback: result.recordset[0].id,
            tipo_feedback: req.body.tipo_feedback,
            contenido_feed: req.body.contenido_feed,
            fecha_envio_feed: req.body.fecha_envio_feed,
            id_usuario: req.body.id_usuario
        });
    } catch (error){
        console.error('Error al crear el Feedback', error);
        res.status(500).json({ message: 'Error al crear el Feedback'});
    }
};


//Actualizar un Feedback 
export const updateFeedback = async (req, res) => {

    const id = req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_feedback', sql.Int, id)
        .input('tipo_feedback', sql.VarChar, req.body.tipo_feedback)
        .input('contenido_feed', sql.VarChar, req.body.contenido_feed)
        .input('fecha_envio_feed', sql.Date, req.body.fecha_envio_feed)
        .input('id_usuario', sql.Int, req.body.id_usuario)
        .query(
            "UPDATE FEEDBACK SET tipo_feedback = @tipo_feedback, contenido_feed = @contenido_feed, fecha_envio_feed = @fecha_envio_feed, id_usuario = @id_usuario WHERE id_feedback = @id_feedback"
        );


    console.log(result)
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({message: "Feeback no encontrado"});

    } res.json({
        id_feedback: req.params.id,
        tipo_feedback: req.body.tipo_feedback,
        contenido_feed: req.body.contenido_feed,
        fecha_envio_feed: req.body.fecha_envio_feed,
        id_usuario: req.body.id_usuario
    });
};


//eliminar un Feedback
export const deleteFeedback = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_feedback', sql.Int, req.params.id)
    .query("DELETE FROM FEEDBACK WHERE id_feedback = @id_feedback");
    console.log(result)
    if (result.rowsAffected[0] === 0 ){
        return res.status(404).json({message: "Feeback no encontrado"});
    }
    return res.json({ message: "Feedback eliminado"})
};