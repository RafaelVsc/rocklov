require "allure-cucumber"
require "capybara"
# importando modulo do capybara para funcionar com cucumber
require "capybara/cucumber"
require "faker"

# config é uma constante, imutavel, Fil.join recebe o caminho de execução do projeto, o caminho relativo do arquivo local.yml/hmg.yml etc...
# ENV é um recurso do ruby para ter acesso as variáveis de ambiente
CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))

case ENV["BROWSER"]
when "firefox"
  @driver = :selenium
when "chrome"
  @driver = :selenium_chrome
when "firefox_headless"
  @driver = :selenium_headless
when "chrome_headless"
  Capybara.register_driver :selenium_chrome_headless do |app|
    version = Capybara::Selenium::Driver.load_selenium
    options_key = Capybara::Selenium::Driver::CAPS_VERSION.satisfied_by?(version) ? :capabilities : :options
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.add_argument("--headless")
      opts.add_argument("--disable-gpu")
      opts.add_argument("--disable-site-isolation-trials")
      opts.add_argument("--no-sandbox")
      opts.add_argument("--disable-dev-shm-usage")
    end

    Capybara::Selenium::Driver.new(app, **{ :browser => :chrome, options_key => browser_options })
  end

  @driver = :selenium_chrome_headless
else
  raise "Navegador inccorreto, variável @driver está vazia"
end

Capybara.configure do |config|
  config.default_driver = @driver
  # carrega a variavel url do arquivo support/config/local.yml
  config.app_host = CONFIG["url"]
  # capybara tem até 10s para achar o elemento, timeout implicito
  config.default_max_wait_time = 10
end

AllureCucumber.configure do |config|
  config.results_directory = "/logs"
  # a linha abaixo configura para limpar os relatorios do allure sempre que executar os testes
  config.clean_results_directory = true
end
