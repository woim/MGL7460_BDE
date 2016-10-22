class BdCours
  attr_reader :cours
  def initialize( accesseur )
    @cours = []
    @accesseur = accesseur
  end  
  def cours_exsite( sigle_cours )
    return ( index( sigle_cours ) != nil ) ? true : false
  end
  def charger_base_donnee( nom_fichier )
    @cours = @accesseur.charger_base_donnee( nom_fichier )
  end
  def ajouter_cours( sigle_cours )
    cours_supplementaire = Cours.new( sigle_cours )
  end
  def selectionner_cours( sigle_cours )
    index_cours = index( sigle_cours ) 
    return ( index_cours == nil ) ? nil : @cours[index_cours]
  end
  def lister_cours( arranger=false )
    liste = String.new
    @cours_ordonne = @cours
    if arranger == true
      @cours_ordonne = @cours.sort{ |a,b| a.sigle <=> b.sigle }
    end
    @cours_ordonne.each do |c|
      liste += c.sigle + "\n"
    end
    return liste
  end
  
  private 
  
  def index( sigle_cours )
    @cours.find_index{ |c| c.sigle.to_s == sigle_cours }
  end  
end
