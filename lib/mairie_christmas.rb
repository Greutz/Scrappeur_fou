require 'pry'
require 'open-uri'
require 'nokogiri'
require 'rspec'


def get_townhall_email(url_list)

    email = townhall_url.xpath('//*[contains(text(), "@")]')
    new_arr = []
    email.each do |i|
        new_arr << i.text
    end
    puts new_arr
end

def get_townhall_urls
  townhall_url = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/"))
  url_list = []
    links_list = townhall_url.xpath('//*[contains(text(), "html")]')
      links_list.each do |i|
        url_list << i.text
      end
      puts url_list
return url_list
end

get_townhall_email(get_townhall_urls)