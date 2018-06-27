class ReceiptsController < ApplicationController
  before_action :check_login
  def create
    book = params[:receipt][:book_id]
    if (params[:receipt][:store_id]).nil?
        #店情報は必須
        redirect_to new_store_path(book_id: book)
    elsif (params[:receipt][:price]).empty?
      #金額なしは再入力
      flash.now[:danger] = "金額を入力してください"
      redirect_to book_path(book)
    else
      if Book.exists?(:id => book)
      #@receipt = Receipt.new(receipt_params)
      #@receipt.user_id = current_user.id
      #@receipt.save
        receipt = receipt_params
        receipt[:user_id] = current_user.id
      
      
      
        Book.find(book).receipts.create(receipt)
        month = params[:receipt][:month]
        year = params[:receipt][:year]
        redirect_to book_path(book, month: month, year: year)
      else
        redirect_to user_path(current_user.id)
      end
    end
  end
  
  def destroy
    @receipt = Receipt.find(params[:id])
    book = Book.find(@receipt.book_id)
    #@receipt.destroy
    book.receipts.find_by(:id => params[:id]).destroy
    redirect_to book_path(book)
  end
  
  private
  def receipt_params
    params.require(:receipt).permit(:store_id, :price, :book_id, :pay_date)
  end
  
end
