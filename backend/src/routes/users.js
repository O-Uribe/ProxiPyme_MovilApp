const express = require('express');
const router = express.Router();
const User = require('../models/userModel');
const faker = require('faker');
const Usuarios = require('../models/userModel');

// Ruta para obtener todos los usuarios
router.get('/api/users', async (req, res) => {
    try {
        const users = await Usuarios.find();
        res.json(users);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Ruta para crear un nuevo usuario
router.get('/api/users/create',async(req, res) => {
    for (let i = 0; i <= 10; i++) {
        await Usuarios.create({
            nombreUsuario: faker.name.firstName(),
            correo: faker.internet.email(),
            contraseña: faker.internet.password()
        });
    }
    try {
        res.json({ message: '10 usuarios creados' });
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

module.exports = router;
