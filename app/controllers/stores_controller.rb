class StoresController < ApplicationController
  before_action :check_login
  before_action :check_book, except: [:create, :update]

  def new
    @bookid = params[:book_id]
    @store = Store.new
  end 
  
  def create
    @book = Book.find(params[:store][:book_id])
    @store = @book.stores.build(store_params)
    @bookid = @book.id
    
    if @store.save
      redirect_to stores_path(book_id: @book.id)
    else
      #flash[:danger] = "店舗追加に失敗しました。"
      render 'new'
    end
  end
  
  def index
    @book = Book.find(params[:book_id])
    @stores = @book.stores
    @bookid = params[:book_id]
  end
  
  def edit
    @store = Store.find(params[:id])
    @bookid = params[:book_id]
  end
  
  def update
    bookid = params[:store][:book_id]
    @store = Store.find(params[:id])
    if @store.update(store_params)
      redirect_to stores_path(book_id: bookid)
    else
      flash.now[:danger] = "店情報の編集に失敗しました。"
      render 'edit'
    end
  end
  
  
  
  def destroy
    Store.find(params[:id]).destroy
    
    redirect_to stores_path
  end
  
  private
  def store_params
    params.require(:store).permit(:name, :genre_id, :book_id)
  end
  
  def check_book
    unless params[:book_id]
      redirect_to books_path
    end
  end
end
