Dado("que acesso a página principal") do
  @loging_page.open_page
end

Quando("submeto minhas credenciais com {string} e {string}") do |email, password|
  @loging_page.login_with(email, password)
end
