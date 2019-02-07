require_relative 'recipe'
require 'csv'
require 'pry-byebug'

class Cookbook
  attr_accessor :recipes
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def mark_recipe_as_done(recipe)
    recipe.mark_as_done
    update_csv
  end

  private

  def update_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      recipe = Recipe.new(row[0], row[1], row[2], row[3], row[4])
      @recipes.push(recipe)
    end
  end
end
