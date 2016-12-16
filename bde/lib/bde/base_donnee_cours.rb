class BdCours
  attr_reader :cours

  def initialize( accesseur )
    @cours = []
    @accesseur = accesseur
  end

  def cours_existe?( sigle_cours )
    index( sigle_cours )
  end

  def charger_base_donnee( nom_fichier )
    @cours = @accesseur.charger_base_donnee( nom_fichier )
  end

  def ajouter_cours( sigle_cours )
    cours_supplementaire = Cours.new( sigle_cours )
    fail sigle_cours + " existe deja." if cours_existe?( sigle_cours )
    @cours.push( cours_supplementaire )
  end

  def selectionner_cours( sigle_cours )
    index_cours = index( sigle_cours )
    ( index_cours == nil ) ? nil : @cours[index_cours]
  end

  def lister_cours( arranger = nil )
    @cours_ordonne = arranger ? @cours.sort : @cours
    @cours_ordonne
      .map { |c| "#{c.sigle}" }
      .join("\n")
  end

  def sauvegarder_base_donnee( nom_fichier )
    @accesseur.collection_cours = @cours
    @accesseur.sauvegarder_base_donnee( nom_fichier )
  end

  def export_json( nom_fichier )
    JSON.dump(@cours.map { |e| e.to_json }, File.open( nom_fichier, "w" ) )
  end

  def retirer_cours( sigle_cours )
    cours_effacer = Cours.new( sigle_cours )
    fail sigle_cours + " n'existe pas." if !cours_existe?( sigle_cours )
    @cours.delete_at( index( sigle_cours ) )
  end

  private

  def index( sigle_cours )
    @cours.find_index{ |c| c.sigle.to_s == sigle_cours }
  end

end
