require 'redcarpet'

module Recipes
  class RecipeTransformService < BaseService
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
      if data.is_a? Contentful::Array
        transform_list
      else
        transform_recipe(data)
      end
    end

    def transform_list
      data.map {|recipe| transform_recipe(recipe)}
    end

    def transform_recipe(recipe)
      OpenStruct.new(
        id: recipe.id,
        title: recipe.title,
        description: markdown(recipe),
        photo_url: photo_url(recipe),
        tags: tags(recipe),
        chef: chef(recipe)
      )
    end

    def markdown(recipe)
      renderer = Redcarpet::Render::HTML.new({})
      markdown = Redcarpet::Markdown.new(renderer, {})
      markdown.render(recipe.description)
    end

    def tags(recipe)
      recipe.tags.map(&:name)
    end

    def photo_url(recipe)
      recipe&.photo&.url || 'https://i.picsum.photos/id4000.jpg?hmac=aHjb0fRa1t14DTIEBcoC12c5rAXOSwnVlaA5ujxPQ0I'
    end

    def chef(recipe)
      recipe&.chef&.name || ''
    end
  end
end