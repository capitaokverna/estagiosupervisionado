const API_URL = "http://localhost:3000/api";

document.addEventListener("DOMContentLoaded", () => {

    carregarClientes();

});

async function salvarCliente() {

    const cliente = {

        razao_social:
            document.getElementById("razao_social").value.trim(),

        cnpj:
            document.getElementById("cnpj").value.trim(),

        endereco:
            document.getElementById("endereco").value.trim(),

        contato_tecnico_nome:
            document.getElementById("contato_tecnico_nome").value.trim(),

        contato_tecnico_telefone:
            document.getElementById("contato_tecnico_telefone").value.trim(),

        contato_tecnico_email:
            document.getElementById("contato_tecnico_email").value.trim(),

        contato_gerencial_nome:
            document.getElementById("contato_gerencial_nome").value.trim(),

        contato_gerencial_telefone:
            document.getElementById("contato_gerencial_telefone").value.trim(),

        contato_gerencial_email:
            document.getElementById("contato_gerencial_email").value.trim()

    };

    if (
        !cliente.razao_social ||
        !cliente.cnpj
    ) {

        alert("Razão Social e CNPJ são obrigatórios.");

        return;

    }

    try {

        const response = await fetch(

            `${API_URL}/clientes`,

            {
                method: "POST",

                headers: {
                    "Content-Type": "application/json"
                },

                body: JSON.stringify(cliente)

            }

        );

        const data = await response.json();

        if (data.success) {

            alert("Cliente cadastrado com sucesso.");

            limparFormulario();

            carregarClientes();

        } else {

            alert(data.message || "Erro ao cadastrar cliente.");

        }

    }
    catch (error) {

        console.error(error);

        alert("Erro ao conectar com o servidor.");

    }

}

async function carregarClientes() {

    try {

        const response = await fetch(
            `${API_URL}/clientes`
        );

        const clientes = await response.json();

        const tabela =
            document.getElementById("clientesTable");

        tabela.innerHTML = "";

        clientes.forEach(cliente => {

            tabela.innerHTML += `
                <tr>

                    <td>${cliente.razao_social}</td>

                    <td>${cliente.cnpj}</td>

                    <td>${cliente.contato_tecnico_nome || '-'}</td>

                    <td>
                        <span class="badge bg-success">
                            Ativo
                        </span>
                    </td>

                    <td>

                        <button
                            class="btn btn-sm btn-primary">

                            Editar

                        </button>

                        <button
                            class="btn btn-sm btn-danger"
                            onclick="excluirCliente(${cliente.id})">

                            Excluir

                        </button>

                    </td>

                </tr>
            `;

        });

    }
    catch(error){

        console.error(error);

    }

}

async function excluirCliente(id) {

    const confirmar = confirm(
        "Deseja realmente excluir este cliente?"
    );

    if (!confirmar)
        return;

    try {

        const response = await fetch(

            `${API_URL}/clientes/${id}`,

            {
                method: "DELETE"
            }

        );

        const data = await response.json();

        if (data.success) {

            carregarClientes();

        }
        else {

            alert(
                data.message ||
                "Erro ao excluir cliente."
            );

        }

    }
    catch(error){

        console.error(error);

        alert(
            "Erro ao conectar com o servidor."
        );

    }

}

function limparFormulario() {

    document.getElementById("clienteForm").reset();

}
