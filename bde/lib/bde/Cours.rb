class Cours
  attr_reader :sigle
  attr_reader :etudiants
  def initialize( sigle )
    fail "Le nom du cours doit etre de format SSSDDD" \
      unless ( sigle =~ /[A-Z]{3}[0-9]{3}/ ) == 0
    @sigle = sigle
    @etudiants = []
  end
	def lister_etudiants( arrange=false )
    @etudiants_ordonnes = @etudiants
    if arrange == true
      @etudiants_ordonnes = @etudiants.sort{ |a,b| par_etat_civil(a, b) }
    end
    liste = String.new
    @etudiants_ordonnes.each do |eleve|
      liste += eleve.afficher_etat_civil + "\n"
    end
    return liste      
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
		eval = String.new
    @etudiants.each do |eleve|
      eval += eleve.afficher_etat_civil + ": " + eleve.afficher_notes + "\n" 
    end
    return eval
	end
  def saisir_eval( etudiant, note )
    test_etudiant( etudiant, !@etudiants.include?( etudiant ), " n'existe pas." )
    index = @etudiants.find_index( etudiant )
    @etudiants[index].ajouter_note( note )
	end
  def afficher_moyenne(etudiant)
		puts "afficher moyenne etudiant"
  end
  def ==(c)
    @sigle == c.sigle
    @etudiants == c.etudiants
  end
  
  private
  
  def par_etat_civil( a, b )
    if a.nom == b.nom
      a.prenoms <=> b.prenoms
    else
      a.nom <=> b.nom
    end 
  end
  def test_etudiant( etudiant, condition, message )
    fail "L'argument n'est pas de type etudiant" \
      unless etudiant.instance_of? Etudiant
    fail etudiant.afficher_etat_civil + message if condition #!@etudiants.include?( etudiant )
  end
  
end
