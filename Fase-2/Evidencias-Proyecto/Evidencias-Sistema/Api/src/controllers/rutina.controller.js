import { getConnection } from "../database/connection.js";
import sql from 'mssql';



//obtener todas las rutinas
export const getRutinas = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM RUTINA;')
    res.json(result.recordset)

};


//obtener un rutina por id
export const getRutina = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_rutina', sql.Int, req.params.id)
    .query('SELECT * FROM RUTINA WHERE id_rutina = @id_rutina');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Rutina no encontrada"});
    }
    return res.json(result.recordset[0])
};


// Crear una rutina
export const createRutina = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try{
        //Verificar si la rutina ya existe
        const existingRutina = await pool
            .request()
            .input('nombre_rutina', sql.VarChar, req.body.nombre_rutina)
            .query("SELECT COUNT(*) AS count FROM RUTINA WHERE nombre_rutina = @nombre_rutina");
        
        if (existingRutina.recordset[0].count > 0){
            return res.status(400).json({ message: 'La rutina ya está en uso'});
        }

        // Si no existe, proceder a crear la nueva rutina
        const result = await pool
            .request()
            .input('nombre_rutina', sql.VarChar, req.body.nombre_rutina)
            .input('id_usuario', sql.Int, req.body.id_usuario)
            .query("INSERT INTO RUTINA (nombre_rutina, id_usuario) VALUES (@nombre_rutina, @id_usuario); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);
        
        res.status(201).json({
            id_rutina: result.recordset[0].id,
            nombre_rutina: req.body.nombre_rutina,
            id_usuario: req.body.id_usuario
        });
    } catch (error){
        console.error('Error al crear la rutina', error);
        res.status(500).json({ message: 'Error al crear la rutina'});
    }
};

//Actualizar una Rutina 
export const updateRutina = async (req, res) => {

    const id = req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_rutina', sql.Int, id)
        .input('nombre_rutina', sql.VarChar, req.body.nombre_rutina)
        .input('id_usuario', sql.Int, req.body.id_usuario)
        .query(
            "UPDATE RUTINA SET nombre_rutina = @nombre_rutina, id_usuario = @id_usuario WHERE id_rutina = @id_rutina"
        );


    console.log(result)
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({message: "Rutina no encontrada"});

    } res.json({
        id_rutina: req.params.id,
        nombre_rutina: req.body.nombre_rutina,
        id_usuario: req.body.id_usuario
    });
};


//eliminar una Rutina
export const deleteRutina = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_rutina', sql.Int, req.params.id)
    .query("DELETE FROM RUTINA WHERE id_rutina = @id_rutina");
    console.log(result)
    if (result.rowsAffected[0] === 0 ){
        return res.status(404).json({message: "Rutina no encontrada"});
    }
    return res.json({ message: "Rutina eliminada"})
};