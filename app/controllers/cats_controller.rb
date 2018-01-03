class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    if @cat
      render :show
    else
      render plain: "Couldn't find the cat.", status: 404
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    if @cat
      render :edit
    else
      render plain: "Couldn't find the cat.", status: 404
    end
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cats_url
    else
      render json: @cat
    end
  end

  def update
    @cat = Cat.find_by(id: params[:id])
    if @cat.update(cat_params)
      redirect_to cats_url
    else
      render json: @cat
    end
  end


  private

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
  end

end
