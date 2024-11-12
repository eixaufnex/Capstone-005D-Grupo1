import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todos los logros globales
export const getLogrosGlobales = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query('SELECT * FROM LOGRO_GLOBAL;');
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener logros globales:', error);
        res.status(500).json({ message: 'Error al obtener logros globales' });
    }
};

// Obtener logros obtenidos por usuario
export const getLogrosObtenidosPorUsuario = async (req, res) => {
    const { firebase_id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .query(`
                SELECT LG.id_logro_global, LG.nombre_logro, LG.descripcion_logro, LO.fecha_obtencion
                FROM LOGRO_GLOBAL LG
                LEFT JOIN LOGRO_OBTENIDO LO ON LG.id_logro_global = LO.id_logro_global AND LO.firebase_id = @firebase_id
                ORDER BY LG.id_logro_global;
            `);

        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener logros obtenidos por usuario:', error);
        res.status(500).json({ message: 'Error al obtener logros obtenidos' });
    }
};

// Crear un logro global
export const createLogroGlobal = async (req, res) => {
    const { nombre_logro, descripcion_logro } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('nombre_logro', sql.VarChar, nombre_logro)
            .input('descripcion_logro', sql.Text, descripcion_logro)
            .query(`
                INSERT INTO LOGRO_GLOBAL (nombre_logro, descripcion_logro)
                VALUES (@nombre_logro, @descripcion_logro);
                SELECT SCOPE_IDENTITY() AS id;
            `);

        res.status(201).json({
            id_logro_global: result.recordset[0].id,
            nombre_logro,
            descripcion_logro
        });
    } catch (error) {
        console.error('Error al crear logro global:', error);
        res.status(500).json({ message: 'Error al crear logro global' });
    }
};

// Marcar un logro como obtenido por un usuario
export const obtenerLogro = async (req, res) => {
    const { firebase_id, id_logro_global } = req.body;
    const fecha_obtencion = new Date();  // Usamos la fecha actual

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .input('id_logro_global', sql.Int, id_logro_global)
            .input('fecha_obtencion', sql.Date, fecha_obtencion)
            .query(`
                INSERT INTO LOGRO_OBTENIDO (firebase_id, id_logro_global, fecha_obtencion)
                VALUES (@firebase_id, @id_logro_global, @fecha_obtencion);
            `);

        res.status(201).json({
            message: 'Logro obtenido registrado',
            firebase_id,
            id_logro_global,
            fecha_obtencion
        });
    } catch (error) {
        console.error('Error al registrar logro obtenido:', error);
        res.status(500).json({ message: 'Error al registrar logro obtenido' });
    }
};


// Editar un logro global
export const updateLogroGlobal = async (req, res) => {
    const { id } = req.params;
    const { nombre_logro, descripcion_logro } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_logro_global', sql.Int, id)
            .input('nombre_logro', sql.VarChar, nombre_logro)
            .input('descripcion_logro', sql.Text, descripcion_logro)
            .query(`
                UPDATE LOGRO_GLOBAL 
                SET nombre_logro = @nombre_logro, descripcion_logro = @descripcion_logro 
                WHERE id_logro_global = @id_logro_global
            `);

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Logro global no encontrado" });
        }
        res.json({ message: 'Logro global actualizado', id_logro_global: id });
    } catch (error) {
        console.error('Error al actualizar logro global:', error);
        res.status(500).json({ message: 'Error al actualizar logro global' });
    }
};

// Eliminar un logro global
export const deleteLogroGlobal = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_logro_global', sql.Int, id)
            .query("DELETE FROM LOGRO_GLOBAL WHERE id_logro_global = @id_logro_global");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Logro global no encontrado" });
        }
        res.json({ message: "Logro global eliminado" });
    } catch (error) {
        console.error('Error al eliminar logro global:', error);
        res.status(500).json({ message: 'Error al eliminar logro global' });
    }
};
