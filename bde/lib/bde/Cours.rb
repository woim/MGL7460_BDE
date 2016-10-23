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
		fail "L'argument n'est pas de type etudiant" \
      unless etudiant.instance_of? Etudiant
    fail etudiant.afficher_etat_civil + " existe deja." \
      if @etudiants.include?( etudiant )
    @etudiants.push( etudiant )
	end
  def retirer_etudiant(etudiant)
    fail "L'argument n'est pas de type etudiant" \
      unless etudiant.instance_of? Etudiant
    fail etudiant.afficher_etat_civil + " n'existe pas." \
      if !@etudiants.include?( etudiant )
    @etudiants.delete( etudiant )
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
  
  private
  
  def par_etat_civil( a, b )
    if a.nom == b.nom
      a.prenoms <=> b.prenoms
    else
      a.nom <=> b.nom
    end 
  end
end
