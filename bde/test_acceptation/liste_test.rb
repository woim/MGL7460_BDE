require 'test_helper'
require 'bde'

# Cree une base de donnee locale pour test d'acceptation
creer_base_donnee

describe Bde do
  describe "liste" do
  
    it "liste les classes" do
      bde_cli('liste').must_equal ['MATH00','PHYS78','HIS12']
    end
    
    it "liste les classes dans l'ordre alphabetique" do
      bde_cli('liste -alphabetique').must_equal ['HIS12','MATH00','PHYS78']
    end
    
    it "liste les etudiants de la classe MATH00" do
      bde_cli('--class=MATH00 liste').
        must_equal ['Jean Thibodeau', 'Martin Loiseau']
    end
    
    it "liste les etudiants de la classe MATH00 dans l'ordre alphabetique" do
      bde_cli('--class=MATH00 liste -alphabetique').
        must_equal ['Martin Loiseau', 'Jean Thibodeau']
    end
    
  end
end

# Efface la base de donnee
effacer_base_donnee
