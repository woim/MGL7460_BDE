require 'test_helper'
require 'bde'


# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
"BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
"PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16" ]
nom_fichier = ".bde.txt"


describe Bde do
  describe "liste" do
    
    it "liste les classes" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      bde_cli( 'liste' ).must_equal ['MAT008', 'BIO012', 'PHY018']
      effacer_base_donnee( nom_fichier )
    end
    
    it "liste les classes dans l'ordre alphabetique" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      bde_cli( 'liste -a' ).must_equal ['BIO012', 'MAT008', 'PHY018']
      effacer_base_donnee( nom_fichier )
    end

    it "Envoie un message si le cours n'existe pas" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      bde_cli( '--class=INF005 liste' ).
        must_equal ["cours: INF005 n'existe pas."]
      effacer_base_donnee( nom_fichier )  
    end
    
    it "liste les etudiants de la classe MAT008" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      bde_cli( '--class=MAT008 liste' ).
        must_equal ['Loiseau Martin', 'Thibodeau Jean Charles-Henri']
      effacer_base_donnee( nom_fichier )
    end
    
    it "liste les etudiants de la classe BIO012 dans l'ordre alphabetique" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      bde_cli( '--class=BIO012 liste -a' ).
        must_equal ['Loiseau Martin', 'Thibodeau Jean Charles-Henri']
      effacer_base_donnee( nom_fichier )
    end
    
  end
end
