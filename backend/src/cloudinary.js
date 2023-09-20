const cloudinary = require('cloudinary').v2;
const { CloudinaryStorage } = require('multer-storage-cloudinary');

const CLOUD_NAME = process.env.CLOUD_NAME;
const C_API_KEY = process.env.CLOUDINARY_API_KEY;
const C_API_SECRET = process.env.CLOUDINARY_API_SECRET;

cloudinary.config({
    cloud_name: CLOUD_NAME,
    api_key: C_API_KEY,
    api_secret: C_API_SECRET,
});

const storage = new CloudinaryStorage({
    cloudinary,
    params: {
        folder: 'prueba',
        allowedFormats: ['jpeg', 'png', 'jpg'],
    }
});

module.exports = {
    storage
};