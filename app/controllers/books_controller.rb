class BooksController < ApplicationController
  before_action :check_login, only: [:new, :create, :index]
  
  def new
    @book = Book.new
    @book.user_id = current_user.id
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      #新規店舗を追加
      g = Genre.first
      @store = @book.stores.create({name: g.name, genre_id: g.id, book_id: @book.id})
      
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
    
    unless check_user(@book.user_id.to_i)
      return
    end
    
    session[:bookselect] = params[:id]
    
    #日付指定を確認
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
    
    #books_helperに記述
    receipts = view_context.make_receipts(@year, @month)
    
    @data = receipts[:data]
    @income = receipts[:income]
    @payment = receipts[:payment]
    
    @bookid = params[:id]
    
  end
  
  def destroy 
    @book = Book.find(params[:id])
    
    @book.destroy
    
    redirect_to books_path
  end
  
  
  private
  def book_params
    params.require(:book).permit(:name)
  end
  
  
end
