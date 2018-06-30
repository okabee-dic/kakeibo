class MonthlyinputsController < ApplicationController
  def new
    unless params[:book_id]
      redirect_to books_path
    end
    @book_id = params[:book_id]
    
    @book = Book.find(@book_id)
    
    #家計簿を作成したユーザだけが追加可能
    unless check_user(@book.user_id.to_i)
      return
    end
    
    @monthlyinput = Monthlyinput.new
  end
  
  def create
    @monthlyinput = Monthlyinput.new(monthlyinput_params)
    # 家計簿が指定されているかチェック
    unless @monthlyinput.book_id
      redirect_to books_path
      return
    end
    @book = Book.find(@monthlyinput.book_id)
    @book_id = @book.id
    
    #家計簿を作成したユーザだけが追加可能
    unless check_user(@book.user_id.to_i)
      return
    end
    
    @monthlyinput = @book.monthlyinputs.build(monthlyinput_params)
    if @monthlyinput.save
      redirect_to monthlyinputs_path(:book_id => @monthlyinput.book_id)
    else
      flash[:danger] = "失敗しました。"
      render 'new'
    end
    
  end
  
  def index
    unless params[:book_id]
      redirect_to books_path
    end
    @monthlyinputs = Monthlyinput.where(:book_id => params[:book_id] )
    @book_id = params[:book_id]
    
    @book = Book.find(@book_id)
    
    #家計簿を作成したユーザだけが追加可能
    unless check_user(@book.user_id.to_i)
      return
    end
  end
  
  def destroy
    @monthlyinput = Monthlyinput.find(params[:id])
    @book = Book.find(@monthlyinput.book_id)
    
    #家計簿を作成したユーザだけが可能
    unless check_user(@book.user_id.to_i)
      return
    end
    
    @book.monthlyinputs.find(params[:id]).destroy
    flash.now[:danger] = "自動入力を削除しました。"
    
    redirect_to monthlyinputs_path(:book_id => @monthlyinput.book_id)
    
  end
  
  private
  def monthlyinput_params
    params.require(:monthlyinput).permit(:store_id, :price, :start, :enddate, :book_id, :inputday)
  end
  
end
