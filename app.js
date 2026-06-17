const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");

const app = express();

app.use(cors());
app.use(express.json());

const db = new Pool({
    host: "localhost",
    user: "postgres",
    password: "postgres",
    database: "sti_inventory",
    port: 5432
});

app.post("/api/login", async (req, res) => {

    const { username, password } = req.body;

    try {

        const result = await db.query(
            `
            SELECT
                id,
                nome,
                username,
                email,
                perfil
            FROM usuarios
            WHERE username = $1
            AND senha = $2
            AND ativo = true
            `,
            [username, password]
        );

        if (result.rows.length === 0) {

            return res.status(401).json({
                success: false
            });

        }

        return res.json({
            success: true,
            user: result.rows[0]
        });

    }
    catch (error) {

        console.error(error);

        return res.status(500).json({
            success: false
        });

    }

});

app.listen(3000, () => {

    console.log(
        "STI Inventory API iniciada na porta 3000"
    );

});
