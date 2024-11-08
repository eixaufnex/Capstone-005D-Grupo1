import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todas las rutinas detalladas
export const getRutinas_detalladas = async (req, res) => {
    const pool = await getConnection();
    const result = await pool.request().query('SELECT * FROM RUTINA_DETALLADA;');
    res.json(result.recordset);
};

// Obtener una rutina detallada por id
export const getRutina_detallada = async (req, res) => {
    console.log(req.params.id);
    const pool = await getConnection();
    const result = await pool.request()
        .input('id_rutina_detallada', sql.Int, req.params.id)
        .query('SELECT * FROM RUTINA_DETALLADA WHERE id_rutina_detallada = @id_rutina_detallada');

    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({ message: "Rutina detallada no encontrada" });
    }
    return res.json(result.recordset[0]);
};

// Crear una rutina detallada
export const createRutina_detallada = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try {
        // Verificar si la rutina detallada ya existe
        const existingRutina_detallada = await pool
            .request()
            .input('id_rutina_detallada', sql.Int, req.body.id_rutina_detallada)
            .query("SELECT COUNT(*) AS count FROM RUTINA_DETALLADA WHERE id_rutina_detallada = @id_rutina_detallada");

        if (existingRutina_detallada.recordset[0].count > 0) {
            return res.status(400).json({ message: 'La rutina detallada ya está en uso' });
        }

        // Si no existe, proceder a crear la nueva rutina detallada 
        const result = await pool
            .request()
            .input('series', sql.Int, req.body.series)
            .input('repeticiones', sql.Int, req.body.repeticiones)
            .input('peso', sql.Float, req.body.peso)
            .input('descanso', sql.Int, req.body.descanso)
            .input('fecha_rutina', sql.Date, req.body.fecha_rutina)
            .input('id_rutina', sql.Int, req.body.id_rutina)
            .input('id_lista_ejercicio', sql.Int, req.body.id_lista_ejercicio)
            .query("INSERT INTO RUTINA_DETALLADA (series, repeticiones, peso, descanso, fecha_rutina, id_rutina, id_lista_ejercicio) VALUES (@series, @repeticiones, @peso, @descanso, @fecha_rutina, @id_rutina, @id_lista_ejercicio); SELECT SCOPE_IDENTITY() AS id;");

        console.log(result);

        res.status(201).json({
            id_rutina_detallada: result.recordset[0].id,
            series: req.body.series,
            repeticiones: req.body.repeticiones,
            peso: req.body.peso,
            descanso: req.body.descanso,
            fecha_rutina: req.body.fecha_rutina,
            id_rutina: req.body.id_rutina, 
            id_lista_ejercicio: req.body.id_lista_ejercicio
        });
    } catch (error) {
        console.error('Error al crear la Rutina detallada', error);
        res.status(500).json({ message: 'Error al crear la Rutina detallada' });
    }
};

// Actualizar una rutina detallada 
export const updateRutina_detallada = async (req, res) => {
    const id = req.params.id;
    const pool = await getConnection();
    const result = await pool.request()
        .input('id_rutina_detallada', sql.Int, id)
        .input('series', sql.Int, req.body.series)
        .input('repeticiones', sql.Int, req.body.repeticiones)
        .input('peso', sql.Float, req.body.peso)
        .input('descanso', sql.Int, req.body.descanso)
        .input('fecha_rutina', sql.Date, req.body.fecha_rutina)
        .input('id_rutina', sql.Int, req.body.id_rutina) // Cambiado de id_usuario a id_rutina
        .input('id_lista_ejercicio', sql.Int, req.body.id_lista_ejercicio)
        .query("UPDATE RUTINA_DETALLADA SET series = @series, repeticiones = @repeticiones, peso = @peso, descanso = @descanso, fecha_rutina = @fecha_rutina, id_rutina = @id_rutina, id_lista_ejercicio = @id_lista_ejercicio WHERE id_rutina_detallada = @id_rutina_detallada");

    console.log(result);
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({ message: "Rutina detallada no encontrada" });
    }
    res.json({
        id_rutina_detallada: req.params.id,
        series: req.body.series,
        repeticiones: req.body.repeticiones,
        peso: req.body.peso,
        descanso: req.body.descanso,
        fecha_rutina: req.body.fecha_rutina,
        id_rutina: req.body.id_rutina, // Cambiado aquí también
        id_lista_ejercicio: req.body.id_lista_ejercicio
    });
};

// Eliminar una rutina detallada
export const deleteRutina_detallada = async (req, res) => {
    const pool = await getConnection();
    const result = await pool.request()
        .input('id_rutina_detallada', sql.Int, req.params.id)
        .query("DELETE FROM RUTINA_DETALLADA WHERE id_rutina_detallada = @id_rutina_detallada");
    
    console.log(result);
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({ message: "Rutina detallada no encontrada" });
    }
    return res.json({ message: "Rutina detallada eliminada" });
};
