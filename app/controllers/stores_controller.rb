class StoresController < ApplicationController
  before_action :check_login
  def new
    @store = Store.new
  end 
  
  def create
    @store = Store.new(store_params)
    
    if @store.save
      redirect_to stores_path
    else
      flash.now[:danger] = "店舗追加に失敗しました。"
    end
  end
  
  def index
    @stores = Store.all
  end
  
  def edit
    @store = Store.find(params[:id])
    
  end
  
  def update
    @store = Store.find(params[:id])
    if @store.save
      redirect_to stores_path
    else
      flash.now[:danger] = "店舗追加に失敗しました。"
    end
  end
  
  
  
  def destroy
    Store.find(params[:id]).destroy
    
    redirect_to stores_path
  end
  
  private
  def store_params
    params.require(:store).permit(:name, :genre_id)
  end
end
