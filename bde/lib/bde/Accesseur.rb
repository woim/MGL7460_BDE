class Accesseur
  attr_accessor :collection_cours
  attr_reader :format
  def initialize( formattage )
    @collection_cours = []
    @format = formattage
  end
  def charger_base_donnee( nom_fichier )
    fail "Le fichier n'existe pas" unless File.file?( nom_fichier )
    File.open( nom_fichier, "r" ).each_line do |ligne|
      @collection_cours.push( @format.extraire_information( ligne ) )
    end
    return @collection_cours
  end
  def sauvegarder_base_donnee( nom_fichier )
    File.open( nom_fichier, "w" ) do |fich|
      @collection_cours.each do |c|
        ligne = @format.ecrire_information( c )
        fich.puts ligne
      end
    end
  end
end
