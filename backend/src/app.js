const express =  require('express');
const app = express();

const morgan = require('morgan');
const cors = require('cors');

const mongoose = require('./database'); 

app.use(morgan('dev'));
app.use(cors());

app.use(require('./routes/users'));
app.use(require('./routes/pymes'));



module.exports = app;

