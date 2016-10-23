require 'test_helper'
require 'bde'


# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
"BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
"PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16" ]
nom_fichier = ".bde.txt"


describe Bde do
  describe "ajouter" do
    before{ creer_base_donnee( base_donnee_test, nom_fichier ) }
    
    it "ajouter un cours sans sigle" do
      bde_cli( 'ajout' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "ajouter un cours avec mauvais sigle" do
      bde_cli( 'ajout -n DF54' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "ajouter un cours qui existe deja" do
      bde_cli( 'ajout -n MAT008' ).
        must_equal( ["error: MAT008 existe deja."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "ajouter un cours" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
        "BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
        "PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16",
        "INF075/"]        
      bde_cli( 'ajout -n INF075' )
      File.open( nom_fichier, "r" ).read.
        must_equal( nouvelle_base_donnee.join("\n").chomp )
      effacer_base_donnee( nom_fichier )
    end
    
    it "ajouter un etudiant qui existe deja" do
      bde_cli( '--class=MAT008 ajout -n Loiseau -p Martin' ).
        must_equal( ["error: Loiseau Martin existe deja."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "ajouter un etudiant sur un cours qui n'existe pas" do
      bde_cli( '--class=INF005 ajout -n Loiseau -p Martin' ).
        must_equal( ["cours: INF005 n'existe pas."] )
      effacer_base_donnee( nom_fichier )
    end
    
    it "ajouter un etudiant" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17|Loup,Garou",
        "BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
        "PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16"]
      bde_cli( '--class=MAT008 ajout -n Loup -p Garou' )
      File.open( nom_fichier, "r" ).read.
        must_equal( nouvelle_base_donnee.join( "\n" ) )
      effacer_base_donnee( nom_fichier )
    end

  end
end