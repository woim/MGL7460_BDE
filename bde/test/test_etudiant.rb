require 'test_helper'
require 'bde'

describe Etudiant do
  describe ".new" do  
    let(:nom1) { "Thibodeau" }
    let(:prenom1) { "Jean" }
    let(:prenom2) { "Gustave" }
        
    it "cree un etudiant en donnant nom" do
      lambda{ Etudiant.new( nom1 ) }.must_raise( RuntimeError )
    end
  
    it "cree un etudiant en donnant nom et prenom" do
      etudiant = Etudiant.new( nom1, prenom1 )
      etudiant.nom.must_equal(nom1)
      etudiant.prenoms.must_equal([prenom1])
    end
    
    it "cree un etudiant en donnant nom et 2 prenoms" do
      etudiant = Etudiant.new( nom1, prenom1, prenom2 )
      etudiant.nom.must_equal(nom1)
      etudiant.prenoms.must_equal( [prenom1, prenom2] )
    end
  end
  
  describe "#ajouter_note" do
    let(:note) { 15 }
    let(:notes1) { [15, 16, 17] }
    let(:notes2) { [15, 'a', 17] }
    let(:notes3) { [15, -5, 17] }
    before { @etudiant = Etudiant.new("Robert","Lapin") } 
        
    it "ajoute une note" do
      @etudiant.ajouter_note(note)
      @etudiant.notes.must_equal( [15] )
    end
    
    it "ajoute des notes" do
      @etudiant.ajouter_note(note)
      @etudiant.ajouter_note(notes1)
      @etudiant.notes.must_equal( [15, 15, 16, 17] )
    end    
    
    it "saisit avec lettre" do
      lambda{ @etudiant.ajouter_note(notes2) }.must_raise( RuntimeError )
    end
    
    it "saisit nombre negatif" do
      lambda{ @etudiant.ajouter_note(notes3) }.must_raise( RuntimeError )
    end
  end
  
  describe "#afficher_notes" do
    let(:notes) { [15, 16, 17] }
    before { @etudiant = Etudiant.new("Robert","Lapin") }    
    
    it "affiche rien si aucune note saisie" do
      @etudiant.afficher_notes.must_be_empty
    end
    
    it "afficher les notes" do
      @etudiant.ajouter_note(notes)
      @etudiant.afficher_notes.must_equal "15 16 17"
    end   
  end  
end
