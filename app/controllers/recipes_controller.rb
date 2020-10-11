class RecipesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:option] == "recent" || params[:option] == nil
      @page_title = "Recent Recipes"
      @recipes = Recipe.all.order(created_at: :desc).paginate(page: params[:page])
    elsif params[:option] == "popular"
      @page_title = "Popular Recipes"
      # recipes_hash = Recipe.joins(:passive_likes).group("liked_id").order('count_all DESC', created_at: :desc).count
      recipes_hash = Recipe.joins(:passive_likes).group("liked_id").order('count_all DESC').order(created_at: :desc).count
      recipe_ids = recipes_hash.keys
      recipe_array = Recipe.find(recipe_ids).sort_by{ |recipe| recipe_ids.index(recipe.id)}
      @recipes = Kaminari.paginate_array(recipe_array).page(params[:page]).per(20)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    # @recipe = current_user.recipes.build if logged_in?
    @recipe = Recipe.new
    4.times { @recipe.ingredients.build }
    3.times { @recipe.instructions.build }

  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    @recipe.image.attach(params[:recipe][:image])
    if @recipe.save
      flash[:success] = "Recipe created! / レシピが投稿されました。"
      redirect_to recipes_url
    else
      render 'recipes/new'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe updated / 更新に成功しました。"
      redirect_to @recipe
      #更新に成功した場合に扱う
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Recipe deleted / レシピを削除しました。"
    redirect_to request.referrer || root_url
  end

  private

  # def recipe_params
  #   params.require(:recipe).permit(:content, :image)
  # end

  def recipe_params
    params.require(:recipe).permit(:title, :about, :image, :_destroy,
                              category_ids: [], 
                              instructions_attributes: [:id, :no, :how_to, :_destroy],
                              ingredients_attributes: [:id, :ingre, :amount, :_destroy]
                            )
  end

  def correct_user
    @recipe = current_user.recipes.find_by(id: params[:id])
    redirect_to root_url if @recipe.nil?
  end

end
