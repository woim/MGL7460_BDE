require 'test_helper'
require 'bde'


# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MAT008/Loiseau,Martin=12.0,13.0,14.0|Thibodeau,Jean,Charles-Henri=18.0,18.0,17.0",
"BIO012/Thibodeau,Jean,Charles-Henri=17.0,13.0,15.0|Loiseau,Martin=17.0,19.0,15.0",
"PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0" ]
nom_fichier = ".bde.txt"


describe Bde do
  describe "saisir_eval" do
  
    it "saisir evaluation sans classe" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      bde_cli( 'saisir_eval' ).
        must_equal( ["une classe doit etre selectionnee."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "saisir evaluation si le cours n'existe pas" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      bde_cli( '--class=INF005 saisir_eval' ).
        must_equal ["cours: INF005 n'existe pas."]
      effacer_base_donnee( nom_fichier )  
    end
        
    it "saisir evaluation si un etudiant qui n'existe pas" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      bde_cli( '--class=MAT008 saisir_eval -n Loup -p Garou' ).
        must_equal( ["error: Loup Garou n'existe pas."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "saisir evaluation sur un cours qui n'existe pas" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      bde_cli( '--class=INF005 saisir_eval -n Loiseau -p Martin' ).
        must_equal( ["cours: INF005 n'existe pas."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "saisir une evaluation" do
      creer_base_donnee( base_donnee_test, nom_fichier )
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12.0,13.0,14.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,18.0,17.0",
        "BIO012/Thibodeau,Jean,Charles-Henri=17.0,13.0,15.0|Loiseau,Martin=17.0,19.0,15.0",
        "PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0"]        
      bde_cli( '--class=MAT008 saisir_eval -n Loiseau -p Martin -e 15.0' )
      File.open( nom_fichier, "r" ).read.split("\n").
        must_equal( nouvelle_base_donnee )
      effacer_base_donnee( nom_fichier )
    end
  
  end
end
