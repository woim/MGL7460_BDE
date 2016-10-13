class Etudiant
	attr_accessor :prenom, :nom
	def initialize()
		@notes = []
  end
  def initialize(nom,prenom)
		@notes  = []
    @nom    = nom
    @prenom = prenom
  end
	def ajout_note(note)
		puts "ajoute note"
  end
	def bulletin_notes()
		puts "retourne les notes"
  end
	def affciher_notes()
		puts "affiche les notes"
  end
end
