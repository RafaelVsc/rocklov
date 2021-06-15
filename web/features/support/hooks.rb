# instanciando a classe LoginPage para que fique disponível em toda execução da bateria de testes
# sem a necessidade de instanciar a classe em outros steps definitinos

Before do
  @alert = AlertComponent.new
  @loging_page = LoginPage.new
  @signup_page = SignupPage.new
  @dash_page = DashboardPage.new
  @equipos_page = EquiposPage.new

  # page.driver.browser.manage.window.maximize
  page.current_window.resize_to(1440, 900)
end

After do
  temp_shot = page.save_screenshot("logs/temp_screenshot.png")
  Allure.add_attachment(
    name: "Screenshot",
    type: Allure::ContentType::PNG,
    source: File.open(temp_shot),
  )
end

# testar depois metodos abaixo para anexo no html.
# ver comentário na aula https://qaninja.academy/lesson/detail/57/1563/
# After do |scenario|
#   tempShot = page.save_screenshot("logs/tempShot.png")

#   screeshot = Base64.encode64(File.open(tempShot).read)

#   embed(screeshot, "image/png", "Print_da_tela")
#   # attach(screeshot, "image/png")
# end
