Dado("que acesso a página de cadastro") do
  @signup_page.open_signup
end

Quando("submeto o seguinte formulário de cadastro:") do |table|
  # |table| is a Cucumber::MultilineArgument::DataTable

  # transforma a tabela do cadastro.feature (converte para hashes) transforma em array de dados
  # .first retornará primeira posição do array
  # user[:nome] = a coluna nome da table (cadastro.feature)
  # log table.hashes
  # [{"nome"=>"Rafael Vescio", "email"=>"rafael@gmail.com", "senha"=>"pwd123"}]
  user = table.hashes.first
  # log user
  # {"nome"=>"Rafael Vescio", "email"=>"rafael@gmail.com", "senha"=>"pwd123"}

  MongoDB.new.remove_user(user[:email])
  @signup_page.create_user(user)
end
