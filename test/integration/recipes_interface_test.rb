require 'test_helper'

class RecipesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "recipe interface" do
    log_in_as(@user)
    get recipes_path
    assert_select 'div.pagination'
    #無効な送信
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: {title: "", about: ""}}
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    title = "tekka-don"
    about = "tuna"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { title: title, about: about} }
    end
    assert_redirected_to recipes_url
    follow_redirect!
    assert_match title, response.body
    assert_match about, response.body

    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_recipe = @user.recipes.paginate(page: 1).first
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(first_recipe)
    end
    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
