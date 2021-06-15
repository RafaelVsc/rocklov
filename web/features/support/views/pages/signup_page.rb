class SignupPage
  include Capybara::DSL

  def open_signup
    visit "/signup"
  end

  # user é o objeto inteiro contendo (nome, email, senha) esse objeto é construido no cadastro_steps.rb
  def create_user(user)
    find("#fullName").set user[:nome]
    find("#email").set user[:email]
    find("#password").set user[:senha]
    click_button "Cadastrar"
  end
end
