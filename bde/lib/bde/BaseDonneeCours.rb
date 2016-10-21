class BdCours
  attr_reader :cours
  def initialize( accesseur )
    @cours = []
    @accesseur = accesseur
  end  
  def cours_exsite(sigle_cours)
    return true
  end
  def assigner_accesseur( accesseur ) 
    
  end
  def charger_base_donnee( nom_fichier )
    @cours = @accesseur.charger_base_donnee( nom_fichier )
  end
  def ajouter_cours(sigle_cours)
      puts "ajout cours"
  end
  def selectionner_cours(sigle_cours)
    index_cours = @cours.find_index{ |c| c.sigle.to_s == sigle_cours }
    res = nil
    res = @cours[index_cours] if index_cours != nil
  end
  def lister_cours
    liste = String.new
    @cours.each do |c|
      liste += c.sigle + "\n"
    end
    return liste
  end
end
