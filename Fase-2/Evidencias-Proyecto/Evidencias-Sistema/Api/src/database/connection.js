import sql from 'mssql'


//modificar segun donde se utilice
const dbSettings = {
    user: 'newuser',
    password: 'dangeurus 12',
    server: 'DESKTOP-R1HNFO0', 
    database: 'pr_capstone',
    options: {
            encrypt: false, // Añadir esta opción si no estás usando SSL
            enableArithAbort: true 
    }
}


export const getConnection = async () => {
    try{
        const pool = await sql.connect(dbSettings);
        return pool;
    } catch (error){
        console.error(error)
    }
}

