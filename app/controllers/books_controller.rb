class BooksController < ApplicationController
  before_action :check_login, only: [:new, :create, :index]
  
  def new
    @book = Book.new
    @book.user_id = current_user.id
    view_context.showleft
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      redirect_to book_path(@book.id)
    else
      flash.now[:danger] = "家計簿を作るのに失敗しました。"
      render 'new'
    end
  end
  
  def index
    @books = Book.where({user_id: current_user.id})
  end
  
  def show
    @book = Book.find(params[:id])
    
    if params[:month]
      @month = params[:month].to_i
    else
      @month = Time.now.month
    end
    
    if params[:year]
      @year = params[:year].to_i
    else
      @year = Time.now.year
    end
    
    receipts = view_context.make_receipts(@year, @month)
    
    @data = receipts[:data]
    @income = receipts[:income]
    @payment = receipts[:payment]
    
    @bookid = params[:id]
    #p @data
    
  end
  
  
  private
  def book_params
    params.require(:book).permit(:name)
  end
end
