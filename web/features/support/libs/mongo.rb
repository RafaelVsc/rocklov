require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :client, :users, :equipos

  def initialize
    # realiza conexão com mongodb antes da execução dos steps abaixo
    # client = Mongo::Client.new('mongodb://rocklov-db:27017/rocklov')

    # carrega a variavel mongo do arquivo support/config/local.yml
    @client = Mongo::Client.new(CONFIG["mongo"])
    # conecta a collection users e equipo do mongo
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_danger
    @client.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def remove_user(email)
    # deleta o email automaticamente antes de preencher o campo e finalizar o cadastro
    users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipo(name, email)
    user_id = get_user(email)
    @equipos.delete_many({ name: name, user: user_id })
  end
end
