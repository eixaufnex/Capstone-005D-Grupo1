import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todas las listas de ejercicios con sus detalles
export const getList_ejercicios = async (req, res) => {
    const pool = await getConnection();
    const result = await pool.request().query(`
        SELECT 
            LE.id_lista_ejercicio,
            LE.nombre_ejercicio,
            LE.imagen_ejercicio,
            LE.emoji_ejercicio,
            LE.tipo_ejercicio,
            LE.dificultad_ejercicio,
            GM.id_grupo_muscular,
            GM.grupo_musculo AS grupo_muscular,
            DE.descripcion_ejercicio,
            DE.instrucciones_ejercicio
        FROM LISTA_EJERCICIO LE
        INNER JOIN GRUPO_MUSCULAR GM ON LE.id_grupo_muscular = GM.id_grupo_muscular
        LEFT JOIN DETALLE_EJERCICIO DE ON LE.id_lista_ejercicio = DE.id_lista_ejercicio;
    `);
    res.json(result.recordset);
};

// Obtener una lista de ejercicio con detalles por ID
export const getList_ejercicio = async (req, res) => {
    const { id } = req.params;
    const pool = await getConnection();
    const result = await pool.request()
        .input('id_lista_ejercicio', sql.Int, id)
        .query(`
            SELECT 
                LE.id_lista_ejercicio,
                LE.nombre_ejercicio,
                LE.imagen_ejercicio,
                LE.emoji_ejercicio,
                LE.tipo_ejercicio,
                LE.dificultad_ejercicio,
                GM.id_grupo_muscular,
                GM.grupo_musculo AS grupo_muscular,
                DE.descripcion_ejercicio,
                DE.instrucciones_ejercicio
            FROM LISTA_EJERCICIO LE
            INNER JOIN GRUPO_MUSCULAR GM ON LE.id_grupo_muscular = GM.id_grupo_muscular
            LEFT JOIN DETALLE_EJERCICIO DE ON LE.id_lista_ejercicio = DE.id_lista_ejercicio
            WHERE LE.id_lista_ejercicio = @id_lista_ejercicio;
        `);

    if (result.recordset.length === 0) {
        return res.status(404).json({ message: "Lista de ejercicio no encontrada" });
    }
    res.json(result.recordset[0]);
};

// Crear una nueva lista de ejercicio con detalles
export const createList_ejercicio = async (req, res) => {
    const { nombre_ejercicio, imagen_ejercicio, emoji_ejercicio, tipo_ejercicio, dificultad_ejercicio, id_grupo_muscular, descripcion_ejercicio, instrucciones_ejercicio } = req.body;
    const pool = await getConnection();

    try {
        // Verificar si el nombre del ejercicio ya existe
        const existingLista_ejercicio = await pool.request()
            .input('nombre_ejercicio', sql.VarChar, nombre_ejercicio)
            .query("SELECT COUNT(*) AS count FROM LISTA_EJERCICIO WHERE nombre_ejercicio = @nombre_ejercicio");

        if (existingLista_ejercicio.recordset[0].count > 0) {
            return res.status(400).json({ message: 'La lista de ejercicio ya está en uso' });
        }

        // Crear el nuevo ejercicio en la tabla LISTA_EJERCICIO
        const resultLE = await pool.request()
            .input('nombre_ejercicio', sql.VarChar, nombre_ejercicio)
            .input('imagen_ejercicio', sql.Text, imagen_ejercicio)
            .input('emoji_ejercicio', sql.NVarChar, emoji_ejercicio)
            .input('tipo_ejercicio', sql.VarChar, tipo_ejercicio)
            .input('dificultad_ejercicio', sql.VarChar, dificultad_ejercicio)
            .input('id_grupo_muscular', sql.Int, id_grupo_muscular)
            .query(`
                INSERT INTO LISTA_EJERCICIO (nombre_ejercicio, imagen_ejercicio, emoji_ejercicio, tipo_ejercicio, dificultad_ejercicio, id_grupo_muscular) 
                VALUES (@nombre_ejercicio, @imagen_ejercicio, @emoji_ejercicio, @tipo_ejercicio, @dificultad_ejercicio, @id_grupo_muscular);
                SELECT SCOPE_IDENTITY() AS id;
            `);

        const id_lista_ejercicio = resultLE.recordset[0].id;

        // Crear el detalle en la tabla DETALLE_EJERCICIO
        await pool.request()
            .input('descripcion_ejercicio', sql.Text, descripcion_ejercicio)
            .input('instrucciones_ejercicio', sql.VarChar, instrucciones_ejercicio)
            .input('id_lista_ejercicio', sql.Int, id_lista_ejercicio)
            .query(`
                INSERT INTO DETALLE_EJERCICIO (descripcion_ejercicio, instrucciones_ejercicio, id_lista_ejercicio) 
                VALUES (@descripcion_ejercicio, @instrucciones_ejercicio, @id_lista_ejercicio);
            `);

        res.status(201).json({
            id_lista_ejercicio,
            nombre_ejercicio,
            imagen_ejercicio,
            emoji_ejercicio,
            tipo_ejercicio,
            dificultad_ejercicio,
            id_grupo_muscular,
            descripcion_ejercicio,
            instrucciones_ejercicio
        });
    } catch (error) {
        console.error('Error al crear la lista de ejercicios', error);
        res.status(500).json({ message: 'Error al crear la lista de ejercicios' });
    }
};

// Actualizar una lista de ejercicios y su detalle
export const updateList_ejercicio = async (req, res) => {
    const { id } = req.params;
    const { nombre_ejercicio, imagen_ejercicio, emoji_ejercicio, tipo_ejercicio, dificultad_ejercicio, id_grupo_muscular, descripcion_ejercicio, instrucciones_ejercicio } = req.body;
    const pool = await getConnection();

    const result = await pool.request()
        .input('id_lista_ejercicio', sql.Int, id)
        .input('nombre_ejercicio', sql.VarChar, nombre_ejercicio)
        .input('imagen_ejercicio', sql.Text, imagen_ejercicio)
        .input('emoji_ejercicio', sql.NVarChar, emoji_ejercicio)
        .input('tipo_ejercicio', sql.VarChar, tipo_ejercicio)
        .input('dificultad_ejercicio', sql.VarChar, dificultad_ejercicio)
        .input('id_grupo_muscular', sql.Int, id_grupo_muscular)
        .query(`
            UPDATE LISTA_EJERCICIO 
            SET nombre_ejercicio = @nombre_ejercicio, imagen_ejercicio = @imagen_ejercicio, emoji_ejercicio = @emoji_ejercicio, 
                tipo_ejercicio = @tipo_ejercicio, dificultad_ejercicio = @dificultad_ejercicio, id_grupo_muscular = @id_grupo_muscular 
            WHERE id_lista_ejercicio = @id_lista_ejercicio;
        `);

    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({ message: "Lista de ejercicios no encontrada" });
    }

    // Actualizar el detalle en DETALLE_EJERCICIO
    await pool.request()
        .input('descripcion_ejercicio', sql.Text, descripcion_ejercicio)
        .input('instrucciones_ejercicio', sql.VarChar, instrucciones_ejercicio)
        .input('id_lista_ejercicio', sql.Int, id)
        .query(`
            UPDATE DETALLE_EJERCICIO 
            SET descripcion_ejercicio = @descripcion_ejercicio, instrucciones_ejercicio = @instrucciones_ejercicio 
            WHERE id_lista_ejercicio = @id_lista_ejercicio;
        `);

    res.json({
        id_lista_ejercicio: id,
        nombre_ejercicio,
        imagen_ejercicio,
        emoji_ejercicio,
        tipo_ejercicio,
        dificultad_ejercicio,
        id_grupo_muscular,
        descripcion_ejercicio,
        instrucciones_ejercicio
    });
};

// Eliminar una lista de ejercicios y su detalle
export const deleteList_ejercicio = async (req, res) => {
    const { id } = req.params;
    const pool = await getConnection();

    // Eliminar detalle primero (por la relación)
    await pool.request()
        .input('id_lista_ejercicio', sql.Int, id)
        .query("DELETE FROM DETALLE_EJERCICIO WHERE id_lista_ejercicio = @id_lista_ejercicio");

    // Eliminar el ejercicio
    const result = await pool.request()
        .input('id_lista_ejercicio', sql.Int, id)
        .query("DELETE FROM LISTA_EJERCICIO WHERE id_lista_ejercicio = @id_lista_ejercicio");

    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({ message: "Lista de ejercicio no encontrada" });
    }

    res.json({ message: "Lista de ejercicio eliminada" });
};
