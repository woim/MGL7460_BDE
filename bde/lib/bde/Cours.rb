class Cours
  attr_reader :sigle
  attr_reader :etudiants
  def initialize( sigle )
    fail "Le nom du cours doit etre de format SSSDDD" \
      unless sigle =~ /[A-Z][A-Z][A-Z]\d\d\d/
    @sigle = sigle
    @etudiants = []
  end
	def lister_etudiants
  return "" if @etudiants.empty?
		@etudiants.each do |eleve|
      puts eleve.nom #eleve.prenoms.join(" ")
    end      
  end
	def ajouter_etudiant(etudiant)
		fail "L'argument n'est pas de type etudiant" \
      unless etudiant.instance_of? Etudiant
    @etudiants.push(etudiant)
	end
  def retirer_etudiant(etudiant)
    fail "L'argument n'est pas de type etudiant" \
      unless etudiant.instance_of? Etudiant
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
end
