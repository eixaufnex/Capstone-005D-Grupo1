import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todas las notificaciones
export const getnotificaciones = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query('SELECT * FROM NOTIFICACION;');
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener notificaciones:', error);
        res.status(500).json({ message: 'Error al obtener notificaciones' });
    }
};

// Obtener una notificación por id
export const getnotificacion = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_notificacion', sql.Int, req.params.id)
            .query('SELECT * FROM NOTIFICACION WHERE id_notificacion = @id_notificacion');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Notificación no encontrada" });
        }
        return res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener notificación:', error);
        res.status(500).json({ message: 'Error al obtener notificación' });
    }
};

// Crear una notificación
export const createNotificacion = async (req, res) => {
    const { tipo_notificacion, mensaje_notificacion, fecha_notificacion, firebase_id } = req.body;

    try {
        const pool = await getConnection();

        // Verificar si la notificación ya existe
        const existingNotificacion = await pool.request()
            .input('tipo_notificacion', sql.VarChar, tipo_notificacion)
            .query("SELECT COUNT(*) AS count FROM NOTIFICACION WHERE tipo_notificacion = @tipo_notificacion");

        if (existingNotificacion.recordset[0].count > 0) {
            return res.status(400).json({ message: 'La notificación ya está en uso' });
        }

        // Crear la nueva notificación
        const result = await pool.request()
            .input('tipo_notificacion', sql.VarChar, tipo_notificacion)
            .input('mensaje_notificacion', sql.Text, mensaje_notificacion)
            .input('fecha_notificacion', sql.Date, fecha_notificacion)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query(
                "INSERT INTO NOTIFICACION (tipo_notificacion, mensaje_notificacion, fecha_notificacion, firebase_id) VALUES (@tipo_notificacion, @mensaje_notificacion, @fecha_notificacion, @firebase_id); SELECT SCOPE_IDENTITY() AS id;"
            );

        res.status(201).json({
            id_notificacion: result.recordset[0].id,
            tipo_notificacion,
            mensaje_notificacion,
            fecha_notificacion,
            firebase_id
        });
    } catch (error) {
        console.error('Error al crear la notificación:', error);
        res.status(500).json({ message: 'Error al crear la notificación' });
    }
};

// Actualizar una notificación
export const updateNotificacion = async (req, res) => {
    const { id } = req.params;
    const { tipo_notificacion, mensaje_notificacion, fecha_notificacion, firebase_id } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_notificacion', sql.Int, id)
            .input('tipo_notificacion', sql.VarChar, tipo_notificacion)
            .input('mensaje_notificacion', sql.Text, mensaje_notificacion)
            .input('fecha_notificacion', sql.Date, fecha_notificacion)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query(
                "UPDATE NOTIFICACION SET tipo_notificacion = @tipo_notificacion, mensaje_notificacion = @mensaje_notificacion, fecha_notificacion = @fecha_notificacion, firebase_id = @firebase_id WHERE id_notificacion = @id_notificacion"
            );

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Notificación no encontrada" });
        }
        res.json({
            id_notificacion: id,
            tipo_notificacion,
            mensaje_notificacion,
            fecha_notificacion,
            firebase_id
        });
    } catch (error) {
        console.error('Error al actualizar la notificación:', error);
        res.status(500).json({ message: 'Error al actualizar la notificación' });
    }
};

// Eliminar una notificación
export const deleteNotificacion = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_notificacion', sql.Int, id)
            .query("DELETE FROM NOTIFICACION WHERE id_notificacion = @id_notificacion");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Notificación no encontrada" });
        }
        res.json({ message: "Notificación eliminada" });
    } catch (error) {
        console.error('Error al eliminar la notificación:', error);
        res.status(500).json({ message: 'Error al eliminar la notificación' });
    }
};
