import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todas las rutinas detalladas con sus ejercicios
export const getRutinasDetalladasConEjercicios = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query(`
            SELECT 
                rd.id_rutina_detallada,
                rd.id_rutina,
                rd.id_lista_ejercicio,
                rd.series,
                rd.repeticiones,
                rd.peso,
                rd.rpe,
                rd.tiempo_ejercicio,
                rd.fecha_rutina,
                rd.dias_rutina,
                rd.comentarios
            FROM 
                RUTINA_DETALLADA rd
            JOIN 
                RUTINA_EJERCICIO re ON rd.id_rutina = re.id_rutina AND rd.id_lista_ejercicio = re.id_lista_ejercicio;
        `);

        console.log("Datos de rutinas detalladas con ejercicios:", result.recordset);
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener rutinas detalladas con ejercicios:', error);
        res.status(500).json({ message: 'Error al obtener rutinas detalladas con ejercicios.' });
    }
};

// Obtener una rutina detallada por id
export const getRutina_detallada = async (req, res) => {
    const id = req.params.id;
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_rutina_detallada', sql.Int, id)
            .query(`
                SELECT * 
                FROM RUTINA_DETALLADA 
                WHERE id_rutina_detallada = @id_rutina_detallada
            `);

        if (result.recordset.length === 0) {
            return res.status(404).json({ message: "Rutina detallada no encontrada." });
        }
        res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener la rutina detallada:', error);
        res.status(500).json({ message: 'Error al obtener la rutina detallada.' });
    }
};

// Crear una rutina detallada
export const createRutina_detallada = async (req, res) => {
    const { series, repeticiones, peso, rpe, tiempo_ejercicio, fecha_rutina, dias_rutina, comentarios, id_rutina, id_lista_ejercicio } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('series', sql.Int, series)
            .input('repeticiones', sql.Int, repeticiones)
            .input('peso', sql.Float, peso)
            .input('rpe', sql.Int, rpe)
            .input('tiempo_ejercicio', sql.Int, tiempo_ejercicio)
            .input('fecha_rutina', sql.Date, fecha_rutina)
            .input('dias_rutina', sql.VarChar, dias_rutina)
            .input('comentarios', sql.Text, comentarios)
            .input('id_rutina', sql.Int, id_rutina)
            .input('id_lista_ejercicio', sql.Int, id_lista_ejercicio)
            .query(`
                INSERT INTO RUTINA_DETALLADA 
                (series, repeticiones, peso, rpe, tiempo_ejercicio, fecha_rutina, dias_rutina, comentarios, id_rutina, id_lista_ejercicio) 
                VALUES (@series, @repeticiones, @peso, @rpe, @tiempo_ejercicio, @fecha_rutina, @dias_rutina, @comentarios, @id_rutina, @id_lista_ejercicio);
                SELECT SCOPE_IDENTITY() AS id_rutina_detallada;
            `);

        res.status(201).json({
            id_rutina_detallada: result.recordset[0].id_rutina_detallada,
            series,
            repeticiones,
            peso,
            rpe,
            tiempo_ejercicio,
            fecha_rutina,
            dias_rutina,
            comentarios,
            id_rutina,
            id_lista_ejercicio
        });
    } catch (error) {
        console.error('Error al crear la rutina detallada:', error);
        res.status(500).json({ message: 'Error al crear la rutina detallada.' });
    }
};

// Actualizar una rutina detallada
export const updateRutina_detallada = async (req, res) => {
    const id = req.params.id;
    const { series, repeticiones, peso, rpe, tiempo_ejercicio, fecha_rutina, dias_rutina, comentarios, id_rutina, id_lista_ejercicio } = req.body;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_rutina_detallada', sql.Int, id)
            .input('series', sql.Int, series)
            .input('repeticiones', sql.Int, repeticiones)
            .input('peso', sql.Float, peso)
            .input('rpe', sql.Int, rpe)
            .input('tiempo_ejercicio', sql.Int, tiempo_ejercicio)
            .input('fecha_rutina', sql.Date, fecha_rutina)
            .input('dias_rutina', sql.VarChar, dias_rutina)
            .input('comentarios', sql.Text, comentarios)
            .input('id_rutina', sql.Int, id_rutina)
            .input('id_lista_ejercicio', sql.Int, id_lista_ejercicio)
            .query(`
                UPDATE RUTINA_DETALLADA 
                SET series = @series, repeticiones = @repeticiones, peso = @peso, rpe = @rpe, tiempo_ejercicio = @tiempo_ejercicio, 
                    fecha_rutina = @fecha_rutina, dias_rutina = @dias_rutina, comentarios = @comentarios, id_rutina = @id_rutina, id_lista_ejercicio = @id_lista_ejercicio
                WHERE id_rutina_detallada = @id_rutina_detallada
            `);

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Rutina detallada no encontrada." });
        }
        res.json({
            id_rutina_detallada: id,
            series,
            repeticiones,
            peso,
            rpe,
            tiempo_ejercicio,
            fecha_rutina,
            dias_rutina,
            comentarios,
            id_rutina,
            id_lista_ejercicio
        });
    } catch (error) {
        console.error('Error al actualizar la rutina detallada:', error);
        res.status(500).json({ message: 'Error al actualizar la rutina detallada.' });
    }
};

// Eliminar una rutina detallada
export const deleteRutina_detallada = async (req, res) => {
    const id = req.params.id;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_rutina_detallada', sql.Int, id)
            .query("DELETE FROM RUTINA_DETALLADA WHERE id_rutina_detallada = @id_rutina_detallada");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Rutina detallada no encontrada." });
        }
        res.json({ message: "Rutina detallada eliminada exitosamente." });
    } catch (error) {
        console.error('Error al eliminar la rutina detallada:', error);
        res.status(500).json({ message: 'Error al eliminar la rutina detallada.' });
    }
};
