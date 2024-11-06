import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todas las rutinas de un usuario específico por firebase_id
export const getRutinaXUsuario = async (req, res) => {
    const firebaseId = req.params.firebase_id; // Ajuste en la captura del parámetro
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebaseId)
            .query('SELECT * FROM RUTINA WHERE firebase_id = @firebase_id');

        if (!result.recordset || result.recordset.length === 0) {
            return res.status(404).json({ message: "No se encontraron rutinas para este usuario" });
        }

        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener las rutinas del usuario:', error);
        res.status(500).json({ message: "Error al obtener las rutinas del usuario" });
    }
};


// Obtener todas las rutinas
export const getRutinas = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query('SELECT * FROM RUTINA;');
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener rutinas:', error);
        res.status(500).json({ message: 'Error al obtener rutinas' });
    }
};

// Obtener una rutina por id
export const getRutina = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_rutina', sql.Int, req.params.id)
            .query('SELECT * FROM RUTINA WHERE id_rutina = @id_rutina');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Rutina no encontrada" });
        }
        return res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener la rutina:', error);
        res.status(500).json({ message: 'Error al obtener la rutina' });
    }
};

// Crear una rutina
export const createRutina = async (req, res) => {
    const { nombre_rutina, emoji, firebase_id } = req.body;

    try {
        const pool = await getConnection();

        // Verificar si la rutina ya existe
        const existingRutina = await pool.request()
            .input('nombre_rutina', sql.VarChar, nombre_rutina)
            .query("SELECT COUNT(*) AS count FROM RUTINA WHERE nombre_rutina = @nombre_rutina");

        if (existingRutina.recordset[0].count > 0) {
            return res.status(400).json({ message: 'La rutina ya está en uso' });
        }

        // Crear la nueva rutina
        const result = await pool.request()
            .input('nombre_rutina', sql.VarChar, nombre_rutina)
            .input('emoji', sql.NVarChar, emoji)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query("INSERT INTO RUTINA (nombre_rutina, emoji, firebase_id) VALUES (@nombre_rutina, @emoji, @firebase_id); SELECT SCOPE_IDENTITY() AS id;");

        res.status(201).json({
            id_rutina: result.recordset[0].id,
            nombre_rutina,
            emoji,
            firebase_id
        });
    } catch (error) {
        console.error('Error al crear la rutina:', error);
        res.status(500).json({ message: 'Error al crear la rutina' });
    }
};

// Actualizar una rutina
export const updateRutina = async (req, res) => {
    const { id } = req.params;
    const { nombre_rutina, emoji, firebase_id } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_rutina', sql.Int, id)
            .input('nombre_rutina', sql.VarChar, nombre_rutina)
            .input('emoji', sql.NVarChar, emoji)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query("UPDATE RUTINA SET nombre_rutina = @nombre_rutina, emoji = @emoji, firebase_id = @firebase_id WHERE id_rutina = @id_rutina");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Rutina no encontrada" });
        }
        res.json({
            id_rutina: id,
            nombre_rutina,
            emoji,
            firebase_id
        });
    } catch (error) {
        console.error('Error al actualizar la rutina:', error);
        res.status(500).json({ message: 'Error al actualizar la rutina' });
    }
};

// Eliminar una rutina
export const deleteRutina = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_rutina', sql.Int, id)
            .query("DELETE FROM RUTINA WHERE id_rutina = @id_rutina");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Rutina no encontrada" });
        }
        res.json({ message: "Rutina eliminada" });
    } catch (error) {
        console.error('Error al eliminar la rutina:', error);
        res.status(500).json({ message: 'Error al eliminar la rutina' });
    }
};
