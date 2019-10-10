require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rspec'
require 'pry'

# On défini la page à parser
def parsed_page
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")) # open-uri permet de parser un site live
	return page
end 

# Avec xpath, on choisi les noms des crypto à scrapper
def scrapp_names
	page = parsed_page
	names = page.xpath('//*[@class="text-left col-symbol"]') # //*cherche dans toute l'arbo, [@class="text"] cherche les classes comprenant le texte écrit
	names_array = [] # On créer un array pour stocker les dits noms
	names.each do |name| # Pour chaque élément de names on remplit l'array et on convertit en string
		names_array << name.text.to_sym # On transforme l'objet nokogiri en string, puis en symbole (plus rapide d'accès que les strings, inchangeables, mais on ne compte pas les modifier)
	end
	return names_array
end

# Avec xpath, on choisi les prix des crypto à scrapper
def scrapp_prices
	page = parsed_page
	prices = page.xpath('//*[@class="price"]')
	prices_array = []
	prices.each do |price|   # Pour chaque élément de prices on récupère le texte et on l'injecte dans prices_array, en partant de l'index 1, un symbole $ étant à l'index 0,
		prices_array << price.text[1..-1].to_f # ce qui rend la conversion en float impossible (renvoie des floats a 0.0)
	end
	return prices_array
end 

# Méthode orchestre 
def perform
	names_array = scrapp_names # On lance nos méthodes et on stock leur return dans des variables
	prices_array = scrapp_prices 
	result = [] 
	names_array.each_with_index do |k, v|	# On part de l'array des noms, avec un .each_with_index (pour n'injecter qu'un élément a la fois) pour chaque élément denames_array, on utilise les index k et v(défini plus bas) pour :
		result << {k => (prices_array)[v]} # On push chaque chaque élément de names_array en clé (k) {k => , et pour valeurs associée on prends chaque éléments de prices_array, grace à son index v (prices_array)[v]
	end
	puts result
	return result
end


perform