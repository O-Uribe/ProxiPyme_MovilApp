const app = require("./app");
const { connectDB } = require("./database");
const { uploadImage } = require("./routes/storage")

//Extrae URI desde variable de entorno creada
const PORT = process.env.PORT || 5000;

// Cloudinary
const { storage } = require('./routes/storage');
const multer = require('multer');
const upload = multer({ storage });

async function main() {
  //Inicializar la conexion a mongoDB
  await connectDB();
  //Inicializar el servidor express
  await app.listen(PORT, () => {
    console.log(`Servidor escuchando en el puerto ${PORT}`);
  });

  
}

main();
