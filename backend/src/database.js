const mongoose = require('mongoose');
require('dotenv').config();


// URI de conexión a la base de datos
const URI = process.env.MONGODB_URI;

// Conectarse a la base de datos

async function connectDB() {
    mongoose.connect(URI, {useNewUrlParser: true, useUnifiedTopology: true})
        .then(() => {
            console.log('Conexión exitosa a MongoDB');
        })
        .catch((err) => {
            console.error('Error al conectar a MongoDB:', err);
        }); 
    };

// Exportar el objeto de conexion a la BD
module.exports = {connectDB};

