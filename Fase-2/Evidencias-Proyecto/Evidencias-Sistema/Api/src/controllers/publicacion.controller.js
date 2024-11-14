import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todas las publicaciones
export const getPublicaciones = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query('SELECT * FROM PUBLICACIONES ORDER BY fecha_creacion DESC;');
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener publicaciones:', error);
        res.status(500).json({ message: 'Error al obtener publicaciones' });
    }
};

// Obtener publicaciones de un usuario específico
export const getPublicacionesByUser = async (req, res) => {
    const { firebase_id } = req.params;
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .query('SELECT * FROM PUBLICACIONES WHERE firebase_id = @firebase_id ORDER BY fecha_creacion DESC;');
        
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener publicaciones del usuario:', error);
        res.status(500).json({ message: 'Error al obtener publicaciones del usuario' });
    }
};

// Crear una nueva publicación con validación de firebase_id en USUARIO
export const createPublicacion = async (req, res) => {
    const { firebase_id, descripcion } = req.body;
    try {
        const pool = await getConnection();

        // Verificar si el firebase_id existe en la tabla USUARIO antes de insertar en PUBLICACIONES
        const userResult = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .query('SELECT 1 FROM USUARIO WHERE firebase_id = @firebase_id');

        if (userResult.recordset.length === 0) {
            // Si el usuario no existe en USUARIO, devolver un error claro
            return res.status(400).json({ message: "El usuario no existe en la base de datos." });
        }

        // Insertar la publicación si el usuario existe
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .input('descripcion', sql.Text, descripcion || null)
            .query(
                `INSERT INTO PUBLICACIONES (firebase_id, descripcion, likes, fecha_creacion) 
                 VALUES (@firebase_id, @descripcion, 0, GETDATE()); 
                 SELECT SCOPE_IDENTITY() AS id_publicacion;`
            );

        // Respuesta exitosa con la publicación creada
        res.status(201).json({
            id_publicacion: result.recordset[0].id_publicacion,
            firebase_id,
            descripcion,
            likes: 0,
            fecha_creacion: new Date()
        });
    } catch (error) {
        console.error('Error al crear la publicación:', error);
        res.status(500).json({ message: 'Error al crear la publicación' });
    }
};

// Verificar si un usuario ha dado "like" a una publicación
export const hasUserLiked = async (req, res) => {
    const { id_publicacion, firebase_id } = req.params;
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_publicacion', sql.Int, id_publicacion)
            .input('firebase_id', sql.VarChar, firebase_id)
            .query('SELECT 1 FROM PUBLICACIONES WHERE id_publicacion = @id_publicacion AND firebase_id = @firebase_id');

        if (result.recordset.length > 0) {
            // El usuario ha dado "like" a esta publicación
            res.json({ liked: true });
        } else {
            // El usuario no ha dado "like" a esta publicación
            res.json({ liked: false });
        }
    } catch (error) {
        console.error('Error al verificar estado de like:', error);
        res.status(500).json({ message: 'Error al verificar estado de like' });
    }
};


// Dar like a una publicación
export const likePublicacion = async (req, res) => {
    const { id_publicacion } = req.params;
    try {
        const pool = await getConnection();
        
        // Incrementar el contador de likes
        await pool.request()
            .input('id_publicacion', sql.Int, id_publicacion)
            .query('UPDATE PUBLICACIONES SET likes = likes + 1 WHERE id_publicacion = @id_publicacion');

        res.json({ message: "Like agregado" });
    } catch (error) {
        console.error('Error al dar like a la publicación:', error);
        res.status(500).json({ message: 'Error al dar like a la publicación' });
    }
};

//funcion para restar los likes
export const unlikePublicacion = async (req, res) => {
    const { id_publicacion } = req.params;
    try {
        const pool = await getConnection();
        
        // Incrementar el contador de likes
        await pool.request()
            .input('id_publicacion', sql.Int, id_publicacion)
            .query('UPDATE PUBLICACIONES SET likes = likes - 1 WHERE id_publicacion = @id_publicacion');

        res.json({ message: "Like restado" });
    } catch (error) {
        console.error('Error al dar quitar like a la publicación:', error);
        res.status(500).json({ message: 'Error al quitar like a la publicación' });
    }
};

// Eliminar una publicación
// Cambia el endpoint a '/publicacion/:id_publicacion/delete' en tu router y usa POST en lugar de DELETE
export const deletePublicacion = async (req, res) => {
    const { id_publicacion } = req.params;
    try {
        const pool = await getConnection();        
        const result = await pool.request()
            .input('id_publicacion', sql.Int, id_publicacion)
            .query('DELETE FROM PUBLICACIONES WHERE id_publicacion = @id_publicacion');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Publicación no encontrada" });
        }

        res.json({ message: "Publicación eliminada" });
    } catch (error) {
        console.error('Error al eliminar la publicación:', error);
        res.status(500).json({ message: 'Error al eliminar la publicación' });
    }
};