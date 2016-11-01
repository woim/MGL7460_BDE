class Etudiant
  #include Enumerable ca ne marche pas
	attr_accessor :nom
  attr_reader :prenoms
  attr_reader :notes

  def initialize( nom, *args )
    fail "un etudiant doit avoir au moins un nom et un prenom" if args.empty?
    @nom = nom
    @prenoms = args.flatten
    @notes = []
  end

	def ajouter_note( *args )
    args = args.flatten
    fail "les arguments ne peuvent etre que des chiffres entier" \
      unless args.all?{ |x| ( x.is_a? Numeric ) && x >= 0 }
 		@notes.concat( args.map!{ |x| x.to_f } )
    @notes = @notes.flatten
  end

	def notes_to_s
    @notes.join(" ")
  end

  def etat_civil
    @nom + " " + @prenoms.join(" ")
  end

  def ==(e)
    @nom == e.nom &&
    @prenoms == e.prenoms
  end

  def <=>(e)
    if @nom == e.nom
      @prenoms <=> e.prenoms
    else
      @nom <=> e.nom
    end
  end

end
