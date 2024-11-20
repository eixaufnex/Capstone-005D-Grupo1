import { getConnection } from "../database/connection.js";
import sql from 'mssql';



// Obtener las rutinas y ejercicios de un usuario por su firebase_id
export const getRutinasAndEjerciciosByUser = async (req, res) => {
    const firebaseId = req.params.firebase_id;

    if (!firebaseId) {
        return res.status(400).json({ message: 'El firebase_id es obligatorio' });
    }

    try {
        const pool = await getConnection();

        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebaseId)
            .query(`
                SELECT 
                    r.id_rutina,
                    r.nombre_rutina,
                    le.id_lista_ejercicio,
                    le.nombre_ejercicio,
                    rd.series,
                    rd.repeticiones,
                    rd.peso,
                    rd.rpe,
                    rd.tiempo_ejercicio,
                    rd.fecha_rutina
                FROM 
                    USUARIO u
                JOIN 
                    RUTINA r ON u.firebase_id = r.firebase_id
                JOIN 
                    RUTINA_EJERCICIO re ON r.id_rutina = re.id_rutina
                JOIN 
                    LISTA_EJERCICIO le ON re.id_lista_ejercicio = le.id_lista_ejercicio
                JOIN 
                    RUTINA_DETALLADA rd ON re.id_rutina = rd.id_rutina AND re.id_lista_ejercicio = rd.id_lista_ejercicio
                WHERE 
                    u.firebase_id = @firebase_id
            `);

        res.status(200).json(result.recordset);
    } catch (error) {
        console.error('Error al obtener las rutinas y ejercicios del usuario:', error);
        res.status(500).json({ message: 'Error al obtener las rutinas y ejercicios del usuario', error: error.message });
    }
};




// Agregar ejercicios a una rutina
export const addEjerciciosToRutina = async (req, res) => {
    const { id_rutina, ejercicios_id } = req.body;

    // Validación de los datos de entrada
    if (!id_rutina || !Array.isArray(ejercicios_id) || ejercicios_id.length === 0) {
        return res.status(400).json({ message: 'Datos inválidos, asegúrate de enviar un id_rutina y un array de ejercicios_id' });
    }

    let transaction;

    try {
        const pool = await getConnection();
        
        // Iniciar una transacción
        transaction = new sql.Transaction(pool);
        await transaction.begin();

        for (let id_lista_ejercicio of ejercicios_id) {
            try {
                await transaction.request()
                    .input('id_rutina', sql.Int, id_rutina)
                    .input('id_lista_ejercicio', sql.Int, id_lista_ejercicio)
                    .query('INSERT INTO RUTINA_EJERCICIO (id_rutina, id_lista_ejercicio) VALUES (@id_rutina, @id_lista_ejercicio)');
            } catch (error) {
                throw new Error(`Error al agregar ejercicio ${id_lista_ejercicio}: ${error.message}`);
            }
        }

        await transaction.commit();
        res.status(200).json({ message: 'Ejercicios agregados a la rutina exitosamente' });
    } catch (error) {
        if (transaction) {
            await transaction.rollback();
        }
        console.error('Error al agregar ejercicios a la rutina:', error);
        res.status(500).json({ message: 'Error al agregar ejercicios a la rutina', error: error.message });
    }
};

// Obtener los ejercicios de una rutina por su id
export const getEjerciciosByRutina = async (req, res) => {
    const id_rutina = req.params.id;

    if (!id_rutina) {
        return res.status(400).json({ message: 'El id de la rutina es obligatorio' });
    }

    try {
        const pool = await getConnection();

        const checkRutina = await pool.request()
            .input('id_rutina', sql.Int, id_rutina)
            .query('SELECT COUNT(*) AS count FROM RUTINA WHERE id_rutina = @id_rutina');

        if (checkRutina.recordset[0].count === 0) {
            return res.status(404).json({ message: 'Rutina no encontrada' });
        }

        const result = await pool.request()
            .input('id_rutina', sql.Int, id_rutina)
            .query(`
                SELECT E.id_lista_ejercicio, E.nombre_ejercicio, E.tipo_ejercicio, E.dificultad_ejercicio
                FROM LISTA_EJERCICIO E
                JOIN RUTINA_EJERCICIO RE ON E.id_lista_ejercicio = RE.id_lista_ejercicio
                WHERE RE.id_rutina = @id_rutina
            `);

        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener los ejercicios de la rutina:', error);
        res.status(500).json({ message: 'Error al obtener los ejercicios de la rutina', error: error.message });
    }
};

// Eliminar un ejercicio de una rutina
export const deleteEjercicioFromRutina = async (req, res) => {
    const { id_rutina, id_lista_ejercicio } = req.params;

    // Validación de los parámetros
    if (!id_rutina || !id_lista_ejercicio) {
        return res.status(400).json({ message: 'Los parámetros id_rutina y id_lista_ejercicio son obligatorios' });
    }

    try {
        const pool = await getConnection();

        // Eliminar el ejercicio de la rutina
        await pool.request()
            .input('id_rutina', sql.Int, id_rutina)
            .input('id_lista_ejercicio', sql.Int, id_lista_ejercicio)
            .query('DELETE FROM RUTINA_EJERCICIO WHERE id_rutina = @id_rutina AND id_lista_ejercicio = @id_lista_ejercicio');

        res.status(200).json({ message: 'Ejercicio eliminado de la rutina exitosamente' });
    } catch (error) {
        console.error('Error al eliminar el ejercicio de la rutina:', error);
        res.status(500).json({ message: 'Error al eliminar el ejercicio de la rutina', error: error.message });
    }
};
