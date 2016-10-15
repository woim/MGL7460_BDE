class Etudiant
	attr_accessor :nom
  attr_reader :prenoms 
  @notes = []
  @prenoms = []
  def self.initialize( nom, *args )
    @nom    = nom
    @prenom = *args
  end
	def self.ajouter_note(note)
		puts "ajoute note"
  end
	def self.recuperer_notes()
		puts "retourne les notes"
  end
	def self.afficher_notes()
		puts "affiche les notes"
  end
end
