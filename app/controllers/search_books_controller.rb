class SearchBooksController < ApplicationController

  def search
    @params = params
    query = params[:q] || ""
    genre = params[:genre_id] || ""
    @books = Book.tire.search(load: true, page: params[:page], per_page: 15) do 
      query do
        string query
      end
      filter :term, :genre_id => genre if genre != "" && genre != "0"
    end
  end

end
