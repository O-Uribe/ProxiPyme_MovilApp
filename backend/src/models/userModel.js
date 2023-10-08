const { Schema, model } = require('mongoose');

const userSchema = new Schema({
    tipoUsuario: {
        type: String,
    },
    nombreUsuario: {
        type: String,
    },
    correo: {
        type: String,
        unique: true,
    },
    contraseña: {
        type: String,
    },
    // Propiedades específicas para pymes
    nombrePyme: {
        type: String, 
    },
    direccionPyme: {
        type: String, 
    },
    encargadoPyme: {
        type: String, 
    },
    descripcionPyme: {
        type: String, 
    },
    logoPyme: {
        type: String,
    },
});

const Usuarios = model('Usuario', userSchema);

module.exports = Usuarios;
