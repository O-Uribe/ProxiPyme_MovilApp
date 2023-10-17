const express = require('express');
const router = express.Router();
const Pymes = require('../models/pymeModel');

const faker = require('faker');

// Ruta para obtener todos las pymes
router.get('/api/pymes', async (req, res) => {
    try {
        const pymes = await Pymes.find();
        res.json(pymes);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});


// Ruta para crear un nueva pyme
router.get('/api/pymes/create', async (req, res) => {
    for (let i = 0; i <= 5; i++) {
        await Pymes.create({
            nombre: faker.company.companyName(),
            ubicacion: 'faker.address.streetAddress()',
            descripcion: faker.lorem.paragraph(),
            categoria: faker.commerce.department(),
            modalidad: faker.commerce.productName(),
            redes_sociales: {
                facebook: faker.internet.url(),
                instagram: faker.internet.url()
            },
            productos: [
                {
                    nombre: faker.commerce.productName(),
                    descripcion: faker.commerce.productDescription(),
                    imagen: faker.image.imageUrl(),
                    precio: faker.commerce.price()
                },
                // {
                //     nombre: faker.commerce.productName(),
                //     descripcion: faker.commerce.productDescription(),
                //     imagen: faker.image.imageUrl(),
                //     precio: faker.commerce.price()
                // },
                // {
                //     nombre: faker.commerce.productName(),
                //     descripcion: faker.commerce.productDescription(),
                //     imagen: faker.image.imageUrl(),
                //     precio: faker.commerce.price()
                // }
            ],
            reseñas: [
                // {
                //     usuario_id: faker.random.number(),
                //     calificacion: faker.random.number(),
                //     comentario: faker.lorem.paragraph()
                // },
                // {
                //     usuario_id: faker.random.number(),
                //     calificacion: faker.random.number(),
                //     comentario: faker.lorem.paragraph()
                // },
                // {
                //     usuario_id: faker.random.number(),
                //     calificacion: faker.random.number(),
                //     comentario: faker.lorem.paragraph()
                // }
            ]
        });
    }
    try {
        res.json({ message: 'Pymes creadas' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Otras rutas como actualizar y eliminar pymes pueden agregarse aquí

module.exports = router;
