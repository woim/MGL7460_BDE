class Cours
  attr_accessor :sigle
  @etudiants = []
  def initialize()
  end
  def initialize(sigle)
    @sigle = sigle
  end
	def lister_etudiants()
		puts "liste les etudiants"
  end
	def ajouter_etudiant(etudiant)
		puts "ajoute un etudiant"
	end
  def retirer_etudiant(etudiant)
		puts "retire etudiant"
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
