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
      @collection_cours.push( @format.deformater( ligne ) )
    end
    @collection_cours
  end

  def sauvegarder_base_donnee( nom_fichier )
    File.open( nom_fichier, "w" ) do |fich|
      @collection_cours.each do |c|
        fich.puts @format.formater( c )
      end
    end
  end

end
