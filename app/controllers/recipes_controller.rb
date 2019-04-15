class RecipesController < ApplicationController

  def new
    @baker = current_baker
    @recipe = Recipe.new
  end

  def create
    @baker = current_baker
    @recipe = @baker.recipes.new(recipe_params)
    if @recipe.save
      flash[:notice] = "#{@recipe.name} Recipe Added!"
      redirect_to profile_path
    else
      @recipe.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @baker = current_baker
    @recipe = Recipe.find(params[:id])
  end

  def update
    @baker = current_baker
    if @recipe = @baker.recipes.update(recipe_params)
      flash[:update] = "Recipe Updated"
      redirect_to profile_path
    else
      flash[:errors] = @recipe.errors.full_messages
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to profile_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :bake_time, :oven_temp)
  end
end
