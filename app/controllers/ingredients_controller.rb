class IngredientsController < ApplicationController
  def new
    @recipe = Recipe.find_by(:id, params[:recipe][:id])
    @ingredient = Ingredient.new
    @instruction = Instruction.new
  end

  def create
    @ingredient = @recipe.ingredients.build(ingre_params)
    @instruction = @recipe.instructions.build(inst_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def ingre_params
      params.require(:ingredient).permit(:ingre, :amount)
    end

    def inst_params
      params.require(:instruction).permit(:no, :how_to)
    end

  end
