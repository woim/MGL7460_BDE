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
  %x{bundle exec bin/bde #{cmd}}.split("\n")
end


def creer_base_donnee
end

def effacer_base_donnee
end
