import { getConnection } from "../database/connection.js";
import sql from 'mssql';



//obtener todos los progresos
export const getProgresos = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM PROGRESO;')
    res.json(result.recordset)

};


//obtener un Progreso por id
export const getProgreso = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_progreso', sql.Int, req.params.id)
    .query('SELECT * FROM PROGRESO WHERE id_progreso = @id_progreso');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Progreso no encontrado"});
    }
    return res.json(result.recordset[0])
};


// Crear un Progreso
export const createProgreso = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try{
        //Verificar si el Progreso ya existe
        const existingProgreso = await pool
            .request()
            .input('id_progreso', sql.Int, req.body.id_progreso)
            .query("SELECT COUNT(*) AS count FROM PROGRESO WHERE id_progreso = @id_progreso");
        
        if (existingProgreso.recordset[0].count > 0){
            return res.status(400).json({ message: 'El Progreso ya está en uso'});
        }

        // Si no existe, proceder a crear el nuevo Progreso
        const result = await pool
            .request()
            .input('comentarios_progreso', sql.VarChar, req.body.comentarios_progreso)
            .input('id_rutina_detallada', sql.Int, req.body.id_rutina_detallada)
            .query("INSERT INTO PROGRESO (comentarios_progreso, id_rutina_detallada) VALUES (@comentarios_progreso, @id_rutina_detallada); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);
        
        res.status(201).json({
            id_progreso: result.recordset[0].id,
            comentarios_progreso: req.body.comentarios_progreso,
            id_rutina_detallada: req.body.id_rutina_detallada
        });
    } catch (error){
        console.error('Error al crear el Progreso', error);
        res.status(500).json({ message: 'Error al crear el Progreso'});
    }
};

//Actualizar un Progreso 
export const updateProgreso = async (req, res) => {

    const id = req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_progreso', sql.Int, id)
        .input('comentarios_progreso', sql.VarChar, req.body.comentarios_progreso)
        .input('id_rutina_detallada', sql.Int, req.body.id_rutina_detallada)
        .query(
            "UPDATE PROGRESO SET comentarios_progreso = @comentarios_progreso, id_rutina_detallada = @id_rutina_detallada WHERE id_progreso = @id_progreso"
        );


    console.log(result)
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({message: "Progreso no encontrado"});

    } res.json({
        id_progreso: req.params.id,
        comentarios_progreso: req.body.comentarios_progreso,
        id_rutina_detallada: req.body.id_rutina_detallada
    });
};


//eliminar un Progreso
export const deleteProgreso = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_progreso', sql.Int, req.params.id)
    .query("DELETE FROM PROGRESO WHERE id_progreso = @id_progreso");
    console.log(result)
    if (result.rowsAffected[0] === 0 ){
        return res.status(404).json({message: "Progreso no encontrado"});
    }
    return res.json({ message: "Progreso eliminado"})
};