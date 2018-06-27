class GenresController < ApplicationController
  before_action :check_login
  
  def new
    @genre = Genre.new
  end
  def create
    @genre = Genre.new(genre_params)
    
    if @genre.save
      redirect_to genres_path
    else
      flash.now[:danger] = "ジャンル追加に失敗しました。"
      render 'new'
    end
  end
  
  def index 
    @genres = Genre.all
  end
  
  def destroy
    Genre.find(params[:id]).destroy
    
    redirect_to genres_path
  end
  
  private
  def genre_params
    params.require(:genre).permit(:name, :convinience, :eatout, :supermarket, :income, :hobby, :cost)
  end
end
