class CategoriesController < ApplicationController

  def index
    @category = Category.find_by(id: params[:id])
    @recipes = Recipe.where(category_id: @category.id)
  end
  
  def recipe
    @category = Category.find(params[:id]) 
    @recipes = @category.recipes.paginate(page: params[:page])
    @page_title = "#{@category.name} Recipes"
    render template: "recipes/index"
  end
  
  # def find_recipe(category)
  #   recipe_array = Recipe.where(category_id: category.id)
    
  # end
  
end
