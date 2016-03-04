class DosesController < ApplicationController
  before_action :find_cocktail, only: [ :new, :create, :destroy]

  def new
    find_cocktail
    @dose = Dose.new
    @available_ingredients = Ingredient.all - @cocktail.ingredients
  end

  def create
    set_dose
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail_id)
    else
      render "new"
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end


  private

  def set_dose
    @dose = @cocktail.doses.build(dose_params)
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end



