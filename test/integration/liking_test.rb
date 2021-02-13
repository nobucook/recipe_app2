require 'test_helper'

class LikingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @recipe = recipes(:misoshiru)
    @category = categories(:Side)
    log_in_as(@user)
  end

  test "recipe page like unlike" do
    get recipe_path(@recipe)
    assert_not @recipe.likers.empty?
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', -1 do
      delete like_path(likes(:one))
    end
    assert_redirected_to recipe_path(@recipe)
    follow_redirect!
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', 1 do
      post likes_path(liker_id: @user.id, liked_id: @recipe.id)
    end
    assert_redirected_to recipe_path(@recipe)
    follow_redirect!
    assert_match @recipe.likers.count.to_s, response.body
  end

  test "recipe page like unlike with ajax" do
    get recipe_path(@recipe)
    assert_not @recipe.likers.empty?
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', -1 do
      delete like_path(likes(:one)), xhr: true
    end
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', 1 do
      post likes_path(liker_id: @user.id, liked_id: @recipe.id), xhr: true
    end
    assert_match @recipe.likers.count.to_s, response.body
  end

  test "recipe category page like unlike" do
    get recipe_category_path(id: @category.id)
    assert_not @recipe.likers.empty?
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', -1 do
      delete like_path(likes(:one))
    end
    # assert_redirected_to recipe_category_path(id: @category.id), {'HTTP_REFERER' => recipe_category_url(id: @category.id)}
    # follow_redirect!
    get recipe_category_path(id: @category.id)
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', 1 do
      post likes_path(liker_id: @user.id, liked_id: @recipe.id)
    end
    # assert_redirected_to recipe_category_path(id: @category.id)
    # follow_redirect!
    get recipe_category_path(id: @category.id)
    assert_match @recipe.likers.count.to_s, response.body
  end

  test "recipe category page like unlike with ajax" do
    get recipe_category_path(id: @category.id)
    assert_not @recipe.likers.empty?
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', -1 do
      delete like_path(likes(:one)), xhr: true
    end
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', 1 do
      post likes_path(liker_id: @user.id, liked_id: @recipe.id), xhr: true
    end
    assert_match @recipe.likers.count.to_s, response.body
  end

  test "recipe index page like unlike" do
    get recipes_path
    assert_template 'recipes/index'
    assert_not @recipe.likers.empty?
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', -1 do
      delete like_path(likes(:three))
    end
    get recipes_path
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', 1 do
      post likes_path(liker_id: @user.id, liked_id: @recipe.id)
    end
    get recipes_path
    assert_match @recipe.likers.count.to_s, response.body
  end

  test "recipe index page like unlike with ajax" do
    get recipes_path
    assert_template 'recipes/index'
    assert_not @recipe.likers.empty?
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', -1 do
      delete like_path(likes(:three)),xhr: true
    end
    get recipes_path
    assert_match @recipe.likers.count.to_s, response.body
    assert_difference 'Like.count', 1 do
      post likes_path(liker_id: @user.id, liked_id: @recipe.id), xhr: true
    end
    get recipes_path
    assert_match @recipe.likers.count.to_s, response.body
  end

end
