class SearchBooksController < ApplicationController

  def search
    @params = params
    query = params[:q] || ""
    genre = params[:genre_id] || ""
    if query != ""
        @books = Book.tire.search(load: true, page: params[:page], per_page: 15) do 
          query do
            string query 
          end
          filter :term, :genre_id => genre if genre != "" && genre != "0"
        end
    else
      if use_genre_in_query?(genre)
        @books = Book.where(genre_id: genre).paginate(page: params[:page], :per_page => 15)
      else
        @books == Book.all.paginate(page: params[:page], :per_page => 15)
      end
    end
  end


  def use_genre_in_query?(genre)
    genre != "" && genre != "0"
  end


end
