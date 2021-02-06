class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    if params[:option] == "recent" || params[:option] == nil
      @recipes = @user.recipes.order(created_at: :desc).paginate(page: params[:page])
    elsif
      recipes_hash = @user.recipes.joins(:passive_likes).group("liked_id").order('count_all DESC').count
      recipe_ids = recipes_hash.keys
      recipe_array = Recipe.find(recipe_ids).sort_by{ |recipe| recipe_ids.index(recipe.id)}
      @recipes = Kaminari.paginate_array(recipe_array).page(params[:page]).per(20)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Recipes from Japan!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated / 更新に成功しました。"
      redirect_to @user
      #更新に成功した場合に扱う
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted / ユーザーを削除しました。"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                      :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
