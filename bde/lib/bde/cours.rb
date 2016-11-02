class Cours
  include Comparable
  attr_reader :sigle
  attr_reader :etudiants

  def initialize( sigle )
    fail "Le nom du cours doit etre de format SSSDDD" \
      unless ( sigle =~ /[A-Z]{3}[0-9]{3}/ ) == 0
    @sigle = sigle
    @etudiants = []
  end

  def lister_etudiants( arranger = nil )
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
    @etudiants.map{ |e| e.etat_civil + ": " + e.notes_to_s }
      .join("\n")
	end

  def saisir_eval( etudiant, note )
    verifier_etudiant( etudiant, !@etudiants.include?( etudiant ), false )
    index = @etudiants.find_index( etudiant )
    @etudiants[index].ajouter_note( note )
	end

  def lister_moyenne
    @etudiants.map{ |e| e.etat_civil + ": " + calculer_moyenne( e.notes ).to_s }
              .join("\n")
  end

  def <=>(c)
    # On ordonne / au sigle mais pas les etudiants ce qui peut etre un pb un jour
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
