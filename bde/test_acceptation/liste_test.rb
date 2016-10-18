require 'test_helper'
require 'bde'

# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MATH002/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
"CHIM005/Loiseau,Martin=14,10,15|Thibodeau,Jean,Charles-Henri=17,13,15",
"PHI012/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16" ]
nom_fichier = ".bde.txt"
creer_base_donnee( base_donnee_test, nom_fichier )

describe Bde do
  describe "liste" do
  
    it "liste les classes" do
      bde_cli( 'liste' ).must_equal ['MATH002','CHIM005','PHI012']
    end
    
    it "liste les classes dans l'ordre alphabetique" do
      bde_cli( 'liste -alphabetique' ).must_equal ['CHIM005','MATH002','PHI012']
    end
    
    it "liste les etudiants de la classe MATH20" do
      bde_cli( '--class=MATH002 liste' ).
        must_equal ['Jean Charles-Henri Thibodeau', 'Martin Loiseau']
    end
    
    it "liste les etudiants de la classe MATH00 dans l'ordre alphabetique" do
      bde_cli( '--class=MATH002 liste -alphabetique' ).
        must_equal ['Martin Loiseau', 'Jean Charles-Henri Thibodeau']
    end
    
  end
end

# Efface la base de donnee
effacer_base_donnee( nom_fichier )
