class Accesseur
  attr_accessor :collection_cours
  attr_reader :format
  def initialize( formattage )
    @cours = []
    @format = formattage 
  end
  def charger_base_donnee( nom_fichier )
    fail "Le fichier n'existe pas" unless File.file?( nom_fichier )
    File.open( nom_fichier, "r" ).each_line do |ligne|
      @cours.push( @format.extraire_information( ligne ) )
    end
    return @cours
  end  
  def sauvegarder_base_donnee( nom_fichier )
    File.open( nom_fichier, "w" ) do |fich|
      @cours.each do |c|
        ligne = @format.ecrire_information( c )
        ligne += "\n" if c != @cours[-1]
        fich.puts ligne
      end
    end
  end
end
