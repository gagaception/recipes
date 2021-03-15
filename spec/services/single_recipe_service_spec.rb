require 'rails_helper'

RSpec.describe Recipes::SingleRecipeService, type: :service do
  describe "#initialize" do
    let(:recipe) {Recipes::SingleRecipeService.new('4dT8tcb6ukGSIg2YyuGEOm')}
    
    it "should response to id" do
      expect(recipe.send(:id)).to eq('4dT8tcb6ukGSIg2YyuGEOm')
    end
  end
  
  context "#recipe" do
    it "should return recipe response" do
      response = Recipes::SingleRecipeService.call('4dT8tcb6ukGSIg2YyuGEOm')

      expect(response.successful?).to be true
      expect(response.data.id).to eq('4dT8tcb6ukGSIg2YyuGEOm')
    end

    it "should return error when recipe doesn't exist" do
      response = Recipes::SingleRecipeService.call('non_existing_id')
      error = 
      expect(response.successful?).to be false
      expect(response.error.message).to eq("Recipe with id: non_existing_id not found")
    end
  end
end