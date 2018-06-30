class ReceiptsController < ApplicationController
  before_action :check_login
  def create
    if params[:receipt][:book_id]
      @book = Book.find(params[:receipt][:book_id])
    else
      redirect_to books_path
      return
    end
    
    #家計簿を作成したユーザだけが追加可能
    unless check_user(@book.user_id.to_i)
      return
    end
    if (params[:receipt][:store_id]).nil?
        #店情報は必須
        redirect_to new_store_path(book_id: @book.id)
    elsif (params[:receipt][:price]).empty?
      #金額なしは再入力
      flash[:danger] = "金額を入力してください"
      redirect_to book_path(@book.id)
      #render :template => "book/show"
    else
      if Book.exists?(:id => @book.id)
      #@receipt = Receipt.new(receipt_params)
      #@receipt.user_id = current_user.id
      #@receipt.save
        receipt = receipt_params
        receipt[:user_id] = current_user.id
      
      
      
        Book.find(@book.id).receipts.create(receipt)
        month = params[:receipt][:month]
        year = params[:receipt][:year]
        redirect_to book_path(@book.id, month: month, year: year)
      else
        redirect_to user_path(current_user.id)
      end
    end
  end
  
  def destroy
    @receipt = Receipt.find(params[:id])
    book = Book.find(@receipt.book_id)
    
    #家計簿を作成したユーザだけが可能
    unless check_user(book.user_id.to_i)
      return
    end
    
    #@receipt.destroy
    book.receipts.find_by(:id => params[:id]).destroy
    redirect_to book_path(book)
  end
  
  private
  def receipt_params
    params.require(:receipt).permit(:store_id, :price, :book_id, :pay_date)
  end
  
end
