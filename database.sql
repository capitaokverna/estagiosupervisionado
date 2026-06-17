
-- EDGE INVENTORY - SCRIPT COMPLETO

DROP TABLE IF EXISTS servicos CASCADE;
DROP TABLE IF EXISTS tipos_recurso CASCADE;
DROP TABLE IF EXISTS cloud_providers CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

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

CREATE TABLE cloud_providers (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO cloud_providers (nome) VALUES
('AWS'),('Azure'),('Google Cloud'),('Oracle Cloud'),('On-Premises');

CREATE TABLE tipos_recurso (
    id SERIAL PRIMARY KEY,
    cloud_provider_id INTEGER NOT NULL REFERENCES cloud_providers(id) ON DELETE CASCADE,
    nome VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO tipos_recurso (cloud_provider_id,nome) VALUES
(1,'EC2'),(1,'RDS'),(1,'S3'),(1,'EKS'),(1,'ECS'),(1,'Lambda'),(1,'VPC'),
(2,'Virtual Machine'),(2,'Azure SQL'),(2,'Storage Account'),(2,'AKS'),
(3,'Compute Engine'),(3,'Cloud SQL'),(3,'Cloud Storage'),
(4,'Compute'),(4,'Autonomous Database'),
(5,'Servidor Fisico'),(5,'VMware'),(5,'SQL Server'),(5,'File Server'),(5,'Backup');

CREATE TABLE servicos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
    tipo_recurso_id INTEGER NOT NULL REFERENCES tipos_recurso(id),
    regiao VARCHAR(50),
    identificacao_recurso VARCHAR(255) NOT NULL,
    tamanho_recurso VARCHAR(100),
    status VARCHAR(50) NOT NULL DEFAULT 'Ativo',
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO clientes (
razao_social,cnpj,endereco,
contato_tecnico_nome,contato_tecnico_telefone,contato_tecnico_email,
contato_gerencial_nome,contato_gerencial_telefone,contato_gerencial_email)
VALUES
('Edgepoint IT Solutions','62.287.519/0001-50','Alfredo Chaves - ES','Andre Nascimento','27999999999','andre@edgepoint.com.br','Andre Nascimento','27999999999','andre@edgepoint.com.br'),
('Alpha Logistica Ltda','12.345.678/0001-01','Vitória - ES','Carlos Souza','27999990001','carlos@alpha.com.br','Fernanda Lima','27999990002','fernanda@alpha.com.br'),
('Beta Transportes Ltda','12.345.678/0001-02','Serra - ES','João Pereira','27999990003','joao@beta.com.br','Mariana Costa','27999990004','mariana@beta.com.br'),
('Gamma Industria S/A','12.345.678/0001-03','Cariacica - ES','Ricardo Santos','27999990005','ricardo@gamma.com.br','Patricia Alves','27999990006','patricia@gamma.com.br'),
('Delta Comércio Ltda','12.345.678/0001-04','Vila Velha - ES','Felipe Rocha','27999990007','felipe@delta.com.br','Juliana Martins','27999990008','juliana@delta.com.br'),
('Omega Tecnologia Ltda','12.345.678/0001-05','Belo Horizonte - MG','Thiago Oliveira','31999990001','thiago@omega.com.br','Larissa Gomes','31999990002','larissa@omega.com.br'),
('Sigma Healthcare','12.345.678/0001-06','Rio de Janeiro - RJ','Eduardo Ramos','21999990001','eduardo@sigma.com.br','Camila Nunes','21999990002','camila@sigma.com.br'),
('Lambda Finance','12.345.678/0001-07','São Paulo - SP','Bruno Ferreira','11999990001','bruno@lambda.com.br','Amanda Teixeira','11999990002','amanda@lambda.com.br'),
('Phoenix Group','12.345.678/0001-08','Curitiba - PR','Leandro Melo','41999990001','leandro@phoenix.com.br','Priscila Dias','41999990002','priscila@phoenix.com.br'),
('Atlas Engenharia','12.345.678/0001-09','Brasília - DF','Gustavo Silva','61999990001','gustavo@atlas.com.br','Vanessa Rocha','61999990002','vanessa@atlas.com.br'),
('Nexus Telecom','12.345.678/0001-10','Salvador - BA','Rafael Lima','71999990001','rafael@nexus.com.br','Bianca Souza','71999990002','bianca@nexus.com.br'),
('Vision Agro','12.345.678/0001-11','Goiânia - GO','Pedro Costa','62999990001','pedro@visionagro.com.br','Claudia Pereira','62999990002','claudia@visionagro.com.br'),
('Titan Energia','12.345.678/0001-12','Fortaleza - CE','Lucas Martins','85999990001','lucas@titan.com.br','Renata Almeida','85999990002','renata@titan.com.br'),
('Global Foods','12.345.678/0001-13','Recife - PE','Andre Lopes','81999990001','andre@globalfoods.com.br','Daniela Freitas','81999990002','daniela@globalfoods.com.br'),
('Blue Ocean Services','12.345.678/0001-14','Florianópolis - SC','Marcelo Ribeiro','48999990001','marcelo@blueocean.com.br','Tatiane Campos','48999990002','tatiane@blueocean.com.br'),
('Vertex Solutions','12.345.678/0001-15','Porto Alegre - RS','Henrique Barros','51999990001','henrique@vertex.com.br','Aline Carvalho','51999990002','aline@vertex.com.br');

INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (1,1,'us-east-1','recurso-1','t3.medium','Ativo','Recurso de exemplo 1');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (2,2,'us-west-2','recurso-2','t3.medium','Ativo','Recurso de exemplo 2');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (3,3,'sa-east-1','recurso-3','t3.medium','Ativo','Recurso de exemplo 3');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (4,4,'us-east-1','recurso-4','t3.medium','Ativo','Recurso de exemplo 4');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (5,5,'us-west-2','recurso-5','t3.medium','Ativo','Recurso de exemplo 5');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (6,6,'sa-east-1','recurso-6','t3.medium','Ativo','Recurso de exemplo 6');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (7,7,'us-east-1','recurso-7','t3.medium','Ativo','Recurso de exemplo 7');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (8,8,'us-west-2','recurso-8','t3.medium','Ativo','Recurso de exemplo 8');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (9,9,'sa-east-1','recurso-9','t3.medium','Ativo','Recurso de exemplo 9');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (10,10,'us-east-1','recurso-10','t3.medium','Ativo','Recurso de exemplo 10');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (11,11,'us-west-2','recurso-11','t3.medium','Ativo','Recurso de exemplo 11');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (12,12,'sa-east-1','recurso-12','t3.medium','Ativo','Recurso de exemplo 12');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (13,13,'us-east-1','recurso-13','t3.medium','Ativo','Recurso de exemplo 13');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (14,14,'us-west-2','recurso-14','t3.medium','Ativo','Recurso de exemplo 14');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (15,15,'sa-east-1','recurso-15','t3.medium','Ativo','Recurso de exemplo 15');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (1,16,'us-east-1','recurso-16','t3.medium','Ativo','Recurso de exemplo 16');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (2,17,'us-west-2','recurso-17','t3.medium','Ativo','Recurso de exemplo 17');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (3,18,'sa-east-1','recurso-18','t3.medium','Ativo','Recurso de exemplo 18');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (4,19,'us-east-1','recurso-19','t3.medium','Ativo','Recurso de exemplo 19');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (5,20,'us-west-2','recurso-20','t3.medium','Ativo','Recurso de exemplo 20');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (6,1,'sa-east-1','recurso-21','t3.medium','Ativo','Recurso de exemplo 21');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (7,2,'us-east-1','recurso-22','t3.medium','Ativo','Recurso de exemplo 22');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (8,3,'us-west-2','recurso-23','t3.medium','Ativo','Recurso de exemplo 23');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (9,4,'sa-east-1','recurso-24','t3.medium','Ativo','Recurso de exemplo 24');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (10,5,'us-east-1','recurso-25','t3.medium','Ativo','Recurso de exemplo 25');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (11,6,'us-west-2','recurso-26','t3.medium','Ativo','Recurso de exemplo 26');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (12,7,'sa-east-1','recurso-27','t3.medium','Ativo','Recurso de exemplo 27');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (13,8,'us-east-1','recurso-28','t3.medium','Ativo','Recurso de exemplo 28');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (14,9,'us-west-2','recurso-29','t3.medium','Ativo','Recurso de exemplo 29');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (15,10,'sa-east-1','recurso-30','t3.medium','Ativo','Recurso de exemplo 30');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (1,11,'us-east-1','recurso-31','t3.medium','Ativo','Recurso de exemplo 31');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (2,12,'us-west-2','recurso-32','t3.medium','Ativo','Recurso de exemplo 32');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (3,13,'sa-east-1','recurso-33','t3.medium','Ativo','Recurso de exemplo 33');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (4,14,'us-east-1','recurso-34','t3.medium','Ativo','Recurso de exemplo 34');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (5,15,'us-west-2','recurso-35','t3.medium','Ativo','Recurso de exemplo 35');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (6,16,'sa-east-1','recurso-36','t3.medium','Ativo','Recurso de exemplo 36');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (7,17,'us-east-1','recurso-37','t3.medium','Ativo','Recurso de exemplo 37');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (8,18,'us-west-2','recurso-38','t3.medium','Ativo','Recurso de exemplo 38');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (9,19,'sa-east-1','recurso-39','t3.medium','Ativo','Recurso de exemplo 39');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (10,20,'us-east-1','recurso-40','t3.medium','Ativo','Recurso de exemplo 40');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (11,1,'us-west-2','recurso-41','t3.medium','Ativo','Recurso de exemplo 41');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (12,2,'sa-east-1','recurso-42','t3.medium','Ativo','Recurso de exemplo 42');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (13,3,'us-east-1','recurso-43','t3.medium','Ativo','Recurso de exemplo 43');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (14,4,'us-west-2','recurso-44','t3.medium','Ativo','Recurso de exemplo 44');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (15,5,'sa-east-1','recurso-45','t3.medium','Ativo','Recurso de exemplo 45');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (1,6,'us-east-1','recurso-46','t3.medium','Ativo','Recurso de exemplo 46');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (2,7,'us-west-2','recurso-47','t3.medium','Ativo','Recurso de exemplo 47');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (3,8,'sa-east-1','recurso-48','t3.medium','Ativo','Recurso de exemplo 48');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (4,9,'us-east-1','recurso-49','t3.medium','Ativo','Recurso de exemplo 49');
INSERT INTO servicos (cliente_id,tipo_recurso_id,regiao,identificacao_recurso,tamanho_recurso,status,observacoes) VALUES (5,10,'us-west-2','recurso-50','t3.medium','Ativo','Recurso de exemplo 50');
