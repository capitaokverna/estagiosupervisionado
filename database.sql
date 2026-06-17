-- STI INVENTORY
-- DATABASE SCRIPT

DROP TABLE IF EXISTS servicos CASCADE;
DROP TABLE IF EXISTS tipos_recurso CASCADE;
DROP TABLE IF EXISTS cloud_providers CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;

---------------------------------------------------
-- USUARIOS
---------------------------------------------------

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil VARCHAR(50) NOT NULL DEFAULT 'Administrador',
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuarios (
    nome,
    username,
    email,
    senha,
    perfil
)
VALUES (
    'Andre Nascimento',
    'andrenascimento',
    'andre@stiinventory.com',
    '123456',
    'Administrador'
);

---------------------------------------------------
-- CLIENTES
---------------------------------------------------

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    endereco TEXT,

    contato_tecnico_nome VARCHAR(255),
    contato_tecnico_telefone VARCHAR(50),
    contato_tecnico_email VARCHAR(255),

    contato_gerencial_nome VARCHAR(255),
    contato_gerencial_telefone VARCHAR(50),
    contato_gerencial_email VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

---------------------------------------------------
-- CLOUD PROVIDERS
---------------------------------------------------

CREATE TABLE cloud_providers (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO cloud_providers (nome)
VALUES
('AWS'),
('Azure'),
('Google Cloud'),
('Oracle Cloud'),
('On-Premises');

---------------------------------------------------
-- TIPOS DE RECURSO
---------------------------------------------------

CREATE TABLE tipos_recurso (
    id SERIAL PRIMARY KEY,
    cloud_provider_id INTEGER NOT NULL
        REFERENCES cloud_providers(id)
        ON DELETE CASCADE,

    nome VARCHAR(100) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO tipos_recurso (
    cloud_provider_id,
    nome
)
VALUES
(1,'EC2'),
(1,'RDS'),
(1,'S3'),
(1,'EKS'),
(1,'ECS'),
(1,'Lambda'),
(1,'VPC'),

(2,'Virtual Machine'),
(2,'Azure SQL'),
(2,'Storage Account'),
(2,'AKS'),

(3,'Compute Engine'),
(3,'Cloud SQL'),
(3,'Cloud Storage'),

(4,'Compute'),
(4,'Autonomous Database'),

(5,'Servidor Fisico'),
(5,'VMware'),
(5,'SQL Server'),
(5,'File Server'),
(5,'Backup');

---------------------------------------------------
-- SERVICOS
---------------------------------------------------

CREATE TABLE servicos (

    id SERIAL PRIMARY KEY,

    cliente_id INTEGER NOT NULL
        REFERENCES clientes(id)
        ON DELETE CASCADE,

    tipo_recurso_id INTEGER NOT NULL
        REFERENCES tipos_recurso(id),

    regiao VARCHAR(50),

    identificacao_recurso VARCHAR(255) NOT NULL,

    tamanho_recurso VARCHAR(100),

    status VARCHAR(50)
        NOT NULL DEFAULT 'Ativo',

    observacoes TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

---------------------------------------------------
-- CLIENTES EXEMPLO
---------------------------------------------------

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
VALUES
(
    'STI',
    '62.287.519/0001-50',
    'Alfredo Chaves - ES',

    'Andre Nascimento',
    '27999999999',
    'andre@stiinventory.com',

    'Andre Nascimento',
    '27999999999',
    'andre@stiinventory.com'
),
(
    'Alpha Logistica Ltda',
    '12.345.678/0001-01',
    'Vitória - ES',

    'Carlos Souza',
    '27999990001',
    'carlos@alpha.com.br',

    'Fernanda Lima',
    '27999990002',
    'fernanda@alpha.com.br'
),
(
    'Beta Transportes Ltda',
    '12.345.678/0001-02',
    'Serra - ES',

    'João Pereira',
    '27999990003',
    'joao@beta.com.br',

    'Mariana Costa',
    '27999990004',
    'mariana@beta.com.br'
);

---------------------------------------------------
-- SERVICOS EXEMPLO
---------------------------------------------------

INSERT INTO servicos (
    cliente_id,
    tipo_recurso_id,
    regiao,
    identificacao_recurso,
    tamanho_recurso,
    status,
    observacoes
)
VALUES
(
    1,
    1,
    'us-east-1',
    'ec2-producao-sti',
    't3.medium',
    'Ativo',
    'Servidor principal'
),
(
    2,
    2,
    'sa-east-1',
    'rds-alpha',
    'db.t3.medium',
    'Ativo',
    'Banco principal'
),
(
    3,
    3,
    'us-east-1',
    'backup-beta',
    '500GB',
    'Ativo',
    'Bucket de backup'
);

---------------------------------------------------
-- VIEWS ÚTEIS
---------------------------------------------------

CREATE OR REPLACE VIEW vw_servicos AS
SELECT

    s.id,

    c.razao_social,

    cp.nome AS cloud_provider,

    tr.nome AS tipo_recurso,

    s.regiao,

    s.identificacao_recurso,

    s.tamanho_recurso,

    s.status,

    s.observacoes,

    s.created_at

FROM servicos s

INNER JOIN clientes c
    ON c.id = s.cliente_id

INNER JOIN tipos_recurso tr
    ON tr.id = s.tipo_recurso_id

INNER JOIN cloud_providers cp
    ON cp.id = tr.cloud_provider_id;
