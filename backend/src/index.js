const app = require('./app');

const PORT = process.env.PORT || 5000;

async function main () {
    //Inicializar el servidor
    await app.listen(PORT, () => {
    console.log(`Servidor escuchando en el puerto ${PORT}`);
});}

main();

     