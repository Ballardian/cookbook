# require_relative 'cookbook'
# require_relative 'recipe'
# require_relative 'app'
# require 'csv'
require 'pry-byebug'


# csv_file = File.join(__dir__, 'recipes.csv')
# new_cookbook = Cookbook.new(csv_file)
# recipe = Recipe.new("eggs", "poached")
# recipe_one = Recipe.new("bacon", "burnt")
# new_cookbook.add_recipe(recipe_one)
# p new_cookbook.all
# #new_cookbook.save_recipes(recipe, csv_file)



# ingredient = 'chocolate'
# url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{ingredient}"

# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)

# html_doc.search('.m_titre_resultat a').each do |element|
#   puts element.text.strip
#   puts element.attribute('href').value
# end

require 'open-uri'
require 'nokogiri'


def setup_scrape
  # html_content = open("strawberry").read
  # doc = Nokogiri::HTML(html_content)
  file = 'strawberry.html'
  doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
  return doc
end

def scrape_recipe_name(doc)
  imported_recipe_array = []
  doc.search('.m_titre_resultat').each_with_index do |element, index|
    imported_recipe_array << "#{index + 1}. #{element.text.strip}"
  end
  return imported_recipe_array.first(5)
end

def scrape_recipe_description(doc, index_choice, imported_recipe_array)
  description_array = []
  recipe_array = []
  index_choice -= 1
  recipe_array.push(imported_recipe_array[index_choice])
  doc.search('.m_texte_resultat').each do |element|
    description_array << "#{element.text.strip}"
  end
  return recipe_array.push(description_array[index_choice])
end

def recipe_time(doc)
  recipe_array = []
  doc.search('.m_detail_time').each do |element|
    prep_time = element.search('.m_prep_time').first.parent.text.strip
    # if element.search('.m_cooking_time').nil?
    #   cook_time = element.search('.m_cooking_time').last.parent.text.strip
    #   #binding.pry
    #   recipe_array << [prep_time, cook_time]
    # else
      recipe_array << prep_time
  end
  #return recipe_array.push(description_array[index_choice])
  return recipe_array.first(5)
end

# def difficulty(doc)
#   imported_recipe_array = []
#   doc.search('.m_detail_recette').each do |element|
#     whole_list = "#{element.text.strip}".split(" - ")
#     imported_recipe_array << whole_list[2]
#   end
#   return imported_recipe_array.first(5)
# end

test_scrape = setup_scrape
name_s = scrape_recipe_name(test_scrape)
# p name_s.class
# p scrape_recipe_description(test_scrape, 2, name_s)
p difficulty(test_scrape)

# .m_detail_recette
