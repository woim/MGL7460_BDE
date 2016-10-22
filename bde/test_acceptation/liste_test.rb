require 'test_helper'
require 'bde'

# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
"BIO012/Loiseau,Martin=14,10,15|Thibodeau,Jean,Charles-Henri=17,13,15",
"PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16" ]
nom_fichier = ".bde.txt"
creer_base_donnee( base_donnee_test, nom_fichier )

describe Bde do
  describe "liste" do
  
    it "liste les classes" do
      bde_cli( 'liste' ).must_equal ['MAT008', 'BIO012', 'PHY018']
    end
    
    it "liste les classes dans l'ordre alphabetique" do
      bde_cli( 'liste -a' ).must_equal ['BIO012', 'MAT008', 'PHY018']
    end

    it "Envoie un message si le cours n'existe pas" do
      bde_cli( '--class=INF005 liste' ).
        must_equal ["Ce cours n'existe pas"]
    end
    
    it "liste les etudiants de la classe MAT008" do
      bde_cli( '--class=MAT008 liste' ).
        must_equal ['Loiseau Martin', 'Thibodeau Jean Charles-Henri']
    end
    
    it "liste les etudiants de la classe MATH00 dans l'ordre alphabetique" do
      bde_cli( '--class=MATH002 liste -a' ).
        must_equal ['Martin Loiseau', 'Jean Charles-Henri Thibodeau']
    end
    
  end
end

# Efface la base de donnee
effacer_base_donnee( nom_fichier )
