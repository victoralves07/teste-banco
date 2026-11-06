import express from 'express';
import db from '../database/db.js';

const router = express.Router();

// LISTAR LINHAS
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(
            'SELECT * FROM transport_line'
        );

        res.json(rows);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// BUSCAR LINHA POR ID
router.get('/:id', async (req, res) => {
    try {
        const [rows] = await db.query(
            'SELECT * FROM transport_line WHERE id_transportLine = ?',
            [req.params.id]
        );

        if (rows.length === 0) {
            return res.status(404).json({
                message: 'Linha não encontrada'
            });
        }

        res.json(rows[0]);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// CADASTRAR LINHA
router.post('/', async (req, res) => {
    try {
        const {
            code,
            name_line,
            transport_type,
            color,
            status_line
        } = req.body;

        if (!code || !name_line || !transport_type) {
            return res.status(400).json({
                message: 'Preencha os campos obrigatórios'
            });
        }

        const [result] = await db.query(
            `INSERT INTO transport_line
            (code, name_line, transport_type, color, status_line)
            VALUES (?, ?, ?, ?, ?)`,
            [
                code,
                name_line,
                transport_type,
                color || null,
                status_line || 'ativo'
            ]
        );

        res.status(201).json({
            message: 'Linha cadastrada!',
            id: result.insertId
        });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// ATUALIZAR LINHA
router.put('/:id', async (req, res) => {
    try {
        const {
            code,
            name_line,
            transport_type,
            color,
            status_line
        } = req.body;

        const [result] = await db.query(
            `UPDATE transport_line
            SET code = ?, name_line = ?, transport_type = ?,
                color = ?, status_line = ?
            WHERE id_transportLine = ?`,
            [
                code,
                name_line,
                transport_type,
                color,
                status_line,
                req.params.id
            ]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({
                message: 'Linha não encontrada'
            });
        }

        res.json({ message: 'Linha atualizada!' });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// EXCLUIR LINHA
router.delete('/:id', async (req, res) => {
    try {
        const [result] = await db.query(
            'DELETE FROM transport_line WHERE id_transportLine = ?',
            [req.params.id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({
                message: 'Linha não encontrada'
            });
        }

        res.json({ message: 'Linha excluída!' });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default router;