require 'test_helper'
require 'bde'

# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
"BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
"PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16" ]
nom_fichier = ".bde.txt"
creer_base_donnee( base_donnee_test, nom_fichier )

describe Bde do
  describe "ajout" do
    
    it "ajoute un cours sans sigle" do
      bde_cli( 'ajout ' ).must_equal( ["Aucun sigle de cours saisit."] )
    end
    
    it "ajoute un cours avec mauvais sigle" do
      bde_cli( 'ajout DF54' ).must_equal( ["Aucun sigle de cours saisit."] )
    end
    
    it "ajoute un cours" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
        "BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
        "PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16",
        "INF075/" ]
      bde_cli( 'ajout INF075' )
      File.open( nom_fichier, "r" ).read.
        must_equal( nouvelle_base_donnee.join( "\n" ) 
    end
    
    it "ajoute un etudiant" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17|Loup,Garou,Etienne",
        "BIO012/Thibodeau,Jean,Charles-Henri=17,13,15|Loiseau,Martin=17,19,15",
        "PHY018/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16",
        "INF075/" ]
      bde_cli( '--class=MAT008 ajout Loup Garou Etienne' )
      File.open( nom_fichier, "r" ).read.
        must_equal( nouvelle_base_donnee.join( "\n" )
    end

  end
end
