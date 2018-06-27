class ReceiptsController < ApplicationController
  before_action :check_login
  def create
    book = params[:receipt][:book_id]
    puts book
    if Book.exists?(:id => book)
      #@receipt = Receipt.new(receipt_params)
      #@receipt.user_id = current_user.id
      #@receipt.save
      receipt = receipt_params
      receipt[:user_id] = current_user.id
      Book.find(book).receipts.create(receipt)
      redirect_to book_path(book)
    else
      redirect_to user_path(current_user.id)
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
