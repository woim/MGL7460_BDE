require 'test_helper'
require 'bde'

describe Cours do
  describe ".new" do
    let(:nom1) { 'CH' }
    let(:nom2) { 'CHI001' }    
    
    it "Test il faut initializer la class avec un nom" do
      lambda{ Cours.new }.must_raise( ArgumentError )
    end
    
    it "le sigle du cours doit etre SSSDDD" do
      lambda{ Cours.new( nom1 ) }.must_raise( RuntimeError )
    end
    
    it "le sigle du cours doit etre SSSDDD" do
      cours = Cours.new(nom2)
      cours.sigle.must_equal( "CHI001" )
    end
  end
    
  describe "#ajouter_etudiant" do
  before { 
    @etudiant1 = Etudiant.new( "Thibodeau", "Jean" )
    @cours = Cours.new( "CHI001" ) }
    
    it "test on ajoute bien un etudiant" do 
      lambda{ @cours.ajouter_etudiant( "blabla" ) }.must_raise( RuntimeError )
    end

    it "test on ajoute un etudiant" do 
      @cours.ajouter_etudiant( @etudiant1 )
      @cours.etudiants.must_equal( [@etudiant1] )
    end
  end
  
  #~ describe "#retirer_etudiant" do
    #~ before { 
      #~ @etudiant1 = Etudiant.new( "Thibodeau", "Jean" )
      #~ @cours = Cours.new("CHI001") }
    #~ it "test on retire bien un etudiant" do 
      #~ lambda{ @cours.retirer_etudiant( "blabla" ) }.must_raise( RuntimeError )
    #~ end

    #~ it "test on retire un etudiant" do 
      #~ @cours.ajouter_etudiant( @etudiant1 )
      #~ @cours.retirer_etudiant( @etudiant1 )
      #~ @cours.etudiants.mut_be_empty
    #~ end
    
    #~ it "test on retire un etudiant" do 
      #~ @cours.retirer_etudiant( @etudiant1 )
      #~ @cours.etudiants.mut_be_empty
    #~ end
  #~ end
  
  describe "#lister_etudiants" do
    before { 
      @etudiant1 = Etudiant.new( "Thibodeau", "Jean" )
      @etudiant2 = Etudiant.new( "Martin", "Lucie" ) 
      @cours = Cours.new( "CHI001" ) }
      
    it "retourne une liste vide si aucun etudiant" do
      @cours.lister_etudiants.must_equal( "" )      
    end
    
    it "retourne la liste des etudiants ajoutes au cours" do
      @cours.ajouter_etudiant( @etudiant1 )
      @cours.ajouter_etudiant( @etudiant2 )
      @cours.lister_etudiants.must_equal( "Thibodeau Jean\nMartin Lucie\n" )      
    end
  end
end

