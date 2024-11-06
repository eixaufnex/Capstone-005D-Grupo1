import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todos los perfiles
export const getPerfiles = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query('SELECT * FROM PERFIL;');
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener perfiles:', error);
        res.status(500).json({ message: 'Error al obtener perfiles' });
    }
};

// Obtener un perfil por id
export const getPerfil = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_perfil', sql.Int, req.params.id)
            .query('SELECT * FROM PERFIL WHERE id_perfil = @id_perfil');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Perfil no encontrado" });
        }
        return res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener perfil:', error);
        res.status(500).json({ message: 'Error al obtener perfil' });
    }
};

// Crear un perfil
export const createPerfil = async (req, res) => {
    const { nombre, apellido, tipo_nivel, foto_perfil, biografia, firebase_id } = req.body;

    try {
        const pool = await getConnection();

        // Verificar si el perfil ya existe
        const existingPerfil = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .query("SELECT COUNT(*) AS count FROM PERFIL WHERE firebase_id = @firebase_id");

        if (existingPerfil.recordset[0].count > 0) {
            return res.status(400).json({ message: 'El perfil ya está en uso' });
        }

        // Crear el nuevo perfil
        const result = await pool.request()
            .input('nombre', sql.VarChar, nombre)
            .input('apellido', sql.VarChar, apellido)
            .input('tipo_nivel', sql.VarChar, tipo_nivel)
            .input('foto_perfil', sql.VarBinary, foto_perfil) // Usa VarBinary para imagenes
            .input('biografia', sql.Text, biografia)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query("INSERT INTO PERFIL (nombre, apellido, tipo_nivel, foto_perfil, biografia, firebase_id) VALUES (@nombre, @apellido, @tipo_nivel, @foto_perfil, @biografia, @firebase_id); SELECT SCOPE_IDENTITY() AS id;");

        res.status(201).json({
            id_perfil: result.recordset[0].id,
            nombre,
            apellido,
            tipo_nivel,
            foto_perfil,
            biografia,
            firebase_id
        });
    } catch (error) {
        console.error('Error al crear el perfil:', error);
        res.status(500).json({ message: 'Error al crear el perfil' });
    }
};

// Actualizar un perfil
export const updatePerfil = async (req, res) => {
    const { id } = req.params;
    const { nombre, apellido, tipo_nivel, foto_perfil, biografia, firebase_id } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_perfil', sql.Int, id)
            .input('nombre', sql.VarChar, nombre)
            .input('apellido', sql.VarChar, apellido)
            .input('tipo_nivel', sql.VarChar, tipo_nivel)
            .input('foto_perfil', sql.VarBinary, foto_perfil) // Usa VarBinary para imagenes
            .input('biografia', sql.Text, biografia)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query("UPDATE PERFIL SET nombre = @nombre, apellido = @apellido, tipo_nivel = @tipo_nivel, foto_perfil = @foto_perfil, biografia = @biografia, firebase_id = @firebase_id WHERE id_perfil = @id_perfil");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Perfil no encontrado" });
        }
        res.json({
            id_perfil: id,
            nombre,
            apellido,
            tipo_nivel,
            foto_perfil,
            biografia,
            firebase_id
        });
    } catch (error) {
        console.error('Error al actualizar el perfil:', error);
        res.status(500).json({ message: 'Error al actualizar el perfil' });
    }
};

// Eliminar un perfil
export const deletePerfil = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_perfil', sql.Int, id)
            .query("DELETE FROM PERFIL WHERE id_perfil = @id_perfil");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Perfil no encontrado" });
        }
        res.json({ message: "Perfil eliminado" });
    } catch (error) {
        console.error('Error al eliminar el perfil:', error);
        res.status(500).json({ message: 'Error al eliminar el perfil' });
    }
};
