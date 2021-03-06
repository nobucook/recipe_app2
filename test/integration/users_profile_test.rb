require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

    def setup
      @user = users(:michael)
    end

    test "profile display" do
      get user_path(@user)
      assert_template 'users/show'
      assert_select 'title', full_title(@user.name)
      assert_match @user.name, response.body
      assert_match @user.recipes.count.to_s, response.body
      assert_select 'div.pagination'
      @user.recipes.order(created_at: :desc).paginate(page: 1).each do |recipe|
        assert_match recipe.title, response.body
        assert_match recipe.about, response.body
      end
    end
  end
