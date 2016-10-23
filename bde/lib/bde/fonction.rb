def test_options( sigle, exist, lambda1, lambda2 )  
  if sigle.nil?
    lambda1.()
  else
    if !exist
      puts "cours: " + sigle + " n\'existe pas.\n"        
    else
      lambda2.()
    end
  end
end
