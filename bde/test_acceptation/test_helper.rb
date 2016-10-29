gem 'minitest', '=5.4.3'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'


class Object
  def _describe( test )
    puts "--- On saute les tests pour \"#{test}\" ---"
  end

  def _it( test )
    puts "--- On saute le test \"#{test}\" ---"
  end
end

def bde_cli( cmd )
  # On execute la commande indiquee et on retourne un Array des lignes
  # obtenues.
  %x{bundle exec bin/bde #{cmd} 2>&1}.split("\n") ##
end

def sauvergarder_base_donnee
  %x{mv .bde.txt .bde_backup.txt}
end

def restaurer_base_donnee
  %x{mv .bde_backup.txt .bde.txt }
end

def creer_base_donnee( base_donnee_test, nom_fichier )
  sauvergarder_base_donnee
  File.open( nom_fichier, "w" ) do |fich|
    base_donnee_test.each do |ligne|
      fich.puts ligne
    end
  end
end

def effacer_base_donnee( nom_fichier )
  FileUtils.rm_f nom_fichier
  restaurer_base_donnee
end
