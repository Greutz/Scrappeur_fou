# Scrappeur_fou

Trois programmes et leurs tests :

Scrappeur_fou : 
- Va chercher le cours des cryptomonnaies sur : https://coinmarketcap.com/all/views/all/
et les ressort dans un array de hashes ayant l'acronyme de la crypto en clé, et sa valeur actuelle en valeur

Mairie_christmas :
- Va chercher les liens de toutes les adresses mail des mairies du Val d'Oise sur : http://annuaire-des-mairies.com/95/
récupère ensuite les adresses mail sur chaque page de mairie
et les range dans un array de hashes ayant le nom de la mairie en clé et l'adresse mail de la dite mairie en valeur

Cher_député :
- Va chercher la liste des adresses mail de tous les députés de France sur : 
https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr
et les range dans un array de hashes ayant deux paires de clés/valeurs.
La première paire est pour les noms et prénoms des députés
La deuxième contient en clé "email" et en valeur, l'adresse mail
