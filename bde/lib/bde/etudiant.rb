class Etudiant
  include Comparable
	attr_accessor :nom, :prenoms, :notes

  def initialize( *args )
    @notes = []
    if args.empty?
      @nom = nil
      @prenoms = nil
    else
        fail "un etudiant doit avoir au moins un nom et un prenom" if args.length < 2
        @nom = args[0]
        @prenoms = args.flatten[1..args.length]
    end
  end

  def self.create
    nouvel_etudiant = new
    yield nouvel_etudiant
    nouvel_etudiant.valider
    nouvel_etudiant
  end

	def ajouter_note( *args )
    args = args.flatten
    fail "les arguments ne peuvent etre que des chiffres entier"
      unless notes_valides?( notes )
 		@notes.concat( args.map!{ |x| x.to_f } )
    @notes = @notes.flatten
  end

	def notes_to_s
    @notes.join(" ")
  end

  def etat_civil
    @nom + " " + @prenoms.join(" ")
  end

  def <=>(e)
    if @nom == e.nom
      @prenoms <=> e.prenoms
    else
      @nom <=> e.nom
    end
  end

  def valider
    fail " nom invalide " unless nom_valide?( nom )
    fail " prenoms invalide " unless prenoms_valides?( prenoms )
    fail " notes invalides " unless notes_valides?( notes )
  end

  private

  def notes_valides?( notes )
    notes.all?{ |x| ( x.is_a?( Numeric ) ) && ( x >= 0 ) }
  end

  def nom_valide?( nom )
    nom && nom.kind_of?( String ) && nom =~ /^[A-z]+$/
  end

  def prenoms_valides?( prenoms )
    prenoms.all?{ |x| ( x.is_a?( String ) ) && ( x =~ /^[A-z]+$/ ) }
  end
end
