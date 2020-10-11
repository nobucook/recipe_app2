class CategoriesController < ApplicationController

  def index
    @category = Category.find_by(id: params[:id])
    @recipes = Recipe.where(category_id: @category.id)
  end
  
  def recipe
    if params[:option] == "recent" || params[:option] == nil
      @category = Category.find(params[:id]) 
      @recipes = @category.recipes.order(created_at: :desc).paginate(page: params[:page])
      @page_title = "Recent #{@category.name} Recipes"
      render template: "recipes/index"
    elsif
      @category = Category.find(params[:id]) 
      # @recipes = @category.recipes.order(created_at: :desc).paginate(page: params[:page])
      recipes_hash = @category.recipes.joins(:passive_likes).group("liked_id").order('count_all DESC').count
      recipe_ids = recipes_hash.keys
      recipe_array = Recipe.find(recipe_ids).sort_by{ |recipe| recipe_ids.index(recipe.id)}
      @recipes = Kaminari.paginate_array(recipe_array).page(params[:page]).per(20)
      @page_title = "Popular #{@category.name} Recipes"
      render template: "recipes/index"
    end
  end
  
  # def find_recipe(category)
  #   recipe_array = Recipe.where(category_id: category.id)
    
  # end
  
end
