import { getConnection } from "../database/connection.js";
import sql from 'mssql';


//obtener todos los grupos musculares
export const getGrupos_muscular = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM GRUPO_MUSCULAR;')
    res.json(result.recordset)

};

//obtener un grupo muscular por id
export const getGrupo_muscular = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_grupo_muscular', sql.Int, req.params.id)
    .query('SELECT * FROM GRUPO_MUSCULAR WHERE id_grupo_muscular = @id_grupo_muscular');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "grupo muscular no encontrado"});
    }
    return res.json(result.recordset[0])
};



// Crear un grupo muscular
export const createGrupo_muscular = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    try {
        // Verificar si el grupo muscular ya existe
        const existingGrupo_muscular = await pool
            .request()
            .input('grupo_musculo', sql.VarChar, req.body.grupo_musculo)
            .query("SELECT COUNT(*) AS count FROM GRUPO_MUSCULAR WHERE grupo_musculo = @grupo_musculo");

        if (existingGrupo_muscular.recordset[0].count > 0) {
            return res.status(400).json({ message: 'El Grupo muscular ya está en uso' });
        }

        // Si no existe, proceder a crear el nuevo grupo muscular
        const result = await pool
            .request()
            .input('grupo_musculo', sql.VarChar, req.body.grupo_musculo)
            .input('descripcion_musculo', sql.Text, req.body.descripcion_musculo)
            .query(
                "INSERT INTO GRUPO_MUSCULAR (grupo_musculo, descripcion_musculo) VALUES (@grupo_musculo, @descripcion_musculo); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);

        res.status(201).json({
            id: result.recordset[0].id,
            email: req.body.email,
            user_password: req.body.user_password,
            rol: rol,
            estado: estado
        });
    } catch (error) {
        console.error('Error al crear el grupo muscular:', error);
        res.status(500).json({ message: 'Error al crear el grupo muscular' });
    }
};



//actualizar un Grupo muscular
export const updateGrupo_muscular = async (req, res) =>{

    const id= req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_grupo_muscular', sql.Int, req.params.id)
        .input('grupo_musculo', sql.VarChar, req.body.email)
        .input('descripcion_musculo', sql.VarChar, req.body.user_password)
        .query("UPDATE GRUPO_MUSCULAR SET grupo_musculo = @grupo_musculo, descripcion_musculo = @descripcion_musculo WHERE id_grupo_muscular = @id_grupo_muscular")


    console.log(result)
    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Grupo muscular no encontrado"});
    }
    res.json({  
        id_grupo_muscular: req.params.id,
        grupo_musculo: req.body.grupo_musculo, 
        descripcion_musculo: req.body.descripcion_musculo
        } );
};



//eliminar un Grupo muscular
export const deleteGrupo_muscular = async (req, res) =>{
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_grupo_muscular', sql.Int, req.params.id)
    .query("DELETE FROM GRUPO_MUSCULAR WHERE id_grupo_muscular = @id_grupo_muscular");
    console.log(result)
    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Grupo muscular no encontrado"});
    }
    return res.json({message: "Grupo muscular eliminado"});
};