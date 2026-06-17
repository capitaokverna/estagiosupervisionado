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


//---------------------------------------------------
// LOGIN
//---------------------------------------------------

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
                success: false,
                message: "Usuário ou senha inválidos"
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
            success: false,
            message: "Erro interno do servidor"
        });

    }

});


//---------------------------------------------------
// CLIENTES - LISTAR
//---------------------------------------------------

app.get("/api/clientes", async (req, res) => {

    try {

        const result = await db.query(`
            SELECT
                id,
                razao_social,
                cnpj,
                endereco,

                contato_tecnico_nome,
                contato_tecnico_telefone,
                contato_tecnico_email,

                contato_gerencial_nome,
                contato_gerencial_telefone,
                contato_gerencial_email,

                created_at

            FROM clientes

            ORDER BY id DESC
        `);

        return res.json(
            result.rows
        );

    }
    catch(error){

        console.error(error);

        return res.status(500).json({
            success: false,
            message: error.message
        });

    }

});


//---------------------------------------------------
// CLIENTES - CADASTRAR
//---------------------------------------------------

app.post("/api/clientes", async (req, res) => {

    try {

        const {

            razao_social,
            cnpj,
            endereco,

            contato_tecnico_nome,
            contato_tecnico_telefone,
            contato_tecnico_email,

            contato_gerencial_nome,
            contato_gerencial_telefone,
            contato_gerencial_email

        } = req.body;

        if (
            !razao_social ||
            !cnpj
        ) {

            return res.status(400).json({
                success: false,
                message: "Razão Social e CNPJ são obrigatórios."
            });

        }

        await db.query(

            `
            INSERT INTO clientes (

                razao_social,
                cnpj,
                endereco,

                contato_tecnico_nome,
                contato_tecnico_telefone,
                contato_tecnico_email,

                contato_gerencial_nome,
                contato_gerencial_telefone,
                contato_gerencial_email

            )
            VALUES (
                $1,$2,$3,
                $4,$5,$6,
                $7,$8,$9
            )
            `,

            [

                razao_social,
                cnpj,
                endereco,

                contato_tecnico_nome,
                contato_tecnico_telefone,
                contato_tecnico_email,

                contato_gerencial_nome,
                contato_gerencial_telefone,
                contato_gerencial_email

            ]

        );

        return res.json({
            success: true,
            message: "Cliente cadastrado com sucesso."
        });

    }
    catch(error){

        console.error(error);

        return res.status(500).json({
            success: false,
            message: error.message
        });

    }

});


//---------------------------------------------------
// CLIENTES - EXCLUIR
//---------------------------------------------------

app.delete("/api/clientes/:id", async (req, res) => {

    try {

        const { id } = req.params;

        const result = await db.query(
            `
            DELETE FROM clientes
            WHERE id = $1
            `,
            [id]
        );

        return res.json({
            success: true,
            message: "Cliente removido com sucesso."
        });

    }
    catch(error){

        console.error(error);

        return res.status(500).json({
            success: false,
            message: error.message
        });

    }

});


//---------------------------------------------------
// HEALTH CHECK
//---------------------------------------------------

app.get("/", (req, res) => {

    res.json({
        application: "STI Inventory",
        version: "1.0.0",
        status: "online"
    });

});


//---------------------------------------------------
// START SERVER
//---------------------------------------------------

app.listen(3000, () => {

    console.log(
        "STI Inventory API iniciada na porta 3000"
    );

});
