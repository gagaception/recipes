module Recipes
  class SingleRecipeService < BaseService
    def initialize(id)
      @id = id
    end

    def call
      Response.new(true, nil, recipe)
    rescue StandardError => e
      Response.new(false, e, nil)
    end

    private

    attr_reader :id

    def recipe
      Recipe.find(id) || raise(StandardError, "Recipe with id: #{id} not found")
    end
  end
end