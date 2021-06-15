#language: pt

Funcionalidade: Cadastro
    Sendo um músico que possui equipamentos musicais
    Quero fazer o meu cadastro no RockLov
    Para que eu possa disponibilizá-los para locação

    @cadastro
    Cenario: Fazer cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome          | email            | senha  |
            | Rafael Vescio | rafael@gmail.com | pwd123 |
        Então sou redirecionado para o Dashboard

    # <> = São placeholder do cucumber
    # quando cucumber encontra um esquema de cenario, ele procura pela matriz de "Exemplos"
    # >> faz a substituição dos valores da matriz com os campos da sua tabela
    Esquema do Cenario: Tentativa de Cadastro
        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome         | email         | senha         |
            | <nome_input> | <email_input> | <senha_input> |
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | nome_input    | email_input      | senha_input | mensagem_output                  |
            |               | rafael@gmail.com | pwd123      | Oops. Informe seu nome completo! |
            | Rafael Vescio |                  | pwd123      | Oops. Informe um email válido!   |
            | Rafael Vescio | rafael*gmail.com | pwd123      | Oops. Informe um email válido!   |
            | Rafael Vescio | rafael&gmail.com | pwd123      | Oops. Informe um email válido!   |
            | Rafael Vescio | rafael@gmail.com |             | Oops. Informe sua senha secreta! |
