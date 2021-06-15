describe "POST /equipos/{equipo_id}/bookings" do
  before(:all) do
    payload = { email: "ed@gmail.com", password: "pwd123" }
    result = Sessions.new.login(payload)
    @ed_id = result.parsed_response["_id"]
  end
  context "solicitar locacao" do
    before(:all) do
      # Dado que "Joe perry" tem um equipamento para locação
      result = Sessions.new.login({ email: "joe@gmail.com", password: "pwd123" })
      joe_id = result.parsed_response["_id"]

      fender = {
        thumbnail: Helpers::get_thumbnail("fender-sb.jpg"),
        name: "Fender Strato",
        category: "Cordas",
        price: 150,
      }

      MongoDB.new.remove_equipo(fender[:name], joe_id)

      result = Equipos.new.create(fender, joe_id)
      # retorna o id do equipamento cadastrado
      fender_id = result.parsed_response["_id"]

      # Quando solicitar locação da fender do Joe Perry
      @result = Equipos.new.booking(fender_id, @ed_id)
    end
    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end
end
