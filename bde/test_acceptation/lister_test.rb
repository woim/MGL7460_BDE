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

  describe "lister" do

    it "liste les classes" do
      bde_cli( 'lister_cours' ).must_equal ['MAT008', 'BIO012', 'PHY018']
    end

    it "liste les classes dans l'ordre alphabetique" do
      bde_cli( 'lister_cours -a' ).must_equal ['BIO012', 'MAT008', 'PHY018']
    end

    it "Envoie un message si le cours n'existe pas" do
      bde_cli( '--class=INF005 lister_etudiants' ).
        must_equal ["error: Cours INF005 n'existe pas."]
    end

    it "liste les etudiants de la classe MAT008" do
      bde_cli( '--class=MAT008 lister_etudiants' ).
        must_equal ['Loiseau Martin', 'Thibodeau Jean Charles-Henri']
    end

    it "liste les etudiants de la classe BIO012 dans l'ordre alphabetique" do
      bde_cli( '--class=BIO012 lister_etudiants -a' ).
        must_equal ['Loiseau Martin', 'Thibodeau Jean Charles-Henri']
    end

  end

  after{ effacer_base_donnee( nom_fichier ) }
end
