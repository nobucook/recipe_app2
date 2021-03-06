require 'test_helper'

class RecipesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @category = categories(:Main)
    @category2 = categories(:Side)
    @misoshiru = recipes(:misoshiru)
  end

  test "recipe interface" do
    log_in_as(@user)
    get recipes_path
    assert_select 'div.pagination'
    #無効な送信
    assert_no_difference 'Recipe.count' do
      assert_no_difference 'Ingredient.count' do
         assert_no_difference 'Instruction.count' do
           post recipes_path, params: {recipe: {
                                        title: "",
                                        about: "",
                                        category_ids: [],
                                        ingredients_attributes: {
                                         '0': {ingre: "", amount: ""}
                                       },
                                       instructions_attributes: {
                                         '0': {no: "", how_to: ""}
                                       }
                                         }
                                       }
        end
      end
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    title = "tekka-don"
    about = "tuna"
    category = @category.id
    ingre = "ingre"
    amount = "amount"
    how_to = "how_to"
    no = 1
    log_in_as(@user)
    assert_difference 'Recipe.count', 1 do
      assert_difference 'RecipeCategoryRelation.count', 1 do
       assert_difference 'Ingredient.count', 1 do
          assert_difference 'Instruction.count', 1 do
            post recipes_path, params: {recipe: {
                                         title: title,
                                         about: about,
                                         category_ids: [category],
                                         ingredients_attributes: {
                                          '0': {ingre: ingre, amount: amount}
                                        },
                                        instructions_attributes: {
                                          '0': {no: no, how_to: how_to}
                                        }
                                          }
                                        }
          end
        end
      end
    end
    assert_redirected_to recipes_url
    follow_redirect!
    assert_match title, response.body
    assert_match about, response.body


    @recipe = @user.recipes.order(created_at: :desc).paginate(page: 1).first

    get user_path(@user)
    assert_match title, response.body
    assert_match about, response.body
    assert_match @category.name, response.body



    #投稿したレシピページの確認
    get recipe_path(@recipe)
    assert_match title, response.body
    assert_match about, response.body
    assert_match @category.name,response.body
    assert_match ingre, response.body
    assert_match amount, response.body
    assert_match no.to_s, response.body
    assert_match how_to, response.body
    assert_match 'Edit', response.body

    #レシピの編集
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    title = "una-don"
    about = "unagi"
    category = @category2.id
    ingre = "ingre2"
    amount = "amount2"
    how_to = "how_to2"
    no = 1
    patch recipe_path(@recipe), params: {recipe: {
                                 title: title,
                                 about: about,
                                 category_ids: [category],
                                 ingredients_attributes: {
                                  '0': {ingre: ingre, amount: amount}
                                },
                                instructions_attributes: {
                                  '0': {no: no, how_to: how_to}
                                }
                                  }
                                }

    assert_not flash.empty?
    assert_redirected_to @recipe
    @recipe.reload
    assert_equal title,  @recipe.title
    assert_equal about, @recipe.about
    assert_equal @category2.name, @recipe.categories.first.name




    # 投稿を削除する
    get recipes_url
    assert_select 'p', text: 'Delete'
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end

    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    get user_path(users(:archer))
    assert_select 'p', text: 'Delete', count: 0
  end

  @recipe1 = Recipe.joins(:passive_likes).group("liked_id").order('count_all DESC', created_at: :desc).count.keys[0]
  
  #likeの数による並び替え
  test  "test recipe sort order by count of likes" do
    get recipes_path(option: "popular")
    assert_select 'div.pagination'
  end
end
