require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { campus: @item.campus, cbarra: @item.cbarra, descricao: @item.descricao, ed: @item.ed, estado_conservacao: @item.estado_conservacao, inventory_id: @item.inventory_id, ord: @item.ord, responsavel: @item.responsavel, responsavel_atual: @item.responsavel_atual, sala: @item.sala, sala_atual: @item.sala_atual, situacao_uso: @item.situacao_uso, tombo: @item.tombo, user_id: @item.user_id, valor: @item.valor, verified: @item.verified }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    patch :update, id: @item, item: { campus: @item.campus, cbarra: @item.cbarra, descricao: @item.descricao, ed: @item.ed, estado_conservacao: @item.estado_conservacao, inventory_id: @item.inventory_id, ord: @item.ord, responsavel: @item.responsavel, responsavel_atual: @item.responsavel_atual, sala: @item.sala, sala_atual: @item.sala_atual, situacao_uso: @item.situacao_uso, tombo: @item.tombo, user_id: @item.user_id, valor: @item.valor, verified: @item.verified }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
