require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @recipe   = recipes(:medamayaki)
    @recipe2 = recipes(:misoshiru)
    @category = categories(:Main)
    @category2 = categories(:Side)
    @relation = recipe_category_relations(:one)
  end
  
  test "recipe_category_path show only recipe with category" do
    get recipe_category_path(id: @category.id)
    assert_match @recipe.title, response.body
    assert_match @recipe.about, response.body
  end

  test "recipe_category_path doesn't show recipe with other category" do
    get recipe_category_path(id: @category.id)
    assert_no_match @recipe2.title, response.body
    assert_no_match @recipe2.about, response.body
  end


end
