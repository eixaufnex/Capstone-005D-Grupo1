import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todos los feedbacks
export const getFeedbacks = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query('SELECT * FROM FEEDBACK;');
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener feedbacks:', error);
        res.status(500).json({ message: 'Error al obtener feedbacks' });
    }
};

// Obtener un feedback por id
export const getFeedback = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_feedback', sql.Int, req.params.id)
            .query('SELECT * FROM FEEDBACK WHERE id_feedback = @id_feedback');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Feedback no encontrado" });
        }
        return res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener feedback:', error);
        res.status(500).json({ message: 'Error al obtener feedback' });
    }
};

// Crear un feedback
export const createFeedback = async (req, res) => {
    const { tipo_feedback, contenido_feed, fecha_envio_feed, firebase_id } = req.body;

    try {
        const pool = await getConnection();

        // Verificar si el feedback ya existe
        const existingFeedback = await pool.request()
            .input('contenido_feed', sql.VarChar, contenido_feed)
            .query("SELECT COUNT(*) AS count FROM FEEDBACK WHERE contenido_feed = @contenido_feed");

        if (existingFeedback.recordset[0].count > 0) {
            return res.status(400).json({ message: 'El contenido del feedback ya está en uso' });
        }

        // Crear el nuevo feedback
        const result = await pool.request()
            .input('tipo_feedback', sql.VarChar, tipo_feedback)
            .input('contenido_feed', sql.VarChar, contenido_feed)
            .input('fecha_envio_feed', sql.Date, fecha_envio_feed)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query(
                "INSERT INTO FEEDBACK (tipo_feedback, contenido_feed, fecha_envio_feed, firebase_id) VALUES (@tipo_feedback, @contenido_feed, @fecha_envio_feed, @firebase_id); SELECT SCOPE_IDENTITY() AS id;"
            );

        res.status(201).json({
            id_feedback: result.recordset[0].id,
            tipo_feedback,
            contenido_feed,
            fecha_envio_feed,
            firebase_id
        });
    } catch (error) {
        console.error('Error al crear el feedback:', error);
        res.status(500).json({ message: 'Error al crear el feedback' });
    }
};

// Actualizar un feedback
export const updateFeedback = async (req, res) => {
    const { id } = req.params;
    const { tipo_feedback, contenido_feed, fecha_envio_feed, firebase_id } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_feedback', sql.Int, id)
            .input('tipo_feedback', sql.VarChar, tipo_feedback)
            .input('contenido_feed', sql.VarChar, contenido_feed)
            .input('fecha_envio_feed', sql.Date, fecha_envio_feed)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query(
                "UPDATE FEEDBACK SET tipo_feedback = @tipo_feedback, contenido_feed = @contenido_feed, fecha_envio_feed = @fecha_envio_feed, firebase_id = @firebase_id WHERE id_feedback = @id_feedback"
            );

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Feedback no encontrado" });
        }
        res.json({
            id_feedback: id,
            tipo_feedback,
            contenido_feed,
            fecha_envio_feed,
            firebase_id
        });
    } catch (error) {
        console.error('Error al actualizar el feedback:', error);
        res.status(500).json({ message: 'Error al actualizar el feedback' });
    }
};

// Eliminar un feedback
export const deleteFeedback = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_feedback', sql.Int, id)
            .query("DELETE FROM FEEDBACK WHERE id_feedback = @id_feedback");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Feedback no encontrado" });
        }
        res.json({ message: "Feedback eliminado" });
    } catch (error) {
        console.error('Error al eliminar el feedback:', error);
        res.status(500).json({ message: 'Error al eliminar el feedback' });
    }
};
