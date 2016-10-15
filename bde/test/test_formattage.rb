require 'test_helper'
require 'bde'

format = FormatBd.new()

describe FormatBd do
  before { 
    @cours = Cours.new()
    champ = "MATH20/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17" 
    }
    
  describe "#extraire_cours_information" do  
    it "extrait l'information d'une ligne" do
      cours_extrait = format.extraire_cours_information( champ )
      @cours.must_equal(cours_extrait)
    end
  end
  
  describe "#ecrire_cours_information" do
    it "ecrit l' information d'un cours dans un champ(string)" do
      champ_ecrit = format.ecrire_cours_information( @cours )
      @champ.must_equal(champ_ecrit)
    end
  end
  
end
