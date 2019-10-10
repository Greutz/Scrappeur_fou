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
names_array = []
noms = []
compt = 0
email = []
email_hash = []
final_array = []

    noms = page.xpath('//*[@class="titre_normal"]')
    
    noms.each do |elem|
        names_array << { :first_name => elem.text.split(" ")[1], :last_name => elem.text.split(" ")[2] }
    end
    
      email = page.xpath('//*[contains(text(), "@assemblee-nationale.fr")]')
      
      email.each do |elem|
        email_hash << {:email => elem.text[1..-1]}
      end

      names_array.each do |i|
        final_array = names_array[compt] += email_hash[compt]
        compt += 1
      end
      puts final_array
      
end
    
scrape_depute