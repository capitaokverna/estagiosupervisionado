async function login() {

    const username =
        document.getElementById("username").value;

    const password =
        document.getElementById("password").value;

    const message =
        document.getElementById("message");

    message.innerHTML = "";

    try {

        const response = await fetch(
            "http://localhost:3000/api/login",
            {
                method: "POST",

                headers: {
                    "Content-Type": "application/json"
                },

                body: JSON.stringify({
                    username,
                    password
                })
            }
        );

        const data = await response.json();

        if (!data.success) {

            message.innerHTML =
                "Usuário ou senha inválidos";

            return;
        }

        localStorage.setItem(
            "user",
            JSON.stringify(data.user)
        );

        window.location.href =
            "dashboard.html";

    }
    catch (error) {

        console.error(error);

        message.innerHTML =
            "Erro ao conectar com o servidor";

    }

}
