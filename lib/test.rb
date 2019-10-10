require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def open_links(url_list)
	result = []
	emails = url_list.each do |i|
		binding.pry
			new_url = Nokogiri::HTML(open('http://annuaire-des-mairies.com/95/'))
				email = new_url.xpath('//*[contains(text(), "@")]') 
				result << email.uniq
	end
	binding.pry
puts result
return result
end

def get_townhall_urls
	townhall_url = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/"))
	url_list = []
	  links_list = townhall_url.xpath('//*[contains(text(), "html")]')
		links_list.each do |i|
		  url_list << i.text
		end
		full_url = []
		compteur = 0
		full_url = url_list.each do |elem|
			binding.pry
			url_list[compteur] = url_list["http://annuaire-des-mairies.com/95/#{elem}"]
			compteur += 1
		end
		
		puts full_url
  return url_list
end
  
  get_townhall_urls
  #open_links(get_townhall_urls)