class MonthlyinputsController < ApplicationController
  def new
    unless params[:book_id]
      redirect_to books_path
    end
    @book_id = params[:book_id]
    @monthlyinput = Monthlyinput.new
  end
  
  def create
    @monthlyinput = Monthlyinput.new(monthlyinput_params)
    # 家計簿が指定されているかチェック
    unless @monthlyinput.book_id
      redirect_to books_path
    end
    @book = Book.find(@monthlyinput.book_id)
    if @book.monthlyinputs.create(monthlyinput_params)
      redirect_to monthlyinputs_path(:book_id => @monthlyinput.book_id)
    else
      flash.now[:danger] = "失敗しました。"
      render 'new'
    end
    
  end
  
  def index
    unless params[:book_id]
      redirect_to books_path
    end
    @monthlyinputs = Monthlyinput.where(:book_id => params[:book_id] )
    @book_id = params[:book_id]
  end
  
  def destroy
    @monthlyinput = Monthlyinput.find(params[:id])
    @book = Book.find(@monthlyinput.book_id)
    @book.monthlyinputs.find(params[:id]).destroy
    flash.now[:danger] = "自動入力を削除しました。"
    
    redirect_to monthlyinputs_path(:book_id => @monthlyinput.book_id)
    
  end
  
  private
  def monthlyinput_params
    params.require(:monthlyinput).permit(:store_id, :price, :start, :enddate, :book_id, :inputday)
  end
  
end
