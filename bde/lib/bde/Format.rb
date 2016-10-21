class Format
  def extraire_information( ligne )
    champ = ligne.split("/")    
    cours = Cours.new( champ[0] )
    etudiants_information = champ[1].split("|")
    etudiants_information.each do |info|
      nom_info = info.split("=")[0]
      nom = nom_info.split(",")[0]
      prenoms = nom_info.split(",")[1..-1]
      
      notes_info = info.split("=")[1]
      notes = notes_info.split(",")
      notes.map!{ |x| x.to_f }    
      
      etudiant = Etudiant.new(nom,prenoms)
      etudiant.ajouter_note( notes )
      cours.ajouter_etudiant(etudiant)
    end 
    return cours 
  end  
  def ecrire_information( cours )
  	ligne = cours.sigle
  	cours.etudiants.each do |eleve|
      ligne +=  "/" + eleve.nom + "," + eleve.prenoms.joim(",") + "=" \
                    + eleve.notes.join(",")
    end
  end  
end
