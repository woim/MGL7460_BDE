require 'test_helper'
require 'bde'


# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MAT008/Loiseau,Martin=12.0,13.0,14.0|Thibodeau,Jean,Charles-Henri=18.0,18.0,17.0",
"BIO012/Thibodeau,Jean,Charles-Henri=17.0,13.0,15.0|Loiseau,Martin=17.0,19.0,15.0",
"PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0" ]
nom_fichier = ".bde.txt"


describe Bde do
  describe "retirer" do
    before{ creer_base_donnee( base_donnee_test, nom_fichier ) }
    
    it "retirer un cours sans sigle" do
      bde_cli( 'retirer' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "retirer un cours avec mauvais sigle" do
      bde_cli( 'retirer -n DF54' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "retirer un cours qui n'existe pas" do
      bde_cli( 'retirer -n INF005' ).
        must_equal( ["error: INF005 n'existe pas."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "retirer un cours" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12.0,13.0,14.0|Thibodeau,Jean,Charles-Henri=18.0,18.0,17.0",
        "PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0"]        
      bde_cli( 'retirer -n BIO012' )
      File.open( nom_fichier, "r" ).read.split("\n").
        must_equal( nouvelle_base_donnee )
      effacer_base_donnee( nom_fichier )
    end
    
    it "retirer un etudiant qui n'existe pas" do
      bde_cli( '--class=MAT008 retirer -n Loiseau -p Martin' ).
        must_equal( ["error: Loiseau Martin n'existe pas."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "retirer un etudiant sur un cours qui n'existe pas" do
      bde_cli( '--class=INF005 retirer -n Loiseau -p Martin' ).
        must_equal( ["cours: INF005 n'existe pas."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "retirer un etudiant" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12.0,13.0,14.0",
        "BIO012/Thibodeau,Jean,Charles-Henri=17.0,13.0,15.0|Loiseau,Martin=17.0,19.0,15.0",
        "PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0"]
      bde_cli( '--class=MAT008 retirer -n Loiseau -p Martin' )
      File.open( nom_fichier, "r" ).read.
        must_equal( nouvelle_base_donnee.join( "\n" ) )
      effacer_base_donnee( nom_fichier )
    end

  end
end
