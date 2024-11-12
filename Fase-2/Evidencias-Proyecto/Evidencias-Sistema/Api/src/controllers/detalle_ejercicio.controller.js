import { getConnection } from "../database/connection.js";
import sql from 'mssql';



//obtener todos los detalle ejercicio
export const getDetalles_ejercicios = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM DETALLE_EJERCICIO;')
    res.json(result.recordset)

};


//obtener un detalle de ejercicio por id
export const getDetalle_ejercicio = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_detalle_ejercicio', sql.Int, req.params.id)
    .query('SELECT * FROM DETALLE_EJERCICIO WHERE id_detalle_ejercicio = @id_detalle_ejercicio');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Detalle de ejercicio no encontrado"});
    }
    return res.json(result.recordset[0])
};


// Crear un detalle de ejercicio 
export const createDetalle_ejercicio = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try{
        //Verificar si el detalle de ejercicio ya existe
        const existingDetalle_ejercicio = await pool
            .request()
            .input('descripcion_ejercicio', sql.Text, req.body.descripcion_ejercicio)
            .query("SELECT COUNT(*) AS count FROM DETALLE_EJERCICIO WHERE descripcion_ejercicio = @descripcion_ejercicio");
        
        if (existingDetalle_ejercicio.recordset[0].count > 0){
            return res.status(400).json({ message: 'El Detalle de ejercicio ya está en uso'});
        }

        // Si no existe, proceder a crear el nuevo detalle de ejercicio
        const result = await pool
            .request()
            .input('descripcion_ejercicio', sql.Text, req.body.descripcion_ejercicio)
            .input('instrucciones_ejercicio', sql.VarChar, req.body.instrucciones_ejercicio)
            .input('id_lista_ejercicio', sql.Int, req.body.id_lista_ejercicio)
            .query("INSERT INTO DETALLE_EJERCICIO (descripcion_ejercicio, instrucciones_ejercicio, id_lista_ejercicio) VALUES (@descripcion_ejercicio, @instrucciones_ejercicio, @id_lista_ejercicio); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);
        
        res.status(201).json({
            id_detalle_ejercicio: result.recordset[0].id,
            descripcion_ejercicio: req.body.descripcion_ejercicio,
            instrucciones_ejercicio: req.body.instrucciones_ejercicio,
            id_lista_ejercicio: req.body.id_lista_ejercicio
        });
    } catch (error){
        console.error('Error al crear el detalle de ejercicio', error);
        res.status(500).json({ message: 'Error al crear el detalle de ejercicio'});
    }
};

//Actualizar un detalle de ejercicio 
export const updateDetalle_ejercicio = async (req, res) => {

    const id = req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_detalle_ejercicio', sql.Int, id)
        .input('descripcion_ejercicio', sql.Text, req.body.descripcion_ejercicio)
        .input('instrucciones_ejercicio', sql.VarChar, req.body.instrucciones_ejercicio)
        .input('id_lista_ejercicio', sql.Int, req.body.id_lista_ejercicio)
        .query(
            "UPDATE DETALLE_EJERCICIO SET descripcion_ejercicio = @descripcion_ejercicio, instrucciones_ejercicio = @instrucciones_ejercicio, id_lista_ejercicio = @id_lista_ejercicio WHERE id_detalle_ejercicio = @id_detalle_ejercicio"
        );


    console.log(result)
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({message: "Detalle de ejercicio no encontrado"});

    } res.json({
        id_detalle_ejercicio: req.params.id,
        descripcion_ejercicio: req.body.descripcion_ejercicio,
        instrucciones_ejercicio: req.body.instrucciones_ejercicio,
        id_lista_ejercicio: req.body.id_lista_ejercicio
    });
};

//eliminar un detalle de ejercicio
export const deleteDetalle_ejercicio = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_detalle_ejercicio', sql.Int, req.params.id)
    .query("DELETE FROM DETALLE_EJERCICIO WHERE id_detalle_ejercicio = @id_detalle_ejercicio");
    console.log(result)
    if (result.rowsAffected[0] === 0 ){
        return res.status(404).json({message: "Detalle de ejercicio no encontrado"});
    }
    return res.json({ message: "Detalle de ejercicio eliminado"})
};





















