class BooksController < ApplicationController

before_action :admin_user,     only: [:new, :update, :edit, :create, :destroy]

  def new
      @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_url
    else
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user.id if logged_in?
    @copies = @book.copies.paginate(page: params[:page], :per_page => 30)
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Book updated"
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    Book.tire.index.delete
    Book.tire.import
    Book.tire.index.refresh
    redirect_to books_path
  end

  def index
    @books = Book.paginate(page: params[:page], :per_page => 15)
  end

  def edit
    @book = Book.find(params[:id])
  end

  private

    def admin_user
      if not logged_in? && current_user.admin?
        if params[:id]
          redirect_to book_path(Book.find(params[:id])) 
        else
          redirect_to books_path unless logged_in? && current_user.admin?
        end
      end
    end
  
    def book_params
      params.require(:book).permit(:title, :author, :amount, :synopsis, :picture)
    end

end
