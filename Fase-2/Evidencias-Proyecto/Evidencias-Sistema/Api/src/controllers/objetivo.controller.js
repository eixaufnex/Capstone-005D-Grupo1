import { getConnection } from "../database/connection.js";
import sql from 'mssql';


//obtener todos los Objetivos
export const getObjetivos = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM OBJETIVO;')
    res.json(result.recordset)

};


//obtener un OBJETIVO por id
export const getObjetivo = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_objetivo', sql.Int, req.params.id)
    .query('SELECT * FROM OBJETIVO WHERE id_objetivo = @id_objetivo');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Objetivo no encontrado"});
    }
    return res.json(result.recordset[0])
};



// Crear un Objetivo
export const createObjetivo = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try{
        //Verificar si el objetivo ya existe
        const existingObjetivo = await pool
            .request()
            .input('nombre_objetivo', sql.VarChar, req.body.nombre_objetivo)
            .query("SELECT COUNT(*) AS count FROM OBJETIVO WHERE nombre_objetivo = @nombre_objetivo");
        
        if (existingObjetivo.recordset[0].count > 0){
            return res.status(400).json({ message: 'El Objetivo ya está en uso'});
        }

        // Si no existe, proceder a crear el nuevo Objetivo
        const result = await pool
            .request()
            .input('tipo_objetivo', sql.VarChar, req.body.tipo_objetivo)
            .input('nombre_objetivo', sql.VarChar, req.body.nombre_objetivo)
            .input('descripcion_objetivo', sql.Text, req.body.descripcion_objetivo)
            .input('valor_objetivo', sql.Int, req.body.valor_objetivo)
            .input('fecha_limite', sql.Date, req.body.fecha_limite)
            .input('alcanzado', sql.VarChar, req.body.alcanzado)
            .input('id_usuario', sql.Int, req.body.id_usuario)
            .query("INSERT INTO OBJETIVO (tipo_objetivo, nombre_objetivo, descripcion_objetivo, valor_objetivo, fecha_limite, alcanzado, id_usuario) VALUES (@tipo_objetivo, @nombre_objetivo, @descripcion_objetivo, @valor_objetivo, @fecha_limite, @alcanzado, @id_usuario); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);
        
        res.status(201).json({
            id_objetivo: result.recordset[0].id,
            tipo_objetivo: req.body.tipo_objetivo,
            descripcion_objetivo: req.body.descripcion_objetivo,
            valor_objetivo: req.body.valor_objetivo,
            fecha_limite: req.body.fecha_limite,
            alcanzado: req.body.alcanzado,
            id_usuario: req.body.id_usuario
        });
    } catch (error){
        console.error('Error al crear el objetivo', error);
        res.status(500).json({ message: 'Error al crear el objetivo'});
    }
};


//Actualizar un Objetivo 
export const updateObjetivo = async (req, res) => {

    const id = req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_objetivo', sql.Int, id)
        .input('tipo_objetivo', sql.VarChar, req.body.tipo_objetivo)
        .input('nombre_objetivo', sql.VarChar, req.body.nombre_objetivo)
        .input('descripcion_objetivo', sql.Text, req.body.descripcion_objetivo)
        .input('valor_objetivo', sql.Int, req.body.valor_objetivo)
        .input('fecha_limite', sql.Date, req.body.fecha_limite)
        .input('alcanzado', sql.VarChar, req.body.alcanzado)
        .input('id_usuario', sql.Int, req.body.id_usuario)
        .query(
            "UPDATE OBJETIVO SET tipo_objetivo = @tipo_objetivo, nombre_objetivo = @nombre_objetivo, descripcion_objetivo = @descripcion_objetivo, valor_objetivo = @valor_objetivo, fecha_limite = @fecha_limite, alcanzado = @alcanzado, id_usuario = @id_usuario  WHERE id_objetivo = @id_objetivo"
        );


    console.log(result)
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({message: "Objetivo no encontrado"});

    } res.json({
        id_objetivo: req.params.id,
        tipo_objetivo: req.body.tipo_objetivo,
        descripcion_objetivo: req.body.descripcion_objetivo,
        valor_objetivo: req.body.valor_objetivo,
        fecha_limite: req.body.fecha_limite,
        alcanzado: req.body.alcanzado,
        id_usuario: req.body.id_usuario
    });
};


//eliminar un Objetivo
export const deleteObjetivo = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_objetivo', sql.Int, req.params.id)
    .query("DELETE FROM OBJETIVO WHERE id_objetivo = @id_objetivo");
    console.log(result)
    if (result.rowsAffected[0] === 0 ){
        return res.status(404).json({message: "Objetivo no encontrado"});
    }
    return res.json({ message: "Objetivo eliminado"})
};