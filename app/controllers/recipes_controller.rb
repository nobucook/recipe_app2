class RecipesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @recipes = Recipe.all.paginate(page: params[:page])
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    # @recipe = current_user.recipes.build if logged_in?
    @recipe = Recipe.new
    3.times { @recipe.ingredients.build }
    3.times { @recipe.instructions.build }

  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe created! / レシピが投稿されました。"
      redirect_to recipes_url
    else
      render 'recipes/new'
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Recipe deleted / レシピを削除しました。"
    redirect_to request.referrer || root_url
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :about, :picture, :_destroy,
                              instructions_attributes: [:id, :no, :how_to, :_destroy],
                              ingredients_attributes: [:id, :ingre, :amount, :_destroy]
                            )
  end

  def correct_user
    @recipe = current_user.recipes.find_by(id: params[:id])
    redirect_to root_url if @recipe.nil?
  end

end
