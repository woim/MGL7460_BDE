require 'test_helper'
require 'bde'


# Cree une base de donnee locale pour test d'acceptation
base_donnee_test = [
"MAT008/Loiseau,Martin=12.0,13.0,14.0|Thibodeau,Jean,Charles-Henri=18.0,18.0,18.0",
"BIO012/Thibodeau,Jean,Charles-Henri=17.0,13.0,15.0|Loiseau,Martin=17.0,19.0,15.0",
"PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0" ]
nom_fichier = ".bde.txt"


describe Bde do
  before{ creer_base_donnee( base_donnee_test, nom_fichier ) }

  describe "ajouter" do

    it "ajouter un cours sans sigle" do
      bde_cli( 'ajouter_cours' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
    end

    it "ajouter un cours avec mauvais sigle" do
      bde_cli( 'ajouter_cours -n DF54' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
    end

    it "ajouter un cours qui existe deja" do
      bde_cli( 'ajouter_cours -n MAT008' ).
        must_equal( ["error: MAT008 existe deja."] )
    end

    it "ajouter un cours" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12.0,13.0,14.0|Thibodeau,Jean,Charles-Henri=18.0,18.0,18.0",
        "BIO012/Thibodeau,Jean,Charles-Henri=17.0,13.0,15.0|Loiseau,Martin=17.0,19.0,15.0",
        "PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0",
        "INF075/"]
      bde_cli( 'ajouter_cours -n INF075' )
      File.open( nom_fichier, "r" ).read.split("\n").
        must_equal( nouvelle_base_donnee )
    end

    it "ajouter un etudiant qui existe deja" do
      bde_cli( '--class=MAT008 ajouter_etudiant -n Loiseau -p Martin' ).
        must_equal( ["error: Loiseau Martin existe deja."] )
    end

    it "ajouter un etudiant sur un cours qui n'existe pas" do
      bde_cli( '--class=INF005 ajouter_etudiant -n Loiseau -p Martin' ).
        must_equal( ["error: Cours INF005 n'existe pas."] )
    end

    it "ajouter un etudiant" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12.0,13.0,14.0|Thibodeau,Jean,Charles-Henri=18.0,18.0,18.0|Loup,Garou",
        "BIO012/Thibodeau,Jean,Charles-Henri=17.0,13.0,15.0|Loiseau,Martin=17.0,19.0,15.0",
        "PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0" ]
      bde_cli( '--class=MAT008 ajouter_etudiant -n Loup -p Garou' )
      File.open( nom_fichier, "r" ).read.split("\n").
        must_equal( nouvelle_base_donnee )
    end

  end

  after{ effacer_base_donnee( nom_fichier ) }
end
