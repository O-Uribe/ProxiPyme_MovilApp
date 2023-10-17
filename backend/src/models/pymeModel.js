const mongoose = require('mongoose');

const productoSchema = new mongoose.Schema({
  nombre: String,
  descripcion: String,
  imagen: String,
  precio: Number
});

const reseñaSchema = new mongoose.Schema({
  usuario_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
  },
  calificacion: Number,
  comentario: String
});

const localSchema = new mongoose.Schema({
  nombre: {
    type: String,
    required: true
  },
  ubicacion: String,
  descripcion: String,
  categoria: String,
  modalidad: String,
  redes_sociales: {
    facebook: String,
    instagram: String
  },
  productos: [productoSchema],
  reseñas: [reseñaSchema]
});

const Pyme = mongoose.model('datosPymes', localSchema);

module.exports = Pyme;
