json.extract! item, :id, :user_id, :inventory_id, :verified, :estado_conservacao, :situacao_uso, :sala_atual, :responsavel_atual, :ord, :cbarra, :tombo, :ed, :descricao, :responsavel, :sala, :valor, :campus, :created_at, :updated_at
json.url item_url(item, format: :json)
