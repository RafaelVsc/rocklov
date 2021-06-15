Dado("Login com {string} e {string}") do |email, password|
  @email = email

  @loging_page.open_page
  @loging_page.login_with(email, password)

  # checkpoint para garantir que está na página dashboard
  expect(@dash_page.on_dash?).to be true
end

Dado("que acesso o formulário de cadastro de anúncios") do
  @dash_page.goto_equipo_form
end

Dado("que eu tenho o seguinte equipamento:") do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  @anuncio = table.rows_hash
  # metodo para remoção do equipamento já cadastrado(evitando quebra do cenário)
  MongoDB.new.remove_equipo(@anuncio[:nome], @email)
  # variavel com @ se torna uma variavel de instância, ficando disponível durante toda execução do cenário
  # log @anuncio
end

Quando("submeto o cadastro desse item") do
  @equipos_page.create_equipo(@anuncio)
end

Então("devo ver esse item no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Então("deve conter a mensagem de alerta: {string}") do |expected_alert|
  expect(@alert.alert_dark).to have_text expected_alert
end

# Remover anúncios
Dado("que eu tenho um anúncio indesejado:") do |table|
  user_id = page.execute_script("return localStorage.getItem('user')")

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  EquiposService.new.create(@equipo, user_id)

  visit current_path
end

Quando("eu solicito a exclusão desse item") do
  @dash_page.request_removal(@equipo[:name])
  sleep 1 # thinking time (simula o usuário "pensando")
end

Quando("confirmo a exclusão") do
  @dash_page.confirm_removal
end

Quando("não confirmo a solicitação") do
  @dash_page.cancel_removal
end

Então("não devo ver esse item no meu Dashboard") do
  expect(
    @dash_page.has_no_equipo?(@equipo[:name])
  ).to be true
end

Então("esse item deve permanecer no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @equipo[:name]
end
