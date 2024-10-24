import { getConnection } from "../database/connection.js";
import sql from 'mssql';



//obtener todos los Perfiles
export const getPerfiles = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM PERFIL;')
    res.json(result.recordset)

};

//obtener un Perfil por id
export const getPerfil = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_perfil', sql.Int, req.params.id)
    .query('SELECT * FROM PERFIL WHERE id_perfil = @id_perfil');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Perfil no encontrado"});
    }
    return res.json(result.recordset[0])
};


// Crear un Perfil
export const createPerfil = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try{
        //Verificar si el perfil ya existe
        const existingPerfil = await pool
            .request()
            .input('id_perfil', sql.Int, req.body.id_perfil)
            .query("SELECT COUNT(*) AS count FROM PERFIL WHERE id_perfil = @id_perfil");
        
        if (existingPerfil.recordset[0].count > 0){
            return res.status(400).json({ message: 'El id_perfil ya está en uso'});
        }

        // Si no existe, proceder a crear el nuevo Perfil
        const result = await pool
            .request()
            .input('nombre', sql.VarChar, req.body.nombre)
            .input('apellido', sql.VarChar, req.body.apellido)
            .input('tipo_nivel', sql.VarChar, req.body.tipo_nivel)
            .input('foto_perfil', sql.Image, req.body.foto_perfil)
            .input('biografia', sql.Text, req.body.biografia)
            .input('id_usuario', sql.Int, req.body.id_usuario)
            .query("INSERT INTO PERFIL ( nombre, apellido, tipo_nivel, foto_perfil, biografia, id_usuario) VALUES ( @nombre, @apellido, @tipo_nivel, @foto_perfil, @biografia, @id_usuario); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);
        
        res.status(201).json({
            id_perfil: result.recordset[0].id,
            nombre: req.body.nombre,
            apellido: req.body.apellido,
            tipo_nivel: req.body.tipo_nivel,
            foto_perfil: req.body.foto_perfil,
            biografia: req.body.biografia,
            id_usuario: req.body.id_usuario
        });
    } catch (error){
        console.error('Error al crear el Perfil', error);
        res.status(500).json({ message: 'Error al crear el Perfil'});
    }
};



//Actualizar un Perfil 
export const updatePerfil = async (req, res) => {

    const id = req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_perfil', sql.Int, id)
        .input('nombre', sql.VarChar, req.body.nombre)
        .input('apellido', sql.VarChar, req.body.apellido)
        .input('tipo_nivel', sql.VarChar, req.body.tipo_nivel)
        .input('foto_perfil', sql.Image, req.body.foto_perfil)
        .input('biografia', sql.Text, req.body.biografia)
        .input('id_usuario', sql.Int, req.body.id_usuario)
        .query(
            "UPDATE PERFIL SET  nombre = @nombre, apellido = @apellido, tipo_nivel = @tipo_nivel, foto_perfil = @foto_perfil, biografia = @biografia, id_usuario = @id_usuario  WHERE id_perfil = @id_perfil"
        );


    console.log(result)
    if (result.rowsAffected[0] === 0) {
        return res.status(404).json({message: "Perfil no encontrado"});

    } res.json({
        id_perfil: req.params.id,
        nombre: req.body.nombre,
        apellido: req.body.apellido,
        tipo_nivel: req.body.tipo_nivel,
        foto_perfil: req.body.foto_perfil,
        biografia: req.body.biografia,
        id_usuario: req.body.id_usuario
    });
};


//eliminar un Perfil
export const deletePerfil = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_perfil', sql.Int, req.params.id)
    .query("DELETE FROM PERFIL WHERE id_perfil = @id_perfil");
    console.log(result)
    if (result.rowsAffected[0] === 0 ){
        return res.status(404).json({message: "Perfil no encontrado"});
    }
    return res.json({ message: "Perfil eliminado"})
};