def verifier_cours( sigle, base_donnee )
  fail "Un sigle de cours doit etre fourni." if sigle.nil?
  fail "Cours " + sigle + " n\'existe pas.\n" if !base_donnee.cours_existe?( sigle )
end
