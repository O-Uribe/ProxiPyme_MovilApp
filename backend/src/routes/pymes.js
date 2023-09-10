const express = require('express');
const router = express.Router();
const Local = require('../models/pymeModel');

// Ruta para obtener todos las pymes
router.get('/api/pyme', async (req, res) => {
  try {
    const pymes = await Local.find();
    res.json(pymes);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});


// Ruta para crear un nueva pyme
router.post('/api/pyme/create', async (req, res) => {
  const local = new Local(req.body);
  try {
    const newLocal = await local.save();
    res.status(201).json(newLocal);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Otras rutas como actualizar y eliminar pymes pueden agregarse aquí

module.exports = router;
