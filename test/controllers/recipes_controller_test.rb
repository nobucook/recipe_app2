require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @recipe = recipes(:medamayaki)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { title: "title",
                                  about: "about"}}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Recipe.count' do
      delete recipe_path(@recipe)
    end
    assert_redirected_to login_url
  end

  # test "should create with logged in" do
  #   log_in_as(@user)
  #   assert_difference 'Recipe.count', 1 do
  #      assert_difference 'Ingredient.count', 1 do
  #           post recipes_path, params: {recipe: {
  #                                        title: "title",
  #                                        about: "about",
  #                                        ingredients_attributes: {
  #                                         ingredient: {ingre: "ingre", amount: "1cup"}
  #                                           }
  #                                         }
  #                                       }
  #       end
  #     end
  #   assert_redirected_to recipes_url
  # end
end
