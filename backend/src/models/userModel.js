const {Schema,model} = require('mongoose');

const userSchema = new Schema({
    nombreUsuario: {
        type: String,
    },
    correo: {
        type: String,    
        unique: true
    },
    contraseña: {
        type: String,
    }
});

const Usuarios = model('Usuario', userSchema);

module.exports = Usuarios;