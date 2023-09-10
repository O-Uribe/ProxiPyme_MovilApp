const mongoose = require('mongoose');

// URI de conexión a la base de datos
const URI = "mongodb+srv://ProxiPyme:ay24WV7Lve6U8JPSdfad2@cluster0.hvk7eja.mongodb.net/?retryWrites=true&w=majority"


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

