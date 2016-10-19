class Accesseur
  attr_accessor :collection_cours = []
  def initialize( formattage )
    @collection_cours = []
    @format = nil 
  end
  def charger_base_donnee( nom_fichier )
    fail "Le fichier n'existe pas" unless File.file?( nom_fichier )
      File.open( nom_fichier, "r" ).each_line do |ligne|
        @collection_cours.push( @format.extraire( ligne ) )
      end
  end  
  def sauvegarder_base_donnee( nom_fichier )
    File.open( nom_fichier, "w" ) do |fich|
    @collection_cours.each do |ligne|
      fich.puts ligne
    end
  end
end
