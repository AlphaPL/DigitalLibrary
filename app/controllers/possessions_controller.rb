class PossessionsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy, :update]

  def create
    @copy = Copy.find(params[:borrowed_id])
    current_user.place_order(@copy)
    redirect_to book_path(@copy.book)
  end

  def destroy
    @possession = Possession.find(params[:id]).destroy
    @book = Copy.find(@possession.borrowed_id).book
    @possession.destroy
    redirect_to @book
  end

  def edit
    @possession = Possession.find(params[:id])
    @book = Copy.find(@possession.borrowed_id).book
    action = @possession.specifier == "pending" ? "active" : "delete"
    if action == "active"
      if @possession.update_attributes(specifier: action)
        flash[:success] = "Book order activated"
      end
    else
      @possession.destroy
    end
    redirect_to @book
  end

end
