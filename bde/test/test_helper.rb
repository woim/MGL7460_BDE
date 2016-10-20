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

def creer_base_donnee( base_donnee_test, nom_fichier )
  File.open( nom_fichier, "w" ) do |fich|
    base_donnee_test.each do |ligne|
      fich.puts ligne
    end
  end
end

def effacer_base_donnee( nom_fichier )
  #FileUtils.rm_f nom_fichier
  %x{rm #{nom_fichier} }
end
