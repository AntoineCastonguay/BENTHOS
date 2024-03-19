# Fonction qui permet d'attribuer les arbre toxonomique au identification

attribution.taxo <- function(benthos, esp.info, list.esp){
  
  # Creation de la matrix taxonomie
  taxonomie <- matrix(NA,length(list.esp),7)
  colnames(taxonomie) <- c("phylum", "class", "order", "family", "genus", "taxo_identification", "identification")
  i <- 1
  
  for (esp in esp.info) {
    # si espece est trouver continue sinon option manuelle
    if(!any(is.na(esp.info[[i]]))){
      
      # si gene est present stock dans taxonomie
      if(any(esp[[2]] == "genus")){
        esp.genus <- subset(esp,esp[[2]] == "genus")
        taxonomie[i,5] <- esp.genus$name
      }
      
      # si family est present stock dans taxonomie
      if(any(esp[[2]] == "family")){
        esp.family <- subset(esp,esp[[2]] == "family")
        taxonomie[i,4] <- esp.family$name
      }
      
      # si order est present stock dans taxonomie
      if(any(esp[[2]] == "order")){
        esp.order <- subset(esp,esp[[2]] == "order")
        taxonomie[i,3] <- esp.order$name
      }
      
      # si class est present stock dans taxonomie
      if(any(esp[[2]] == "class")){
        esp.class <- subset(esp,esp[[2]] == "class")
        taxonomie[i,2] <- esp.class$name
      }
      
      # si phylum est present stock dans taxonomie
      if(any(esp[[2]] == "phylum")){
        esp.phylum <- subset(esp,esp[[2]] == "phylum")
        taxonomie[i,1] <- esp.phylum$name
      }
      
      # Determine le niveau taxonomique de l'identification
      esp.min <- subset(esp,tolower(esp[[1]]) == tolower(names(esp.info[i])))
      taxon.min <- esp.min$rank
      taxonomie[i,6] <- taxon.min[1]
      
      # Identification brut
      taxonomie[i,7] <- list.esp[i]
    }else{
      
      # Entrer manuelle de la taxonomie
      print(paste("Espece non trouver :",list.esp[i]))
      
      # Demande a la console le plus bas niveau taxonomique
      print("Niveau taxonomique : phylum, class, order, family, genus")
      esp.min <- readline(prompt = "Entrez le plus bas niveau taxonomique : ")
      taxonomie[i,6] <- tolower(esp.min)
      
      # Demande a la console le phylum
      esp.phylum <- readline(prompt = "Entrez le phylum : ")
      taxonomie[i,1] <- esp.phylum
      
      if(tolower(esp.min) != "phylum"){
        # Demande a la console la class
        esp.class <- readline(prompt = "Entrez la class : ")
        # Si na met NA
        if (tolower(esp.class) == "na" || tolower(esp.class) == "-") {
          esp.class <- NA
        }
        # Stock dans taxonomie
        taxonomie[i,2] <- esp.class
        
        if(tolower(esp.min) != "class"){
          # Demande a la console le order
          esp.order <- readline(prompt = "Entrez le order : ")
          if (tolower(esp.class) == "na" || tolower(esp.class) == "-") {
            esp.order <- NA
          }
          taxonomie[i,3] <- esp.order
          
          if(tolower(esp.min) != "order"){
            # Demande a la console la family
            esp.family <- readline(prompt = "Entrez la family : ")
            if (tolower(esp.class) == "na" || tolower(esp.class) == "-") {
              esp.family <- NA
            }
            taxonomie[i,4] <- esp.family
            
            if(tolower(esp.min) != "family"){
              # Demande a la console le genus
              esp.genus <- readline(prompt = "Entrez le genus : ")
              if (tolower(esp.class) == "na" || tolower(esp.class) == "-") {
                esp.genus <- NA
              }
              taxonomie[i,5] <- esp.genus
              
            }else{
              taxonomie[i,5] <- NA
            }
          }else{
            taxonomie[i,4] <- NA
            taxonomie[i,5] <- NA
          }
        }else{
          taxonomie[i,3] <- NA
          taxonomie[i,4] <- NA
          taxonomie[i,5] <- NA
        }
      }else{
        taxonomie[i,2] <- NA
        taxonomie[i,3] <- NA
        taxonomie[i,4] <- NA
        taxonomie[i,5] <- NA
      }
      
      # Identification brut
      taxonomie[i,7] <- list.esp[i]
    }
    i <- i+1
  }
  
  # # merge benthos et taxonomie a tout les place que le nom_sci de benthos est egale a l'indentification dans taxonomie
  # new.benthos <- merge(benthos, taxonomie, by.x = "nom_sci", by.y = "identification", all.x = TRUE)
  # 
  # # rearrangement des colonnes
  # new.benthos <- data.frame(date = new.benthos$date, 
  #                           site = new.benthos$site, 
  #                           date_obs = new.benthos$date_obs, 
  #                           heure_obs = new.benthos$heure_obs,
  #                           fraction = new.benthos$fraction,
  #                           phylum = new.benthos$phylum,
  #                           class = new.benthos$class,
  #                           order = new.benthos$order,
  #                           family = new.benthos$family,
  #                           genus = new.benthos$genus,
  #                           taxo_min = new.benthos$taxo_identification,
  #                           identification = new.benthos$nom_sci,
  #                           abondance = new.benthos$abondance,
  #                           largeur_riviere = new.benthos$largeur_riviere,
  #                           profondeur_riviere = new.benthos$profondeur_riviere,
  #                           vitesse_courant = new.benthos$vitesse_courant,
  #                           transparence_eau = new.benthos$transparence_eau,
  #                           temperature_eau_c = new.benthos$temperature_eau_c,
  #                           ETIQSTATION = new.benthos$ETIQSTATION)
  
  return(taxonomie)
}