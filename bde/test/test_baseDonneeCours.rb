require 'test_helper'
require 'bde'



describe BdCours do
  let(:liste_cours ) { [Cours.new( "MAT002" ), \
                        Cours.new( "CHI005" ), \
                        Cours.new( "PHI012" )] }
  before do
    @mock_accesseur = MiniTest::Mock.new
    @mock_accesseur.expect( :charger_base_donnee, liste_cours, ["bde_test.txt"] )
    @bde = BdCours.new( @mock_accesseur )
  end

  describe ".new" do
    it "souleve une erreur si aucun argument n'est donne" do
      lambda{ BdCours.new }.must_raise( ArgumentError )
    end
  end 

  describe "#charger_base_donnee" do
    it "charge une base de donnee" do
      @bde.charger_base_donnee( "bde_test.txt" )
      @bde.cours.must_equal( liste_cours )
      @mock_accesseur.verify
    end  
  end
  
  describe "#cours_existe" do
    it "retourne faux si le cours n'existe pas" do
      @bde.cours_exsite( "INF017" ).must_equal( false )
    end
    
    it "retourne vrai si le cours existe" do
      @bde.charger_base_donnee( "bde_test.txt" )
      @bde.cours_exsite( "MAT002" ).must_equal( true )
    end
  end
  
  describe "#lister_cours" do 
    let(:liste_cours ) { [Cours.new( "MAT002" ), \
                          Cours.new( "CHI005" ), \
                          Cours.new( "PHI012" )] }
    before do 
      @mock_accesseur = MiniTest::Mock.new
      @mock_accesseur.expect( :charger_base_donnee, liste_cours, ["bde_test.txt"] )
      @bde = BdCours.new( @mock_accesseur )
    end
    
    it "retourne une chaine de caractere vide si la base de donnee
        n'a pas ete charge" do
      @bde.lister_cours.must_be_empty
    end
    
    it "retourne la liste des sigles" do
      @bde.charger_base_donnee( "bde_test.txt" )
      @bde.lister_cours.must_equal "MAT002\nCHI005\nPHI012\n"
      @mock_accesseur.verify
    end
    
    it "retourne la liste des sigles ordonne alphabetiquement" do
      @bde.charger_base_donnee( "bde_test.txt" )
      @bde.lister_cours(true).must_equal "CHI005\nMAT002\nPHI012\n"
      @mock_accesseur.verify
    end
  end
  
  describe "#selectionner_cours" do
    let(:cours_selectionne) { Cours.new( "PHI012" ) }
     
    it "retourne nil si le cours n'existe pas" do
      @bde.charger_base_donnee( "bde_test.txt" )
      @bde.selectionner_cours( "BLA005" ).must_equal( nil )
      @mock_accesseur.verify
    end
    
    it "retourne le cours specifie par le sigle" do
      @bde.charger_base_donnee( "bde_test.txt" )
      ( @bde.selectionner_cours( "PHI012" ) == cours_selectionne ) == true
    end
  end    
end
