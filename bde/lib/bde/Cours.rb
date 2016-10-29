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
    @etudiants_ordonnes.map{ |e| "#{e.afficher_etat_civil}" }.join("\n")
  end

	def ajouter_etudiant( etudiant )
    test_etudiant( etudiant, @etudiants.include?( etudiant ), " existe deja." )
    @etudiants.push( etudiant )
	end

  def retirer_etudiant( etudiant )
    test_etudiant( etudiant, !@etudiants.include?( etudiant ), " n'existe pas." )
    @etudiants.delete( etudiant )
	end

  def lister_evaluations
    return String.new if etudiants.empty?
    @etudiants.map{ |e| e.afficher_etat_civil + ": " + e.afficher_notes }
      .join("\n")
	end

  def saisir_eval( etudiant, note )
    test_etudiant( etudiant, !@etudiants.include?( etudiant ), " n'existe pas." )
    index = @etudiants.find_index( etudiant )
    @etudiants[index].ajouter_note( note )
	end

  def lister_moyenne
    eval = String.new
    @etudiants.each do |eleve|
      moyenne = calculer_moyenne( eleve.notes )
      eval += eleve.afficher_etat_civil + ": " + moyenne.to_s + "\n"
    end
    eval
  end

  def ==(c)
    @sigle == c.sigle
    @etudiants == c.etudiants
  end

  def <=>(c)
    @sigle <=> c.sigle
  end

  private

  def test_etudiant( etudiant, condition, message )
    fail "L'argument n'est pas de type etudiant" \
      unless etudiant.instance_of? Etudiant
    fail etudiant.afficher_etat_civil + message if condition
  end

  def calculer_moyenne( notes )
    return nil if notes.size == 0
    somme = 0
    notes.each{ |n| somme += n }
    somme /= notes.size
  end

end
