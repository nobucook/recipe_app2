class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @recipe = Recipe.find(params[:liked_id])
    current_user.like(@recipe)
    # redirect_back(fallback_location: @recipe)
    respond_to do |format|
      format.html {redirect_back fallback_location: @recipe}
      format.js
    end
  end

  def destroy
    @recipe = Like.find(params[:id]).liked
    current_user.unlike(@recipe)
    # redirect_back(fallback_location: @recipe)
    respond_to do |format|
      format.html {redirect_back fallback_location: @recipe}
      format.js
    end
  end

end
