import { getConnection } from "../database/connection.js";
import sql from 'mssql';


//obtener todos los usuarios
export const getUsuarios = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM USUARIO;')
    res.json(result.recordset)

};

// Obtener un usuario por id
export const getUsuario = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, req.params.firebase_id)
            .query('SELECT * FROM USUARIO WHERE firebase_id = @firebase_id');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Usuario no encontrado" });
        }
        return res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener usuario:', error);
        res.status(500).json({ message: 'Error al obtener usuario' });
    }
};



// Crear un usuario
export const createUsuario = async (req, res) => {
    const { firebase_id, username, rol = 'usuario', estado = 1 } = req.body;

    try {
        const pool = await getConnection();

        // Verificar si el nombre de usuario ya existe
        const existingUser = await pool.request()
            .input('username', sql.VarChar, username)
            .query("SELECT COUNT(*) AS count FROM USUARIO WHERE username = @username");

        if (existingUser.recordset[0].count > 0) {
            return res.status(400).json({ message: 'El username ya está en uso' });
        }

        // Crear el nuevo usuario
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .input('username', sql.VarChar, username)
            .input('rol', sql.VarChar, rol)
            .input('estado', sql.Int, estado)
            .query("INSERT INTO USUARIO (firebase_id, username, rol, estado, fecha_registro) VALUES (@firebase_id, @username, @rol, @estado, GETDATE())");

        res.status(201).json({ firebase_id, username, rol, estado });
    } catch (error) {
        console.error('Error al crear el usuario:', error);
        res.status(500).json({ message: 'Error al crear el usuario' });
    }
};

// Actualizar un usuario
export const updateUsuario = async (req, res) => {
    const { firebase_id } = req.params;
    const { username, rol, estado } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .input('username', sql.VarChar, username)
            .input('rol', sql.VarChar, rol)
            .input('estado', sql.Int, estado)
            .query("UPDATE USUARIO SET username = @username, rol = @rol, estado = @estado WHERE firebase_id = @firebase_id");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Usuario no encontrado" });
        }
        res.json({ firebase_id, username, rol, estado });
    } catch (error) {
        console.error('Error al actualizar el usuario:', error);
        res.status(500).json({ message: 'Error al actualizar el usuario' });
    }
};



// Eliminar un usuario
export const deleteUsuario = async (req, res) => {
    const { firebase_id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .query("DELETE FROM USUARIO WHERE firebase_id = @firebase_id");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Usuario no encontrado" });
        }
        res.json({ message: "Usuario eliminado" });
    } catch (error) {
        console.error('Error al eliminar el usuario:', error);
        res.status(500).json({ message: 'Error al eliminar el usuario' });
    }
};