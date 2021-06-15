describe "POST /signup" do
  context "novo usuário" do
    before(:all) do
      payload = { name: "Pitty", email: "pitty@bol.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])
      @result = Signup.new.create(payload)
    end

    it "validar status code" do
      expect(@result.code).to eql 200
    end

    it "validar id do usuário" do
      # id.length to eql 24 (no caso dessa api o id sempre sera de 24 caracteres)
      expect(@result.parsed_response["_id"].length).to eql 24
      # expect(@result.parsed_response["_id"].length).to eql 25  # força erro
    end
  end
  context "usuario duplicado na base" do
    before(:all) do
      # dado que eu tenho um novo usuário
      payload = { name: "João da Silva", email: "joao@ig.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      # e o email desse usuário já foi cadastrado no sistema
      Signup.new.create(payload)

      # quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "validar status code (409)" do
      # entao deve retornar o status code 409
      expect(@result.code).to eql 409
    end

    it "retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  # examples = [
  #   {
  #     title: "Campo nome em branco",
  #     payload: { name: "", email: "vescio@bol.com.br", password: "pwd123" },
  #     code: 412,
  #     error: "required name",
  #   },
  #   {
  #     title: "Sem o campo nome",
  #     payload: { email: "vescio@bol.com.br", password: "pwd123" },
  #     code: 412,
  #     error: "required name",
  #   },
  #   {
  #     title: "Campo email em branco",
  #     payload: { name: "Rafael Vescio", email: "", password: "pwd123" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "Sem o campo email",
  #     payload: { name: "Rafael Vescio", password: "pwd123" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "Campo senha em branco",
  #     payload: { name: "Rafael Vescio", email: "vescio@bol.com.br", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "Sem o campo senha",
  #     payload: { name: "Rafael Vescio", email: "vescio@bol.com.br" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]
  examples = Helpers::get_fixture("signup")
  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Signup.new.create(e[:payload])
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
