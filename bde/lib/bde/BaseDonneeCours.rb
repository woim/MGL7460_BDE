class BdCours
  attr_reader :cours
  def initialize( accesseur )
    #~ fail "L'argument n'est pas de type Accesseur" \
      #~ unless accesseur.instance_of? accesseur
    @cours = []
    @accesseur = accesseur
  end  
  def cours_exsite(sigle_cours)
    return true
  end
  def assigner_accesseur( accesseur ) 
    
  end
  def charger_base_donnee( nom_fichier )
    #~ fail "Un accesseur doit etre assigne avant de charger une base de 
          #~ donnee" if @accesseur == nil
    @cours = @accesseur.charger_base_donnee( nom_fichier )
  end
  def ajouter_cours(sigle_cours)
      puts "ajout cours"
  end
  def selectionner_cours(sigle_cours)
    fail "Le nom du cours doit etre de format SSSDDD" \
      unless sigle_cours =~ /[A-Z][A-Z][A-Z]\d\d\d/
    index_cours = @cours.find_index{ |c| c.sigle.to_s == sigle_cours }
    if index_cours != nil
      return @cours[index_cours] 
    else
      return nil
    end
  end
  def lister_cours()
    liste = String.new
    @cours.each do |c|
      liste += c.sigle + "\n"
    end
    return liste
  end
end
