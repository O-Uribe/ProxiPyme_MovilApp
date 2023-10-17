const cloudinary = require("cloudinary").v2;
const multer = require("multer");
const { CloudinaryStorage } = require("multer-storage-cloudinary");

const storage = new CloudinaryStorage({
  cloudinary,
  params: {
    folder: "pymesImages", // Carpeta donde se almacenarán los archivos en Cloudinary
    allowedFormats: ["jpeg", "png", "jpg"], // Formatos permitidos
    // transformation: [{ width: 500, height: 500, crop: "limit" }], // Transformación de la imagen
    // public_id: (req, file) => "custom_public_id", // Nombre personalizado para la imagen en Cloudinary
    format: "jpg", // Formato de la imagen en Cloudinary
  },
});

const upload = multer({ storage: storage });

module.exports = upload;
