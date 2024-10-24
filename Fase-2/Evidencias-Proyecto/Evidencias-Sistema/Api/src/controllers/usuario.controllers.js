import { getConnection } from "../database/connection.js";
import sql from 'mssql';


//obtener todos los usuarios
export const getUsuarios = async (req, res) => {
    const pool = await getConnection()
    const result = await pool.request().query('SELECT * FROM USUARIO;')
    res.json(result.recordset)

};

//obtener un usuario por id
export const getUsuario = async (req, res) =>{
    console.log(req.params.id)
    const pool = await getConnection();
    const result = await pool.request()
    .input('id_usuario', sql.Int, req.params.id)
    .query('SELECT * FROM USUARIO WHERE id_usuario = @id_usuario');

    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Usuario no encontrado"});
    }
    return res.json(result.recordset[0])
};



// Crear un usuario
export const createUsuario = async (req, res) => {
    console.log(req.body);
    const pool = await getConnection();

    const rol = req.body.rol || 'usuario';
    const estado = req.body.estado || 1;

    try {
        // Verificar si el correo ya existe
        const existingUser = await pool
            .request()
            .input('username', sql.VarChar, req.body.username)
            .query("SELECT COUNT(*) AS count FROM USUARIO WHERE username = @username");

        if (existingUser.recordset[0].count > 0) {
            return res.status(400).json({ message: 'El username ya está en uso' });
        }

        // Si no existe, proceder a crear el nuevo usuario
        const result = await pool
            .request()
            .input('firebase_id', sql.VarChar, req.body.firebase_id)
            .input('username', sql.VarChar, req.body.username)
            .input('rol', sql.VarChar, rol)
            .input('estado', sql.Int, estado)
            .query(
                "INSERT INTO USUARIO (firebase_id, username, rol, estado, fecha_registro) VALUES (@firebase_id, @username, @rol, @estado, GETDATE()); SELECT SCOPE_IDENTITY() AS id;"
            );

        console.log(result);

        res.status(201).json({
            id: result.recordset[0].id,
            firebase_id: req.body.firebase_id,
            username: req.body.username,
            rol: rol,
            estado: estado
        });
    } catch (error) {
        console.error('Error al crear el usuario:', error);
        res.status(500).json({ message: 'Error al crear el usuario' });
    }
};



//actualizar un usuario
export const updateUsuario = async (req, res) =>{

    const id= req.params.id;

    const pool = await getConnection()
    const result = await pool.request()
        .input('id_usuario', sql.Int, req.params.id)
        .input('firebase_id', sql.VarChar, req.body.firebase_id)
        .input('username', sql.VarChar, req.body.username)
        .input('rol', sql.VarChar, req.body.rol)
        .input('estado', sql.Int, req.body.estado)
        .query("UPDATE USUARIO SET firebase_id = @firebase_id, username = @username, rol = @rol, estado = @estado WHERE id_usuario = @id_usuario")


    console.log(result)
    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Usuario no encontrado"});
    }
    res.json({  
        id_usuario: req.params.id,
        firebase_id: req.body.firebase_id, 
        username: req.body.username, 
        rol: req.body.rol, 
        estado: req.body.estado} );
};



//eliminar un usuario
export const deleteUsuario = async (req, res) =>{
    const pool = await getConnection()
    const result = await pool.request()
    .input('id_usuario', sql.Int, req.params.id)
    .query("DELETE FROM USUARIO WHERE id_usuario = @id_usuario");
    console.log(result)
    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Usuario no encontrado"});
    }
    return res.json({message: "usuario eliminado"});
};