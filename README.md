# STI Inventory

Sistema web para gerenciamento centralizado de clientes, serviços e ativos tecnológicos administrados pela STI.

## Sobre o Projeto

O STI Inventory foi desenvolvido com o objetivo de centralizar informações operacionais que atualmente encontram-se distribuídas entre planilhas, documentos e diferentes ferramentas de gerenciamento.

A aplicação permite o cadastro e consulta de clientes, serviços prestados e recursos tecnológicos, proporcionando maior organização, agilidade e controle dos ambientes administrados pela empresa.

Este projeto foi desenvolvido como parte da disciplina de Estágio Supervisionado do curso de Tecnologia em Análise e Desenvolvimento de Sistemas.

---

## Funcionalidades

### Dashboard

* Visão geral dos ambientes administrados;
* Indicadores operacionais;
* Resumo de clientes e serviços;
* Estatísticas de recursos tecnológicos.

### Gestão de Clientes

* Cadastro de clientes;
* Consulta de clientes;
* Atualização de informações;
* Registro de contatos técnicos e gerenciais.

### Gestão de Serviços

* Cadastro de serviços;
* Associação de serviços aos clientes;
* Controle de status operacional;
* Consulta de serviços cadastrados.

### Gestão de Recursos

* Cadastro de recursos tecnológicos;
* Associação aos serviços e clientes;
* Controle de recursos de infraestrutura e cloud computing;
* Consulta centralizada dos ativos.

---

## Arquitetura da Solução

```text
Usuário
   │
   ▼
Interface Web
(HTML5, CSS3 e JavaScript)
   │
   ▼
Aplicação STI Inventory
   │
   ▼
Banco de Dados PostgreSQL
```

---

## Tecnologias Utilizadas

* HTML5
* CSS3
* Bootstrap 5
* JavaScript
* PostgreSQL

---

## Fluxo da Aplicação

```text
Login
   │
   ▼
Dashboard
   │
   ├── Clientes
   │      ├─ Cadastro
   │      └─ Consulta
   │
   ├── Serviços
   │      ├─ Cadastro
   │      └─ Consulta
   │
   └── Recursos
          ├─ Cadastro
          └─ Consulta
```

---

## Objetivos

* Centralizar informações operacionais;
* Reduzir a dependência de planilhas eletrônicas;
* Melhorar a organização dos processos internos;
* Facilitar a consulta de informações;
* Apoiar a gestão dos ambientes administrados pela STI.

---

## Futuras Implementações

* Integração com AWS através de APIs;
* Descoberta automática de recursos cloud;
* Controle de contratos e licenciamento;
* Dashboard financeiro;
* Relatórios gerenciais;
* Controle de custos em nuvem;
* Integração com múltiplos provedores cloud.

---

## Telas da Aplicação

* Dashboard
* Cadastro de Clientes
* Consulta de Clientes
* Cadastro de Serviços
* Consulta de Serviços
* Cadastro de Recursos

---

## Autor

**André Luiz Nascimento**

Tecnólogo em Análise e Desenvolvimento de Sistemas.

Especialista em Infraestrutura, Cloud Computing e Soluções AWS.

---

## Licença

Este projeto foi desenvolvido para fins acadêmicos e de demonstração.
