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
            .input('email', sql.VarChar, req.body.email)
            .query("SELECT COUNT(*) AS count FROM USUARIO WHERE email = @email");

        if (existingUser.recordset[0].count > 0) {
            return res.status(400).json({ message: 'El correo ya está en uso' });
        }

        // Si no existe, proceder a crear el nuevo usuario
        const result = await pool
            .request()
            .input('email', sql.VarChar, req.body.email)
            .input('user_password', sql.VarChar, req.body.user_password)
            .input('rol', sql.VarChar, rol)
            .input('estado', sql.Int, estado)
            .query(
                "INSERT INTO USUARIO (email, user_password, rol, estado, fecha_registro) VALUES (@email, @user_password, @rol, @estado, GETDATE()); SELECT SCOPE_IDENTITY() AS id;"
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
        .input('email', sql.VarChar, req.body.email)
        .input('user_password', sql.VarChar, req.body.user_password)
        .input('rol', sql.VarChar, req.body.rol)
        .input('estado', sql.Int, req.body.estado)
        .query("UPDATE USUARIO SET email = @email, user_password = @user_password, rol = @rol, estado = @estado WHERE id_usuario = @id_usuario")


    console.log(result)
    if (result.rowsAffected[0] === 0){
        return res.status(404).json({message: "Usuario no encontrado"});
    }
    res.json({  
        id_usuario: req.params.id,
        email: req.body.email, 
        user_password: req.body.user_password, 
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