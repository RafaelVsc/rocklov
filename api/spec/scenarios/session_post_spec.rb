describe "POST /sessions" do
  context "login com sucesso" do
    # o before sem :all rodará o "hook" para cada it, é uma pré-condição para cada exemplod e teste
    before(:all) do
      # payload não é um json, é um hash do ruby, então no momento do posto via httparty
      payload = { email: "betao@hotmail.com", password: "pwd123" }
      @result = Sessions.new.login(payload)
    end
    it "validar status code" do
      expect(@result.code).to eql 201
    end

    it "validar id do usuário" do
      # id.length to eql 24 (no caso dessa api o id sempre sera de 24 caracteres)
      expect(@result.parsed_response["_id"].length).to eql 24
      # expect(@result.parsed_response["_id"].length).to eql 25  # força erro
    end
  end

  # examples = [
  #   {
  #     title: "senha incorreta",
  #     payload: { email: "betao@yahoo.com", password: "123456" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "usuario não existe",
  #     payload: { email: "404@yahoo.com", password: "pwd123
  #       " },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "email em branco",
  #     payload: { email: "", password: "123456" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "sem o campo o email",
  #     payload: { password: "123456" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "senha em branco",
  #     payload: { email: "betao@yahoo.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "sem o campo senha",
  #     payload: { email: "betao@yahoo.com" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  examples = Helpers::get_fixture("login")
  # para cada item do array "examples" faça
  examples.each do |e|
    context "#{e[:title]}" do
      # o before sem :all rodará o "hook" para cada it, é uma pré-condição para cada exemplod e teste
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end
      it "validar status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "validar mensagem de erro  #{e[:error]}" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
