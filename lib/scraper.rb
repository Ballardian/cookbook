require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

class Scraper
  def initialize(ingredient)
    @ingredient = ingredient
  end

#   def scrape_for_recipes
#     imported_recipe_array = []
#     html_content = open("../strawberry").read
#     doc = Nokogiri::HTML(html_content)

#     doc.search('.m_contenu_resultat').each_with_index do |element, index|
#       imported_recipe_array << ["#{index + 1}. #{element.text.strip}"]
#     end
#     return imported_recipe_array
#   end
# end

  def setup_scrape
    # html_content = open("strawberry").read
    # doc = Nokogiri::HTML(html_content)
    file = 'strawberry.html'
    doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
    return doc
  end

  def scrape_recipe_name(doc)
    name_array = []
    doc.search('.m_titre_resultat').each_with_index do |element, index|
      name_array << "#{index + 1}. #{element.text.strip}"
    end
    return name_array.first(5)
  end

  def scrape_recipe_description(doc, index_choice, name_array)
    description_array = []
    recipe_array = []
    index_choice -= 1
    recipe_array.push(name_array[index_choice])
    doc.search('.m_texte_resultat').each do |element|
      description_array << "#{element.text.strip}"
    end
    return recipe_array.push(description_array[index_choice])
  end

  def recipe_time(doc, index_choice, recipe_array)
    prep_array = []
    index_choice -= 1
    doc.search('.m_detail_time').each do |element|
      prep_time = element.search('.m_prep_time').first.parent.text.strip
      # if element.search('.m_cooking_time').nil?
      #   cook_time = element.search('.m_cooking_time').last.parent.text.strip
      #   #binding.pry
      #   recipe_array << [prep_time, cook_time]
      # else
      prep_array << prep_time
    end
    return recipe_array.push(prep_array[index_choice])
  end

  def recipe_difficulty(doc, index_choice, recipe_array)
    difficulty_array = []
    index_choice -= 1
    doc.search('.m_detail_recette').each do |element|
      whole_list = "#{element.text.strip}".split(" - ")
      difficulty_array << whole_list[2]
    end
    recipe_array.push(difficulty_array[index_choice])
    return recipe_array.push("false")
  end
end
