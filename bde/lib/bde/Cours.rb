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
    liste = String.new
    @etudiants.each do |eleve|
      liste += eleve.afficher_etat_civil + "\n"
    end
    return liste      
  end
	def ajouter_etudiant(etudiant)
		fail "L'argument n'est pas de type etudiant" \
      unless etudiant.instance_of? Etudiant
    @etudiants.push(etudiant)
	end
  def retirer_etudiant(etudiant)
    fail "L'argument n'est pas de type etudiant" \
      unless etudiant.instance_of? Etudiant
      puts "retirer etudiant"
	end
  def afficher_evaluation(etudiant)
		puts "afficher evalaution etudiant"
	end
  def saisir_evaluation(etudiant,note)
		puts "saisir evaluation etudiant"	
	end
  def afficher_moyenne(etudiant)
		puts "afficher moyenne etudiant"
  end
  def ==(c)
    @sigle == c.sigle
    @etudiants == c.etudiants
  end
end
