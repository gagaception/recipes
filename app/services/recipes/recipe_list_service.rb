module Recipes
  class RecipeListService < BaseService
    def initialize(page=1, per_page=4, order_field='sys.createdAt')
      @page = page.to_i
      @per_page = per_page.to_i
      @order_field = order_field
    end

    def call
      Response.new(true, nil, recipes)
    rescue StandartError => e
      Response.new(false, e, nil)
    end

    private
    
    attr_reader :page, :per_page,:order_field

    def recipes
      # In case of a large number of recipes added pagination
      # ContentfulModel paginate method
      Recipe.paginate(page, per_page, order_field).load
    end
  end
end