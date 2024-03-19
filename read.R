# Fonction read.dossier

read.dossier <- function(dossier,rep.travail){
  
  # Changer le repertoir de travail pour les datas
  setwd(dossier)
  
  # Liste tous les fichiers du dossier
  fichiers <- list.files(dossier)
  
  # Enleve le fichier README.md
  fichiersCSV <- fichiers[-1]
  
  # Lecture des fichiers .csv 
  data_list <- lapply(fichiersCSV, read.csv)
  
  # Fusionner les lectures des fichiers
  benthos <- do.call(rbind, data_list)
  
  setwd(rep.travail)
  
  return(benthos)
}