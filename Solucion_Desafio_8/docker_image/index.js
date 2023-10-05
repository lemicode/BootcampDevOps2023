import express from 'express';
import mongoose from 'mongoose'

const Animal = mongoose.model('Animal', new mongoose.Schema({
    tipo: String,
    estado: String
}));

const app = express();

mongoose.connect('mongodb://my_user:my_password@my_mongo:27017/my_db?authSource=admin');

app.get('/', async (_req, res) => {
    console.log('Listando...');
    const animales = await Animal.find();
    return res.send(animales);
});

app.get('/crear', async (_req, res) => {
    console.log('Creando...');
    const count = await Animal.countDocuments();
    await Animal.create({
        tipo: `Chanchito No. ${ count + 1 }`,
        estado: 'Feliz'
    });
    return res.send('Ok');
});

app.listen(3000, () => {
    console.log('Escuchando...');
});