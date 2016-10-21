require 'test_helper'
require 'bde'

base_donnee_test = ["MAT002", "CHI005", "PHY004"]
nom_fichier1 = "test_bde.txt"
nom_fichier2 = "test_bde2.txt"

# Probleme n'efface pas les fichiers

describe Accesseur do
  describe ".new" do
    it "souleve une erreur si aucun argument n'est donne" do
      lambda{ Accesseur.new }.must_raise( ArgumentError )
    end
   end

  describe "#charger_base_donnee" do
    let(:liste_cours ) { [Cours.new( "MAT002" ), \
                          Cours.new( "CHI005" ), \
                          Cours.new( "PHY004" )] }
    before do 
      creer_base_donnee( base_donnee_test, nom_fichier1 )
      @mock_format = MiniTest::Mock.new
      liste_cours.each do |cours|
        @mock_format.expect( :extraire_information, cours, [cours.sigle+"\n"] )
      end
      @accesseur = Accesseur.new( @mock_format )
    end
    
    it "charge une base de donnee" do
      @accesseur.charger_base_donnee( nom_fichier1 )
      @accesseur.collection_cours.must_equal( liste_cours )
      @mock_format.verify
    end
  end
    
  describe "#sauvegarder_base_donnee" do
    let(:liste_cours ) { [Cours.new( "MAT002"), \
                          Cours.new( "MAT002"), \
                          Cours.new( "MAT002" )] }
    before do 
      creer_base_donnee( base_donnee_test, nom_fichier1 )
      @mock_format = MiniTest::Mock.new
      liste_cours.each do |cours|
        @mock_format.expect( :ecrire_information, cours.sigle, [cours] )
      end
      @accesseur = Accesseur.new( @mock_format )
      @accesseur.collection_cours = liste_cours
    end
     
    it "sauvegarde une base de donnee" do
      @accesseur.sauvegarder_base_donnee( nom_fichier2 )
      File.open( nom_fichier2, "r" ).read.must_equal( "MAT002\nMAT002\nMAT002\n" )
      @mock_format.verify 
    end
  end
end

effacer_base_donnee( nom_fichier1 )
effacer_base_donnee( nom_fichier2 )


