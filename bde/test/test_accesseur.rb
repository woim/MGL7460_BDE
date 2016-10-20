require 'test_helper'
require 'bde'

base_donnee_test = ["MATH002"]
nom_fichier1 = "test_bde.txt"
nom_fichier2 = "test_bde2.txt"

# Probleme n'efface pas les fichiers

describe Accesseur do
  describe ".new" do
    it "souleve une erreur si aucun argument n'est donne" do
      lambda{ Accesseur.new }.must_raise( ArgumentError )
    end
    
    #~ it "souleve une erreur si l'argument n'est pas de type Format" do
      #~ lambda{ Accesseur.new( "blah" ) }.must_raise( RunTimeError )
    #~ end
  end

  describe "#charger_base_donnee" do
    #~ let(:liste_cours ) { [Cours.new( "MATH002" ), \
                          #~ Cours.new( "MATH002" ), \
                          #~ Cours.new( "MATH002" )] }
    let(:liste_cours ) { [Cours.new( "MATH002" )] }
    before{ 
      creer_base_donnee( base_donnee_test, nom_fichier1 )
      mock_format = MiniTest::Mock.new
      #~ mock_format.expect( :instance_of?, Format.new )
      # il semble que le mock ne fonctionne qu' une seule fois a discuter avec Mr Tremblay
      mock_format.expect( :extraire_information, Cours.new( "MATH002" ), ["MATH002\n"] )
      @accesseur = Accesseur.new( mock_format ) }
    
    it "souleve une erreur si le fichier n'existe pas" do
      lambda{ @accesseur.charger_base_donnee( "blabla" ) }.
        must_raise( RuntimeError )
    end
    
    it "charge une base de donnee" do
      @accesseur.charger_base_donnee( nom_fichier1 )
      @accesseur.collection_cours.must_equal( liste_cours )
      mock_format.verify
    end
  end
    
  describe "#sauvegarder_base_donnee" do
    #~ let(:liste_cours ) { [Cours.new( "MATH002"), \
                          #~ Cours.new( "MATH002"), \
                          #~ Cours.new( "MATH002" )] }
    let(:liste_cours ) { [Cours.new( "MATH002" )] }
    before{ 
      creer_base_donnee( base_donnee_test, nom_fichier1 )
      mock_format = MiniTest::Mock.new
      mock_format.expect( :ecrire_information, "MATH002", [liste_cours[0]] )
      @accesseur = Accesseur.new( mock_format )
      @accesseur.collection_cours = liste_cours }
    it "sauvegarde une base de donnee" do
      @accesseur.sauvegarder_base_donnee( nom_fichier2 )
      File.open( nom_fichier2, "r").read.must_equal( "MATH002\n" )
      #~ mock_format.verify 
    end
  end
end

effacer_base_donnee( nom_fichier1 )
effacer_base_donnee( nom_fichier2 )
