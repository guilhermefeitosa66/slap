class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :inventory

  #max_paginates_per 50

  attr_accessor :per_page

  before_save do |item|
    begin
      if item.responsavel_atual.nil? || item.responsavel_atual.empty?
        item.responsavel_atual = item.responsavel
      end
    rescue Exception => e
      puts "Erro ao tentar modificar o responsavel_atual"
    end
  end
end
