require "httparty"
# essa classe implementa o HTTParty e define a url padrão da api
class BaseApi
  include HTTParty
  base_uri "http://rocklov-api:3333"
end
