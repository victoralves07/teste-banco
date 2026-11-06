import express from 'express';
import db from '../database/db.js';

const router = express.Router();

// LISTAR ALERTAS
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(
            `SELECT
                a.*,
                tl.name_line,
                s.name_station
            FROM alert a
            INNER JOIN transport_line tl
                ON tl.id_transportLine = a.id_transportLine
            LEFT JOIN station s
                ON s.id_station = a.id_station
            ORDER BY a.created_at DESC`
        );

        res.json(rows);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// CADASTRAR ALERTA
router.post('/', async (req, res) => {
    try {
        const {
            id_transportLine,
            id_station,
            description_alert,
            alert_type
        } = req.body;

        if (!id_transportLine || !description_alert || !alert_type) {
            return res.status(400).json({
                message: 'Preencha os campos obrigatórios'
            });
        }

        const [result] = await db.query(
            `INSERT INTO alert
            (id_transportLine, id_station, description_alert, alert_type)
            VALUES (?, ?, ?, ?)`,
            [
                id_transportLine,
                id_station ?? null,
                description_alert,
                alert_type
            ]
        );

        res.status(201).json({
            message: 'Alerta cadastrado!',
            id: result.insertId
        });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default router;