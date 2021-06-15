Então("sou redirecionado para o Dashboard") do
  # to be true, é experado que o retorno do metodo on_dash? seja true
  expect(@dash_page.on_dash?).to be true
end

Então("vejo a mensagem de alerta: {string}") do |expected_alert|
  expect(@alert.alert_dark).to eql expected_alert
end
