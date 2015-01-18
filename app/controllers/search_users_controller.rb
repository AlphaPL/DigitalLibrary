class SearchUsersController < ApplicationController

  def search
    query = params[:q]
    @users = User.tire.search(load: true, page: params[:page], per_page: 15) do 
      query { string query, default_operator: "AND" } if query.present?
    end
  end

end
