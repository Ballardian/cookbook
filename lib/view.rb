# require_relative 'cookbook'
# require_relative 'recipe'
# require_relative 'app'
require 'csv'
# require 'pry bye-bug'

class View
  # def initialize(cookbook)
  #   @cookbook = cookbook
  # end

  def ask_for_recipe_name
    puts "Name your recipe"
    gets.chomp
  end

  def ask_for_description
    puts "Write a description your recipe"
    gets.chomp
  end

  def ask_for_index
    puts "Give an index"
    gets.chomp.to_i
  end

  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}: #{recipe.description}, prep time: #{recipe.prep_time}, difficulty: #{recipe.difficulty}, done: #{recipe.done}"
    end
  end

  def ask_user_for_ingredient
    puts "Give ingredient"
    gets.chomp
  end

  def ask_user_for_index
    puts "Give index"
    gets.chomp.to_i
  end

  def list_indexs(name_array)
    puts name_array
  end

  def user_mark_recipe
    puts "Choose a recipe to mark as done"
    gets.chomp.to_i
  end
end


