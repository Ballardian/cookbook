require_relative 'view'
require_relative 'scraper'
require 'pry-byebug'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    @view.display_recipes(@cookbook.all)
  end

  def create
    # ask user for name
    name = @view.ask_for_recipe_name
    # ask user for description
    description = @view.ask_for_description
    recipe = Recipe.new(name, description)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    recipe_index = @view.ask_for_index
    @cookbook.remove_recipe(recipe_index)
  end

  def import
    ingredient = @view.ask_user_for_ingredient
    scraper = Scraper.new(ingredient)
    setup_doc = scraper.setup_scrape
    name_array = scraper.scrape_recipe_name(setup_doc)
    @view.list_indexs(name_array)
    index_choice = @view.ask_user_for_index
    recipe_array = scraper.scrape_recipe_description(setup_doc, index_choice, name_array)
    recipe_name_desc = scraper.recipe_time(setup_doc, index_choice, recipe_array)
    recipe_full_array = scraper.recipe_difficulty(setup_doc, index_choice, recipe_name_desc)
    recipe = Recipe.new(recipe_full_array[0], recipe_full_array[1], recipe_full_array[2], recipe_full_array[3], recipe_full_array[4])
    @cookbook.add_recipe(recipe)
  end

  def mark_recipe
    list
    index_choice = @view.user_mark_recipe
    index_choice -= 1
    recipe = @cookbook.all[index_choice]
    @cookbook.mark_recipe_as_done(recipe)
  end
end
