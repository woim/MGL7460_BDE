class Cours
  attr_reader :sigle
  attr_reader :etudiants

  def initialize( sigle )
    fail "Le nom du cours doit etre de format SSSDDD" \
      unless ( sigle =~ /[A-Z]{3}[0-9]{3}/ ) == 0
    @sigle = sigle
    @etudiants = []
  end

  def lister_etudiants( arranger = nil )
    return String.new if etudiants.empty?
    @etudiants_ordonnes = arranger ? @etudiants.sort : @etudiants
    @etudiants_ordonnes.map{ |e| "#{e.etat_civil}" }.join("\n")
  end

	def ajouter_etudiant( etudiant )
    verifier_etudiant( etudiant, @etudiants.include?( etudiant ) )
    @etudiants.push( etudiant )
	end

  def retirer_etudiant( etudiant )
    verifier_etudiant( etudiant, !@etudiants.include?( etudiant ), false )
    @etudiants.delete( etudiant )
	end

  def lister_evaluations
    return String.new if etudiants.empty?
    @etudiants.map{ |e| e.etat_civil + ": " + e.notes_to_s }
      .join("\n")
	end

  def saisir_eval( etudiant, note )
    verifier_etudiant( etudiant, !@etudiants.include?( etudiant ), false )
    index = @etudiants.find_index( etudiant )
    @etudiants[index].ajouter_note( note )
	end

  def lister_moyenne
    eval = String.new
    @etudiants.each do |eleve|
      moyenne = calculer_moyenne( eleve.notes )
      eval += eleve.etat_civil + ": " + moyenne.to_s + "\n"
    end
    eval
  end

  def ==(c)
    @sigle == c.sigle &&
    @etudiants == c.etudiants
  end

  def <=>(c)
    @sigle <=> c.sigle
  end

  private

  def verifier_etudiant( etudiant, condition, present=true )
    fail "L'argument n'est pas de type etudiant" \
      unless etudiant.instance_of? Etudiant
    message = etudiant.etat_civil
    if present
      message += " existe deja."
    else
      message += " n'existe pas."
    end
    fail message if condition
  end

  def calculer_moyenne( notes )
    return nil if notes.size == 0
    somme = notes.reduce(0, :+)
    somme /= notes.size
  end

end
