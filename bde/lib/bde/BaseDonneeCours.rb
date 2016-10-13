
class BdCours
  @cours = []
  def initialize()
    #~ @cours.push(Cours.new('MATH00'))
  end
  def cours_exsite(sigle_cours)
    return true
  end
  def ajout_cours(sigle_cours)
      puts "ajout cours"
  end
  def selectionne_cours(sigle_cours)
    puts "selectionne cours"
    return Cours.new('MATH00')
  end
  def lister_cours()
    puts "liste cours"
  end
end
