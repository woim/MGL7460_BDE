require 'test_helper'
require 'bde'



describe Format do
  before {     
    etudiant1 = Etudiant.new( "Loiseau", "Martin" )
    etudiant1.ajouter_note( [12,13,14] )
    etudiant2 = Etudiant.new( "Thibodeau", "Jean", "Charles-Henri" )
    etudiant2.ajouter_note( [18,18,17] )
        
    @cours = Cours.new( "MAT002" )
    @cours.ajouter_etudiant( etudiant1 )
    @cours.ajouter_etudiant( etudiant2 )
    @champ = "MAT002/Loiseau,Martin=12.0,13.0,14.0|Thibodeau,Jean,Charles-Henri=18.0,18.0,17.0" 
    
    @format = Format.new
  }
    
  describe "#extraire_cours_information" do  
    it "extrait l'information d'une ligne" do
      cours_extrait = @format.extraire_information( @champ )
      @cours.must_equal( cours_extrait )
    end
  end
  
  describe "#ecrire_cours_information" do
    it "ecrit l' information d'un cours dans un champ(string)" do
      champ_ecrit = @format.ecrire_information( @cours )
      @champ.must_equal( champ_ecrit )
    end
  end  
end
