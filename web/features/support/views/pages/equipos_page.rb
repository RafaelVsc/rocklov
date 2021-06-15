class EquiposPage
  include Capybara::DSL

  def create_equipo(equipo)
    # isso é um checkpoint com timeout explicito para garantir que estou na página certa
    page.has_css?("#equipoForm")

    # executa o metodo se o equipo[:thumb] for maior que 0
    upload(equipo[:thumb]) if equipo[:thumb].length > 0
    # find('#name')
    # $ termina com
    find("input[placeholder$='equipamento']").set equipo[:nome]
    select_category(equipo[:categoria]) if equipo[:categoria].length > 0
    # find("#preco").set equipo[:preco]
    find("input[placeholder^=Valor]").set equipo[:preco]

    click_button "Cadastrar"
  end

  def select_category(cat)
    # dentro do select, busca a opção com o texto da categoria e seleciona a opção
    find("#category").find("option", text: cat).select_option
  end

  def upload(file_name)
    # Dir.pwd é um recurso do ruby, faz com que consiga obter o diretorio de execução do projeto
    image = Dir.pwd + "/features/support/fixtures/images/#{file_name}"
    # visible: false = busque pelo seletor css e caso elemento esteja oculto, leve em consideração
    find("#thumbnail input[type=file]", visible: false).set image
  end
end

# expect dentro de classes violam a arquitetura de projeto
# expect(page).to have_css "#equipoForm"
