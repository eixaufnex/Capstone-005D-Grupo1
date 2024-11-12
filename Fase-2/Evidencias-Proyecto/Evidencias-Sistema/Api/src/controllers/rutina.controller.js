import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todas las rutinas de un usuario específico por firebase_id
export const getRutinaXUsuario = async (req, res) => {
    const { firebase_id } = req.params;
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .query('SELECT * FROM RUTINA WHERE firebase_id = @firebase_id');

        if (result.recordset.length === 0) {
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
    const { nombre_rutina, emoji, firebase_id, tipo_rutina, ejercicios } = req.body;

    try {
        const pool = await getConnection();

        // Crear la nueva rutina
        const result = await pool.request()
            .input('nombre_rutina', sql.VarChar, nombre_rutina)
            .input('emoji', sql.NVarChar, emoji)
            .input('firebase_id', sql.VarChar, firebase_id)
            .input('tipo_rutina', sql.VarChar, tipo_rutina)
            .query("INSERT INTO RUTINA (nombre_rutina, emoji, firebase_id, tipo_rutina) VALUES (@nombre_rutina, @emoji, @firebase_id, @tipo_rutina); SELECT SCOPE_IDENTITY() AS id;");

        const id_rutina = result.recordset[0].id;

        // Insertar los ejercicios relacionados en la tabla RUTINA_EJERCICIO, si se reciben en el cuerpo de la solicitud
        if (ejercicios && ejercicios.length > 0) {
            for (const ejercicio of ejercicios) {
                await pool.request()
                    .input('id_rutina', sql.Int, id_rutina)
                    .input('id_lista_ejercicio', sql.Int, ejercicio.id_lista_ejercicio)
                    .query("INSERT INTO RUTINA_EJERCICIO (id_rutina, id_lista_ejercicio) VALUES (@id_rutina, @id_lista_ejercicio)");
            }
        }

        res.status(201).json({
            id_rutina,
            nombre_rutina,
            emoji,
            firebase_id,
            tipo_rutina
        });
    } catch (error) {
        console.error('Error al crear la rutina:', error);
        res.status(500).json({ message: 'Error al crear la rutina' });
    }
};

// Actualizar una rutina
export const updateRutina = async (req, res) => {
    const { id } = req.params;
    const { nombre_rutina, emoji, firebase_id, tipo_rutina } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_rutina', sql.Int, id)
            .input('nombre_rutina', sql.VarChar, nombre_rutina)
            .input('emoji', sql.NVarChar, emoji)
            .input('firebase_id', sql.VarChar, firebase_id)
            .input('tipo_rutina', sql.VarChar, tipo_rutina)
            .query("UPDATE RUTINA SET nombre_rutina = @nombre_rutina, emoji = @emoji, firebase_id = @firebase_id, tipo_rutina = @tipo_rutina WHERE id_rutina = @id_rutina");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Rutina no encontrada" });
        }
        res.json({
            id_rutina: id,
            nombre_rutina,
            emoji,
            firebase_id,
            tipo_rutina
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
