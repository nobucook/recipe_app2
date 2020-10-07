require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

    def setup
      @user = users(:michael)
      @recipe = @user.recipes.build(title: "tamagoyaki",
                                    about: "Soft and Sweet!")
    end

    test "should be valid" do
      assert @recipe.valid?
    end

    test "user id should be present" do
      @recipe.user_id = nil
      assert_not @recipe.valid?
    end

    test "title should be present" do
      @recipe.title = "  "
      assert_not @recipe.valid?
    end


end
