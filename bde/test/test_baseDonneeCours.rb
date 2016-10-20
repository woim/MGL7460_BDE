require 'test_helper'
require 'bde'

nom_fichier = "bde_test.txt"

describe BdCours do
  describe ".new" do
    it "souleve une erreur si aucun argument n'est donne" do
      lambda{ BdCours.new }.must_raise( ArgumentError )
    end
    
    #~ it "souleve une erreur si l'argument n'est pas de type Accesseur" do
      #~ lambda{ BdCours.new( "blah" ) }.must_raise( RunTimeError )
    #~ end
  end 

  describe "#charger_base_donnee" do
    let(:liste_cours ) { [Cours.new( "MATH002"), \
                          Cours.new( "CHIM005"), \
                          Cours.new( "PHI012" )] }
    before{ 
      mock_accesseur = MiniTest::Mock.new
      mock_accesseur.expect( :charger_base_donnee, \
                              liste_cours, \
                              [nom_fichier] )
      @bde = BdCours.new( mock_accesseur ) }
    
    it "souleve une erreur si le fichier n'existe pas" do
      lambda{ @bde.charger_base_donnee( "blabla" ) }.
        must_raise( RuntimeError )
    end
   
    it "charge une base de donnee" do
      @bde.charger_base_donnee( nom_fichier )
      @bde.cours.must_equal( liste_cours )
      # ~mock_accesseur.verify
    end  
  end
  
  describe "#lister_cours" do 
    let(:liste_cours ) { [Cours.new( "MATH002"), \
                          Cours.new( "CHIM005"), \
                          Cours.new( "PHI012" )] }
    before{ 
      mock_accesseur = MiniTest::Mock.new
      mock_accesseur.expect( :charger_base_donnee, \
                              liste_cours, \
                              [nom_fichier] )
      @bde = BdCours.new( mock_accesseur ) }
    
    it "retourne une chaine de caractere vide si la base de donnee
        n'a pas ete charge" do
      @bde.lister_cours.must_be_empty
    end
    
    it "retourne la liste des sigles" do
      @bde.charger_base_donnee( nom_fichier )
      @bde.lister_cours.must_equal "MATH002\nCHIM005\nPHI012\n"
      #~ mock_accesseur.verify
    end
  end
  
  describe "#selectionner_cours" do
    let(:cours_selectionne) { Cours.new( "PHI012" ) }
    let(:liste_cours ) { [Cours.new( "MATH002"), \
                          Cours.new( "CHIM005"), \
                          Cours.new( "PHI012" )] }
    before{ 
      mock_accesseur = MiniTest::Mock.new
      mock_accesseur.expect( :charger_base_donnee, \
                              liste_cours, \
                              [nom_fichier] )
      @bde = BdCours.new( mock_accesseur ) }
    
    it "souleve une erreur si le sigle n'est pas au bon format" do
      lambda{ @bde.selectionner_cours( "lapin" ) }.must_raise( RuntimeError )
    end
    
    it "retourne nil si le cours n'existe pas" do
      @bde.charger_base_donnee( nom_fichier )
      @bde.selectionner_cours( "BLA005" ).must_equal( nil )
      #~ mock_accesseur.verify
    end
    
    it "retourne le cours specifie par le sigle" do
      @bde.charger_base_donnee( nom_fichier )
      @bde.selectionner_cours( "PHI012" ).sigle.must_equal( "PHI012" )
      # Ce test ne me plait pas il faudrait implementer la methode ==
      # pour voir faire une comparaison
      #~ mock_accesseur.verify
    end
  end    
end