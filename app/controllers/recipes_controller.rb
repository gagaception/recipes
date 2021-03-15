class RecipesController < ApplicationController
  def index
    response =  Recipes::RecipeListService.call
    if response.successful?
      @recipes = response.data
    else
      render :file => "#{Rails.root}/public/500.html",  :status => 500
    end
  end

  def show
  end
end
