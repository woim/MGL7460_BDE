class Accesseur
  attr_accessor :collection_cours
  attr_reader :format
  def initialize( formattage )
    #~ fail "L'argument n'est pas de type Format" \
      #~ unless formattage.instance_of? Format
    @collection_cours = []
    @format = formattage 
  end
  def charger_base_donnee( nom_fichier )
    fail "Le fichier n'existe pas" unless File.file?( nom_fichier )
    File.open( nom_fichier, "r" ).each_line do |ligne|
      @collection_cours.push( @format.extraire_information( ligne ) )
    end
  end  
  def sauvegarder_base_donnee( nom_fichier )
    File.open( nom_fichier, "w" ) do |fich|
      @collection_cours.each do |cours|
        fich.puts @format.ecrire_information( cours ) + "\n"
      end
    end
  end
end