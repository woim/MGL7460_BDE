class Etudiant
	attr_accessor :nom
  attr_reader :prenoms 
  attr_reader :notes
  def initialize( nom, *args )
    fail "un etudiant doit avoir au moins un nom et un prenom" if args.empty?
    @nom = nom
    @prenoms = args
    @notes = []
  end
	def ajouter_note( *args )
    args = args.flatten
    fail "les arguments ne peuvent etre que des chiffres entier" \
      unless args.all?{ |x| ( x.is_a? Numeric ) && x >= 0 }
 		@notes.concat( args )
    @notes = @notes.flatten
  end
	def afficher_notes
    @notes.join(" ")    
  end
  def afficher_etat_civil
    return @nom + " " + @prenoms.join(" ")
  end
end
