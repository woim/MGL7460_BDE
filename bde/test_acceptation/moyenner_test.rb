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

  describe "moyenne" do

    it "obtenir moyenne sans classe" do
      bde_cli( 'moyenne' ).
        must_equal( ["une classe doit etre selectionnee."] )
    end

    it "obtenir moyenne si le cours n'existe pas" do
      bde_cli( '--class=INF005 moyenne' ).
        must_equal ["cours: INF005 n'existe pas."]
    end

    it "obtenir evaluation sur un cours qui existe" do
      bde_cli( '--class=MAT008 moyenne' ).
        must_equal( [ "Loiseau Martin: 13.0",
                      "Thibodeau Jean Charles-Henri: 18.0"] )
    end

  end

  after{ effacer_base_donnee( nom_fichier ) }
end
