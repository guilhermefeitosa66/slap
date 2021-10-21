class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user, index: true, foreign_key: true
      t.references :inventory, index: true, foreign_key: true
      t.boolean :verified
      t.string :estado_conservacao
      t.string :situacao_uso
      t.string :sala_atual
      t.string :responsavel_atual
      t.string :ord
      t.string :cbarra
      t.string :tombo
      t.string :ed
      t.text   :descricao
      t.string :responsavel
      t.string :sala
      t.string :valor
      t.string :campus

      t.timestamps null: false
    end
  end
end
