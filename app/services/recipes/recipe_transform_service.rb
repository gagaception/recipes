require 'redcarpet'

module Recipes
  class RecipeTransformService < BaseService
    TransformedRecipe = Struct.new(:id, :title, :description, :photo_url, :tags, :chef)

    def initialize(data)
      @data = data
    end

    def call
      Response.new(true, nil, transform_data)
    rescue StandardError => e
      Response.new(false, e, nil)
    end

    private

    attr_reader :data

    def transform_data
      if data.instance_of? Contentful::Array
        transform_list
      else
        transform_recipe(data)
      end
    end

    def transform_list
      data.map {|recipe| transform_recipe(recipe)}
    end

    def transform_recipe(recipe)
      TransformedRecipe.new(
        recipe.id,
        recipe.title,
        markdown(recipe.description),
        recipe&.photo&.url,
        tags(recipe),
        recipe&.chef&.name
      )
    end

    def markdown(description)
      renderer = Redcarpet::Render::HTML.new({})
      markdown = Redcarpet::Markdown.new(renderer, {})
      markdown.render(description)
    end

    def tags(recipe)
      recipe.tags.map(&:name)
    end
  end
end