require 'rails_helper'

RSpec.describe Recipes::RecipeListService, type: :service do
  describe '#initialize' do
    context "#default params" do
      let(:list) {Recipes::RecipeListService.new}
  
      it "should respond to the first page" do
        expect(list.send(:page)).to eq(1)  
      end

      it "should be ordered by createdAt" do
        expect(list.send(:order_field)).to eq('sys.createdAt') 
      end

      it "should return default recipes count" do
        expect(list.send(:per_page)).to eq(4)
      end
    end

    context "with custom params" do
      let(:list) {Recipes::RecipeListService.new(2, 3, "sys.updatedAt")}

      it "should respond to the second page" do
        expect(list.send(:page)).to eq(2)  
      end

      it "should respond with 3 recipes" do
        expect(list.send(:per_page)).to eq(3)  
      end

      it "should be ordered by updatedAt" do
        expect(list.send(:order_field)).to eq('sys.updatedAt') 
      end
    end
  end
end