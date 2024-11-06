import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todos los logros
export const getLogros = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query('SELECT * FROM LOGRO;');
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener logros:', error);
        res.status(500).json({ message: 'Error al obtener logros' });
    }
};

// Obtener un logro por id
export const getLogro = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_logro', sql.Int, req.params.id)
            .query('SELECT * FROM LOGRO WHERE id_logro = @id_logro');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Logro no encontrado" });
        }
        return res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener logro:', error);
        res.status(500).json({ message: 'Error al obtener logro' });
    }
};

// Crear un logro
export const createLogro = async (req, res) => {
    const { nombre_logro, descripcion_logro, fecha_obtencion, firebase_id } = req.body;

    try {
        const pool = await getConnection();

        // Verificar si el logro ya existe
        const existingLogro = await pool.request()
            .input('nombre_logro', sql.VarChar, nombre_logro)
            .query("SELECT COUNT(*) AS count FROM LOGRO WHERE nombre_logro = @nombre_logro");

        if (existingLogro.recordset[0].count > 0) {
            return res.status(400).json({ message: 'El logro ya está en uso' });
        }

        // Crear el nuevo logro
        const result = await pool.request()
            .input('nombre_logro', sql.VarChar, nombre_logro)
            .input('descripcion_logro', sql.Text, descripcion_logro)
            .input('fecha_obtencion', sql.Date, fecha_obtencion)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query(
                "INSERT INTO LOGRO (nombre_logro, descripcion_logro, fecha_obtencion, firebase_id) VALUES (@nombre_logro, @descripcion_logro, @fecha_obtencion, @firebase_id); SELECT SCOPE_IDENTITY() AS id;"
            );

        res.status(201).json({
            id_logro: result.recordset[0].id,
            nombre_logro,
            descripcion_logro,
            fecha_obtencion,
            firebase_id
        });
    } catch (error) {
        console.error('Error al crear el logro:', error);
        res.status(500).json({ message: 'Error al crear el logro' });
    }
};

// Actualizar un logro
export const updateLogro = async (req, res) => {
    const { id } = req.params;
    const { nombre_logro, descripcion_logro, fecha_obtencion, firebase_id } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_logro', sql.Int, id)
            .input('nombre_logro', sql.VarChar, nombre_logro)
            .input('descripcion_logro', sql.Text, descripcion_logro)
            .input('fecha_obtencion', sql.Date, fecha_obtencion)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query(
                "UPDATE LOGRO SET nombre_logro = @nombre_logro, descripcion_logro = @descripcion_logro, fecha_obtencion = @fecha_obtencion, firebase_id = @firebase_id WHERE id_logro = @id_logro"
            );

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Logro no encontrado" });
        }
        res.json({
            id_logro: id,
            nombre_logro,
            descripcion_logro,
            fecha_obtencion,
            firebase_id
        });
    } catch (error) {
        console.error('Error al actualizar el logro:', error);
        res.status(500).json({ message: 'Error al actualizar el logro' });
    }
};

// Eliminar un logro
export const deleteLogro = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_logro', sql.Int, id)
            .query("DELETE FROM LOGRO WHERE id_logro = @id_logro");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Logro no encontrado" });
        }
        res.json({ message: "Logro eliminado" });
    } catch (error) {
        console.error('Error al eliminar el logro:', error);
        res.status(500).json({ message: 'Error al eliminar el logro' });
    }
};
