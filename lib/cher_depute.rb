require 'pry'
require 'open-uri'
require 'nokogiri'
require 'rspec'

def parsed_page
	page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr")) # open-uri permet de parser un site live
	return page
end 

def scrape_deputies
    # On récupère le retours de la méthode parsed page
  page = parsed_page
  full_names_array = []
  noms = []
  email_array = []

  # On initialise une variable avec xpath pointant vers toutes les classes de l'arborescence html parsée intitulées "titre_normal"
  noms = page.xpath('//*[@class="titre_normal"]')
  # Pour chaque entrée de la variable noms, on va ranger les données converties en texte dans des hashes à l'intèrieur de l'array "full_name_array"
  noms.each do |elem|                          # On split chaque string aux espaces, on enlève l'élément 0 de l'index du string (mr, mme) et on l'ajoute en clé du nouveau hash, puis on fait de même pour la clé "last_name" en enlevant les deux premières partis du string (mr/mme et le prénom) pour ne garder que le nom de famille
    full_names_array << { :first_name => elem.text.split(" ")[1], :last_name => elem.text.split(" ")[2] }
  end

        # Pour les adresses email, on cible les nodes contenant le texte "@assemblee-nationale.fr"
    email = page.xpath('//*[contains(text(), "@assemblee-nationale.fr")]')

        # Pour chaque élément de la variable email, on injecte l'élément en cours dans la boucle, transformé en texte, et troncaté(un espace est présent en début d'adresse) dans un nouvel array
      email.each do |elem|
        email_array <<  elem.text[1..-1]
        end
        # Deux filous utilisent @assemblee-nationale.fr dans leur deux adresses mail, résultant deux "doublons" aux noms différents(donc .uniq inefficace)
        # On les supprime donc du tableau final à la main
        email_array.delete("bureau-m-orphelin@assemblee-nationale.fr")
        email_array.delete("secretariat-blanchet@assemblee-nationale.fr")

        # On dispose à présent d'un array contenant des hash pour les noms, et d'un array contenant des strings pour les adresses
        # On utilise .map.with_index comme agent de transformation pour implémenter dans l'array "full_names_array" le dernier élément manquants aux hashes
        full_names_array.map.with_index do |hash, i| 
            # On ajoute à chaque élément de l'array "full_names_array" une nouvelle paire de clés, et valeurs pour les emails
            hash[:email] = email_array[i]
          end
          # Succès, l'array full_names_array contient toutes les infos demandées
  puts full_names_array
  return full_names_array
end

scrape_depute