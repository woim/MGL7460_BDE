require 'test_helper'
require 'bde'

# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
"BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
"PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16" ]
nom_fichier = ".bde.txt"
#creer_base_donnee( base_donnee_test, nom_fichier )

describe Bde do
  describe "ajout" do
    before{ creer_base_donnee( base_donnee_test, nom_fichier ) }
    
    it "ajoute un cours sans sigle" do
      bde_cli( 'ajout' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
    end
    
    it "ajoute un cours avec mauvais sigle" do
      bde_cli( 'ajout -n DF54' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
    end
    
    it "ajoute un cours qui existe deja" do
      bde_cli( 'ajout -n MAT008' ).
        must_equal( ["error: MAT008 existe deja."] )
    end
    
    it "ajoute un cours" do
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
    
    it "ajoute un etudiant qui existe deja" do
      bde_cli( '--class=MAT008 ajout -n Loiseau -p Martin' ).
        must_equal( ["cours MAT008 / etudiant: Loiseau Martin existe deja.\n"] )
    end
    
    it "ajoute un etudiant" do
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
