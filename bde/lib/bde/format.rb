class Format

  def deformater( ligne )
    champ = ligne.split("/")
    cours = Cours.new( champ[0] )

    # Il y a des eleves
    if champ[1].split("|") != nil
      etudiants_information = champ[1].split("|")

      etudiants_information.each do |info|

        nom_info = info.split("=")[0]
        nom = nom_info.split(",")[0]
        prenoms = nom_info.split(",")[1..-1]
        
        etudiant = Etudiant.create do |e|
                      e.nom = nom
                      e.prenoms = prenoms
                   end

        if info.split("=")[1] != nil
          notes_info = info.split("=")[1]
          notes = notes_info.split(",")
          notes.map!{ |x| x.to_f }
          etudiant.ajouter_note( notes )
        end
        cours.ajouter_etudiant( etudiant )
      end
    end
    cours
  end

  def formater( cours )
  	ligne = cours.sigle + "/"
  	cours.etudiants.each do |eleve|
      ligne +=  eleve.nom + "," +
                eleve.prenoms.join(",")
      ligne += "=" +  eleve.notes.join(",") if !eleve.notes.empty?
      ligne += "|" if eleve != cours.etudiants[-1]
    end
    ligne
  end

end
