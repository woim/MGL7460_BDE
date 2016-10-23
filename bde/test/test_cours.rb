require 'test_helper'
require 'bde'



describe Cours do

  describe ".new" do
    let(:nom1) { "CH" }
    let(:nom2) { "CHI001" }    
    
    it "Test il faut initializer la class avec un nom" do
      lambda{ Cours.new }.must_raise( ArgumentError )
    end
    
    it "le sigle du cours doit etre SSSDDD" do
      lambda{ Cours.new( nom1 ) }.must_raise( RuntimeError )
    end
    
    it "le sigle du cours est correct" do
      cours = Cours.new( nom2 )
      cours.sigle.must_equal( "CHI001" )
    end
  end
    
  describe "#ajouter_etudiant" do
    before do 
      @etudiant1 = Etudiant.new( "Thibodeau", "Jean" )
      @cours = Cours.new( "CHI001" )
    end
    
    it "test on ajoute bien un etudiant" do 
      lambda{ @cours.ajouter_etudiant( "blabla" ) }.must_raise( RuntimeError )
    end
    
    it "test si etudiant existe deja" do
      @cours.ajouter_etudiant( @etudiant1 )
      lambda{ @cours.ajouter_etudiant( @etudiant1 ) }.must_raise( RuntimeError )
    end

    it "test on ajoute un etudiant" do 
      @cours.ajouter_etudiant( @etudiant1 )
      @cours.etudiants.must_equal( [@etudiant1] )
    end
  end
  
  describe "#retirer_etudiant" do
    before do 
      @etudiant1 = Etudiant.new( "Thibodeau", "Jean" )
      @cours = Cours.new( "CHI001" )
    end
    
    it "test on retire bien un etudiant" do 
      lambda{ @cours.retirer_etudiant( "blabla" ) }.must_raise( RuntimeError )
    end
    
    it "test si etudiant n'existe pas" do
      lambda{ @cours.retirer_etudiant( @etudiant1 ) }.must_raise( RuntimeError )
    end

    it "test on retire un etudiant" do 
      @cours.ajouter_etudiant( @etudiant1 )
      @cours.retirer_etudiant( @etudiant1 )
      @cours.etudiants.must_be_empty
    end
  end
  
  describe "#lister_etudiants" do
    before do 
      @etudiant1 = Etudiant.new( "Thibodeau", "Jean" )
      @etudiant2 = Etudiant.new( "Martin", "Lucie" ) 
      @cours = Cours.new( "CHI001" ) 
    end
      
    it "retourne une liste vide si aucun etudiant" do
      @cours.lister_etudiants.must_equal( "" )      
    end
    
    it "retourne la liste des etudiants ajoutes au cours" do
      @cours.ajouter_etudiant( @etudiant1 )
      @cours.ajouter_etudiant( @etudiant2 )
      @cours.lister_etudiants.must_equal( "Thibodeau Jean\nMartin Lucie\n" )      
    end
    
    it "retourne la liste des etudiants arrangee alphabetiquement" do
      @cours.ajouter_etudiant( @etudiant1 )
      @cours.ajouter_etudiant( @etudiant2 )
      @cours.lister_etudiants( true ).must_equal( "Martin Lucie\nThibodeau Jean\n" )      
    end
  end
  
  describe "#==" do
    before do 
      @cour1 = Cours.new( "CHI001" )
      @cour2 = Cours.new( "CHI001" )
      @cour3 = Cours.new( "CHI002" ) 
    end
    
    it "test egalite dans le cas 2 etudiants egaux" do
      ( @cour1 == @cour2 ) == true 
    end
    
    it "test egalite dans le cas 2 etudiants differents" do
      ( @cour1 == @cour3 ) == false 
    end
  end
  
  describe "#lister_evaluations" do 
    before do 
      @etudiant1 = Etudiant.new( "Thibodeau", "Jean" )
      @etudiant1.ajouter_note( [12.0, 14.0, 15.0] )
      @etudiant2 = Etudiant.new( "Martin", "Lucie" ) 
      @cours = Cours.new( "CHI001" )
      @cours.ajouter_etudiant( @etudiant1 )
      @cours.ajouter_etudiant( @etudiant2 )
    end
    it "liste evaluation etudiant" do
      @cours.lister_evaluations.split("\n").
        must_equal( ["Thibodeau Jean: 12.0 14.0 15.0","Martin Lucie: "] )
    end
  end
  
  describe "#saisir_eval" do 
    let(:notes) { [15.0, 16.0] }
    before do 
      @etudiant1 = Etudiant.new( "Thibodeau", "Jean" )
      @etudiant2 = Etudiant.new( "Martin", "Lucie" ) 
      @cours = Cours.new( "CHI001" )
      @cours.ajouter_etudiant( @etudiant1 )
    end
    
    it "test si etudiant n'existe pas" do      
      lambda{ @cours.saisir_eval( @etudiant2, notes ) }.must_raise( RuntimeError )
    end
    
    it "test on ajoute des notes a l'etudiant" do
      @cours.saisir_eval( @etudiant1, notes )
      @cours.etudiants[0].notes.must_equal( notes )
    end    
  end
  
  describe "#lister_moyenne" do 
     before do 
      @etudiant1 = Etudiant.new( "Thibodeau", "Jean" )
      @etudiant1.ajouter_note( [13.0, 14.0, 15.0] )
      @etudiant2 = Etudiant.new( "Martin", "Lucie" ) 
      @cours = Cours.new( "CHI001" )
      @cours.ajouter_etudiant( @etudiant1 )
      @cours.ajouter_etudiant( @etudiant2 )
    end
    it "liste moyenne etudiant" do
      @cours.lister_moyenne.split("\n").
        must_equal( ["Thibodeau Jean: 14.0","Martin Lucie: "] )
    end
  end
  
end

