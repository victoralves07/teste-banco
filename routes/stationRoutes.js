import express from 'express';
import db from '../database/db.js';

const router = express.Router();

// LISTAR ESTAÇÕES
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(
            'SELECT * FROM station'
        );

        res.json(rows);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// CADASTRAR ESTAÇÃO
router.post('/', async (req, res) => {
    try {
        const {
            name_station,
            address,
            latitude,
            longitude
        } = req.body;

        if (!name_station) {
            return res.status(400).json({
                message: 'Nome da estação obrigatório'
            });
        }

        const [result] = await db.query(
            `INSERT INTO station
            (name_station, address, latitude, longitude)
            VALUES (?, ?, ?, ?)`,
            [
                name_station,
                address || null,
                latitude ?? null,
                longitude ?? null
            ]
        );

        res.status(201).json({
            message: 'Estação cadastrada!',
            id: result.insertId
        });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// ESTAÇÕES DE UMA LINHA
router.get('/linha/:id', async (req, res) => {
    try {
        const [rows] = await db.query(
            `SELECT
                s.id_station,
                s.name_station,
                s.address,
                ls.station_order,
                ls.travel_time_to_next_minutes
            FROM line_station ls
            INNER JOIN station s
                ON s.id_station = ls.id_station
            WHERE ls.id_transportLine = ?
            ORDER BY ls.station_order`,
            [req.params.id]
        );

        res.json(rows);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// VINCULAR ESTAÇÃO À LINHA
router.post('/linha/:id', async (req, res) => {
    try {
        const {
            id_station,
            station_order,
            travel_time_to_next_minutes
        } = req.body;

        if (!id_station || !station_order) {
            return res.status(400).json({
                message: 'Informe a estação e sua ordem'
            });
        }

        const [result] = await db.query(
            `INSERT INTO line_station
            (id_transportLine, id_station, station_order,
             travel_time_to_next_minutes)
            VALUES (?, ?, ?, ?)`,
            [
                req.params.id,
                id_station,
                station_order,
                travel_time_to_next_minutes ?? null
            ]
        );

        res.status(201).json({
            message: 'Estação vinculada!',
            id: result.insertId
        });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default router;