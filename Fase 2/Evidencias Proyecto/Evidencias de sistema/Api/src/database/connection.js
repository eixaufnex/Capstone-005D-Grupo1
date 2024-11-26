import sql from 'mssql';

// Configuración principal
const dbSettings1 = {
    user: 'sqlserver',          
    password: 'admin',          
    server: '34.176.231.209',   
    database: 'pr_capstone',    
    options: {
        encrypt: true,          
        enableArithAbort: true, 
        trustServerCertificate: true, 
        port: 1433,             
    },
};

// Configuración de respaldo
const dbSettings2 = {
    user: 'prCapstone',
    password: 'Zxcvbnm12.',
    server: 'MTX08',
    database: 'proyectoCP',
    options: {
        encrypt: false,
        trustServerCertificate: true,
        enableArithAbort: true,
    },
};

export const getConnection = async () => {
    try {
        // Intentar conexión principal
        const pool = await sql.connect(dbSettings1);
        console.log("Conexión establecida con la base de datos de Ian.");
        return pool;
    } catch (error) {
        console.error("Error al conectar con la base de datos de Ian:", error);

        try {
            // Intentar conexión de respaldo si falla la principal
            const poolBackup = await sql.connect(dbSettings2);
            console.log("Conexión establecida con la base de datos de Esteban.");
            return poolBackup;
        } catch (backupError) {
            console.error("Error al conectar con la base de datos de Esteban:", backupError);
            throw new Error("No se pudo establecer la conexión con ninguna base de datos.");
        }
    }
};




/*
const dbSettings1 = {
    user: 'newuser',
    password: 'dangeurus 12',
    server: 'DESKTOP-R1HNFO0',
    database: 'pr_capstone',
    options: {
        encrypt: false,
        enableArithAbort: true,
    },
};


*/