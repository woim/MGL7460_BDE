class BdCours
  attr_reader :cours
  def initialize
    @cours = []
  end  
  def cours_exsite(sigle_cours)
    return true
  end
  def assigner_accesseur( accesseur ) 
    @accesseur = accesseur
  end
  def charger_base_donnee(nom_fichier)
    @cours = @accesseur.charger_base_donnee( nom_fichier )
  end
  def ajouter_cours(sigle_cours)
      puts "ajout cours"
  end
  def selectionner_cours(sigle_cours)
    puts "selectionne cours"
    return Cours.new('MATH00')
  end
  def lister_cours()
    liste = String.new
    @cours.each do |c|
      liste += c.sigle + "\n"
    end
    return liste
  end
end
