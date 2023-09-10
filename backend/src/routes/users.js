const express = require('express');
const router = express.Router();
const User = require('../models/userModel');

// Ruta para obtener todos los usuarios
router.get('/api/users', async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Ruta para crear un nuevo usuario
router.post('/api/users/create', async (req, res) => {
  const user = new User(req.body);
  try {
    const newUser = await user.save();
    res.status(201).json(newUser);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Otras rutas como actualizar y eliminar usuarios pueden agregarse aquí

module.exports = router;
