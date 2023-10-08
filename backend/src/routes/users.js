const express = require('express');
const router = express.Router();
const Usuarios = require('../models/userModel');
const validator = require('validator');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// Ruta para obtener todos los usuarios
router.get('/api/users', async (req, res) => {
    try {
        const users = await Usuarios.find();
        res.json(users);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Ruta para el inicio de sesión de usuarios
router.post('/api/users/login', async (req, res) => {
    try {
        const { correo, contraseña } = req.body;  
        const user = await Usuarios.findOne({ correo });
        if (!user) {
            return res.status(401).json({ error: 'Credenciales incorrectas' });
        }
        // Comparar la contraseña ingresada con la contraseña almacenada en la base de datos
        const passwordMatch = await bcrypt.compare(contraseña, user.contraseña);
        if (passwordMatch) {
            const token = jwt.sign({ userId: user._id, correo: user.correo}, 'taller_IV', { expiresIn: '1h' });
            res.status(200).json({ status:true,token:token});
        } else {
            res.status(401).json({ error: 'Credenciales incorrectas' });
        }
  
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error en el servidor' });
    }
  });


// Ruta para registrar un nuevo usuario
// router.post('/api/users/register', async (req, res) => {
//     try {
//         const { nombreUsuario, correo, contraseña } = req.body;
            
//         if (!validator.isEmail(correo)) {
//             return res.status(400).json({ error: 'El correo electrónico no es válido' });
//         }
//         // Verificar si el correo electrónico ya está en uso
//         const existente = await Usuarios.findOne({ correo });
//         if (existente) {
//             return res.status(400).json({ error: 'El correo electrónico ya está registrado' });
//         }
//         // Encriptar la contraseña
//         const hashedPassword = await bcrypt.hash(contraseña, 10);

//         //Crea un nuevo usuario
//         const newUser = new Usuarios({
//             nombreUsuario,
//             correo,
//             contraseña: hashedPassword
//         });
//         await newUser.save();
//         res.status(201).json({ message: 'Usuario registrado con éxito' });

//     } catch (error) {
//         res.status(400).json({ message: error.message });
//     }
// });

// Ruta para registrar un nuevo usuario
router.post('/api/users/register', async (req, res) => {
    try {
        const { nombreUsuario, correo, contraseña, tipoUsuario } = req.body;
        if (!validator.isEmail(correo)) {
            return res.status(400).json({ error: 'El correo electrónico no es válido' });
        }

        // Verificar si el correo electrónico ya está en uso
        const existente = await Usuarios.findOne({ correo });
        if (existente) {
            return res.status(400).json({ error: 'El correo electrónico ya está registrado' });
        }

        // Encriptar la contraseña
        const hashedPassword = await bcrypt.hash(contraseña, 10);

        if (tipoUsuario === 'Cliente') {
          // Crear un nuevo cliente
            const newUser = new Usuarios({
                tipoUsuario,
                nombreUsuario,
                correo,
                contraseña: hashedPassword,
            });

            await newUser.save();

        } else if (tipoUsuario === 'Pyme') {
            // Manejar el registro de pyme aquí
            const {
                nombrePyme,
                direccionPyme,
                encargadoPyme,
                descripcionPyme,
                logoPyme
            } = req.body;

            const newUser = new Usuarios({
                nombreUsuario,
                correo,
                contraseña: hashedPassword,
                nombrePyme,
                direccionPyme,
                encargadoPyme,
                descripcionPyme,
                logoPyme
            });
            await newUser.save();

        } else {
            return res.status(400).json({ error: 'Tipo de usuario no válido' });
        }

        res.status(201).json({ message: 'Usuario registrado con éxito' });

    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});


module.exports = router;
