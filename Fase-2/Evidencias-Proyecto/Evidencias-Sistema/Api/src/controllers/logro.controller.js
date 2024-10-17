import { getConnection } from "../database/connection.js";
import sql from 'mssql';



//obtener todos los Logros
export const getLogros = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM LOGRO;')
    res.json(result.recordset)

};

//obtener un logro por id
export const getLogro = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_logro', sql.Int, req.params.id)
    .query('SELECT * FROM LOGRO WHERE id_logro = @id_logro');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "logro no encontrado"});
    }
    return res.json(result.recordset[0])
};


// Crear un logro
export const createLogro = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try{
        //Verificar si el logro ya existe
        const existingLogro = await pool
            .request()
            .input('nombre_logro', sql.VarChar, req.body.nombre_logro)
            .query("SELECT COUNT(*) AS count FROM LOGRO WHERE nombre_logro = @nombre_logro");
        
        if (existingLogro.recordset[0].count > 0){
            return res.status(400).json({ message: 'El Logro ya está en uso'});
        }

        // Si no existe, proceder a crear el nuevo logro
        const result = await pool
            .request()
            .input('nombre_logro', sql.VarChar, req.body.nombre_logro)
            .input('descripcion_logro', sql.Text, req.body.descripcion_logro)
            .input('fecha_obtencion', sql.Date, req.body.fecha_obtencion)
            .input('id_usuario', sql.Int, req.body.id_usuario)
            .query("INSERT INTO LOGRO (nombre_logro, descripcion_logro, fecha_obtencion, id_usuario) VALUES (@nombre_logro, @descripcion_logro, @fecha_obtencion, @id_usuario); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);
        
        res.status(201).json({
            id_logro: result.recordset[0].id,
            nombre_logro: req.body.nombre_logro,
            descripcion_logro: req.body.descripcion_logro,
            fecha_obtencion: req.body.fecha_obtencion,
            id_usuario: req.body.id_usuario
        });
    } catch (error){
        console.error('Error al crear el logro', error);
        res.status(500).json({ message: 'Error al crear el logro'});
    }
};


//Actualizar un logro 
export const updateLogro = async (req, res) => {

    const id = req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_logro', sql.Int, id)
        .input('nombre_logro', sql.VarChar, req.body.nombre_logro)
        .input('descripcion_logro', sql.Text, req.body.descripcion_logro)
        .input('fecha_obtencion', sql.Date, req.body.fecha_obtencion)
        .input('id_usuario', sql.Int, req.body.id_usuario)
        .query(
            "UPDATE LOGRO SET nombre_logro = @nombre_logro, descripcion_logro = @descripcion_logro, fecha_obtencion = @fecha_obtencion, id_usuario = @id_usuario WHERE id_logro = @id_logro"
        );


    console.log(result)
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({message: "Logro no encontrado"});

    } res.json({
        id_logro: req.params.id,
        nombre_logro: req.body.nombre_logro,
        descripcion_logro: req.body.descripcion_logro,
        fecha_obtencion: req.body.fecha_obtencion,
        id_usuario: req.body.id_usuario
    });
};



//eliminar un logro
export const deleteLogro = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_logro', sql.Int, req.params.id)
    .query("DELETE FROM LOGRO WHERE id_logro = @id_logro");
    console.log(result)
    if (result.rowsAffected[0] === 0 ){
        return res.status(404).json({message: "Logro no encontrado"});
    }
    return res.json({ message: "Logro eliminado"})
};