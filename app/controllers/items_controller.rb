class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :undo]

  def check
    if !params[:item].nil?
      if !params[:item][:sala].nil?
        session[:sala] = params[:item][:sala]
      end

      if ((!params[:item][:estado_conservacao].nil?) && (!params[:item][:situacao_uso].nil?))
        session[:item_status] = {estado_conservacao: params[:item][:estado_conservacao], situacao_uso: params[:item][:situacao_uso], responsavel_atual: params[:item][:responsavel_atual] }
      end

      if !params[:item][:cbarra].nil? && !params[:item][:cbarra].empty?
        cbarra = params[:item][:cbarra].to_i.to_s
        @item = Item.where(cbarra: cbarra, inventory_id: params[:id]).first
      elsif !params[:item][:tombo].nil? && !params[:item][:tombo].empty?
        tombo = params[:item][:tombo].to_i.to_s
        @item = Item.where(tombo: tombo, inventory_id: params[:id]).first
      end

      if !@item.nil?
        if !@item.verified || params[:item][:change]
          @item.user_id = current_user.id
          @item.sala_atual = session[:sala]
          @item.verified = true
          @item.update(item_params)
        else
          @verified = true
        end
      end
    end
  end

  def items_room_list
    @items = Item.where(sala: params[:room], inventory_id: params[:id])
  end

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
    end
  end

  def undo
    @item.update({verified: false, estado_conservacao: nil, situacao_uso: nil, sala_atual: nil, responsavel_atual: nil})

    respond_to do |format|
      format.html { redirect_to history_path(@item.inventory_id) }
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:user_id, :verified, :estado_conservacao, :situacao_uso, :sala_atual, :responsavel_atual)
    end
end
