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

  describe "retirer" do

    it "retirer un cours sans sigle" do
      bde_cli( 'retirer_cours' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
    end

    it "retirer un cours avec mauvais sigle" do
      bde_cli( 'retirer_cours -n DF54' ).
        must_equal( ["error: Le nom du cours doit etre de format SSSDDD"] )
    end

    it "retirer un cours qui n'existe pas" do
      bde_cli( 'retirer_cours -n INF005' ).
        must_equal( ["error: INF005 n'existe pas."] )
    end

    it "retirer un cours" do
      nouvelle_base_donnee = [
        "MAT008/Loiseau,Martin=12.0,13.0,14.0|Thibodeau,Jean,Charles-Henri=18.0,18.0,18.0",
        "PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0"]
      bde_cli( 'retirer_cours -n BIO012' )
      File.open( nom_fichier, "r" ).read.split("\n").
        must_equal( nouvelle_base_donnee )
    end

    it "retirer un etudiant qui n'existe pas" do
      bde_cli( 'retirer_etudiant --class=MAT008 -n Loup -p Garou' ).
        must_equal( ["error: Loup Garou n'existe pas."] )
    end

    it "retirer un etudiant sur un cours qui n'existe pas" do
      bde_cli( 'retirer_etudiant --class=INF005 -n Loiseau -p Martin' ).
        must_equal( ["error: Cours INF005 n'existe pas."] )
    end

    it "retirer un etudiant" do
      nouvelle_base_donnee = [
        "MAT008/Thibodeau,Jean,Charles-Henri=18.0,18.0,18.0",
        "BIO012/Thibodeau,Jean,Charles-Henri=17.0,13.0,15.0|Loiseau,Martin=17.0,19.0,15.0",
        "PHY018/Loiseau,Martin=17.0,19.0,15.0|Thibodeau,Jean,Charles-Henri=18.0,19.0,16.0" ]
      bde_cli( 'retirer_etudiant --class=MAT008 -n Loiseau -p Martin' )
      File.open( nom_fichier, "r" ).read.split("\n").
        must_equal( nouvelle_base_donnee )
    end

  end

  after{ effacer_base_donnee( nom_fichier ) }
end
