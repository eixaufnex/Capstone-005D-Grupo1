import { getConnection } from "../database/connection.js";
import sql from 'mssql';

// Obtener todos los perfiles
export const getPerfiles = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request().query('SELECT * FROM PERFIL;');
        res.json(result.recordset);
    } catch (error) {
        console.error('Error al obtener perfiles:', error);
        res.status(500).json({ message: 'Error al obtener perfiles' });
    }
};


// Obtener un perfil por firebase_id
export const getPerfilxfirebase = async (req, res) => {
    const { firebase_id } = req.params;
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id) 
            .query('SELECT * FROM PERFIL WHERE firebase_id = @firebase_id');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Perfil no encontrado" });
        }
        return res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener perfil:', error);
        res.status(500).json({ message: 'Error al obtener perfil' });
    }
};


// Obtener un perfil por id
export const getPerfil = async (req, res) => {
    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_perfil', sql.Int, req.params.id)
            .query('SELECT * FROM PERFIL WHERE id_perfil = @id_perfil');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Perfil no encontrado" });
        }
        return res.json(result.recordset[0]);
    } catch (error) {
        console.error('Error al obtener perfil:', error);
        res.status(500).json({ message: 'Error al obtener perfil' });
    }
};

// Crear un perfil
export const createPerfil = async (req, res) => {
    const { nombre, apellido, edad, peso, estatura, genero, tipo_nivel, foto_perfil, biografia, firebase_id } = req.body;

    try {
        const pool = await getConnection();

        // Verificar si el perfil ya existe
        const existingPerfil = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .query("SELECT COUNT(*) AS count FROM PERFIL WHERE firebase_id = @firebase_id");

        if (existingPerfil.recordset[0].count > 0) {
            return res.status(400).json({ message: 'El perfil ya está en uso' });
        }

        // Crear el nuevo perfil
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .input('nombre', sql.VarChar, nombre)
            .input('apellido', sql.VarChar, apellido)
            .input('edad', sql.Int, edad)
            .input('peso', sql.Decimal(5, 2), peso)
            .input('estatura', sql.Decimal(5, 2), estatura)
            .input('genero', sql.VarChar, genero)
            .input('tipo_nivel', sql.VarChar, tipo_nivel)
            .input('foto_perfil', sql.Text, foto_perfil)
            .input('biografia', sql.Text, biografia)
            .query(`INSERT INTO PERFIL (firebase_id, nombre, apellido, edad, peso, estatura, genero, tipo_nivel, foto_perfil, biografia) 
                    VALUES (@firebase_id, @nombre, @apellido, @edad, @peso, @estatura, @genero, @tipo_nivel, @foto_perfil, @biografia);
                    SELECT SCOPE_IDENTITY() AS id;`);

        res.status(201).json({
            id_perfil: result.recordset[0].id,
            nombre,
            apellido,
            edad,
            peso,
            estatura,
            genero,
            tipo_nivel,
            foto_perfil,
            biografia,
            firebase_id
        });
    } catch (error) {
        console.error('Error al crear el perfil:', error);
        res.status(500).json({ message: 'Error al crear el perfil' });
    }
};

// Actualizar un perfil por firebase_id
export const updatePerfil = async (req, res) => {
    const { firebase_id } = req.params; // Utilizamos firebase_id como identificador
    const { foto_perfil } = req.body; // Solo se espera actualizar foto_perfil

    try {
        const pool = await getConnection();

        // Recuperar los valores existentes del perfil
        const existingPerfil = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .query('SELECT * FROM PERFIL WHERE firebase_id = @firebase_id');

        if (existingPerfil.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Perfil no encontrado" });
        }

        // Conservar los valores existentes
        const perfil = existingPerfil.recordset[0];
        const nombre = perfil.nombre;
        const apellido = perfil.apellido;
        const edad = perfil.edad;
        const peso = perfil.peso;
        const estatura = perfil.estatura;
        const genero = perfil.genero;
        const tipo_nivel = perfil.tipo_nivel;
        const biografia = perfil.biografia;

        // Realizar la actualización de foto_perfil y conservar los demás valores
        const result = await pool.request()
            .input('firebase_id', sql.VarChar, firebase_id)
            .input('nombre', sql.VarChar, nombre)
            .input('apellido', sql.VarChar, apellido)
            .input('edad', sql.Int, edad)
            .input('peso', sql.Decimal(5, 2), peso)
            .input('estatura', sql.Decimal(5, 2), estatura)
            .input('genero', sql.VarChar, genero)
            .input('tipo_nivel', sql.VarChar, tipo_nivel)
            .input('foto_perfil', sql.Text, foto_perfil)
            .input('biografia', sql.Text, biografia)
            .query(`UPDATE PERFIL SET 
                    nombre = @nombre, 
                    apellido = @apellido, 
                    edad = @edad, 
                    peso = @peso, 
                    estatura = @estatura, 
                    genero = @genero, 
                    tipo_nivel = @tipo_nivel, 
                    foto_perfil = @foto_perfil, 
                    biografia = @biografia 
                    WHERE firebase_id = @firebase_id`);

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Perfil no encontrado" });
        }

        res.json({ message: "Perfil actualizado correctamente", foto_perfil });
    } catch (error) {
        console.error('Error al actualizar el perfil:', error);
        res.status(500).json({ message: 'Error al actualizar el perfil' });
    }
};



// Eliminar un perfil
export const deletePerfil = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('id_perfil', sql.Int, id)
            .query("DELETE FROM PERFIL WHERE id_perfil = @id_perfil");

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({ message: "Perfil no encontrado" });
        }
        res.json({ message: "Perfil eliminado" });
    } catch (error) {
        console.error('Error al eliminar el perfil:', error);
        res.status(500).json({ message: 'Error al eliminar el perfil' });
    }
};
