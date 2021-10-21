class StaticsController < ApplicationController
  before_action :home_redirect, only: [:home]

  def home
  end

  def not_found
  end

  def server_error
  end

  private
    def home_redirect
      #path = root_path

      if user_signed_in?
        unless current_user.admin
          redirect_to choose_inventory_path
        end
      end
    end
end
