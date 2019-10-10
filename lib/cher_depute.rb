require 'pry'
require 'open-uri'
require 'nokogiri'
require 'rspec'

def parsed_page
	page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr")) # open-uri permet de parser un site live
	return page
end 

def scrape_depute
  page = parsed_page
  full_names_array = []
  noms = []
  email_array = []

  noms = page.xpath('//*[@class="titre_normal"]')
  noms.each do |elem|
    full_names_array << { :first_name => elem.text.split(" ")[1], :last_name => elem.text.split(" ")[2] }
  end

    email = page.xpath('//*[contains(text(), "@assemblee-nationale.fr")]')

      email.each do |elem|
        email_array <<  elem.text[1..-1]
        end

        email_array.delete("bureau-m-orphelin@assemblee-nationale.fr")
        email_array.delete("secretariat-blanchet@assemblee-nationale.fr")

        full_names_array.map.with_index do |hash, i| 
            hash[:email] = email_array[i]
          end
  puts full_names_array
  return full_names_array
end

scrape_depute