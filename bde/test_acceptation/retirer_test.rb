require 'test_helper'
require 'bde'


# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
"BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
"PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16" ]
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
      bde_cli( 'retier -n DF54' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "retirer un cours qui n'existe pas" do
      bde_cli( 'retirer -n MAT008' ).
        must_equal( ["error: MAT008 n'existe pas."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "retirer un cours" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
        "PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16"]        
      bde_cli( 'ajout -n BIO012' )
      File.open( nom_fichier, "r" ).read.
        must_equal( nouvelle_base_donnee.join("\n").chomp )
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
        "MAT008/Thibodeau,Jean,Charles-Henri=18,18,17",
        "BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
        "PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16"]
      bde_cli( '--class=MAT008 retirer -n Loiseau -p Martin' )
      File.open( nom_fichier, "r" ).read.
        must_equal( nouvelle_base_donnee.join( "\n" ) )
      effacer_base_donnee( nom_fichier )
    end

  end
end
