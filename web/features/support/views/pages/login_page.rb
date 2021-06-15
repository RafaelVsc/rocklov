class LoginPage
  # def initialize

  # end
  # a class LoginPage não conhece os metodos do capybara, como o visit "/", dessa forma utiliza-se o Capybara::DSL
  # muito parecido com herança, assim a classe passará a conhecer todos os recursos do capybara
  include Capybara::DSL

  def open_page
    visit "/"
  end

  def login_with(email, password)
    find("input[placeholder='Seu email']").set email
    find("input[type='password']").set password
    click_button "Entrar"
  end
end
