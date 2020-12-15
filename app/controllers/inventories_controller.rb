class InventoriesController < ApplicationController
  require 'spreadsheet'

  before_action :set_inventory, only: [:show, :edit, :update, :destroy, :room, :export, :export_divergent, :history]

  def choose_inventory
    @inventories = current_user.inventories
  end

  def room
  end

  def export
    @data = @inventory.items

    p = Axlsx::Package.new
    wb = p.workbook
    
    wb.add_worksheet(name: "inventario") do |sheet|
      sheet.add_row ["ORDEM", "COD. BARRAS", "TOMBO", "ED", "DESCRIÇÃO", "RESPONSAVEL ATUAL", "SALA ATUAL", "VALOR", "ESTADO DE CONSERVAÇÃO", "SITUAÇÃO DE USO"]

      @data.each do |i|
        sala = i.sala
        sala = i.sala_atual unless i.sala_atual.nil?

        responsavel = i.responsavel
        responsavel = i.responsavel_atual unless i.responsavel_atual.nil? || i.responsavel_atual.empty?

        sheet.add_row [i.ord, i.cbarra, i.tombo, i.ed, i.descricao, responsavel, sala, i.valor, i.estado_conservacao, i.situacao_uso]
      end
    end
    
    send_data p.to_stream.read, type: "application/xlsx", filename: "inventario.xlsx"    
  end

  def export_divergent
    @items = @inventory.items.where(verified: true)
  end

  def index
    @inventories = Inventory.all
  end

  def show
    filter = {}
    per_page = 10

    unless params[:item].nil?
      unless params[:item][:sala].nil? || params[:item][:sala].empty?
        filter[:sala] = params[:item][:sala] 
      end

      unless params[:item][:verified].nil? || params[:item][:verified].empty?
        h = { "true"=>true, true=>true, "false"=>false, false=>false }
        filter[:verified] = h[params[:item][:verified]]
      end

      session[:filter] = filter.dup
      session[:filter][:per_page] = params[:item][:per_page]
    end

    unless session[:filter].nil?
      per_page = session[:filter][:per_page]
    end

    @items = @inventory.items.where(filter).page(params[:page]).per(per_page)
  end

  def history
    per_page = 10

    unless params[:item].nil?
      session[:filter] = {}
      session[:filter][:per_page] = params[:item][:per_page]
    end

    unless session[:filter].nil?
      per_page = session[:filter][:per_page]
    end

    @items = @inventory.items.where(verified: true).order(updated_at: :desc).page(params[:page]).per(per_page)
  end

  def new
    @inventory = Inventory.new(year: Time.now.year)
  end

  def edit
  end

  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        migrate_spreadsheet(@inventory) if params[:inventory][:file]

        format.html { redirect_to @inventory, notice: 'Inventário salvo com sucesso!' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        migrate_spreadsheet(@inventory)  if params[:inventory][:file]

        format.html { redirect_to @inventory, notice: 'Inventário salvo com sucesso!' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @inventory.destroy
    respond_to do |format|
      format.html { redirect_to inventories_url, notice: 'O inventário foi apagado!' }
    end
  end

  private
  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:year, :campus, :file, user_ids: [])
  end

  def migrate_spreadsheet(inventory)
    # if not have a file return false
    return false if @inventory.file.nil?
    # clean items
    inventory.items.destroy_all

    # create a hash params with all spreadsheet data
    book = Spreadsheet.open("#{Rails.root}/public#{inventory.file_url}")
    sheet1 = book.worksheet(0) # can use an index or worksheet name

    sheet1.each_with_index do |row, i|
      next if i == 0
      
      attributes = {
        verified: false,
        ord:               row[0].to_i,
        cbarra:            row[1].to_i,
        tombo:             row[2].to_i,
        ed:                row[3].to_i,
        descricao:         row[4],
        responsavel:       row[5],
        sala:              row[6],
        valor:             row[7]
      }

      inventory.items.create!(attributes)
    end
  end
end
