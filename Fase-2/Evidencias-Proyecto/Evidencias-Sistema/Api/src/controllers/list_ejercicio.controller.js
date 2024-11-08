import { getConnection } from "../database/connection.js";
import sql from 'mssql';



//obtener todas las listas de ejercicios
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
            GM.grupo_musculo AS grupo_muscular
        FROM LISTA_EJERCICIO LE
        INNER JOIN GRUPO_MUSCULAR GM ON LE.id_grupo_muscular = GM.id_grupo_muscular;
    `);
    res.json(result.recordset);
};


//obtener una lista de ejercicio por id
export const getList_ejercicio = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_lista_ejercicio', sql.Int, req.params.id)
    .query('SELECT * FROM LISTA_EJERCICIO WHERE id_lista_ejercicio = @id_lista_ejercicio');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Lista de ejercicio no encontrada"});
    }
    return res.json(result.recordset[0])
};



// Crear una lista de ejercicio
export const createList_ejercicio = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try{
        //Verificar si la lista ejercicio ya existe
        const existingLista_ejercicio = await pool
            .request()
            .input('nombre_ejercicio', sql.VarChar, req.body.nombre_ejercicio)
            .query("SELECT COUNT(*) AS count FROM LISTA_EJERCICIO WHERE nombre_ejercicio = @nombre_ejercicio");
        
        if (existingLista_ejercicio.recordset[0].count > 0){
            return res.status(400).json({ message: 'La lista de ejercicio ya está en uso'});
        }

        // Si no existe, proceder a crear la nueva lista de ejercicio
        const result = await pool
            .request()
            .input('nombre_ejercicio', sql.VarChar, req.body.nombre_ejercicio)
            .input('imagen_ejercicio', sql.Text, req.body.imagen_ejercicio)
            .input('emoji_ejercicio', sql.NVarChar, req.body.emoji_ejercicio)
            .input('tipo_ejercicio', sql.VarChar, req.body.tipo_ejercicio)
            .input('dificultad_ejercicio', sql.VarChar, req.body.dificultad_ejercicio)
            .input('id_grupo_muscular', sql.Int, req.body.id_grupo_muscular)
            .query("INSERT INTO LISTA_EJERCICIO (nombre_ejercicio, imagen_ejercicio, emoji_ejercicio, tipo_ejercicio, dificultad_ejercicio, id_grupo_muscular) VALUES (@nombre_ejercicio, @imagen_ejercicio, @emoji_ejercicio, @tipo_ejercicio, @dificultad_ejercicio, @id_grupo_muscular); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);
        
        res.status(201).json({
            id_lista_ejercicio: result.recordset[0].id,
            nombre_ejercicio: req.body.nombre_ejercicio,
            imagen_ejercicio: req.body.imagen_ejercicio,
            emoji_ejercicio: req.body.emoji_ejercicio,
            tipo_ejercicio: req.body.tipo_ejercicio,
            dificultad_ejercicio: req.body.dificultad_ejercicio,
            id_grupo_muscular: req.body.id_grupo_muscular
        });
    } catch (error){
        console.error('Error al crear la lista de ejercicios', error);
        res.status(500).json({ message: 'Error al crear la lista de ejercicios'});
    }
};


//Actualizar una lista de ejercicios 
export const updateList_ejercicio = async (req, res) => {

    const id = req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_lista_ejercicio', sql.Int, id)
        .input('nombre_ejercicio', sql.VarChar, req.body.nombre_ejercicio)
        .input('imagen_ejercicio', sql.Text, req.body.imagen_ejercicio)
        .input('emoji_ejercicio', sql.NVarChar, emoji_ejercicio)
        .input('tipo_ejercicio', sql.VarChar, tipo_ejercicio)
        .input('dificultad_ejercicio', sql.VarChar, dificultad_ejercicio)
        .input('id_grupo_muscular', sql.Int, req.body.id_grupo_muscular)
        .query(
            "UPDATE LISTA_EJERCICIO SET nombre_ejercicio = @nombre_ejercicio, imagen_ejercicio = @imagen_ejercicio, emoji_ejercicio = @emoji_ejercicio, tipo_ejercicio = @tipo_ejercicio, dificultad_ejercicio = @dificultad_ejercicio, id_grupo_muscular = @id_grupo_muscular WHERE id_lista_ejercicio = @id_lista_ejercicio"
        );


    console.log(result)
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({message: "Lista de ejercicios no encontrada"});

    } res.json({
        id_lista_ejercicio: req.params.id,
        nombre_ejercicio: req.body.nombre_ejercicio,
        imagen_ejercicio: req.body.imagen_ejercicio,
        emoji_ejercicio: req.body.emoji_ejercicio,
        tipo_ejercicio: req.body.tipo_ejercicio,
        dificultad_ejercicio: req.body.dificultad_ejercicio,
        id_grupo_muscular: req.body.id_grupo_muscular
    });
};

//eliminar una lista de ejercicio
export const deleteList_ejercicio = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_lista_ejercicio', sql.Int, req.params.id)
    .query("DELETE FROM LISTA_EJERCICIO WHERE id_lista_ejercicio = @id_lista_ejercicio");
    console.log(result)
    if (result.rowsAffected[0] === 0 ){
        return res.status(404).json({message: "Lista de ejercicio no encontrada"});
    }
    return res.json({ message: "Lista de ejercicio eliminada"})
};