require 'rails_helper'

RSpec.describe Recipes::RecipeTransformService, type: :service do
  context "Single recipe" do
    context "with all data" do
      let(:recipe) do 
        OpenStruct.new(
          id: "c86ds78cdscsdhsdsdf",
          title: "Sample recipe",
          description: "__bold text__ *Italic text*: [watch video](https://www.youtube.com/)",
          photo: OpenStruct.new(url: 'photo_url'),
          tags: [OpenStruct.new(name: 'sample_tag'), OpenStruct.new(name: 'second_tag')],
          chef: OpenStruct.new(name: "Sample chef")
        )
      end
      
      it "should return all values" do
        response = Recipes::RecipeTransformService.call(recipe)
  
        expect(response.data.id).to eq("c86ds78cdscsdhsdsdf")
        expect(response.data.title).to eq("Sample recipe")
        expect(response.data.photo_url).to eq("photo_url")
        expect(response.data.chef).to eq("Sample chef")
        expect(response.data.tags).to eq(["sample_tag", "second_tag"])
      end
  
      it "should return description" do
        response = Recipes::RecipeTransformService.call(recipe)
  
        markdown_desc = <<~MARKDOWN
          <p><strong>bold text</strong> <em>Italic text</em>: <a href=\"https://www.youtube.com/\">watch video</a></p>
        MARKDOWN
  
        expect(response.data.description).to eq(markdown_desc)
      end
    end
  
    context "with missing data" do
      let(:recipe) do 
        OpenStruct.new(
          id: "c86ds78cdscsdhsdsdf",
          title: "Sample recipe",
          description: '',
          photo: OpenStruct.new(url: nil),
          tags: [],
          chef: OpenStruct.new(chef: nil),
        )
      end
  
      it "should return default values" do
        response = Recipes::RecipeTransformService.call(recipe)
        expect(response.data.photo_url).to eq("https://i.picsum.photos/id4000.jpg?hmac=aHjb0fRa1t14DTIEBcoC12c5rAXOSwnVlaA5ujxPQ0I")
        expect(response.data.chef).to eq('')
        expect(response.data.tags).to eq([])
      end
    end
  end

  context "Recipe list" do
    let(:recipes) do 
      [
        OpenStruct.new(
          id: "c86ds78cdscsdhsdsdf",
          title: "Sample recipe",
          description: "__bold text__ *Italic text*: [watch video](https://www.youtube.com/)",
          photo: OpenStruct.new(url: 'photo_url'),
          tags: [OpenStruct.new(name: 'sample_tag'), OpenStruct.new(name: 'second_tag')],
          chef: OpenStruct.new(name: "Sample chef")
        )
      ]
    end
    
    before :each do
      allow(recipes).to receive(:is_a?).and_return(true)
    end

    it "should be Array" do
      response = Recipes::RecipeTransformService.call(recipes)

      expect(response.data).to be_instance_of(Array)
    end

    it "should return values" do
      response = Recipes::RecipeTransformService.call(recipes)
      recipe = response.data.first

      markdown_desc = <<~MARKDOWN
        <p><strong>bold text</strong> <em>Italic text</em>: <a href=\"https://www.youtube.com/\">watch video</a></p>
      MARKDOWN

      expect(recipe.id).to eq("c86ds78cdscsdhsdsdf")
      expect(recipe.title).to eq("Sample recipe")
      expect(recipe.photo_url).to eq("photo_url")
      expect(recipe.chef).to eq("Sample chef")
      expect(recipe.tags).to eq(["sample_tag", "second_tag"])
      expect(recipe.description).to eq(markdown_desc)
    end
  end
end