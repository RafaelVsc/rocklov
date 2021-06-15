require_relative "base_api"

# herda as caracteristicas da classe BaseApi (do arqiuvo base_api)
class Sessions < BaseApi
  def login(payload)
    # passa o parametro body (corpo da requisição) transformando payload em objeto json
    return self.class.post(
             "/sessions",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
    # variavel @result conseguimos acessar o status code retornado do HTTParty
    # puts @result
    # puts @result.class # tipo HTTParty::Response
    # parsed_response parseia o objeto HTTParty::Response para objeto Hash do ruby
    # podendo acessar qualquer item do objeto com ["nome_do_itemeae"]
    # puts @result.parsed_response["name"]
    # puts @result.parsed_response.class # tipo Hash do ruby
  end
end

# com include do HTTParty a classe herda os próprios metodos do HTTParty, utilizando o self.class(sua classe).post(get, ect...)
