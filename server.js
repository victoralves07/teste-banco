import express from 'express';
import dotenv from 'dotenv';

import db from './database/db.js';

import transportRoutes from './routes/transportRoutes.js';
import stationRoutes from './routes/stationRoutes.js';
import alertRoutes from './routes/alertRoutes.js';

dotenv.config();

const app = express();

app.use(express.json());
app.use(express.static('public'));

// TESTAR CONEXÃO
app.get('/api/teste', async (req, res) => {
    try {
        await db.query('SELECT 1');

        res.json({
            message: 'Banco conectado com sucesso!'
        });

    } catch (error) {
        res.status(500).json({
            error: error.message
        });
    }
});

// ROTAS
app.use('/api/linhas', transportRoutes);
app.use('/api/estacoes', stationRoutes);
app.use('/api/alertas', alertRoutes);

// SERVIDOR
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});