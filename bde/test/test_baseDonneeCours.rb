require 'test_helper'
require 'bde'

base_donnee_test = [
"MATH002/Loiseau,Martin=12,13,14|Thibodeau,Jean,Charles-Henri=18,18,17",
"CHIM005/Loiseau,Martin=14,10,15|Thibodeau,Jean,Charles-Henri=17,13,15",
"PHI012/Loiseau,Martin=17,19,15|Thibodeau,Jean,Charles-Henri=18,19,16" ]
nom_fichier = "bde_test.txt"
creer_base_donnee( base_donnee_test, nom_fichier )

describe BdCours do
  describe "#charger_base_donnee" do
    let(:liste_cours ) { [Cours.new( "MATH002"), \
                          Cours.new( "CHIM005"), \
                          Cours.new( "PHI012" )] }
    before{ @bde = BdCours.new }
    
    it "souleve une erreur si le fichier n'existe pas" do
      lambda{ @bde.charger_base_donnee( "blabla" ) }.must_raise( RuntimeError )
    end
    
    it "souleve une erreur si le un accesseur n'a pas d'abord ete assigne" do
      lambda{ @bde.charger_base_donnee( nom_fichier ) }.must_raise( RuntimeError )
    end
    
    it "charge une base de donnee" do
      mock_accesseur = MiniTest::Mock.new
      mock_accesseur.expect( :charger_base_donnee, :liste_cours, nom_fichier )
      @bde.assigner_accesseur( mock_accesseur )
      @bde.charger_base_donnee( nom_fichier )
      @bde.cours.must_equal( liste_cours )
      mock_accesseur.verify
    end  
  end
  
  describe "#lister_cours" do 
    before{ @bde = BdCours.new }
    
    it "retourne une chaine de caractere vide si la base de donnee
        n'a pas ete charge" do
      @bde.lister_cours.must_be_empty
    end
    
    it "retourne la liste des sigles" do
      mock_accesseur = MiniTest::Mock.new
      mock_accesseur.expect(:charger_base_donnee, :liste_cours, nom_fichier )
      @bde.assigner_accesseur( mock_accesseur )
      @bde.charger_base_donnee( nom_fichier )
      @bde.lister_cours.must_equal "MATH002\nCHIM005\nPHI012\n"
      mock_accesseur.verify
    end
  end
  
  describe "#selectionner_cours" do
    let(:cours_selectionne) { Cours.new(PHI012) }
    before{ @bde = BdCours.new }
    
    it "souleve une erreur si le sigle n'est pas au bon format" do
      lambda{ @bde.slectionner_cours("lapin") }.must_raise( RuntimeError )
    end
    
    it "retourne un message d'erreur si le cours n'existe pas" do
      mock_accesseur = MiniTest::Mock.new
      mock_accesseur.expect(:charger_base_donnee, :liste_cours, nom_fichier )
      @bde.assigner_accesseur( mock_accesseur )
      @bde.charger_base_donnee( nom_fichier )
      @bde.slectionner_cours( "BLA005" ).must_equal( "Ce cours n'existe pas")
      mock_accesseur.verify
    end
    
    it "retourne le cours specifie par le sigle" do
      mock_accesseur = MiniTest::Mock.new
      mock_accesseur.expect(:charger_base_donnee, :liste_cours, nom_fichier )
      @bde.assigner_accesseur( mock_accesseur )
      @bde.charger_base_donnee( nom_fichier )
      @bde.selectionner_cours( "PHI012" ).must_equal( cours_selectionne )
      mock_accesseur.verify
    end
  end    
end

#effacer_base_donnee( nom_fichier )
