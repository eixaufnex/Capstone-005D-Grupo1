import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todos los objetivos
export const getObjetivos = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query('SELECT * FROM OBJETIVO;');
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener objetivos:', error);
        res.status(500).json({ message: 'Error al obtener objetivos' });
    }
};

// Obtener un objetivo por id
export const getObjetivo = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_objetivo', sql.Int, req.params.id)
            .query('SELECT * FROM OBJETIVO WHERE id_objetivo = @id_objetivo');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Objetivo no encontrado" });
        }
        return res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener objetivo:', error);
        res.status(500).json({ message: 'Error al obtener objetivo' });
    }
};

// Crear un objetivo
export const createObjetivo = async (req, res) => {
    const { tipo_objetivo, nombre_objetivo, descripcion_objetivo, valor_inicial, valor_actual, valor_objetivo, fecha_limite, alcanzado, firebase_id } = req.body;

    try {
        const pool = await getConnection();

        // Verificar si el objetivo ya existe (nombre y firebase_id)
        const existingObjetivo = await pool.request()
            .input('nombre_objetivo', sql.VarChar, nombre_objetivo)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query("SELECT COUNT(*) AS count FROM OBJETIVO WHERE nombre_objetivo = @nombre_objetivo AND firebase_id = @firebase_id");

        if (existingObjetivo.recordset[0].count > 0) {
            return res.status(400).json({ error: 'El objetivo ya está en uso' });
        }

        // Crear el nuevo objetivo
        const result = await pool.request()
            .input('tipo_objetivo', sql.VarChar, tipo_objetivo)
            .input('nombre_objetivo', sql.VarChar, nombre_objetivo)
            .input('descripcion_objetivo', sql.Text, descripcion_objetivo)
            .input('valor_inicial', sql.Int, valor_inicial)
            .input('valor_actual', sql.Int, valor_actual)
            .input('valor_objetivo', sql.Int, valor_objetivo)
            .input('fecha_limite', sql.Date, fecha_limite)
            .input('alcanzado', sql.VarChar, alcanzado)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query(
                "INSERT INTO OBJETIVO (tipo_objetivo, nombre_objetivo, descripcion_objetivo, valor_inicial, valor_actual, valor_objetivo, fecha_limite, alcanzado, firebase_id) VALUES (@tipo_objetivo, @nombre_objetivo, @descripcion_objetivo, @valor_inicial, @valor_actual, @valor_objetivo, @fecha_limite, @alcanzado, @firebase_id); SELECT SCOPE_IDENTITY() AS id_objetivo;"
            );

        res.status(201).json({
            id_objetivo: result.recordset[0].id_objetivo,
            tipo_objetivo,
            nombre_objetivo,
            descripcion_objetivo,
            valor_inicial,
            valor_actual,
            valor_objetivo,
            fecha_limite,
            alcanzado,
            firebase_id
        });
    } catch (error) {
        console.error('Error al crear el objetivo:', error);
        res.status(500).json({ error: 'Error al crear el objetivo', details: error.message });
    }
};


// Actualizar un objetivo
export const updateObjetivo = async (req, res) => {
    const { id } = req.params;
    const {
        tipo_objetivo,
        nombre_objetivo,
        descripcion_objetivo,
        valor_inicial,
        valor_actual,
        valor_objetivo,
        fecha_limite,
        alcanzado,
        firebase_id
    } = req.body;

    // Validación de datos de entrada
    if (!tipo_objetivo || !nombre_objetivo || !firebase_id || valor_inicial == null || valor_objetivo == null) {
        return res.status(400).json({ message: "Datos incompletos" });
    }

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_objetivo', sql.Int, id)
            .input('tipo_objetivo', sql.VarChar, tipo_objetivo)
            .input('nombre_objetivo', sql.VarChar, nombre_objetivo)
            .input('descripcion_objetivo', sql.Text, descripcion_objetivo)
            .input('valor_inicial', sql.Int, valor_inicial)
            .input('valor_actual', sql.Int, valor_actual)
            .input('valor_objetivo', sql.Int, valor_objetivo)
            .input('fecha_limite', sql.Date, fecha_limite)
            .input('alcanzado', sql.VarChar, alcanzado)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query(`
                UPDATE OBJETIVO 
                SET tipo_objetivo = @tipo_objetivo, 
                    nombre_objetivo = @nombre_objetivo, 
                    descripcion_objetivo = @descripcion_objetivo, 
                    valor_inicial = @valor_inicial,
                    valor_actual = @valor_actual,
                    valor_objetivo = @valor_objetivo, 
                    fecha_limite = @fecha_limite, 
                    alcanzado = @alcanzado, 
                    firebase_id = @firebase_id 
                WHERE id_objetivo = @id_objetivo
            `);

        // Verificar si se encontró el objetivo
        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Objetivo no encontrado" });
        }

        res.json({ message: "Objetivo actualizado correctamente" });
    } catch (error) {
        console.error('Error al actualizar el objetivo:', error);
        res.status(500).json({ message: 'Error al actualizar el objetivo' });
    }
};


// Eliminar un objetivo
export const deleteObjetivo = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_objetivo', sql.Int, id)
            .query("DELETE FROM OBJETIVO WHERE id_objetivo = @id_objetivo");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Objetivo no encontrado" });
        }
        res.json({ message: "Objetivo eliminado" });
    } catch (error) {
        console.error('Error al eliminar el objetivo:', error);
        res.status(500).json({ message: 'Error al eliminar el objetivo' });
    }
};
