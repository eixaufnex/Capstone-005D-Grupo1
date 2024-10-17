import { getConnection } from "../database/connection.js";
import sql from 'mssql';



//obtener todos las notificaciones
export const getnotificaciones = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM NOTIFICACION;')
    res.json(result.recordset)

};

//obtener un notificacion por id
export const getnotificacion = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_notificacion', sql.Int, req.params.id)
    .query('SELECT * FROM NOTIFICACION WHERE id_notificacion = @id_notificacion');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "notificación no encontrada"});
    }
    return res.json(result.recordset[0])
};


// Crear una notificacion
export const createNotificacion = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try{
        //Verificar si la notificación ya existe
        const existingNotificacion = await pool
            .request()
            .input('tipo_notificacion', sql.VarChar, req.body.tipo_notificacion)
            .query("SELECT COUNT(*) AS count FROM NOTIFICACION WHERE tipo_notificacion = @tipo_notificacion");
        
        if (existingNotificacion.recordset[0].count > 0){
            return res.status(400).json({ message: 'La notificación ya está en uso'});
        }

        // Si no existe, proceder a crear la nueva notificación
        const result = await pool
            .request()
            .input('tipo_notificacion', sql.VarChar, req.body.tipo_notificacion)
            .input('mensaje_notificacion', sql.VarChar, req.body.mensaje_notificacion)
            .input('fecha_notificacion', sql.Date, req.body.fecha_notificacion)
            .input('id_usuario', sql.Int, req.body.id_usuario)
            .query("INSERT INTO NOTIFICACION (tipo_notificacion, mensaje_notificacion, fecha_notificacion, id_usuario) VALUES (@tipo_notificacion, @mensaje_notificacion, @fecha_notificacion, @id_usuario); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);
        
        res.status(201).json({
            id_notificacion: result.recordset[0].id,
            tipo_notificacion: req.body.tipo_notificacion,
            mensaje_notificacion: req.body.mensaje_notificacion,
            fecha_notificacion: req.body.fecha_notificacion,
            id_usuario: req.body.id_usuario
        });
    } catch (error){
        console.error('Error al crear la notificación', error);
        res.status(500).json({ message: 'Error al crear la notificación'});
    }
};


//Actualizar una notificacion 
export const updateNotificacion = async (req, res) => {

    const id = req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_notificacion', sql.Int, id)
        .input('tipo_notificacion', sql.VarChar, req.body.tipo_notificacion)
        .input('mensaje_notificacion', sql.Text, req.body.mensaje_notificacion)
        .input('fecha_notificacion', sql.Date, req.body.fecha_notificacion)
        .input('id_usuario', sql.Int, req.body.id_usuario)
        .query(
            "UPDATE NOTIFICACION SET tipo_notificacion = @tipo_notificacion, mensaje_notificacion = @mensaje_notificacion, fecha_notificacion = @fecha_notificacion, id_usuario = @id_usuario WHERE id_notificacion = @id_notificacion"
        );


    console.log(result)
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({message: "Notificación no encontrada"});

    } res.json({
        id_notificacion: req.params.id,
        tipo_notificacion: req.body.tipo_notificacion,
        mensaje_notificacion: req.body.mensaje_notificacion,
        fecha_notificacion: req.body.fecha_notificacion,
        id_usuario: req.body.id_usuario
    });
};



//eliminar una notificacion
export const deleteNotificacion = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_notificacion', sql.Int, req.params.id)
    .query("DELETE FROM NOTIFICACION WHERE id_notificacion = @id_notificacion");
    console.log(result)
    if (result.rowsAffected[0] === 0 ){
        return res.status(404).json({message: "Notificación no encontrada"});
    }
    return res.json({ message: "Notificación eliminada"})
};