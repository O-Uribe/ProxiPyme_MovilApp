const express =  require('express');
const app = express();

//Modulos para el servidor 
const morgan = require('morgan');
const cors = require('cors');

//Conexion a la base de datos
const mongoose = require('./database'); 

//Configuraciones
app.use(morgan('dev'));
app.use(cors());

//Rutas 
app.use(require('./routes/users'));
app.use(require('./routes/pymes'));


module.exports = app;

