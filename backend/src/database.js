const mongoose = require('mongoose');
// Cargar variables de entorno
require('dotenv').config();


// URI de conexión a la base de datos
const URI = process.env.MONGODB_URI;

// Conectarse a la base de datos
mongoose.connect(URI, {
    useNewUrlParser: true, useUnifiedTopology: true}
)
  .then(() => {
    console.log('Conexión exitosa a MongoDB');
  })
  .catch((err) => {
    console.error('Error al conectar a MongoDB:', err);
  });

// Exportar la instancia de mongoose
module.exports = mongoose;

