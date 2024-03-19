# Projet benthos Antoine, Claudiane et Juliette

library(dplyr)

# Repertoir de travail
#### WARNING : changer rep.travail pour votre chemin a vous
rep.travail <- "~/R_projet/BIO500/projet_benthos/"
setwd(rep.travail)

# Si premiere ouverture : 
#source("script_premiere_utilisation.R")

# Emplacement dossier data benthos
dossier <- paste0(rep.travail,"benthos")

# Extraction des données benthos
source("read.R")
  benthos <- read.dossier(dossier, rep.travail)
  
# Enleve toues les colonnes avec juste des NA
source("colNA.R")
  benthos <- colNA(benthos)

# Normalise toute les format heure, minute et seconde
source("normalize_time.R")
  for (i in 1:length(benthos$heure_obs)) {
    benthos$heure_obs[i] <- normalize.time(benthos$heure_obs[i])
  }


### WARNING : public avertis!!!!!!


# Liste toutes les identification differente recenser
list.esp <- unique(benthos$nom_sci)
# Trouver les noms avec le séparateur |
nom.double <- list.esp[grep("\\|", list.esp)]

# Liste les noms doubles
source("double_name.R")  
  list.esp.double <- double.name(list.esp,nom.double)

# Enleve de list.esp les nom.double
list.esp <- list.esp[!(list.esp %in% nom.double)]

# Ajout la taxonomie  
#source("taxonomie.R")  
  # Etape difficile a Run a cause de request a une base de donnees, donc l'etape a ete prefaite.
  #esp.info <- taxo(list.esp, list.esp.double)
  load("esp_info_3.RData")
  
# Cree une liste avec tous les especes dans le bonne ordre
list.esp <- names(esp.info)
pos.sup <- length(list.esp)
pos.inf <- pos.sup - (length(nom.double)-1)
list.esp[pos.inf:pos.sup] <- nom.double

# Ajoute au tableau les niveau taxonomique
source("attribution_taxo.R")  
  taxonomie <- attribution.taxo(benthos, esp.info, list.esp)
genus
Arthropoda
Insecta
Coleoptera
Scarabaeidae
Caecidota

taxonomie <- as.data.frame(taxonomie)
taxonomie <- data.frame(identification = taxonomie$identification,
                        phylum = taxonomie$phylum,
                        class = taxonomie$class,
                        orders = taxonomie$order,
                        family = taxonomie$family,
                        genus = taxonomie$genus,
                        taxo_min= taxonomie$taxo_identification)

abondance <- data.frame(date_ab = benthos$date,
                        site_ab = benthos$site,
                        identification_ab = benthos$nom_sci,
                        abondance = benthos$abondance)

benthos.cond <- benthos %>% distinct(date, .keep_all = TRUE)

site <- data.frame(date = benthos.cond$date,     
                   site = benthos.cond$site,
                   date_obs = benthos.cond$date_obs,
                   heure_obs = benthos.cond$heure_obs,
                   fraction = benthos.cond$fraction)

condition_echantillonnage <- data.frame(date_cond = benthos.cond$date,
                                        site_cond = benthos.cond$site,
                                        station = benthos.cond$ETIQSTATION,
                                        largeur_riviere = benthos.cond$largeur_riviere,
                                        profondeur_riviere = benthos.cond$profondeur_riviere,
                                        vitesse_courant = benthos.cond$vitesse_courant,
                                        transparence_eau = benthos.cond$transparence_eau,
                                        temperature_eau_c = benthos.cond$temperature_eau_c)

write.csv(x = taxonomie,file = "taxonomie.csv",row.names = FALSE)
write.csv(x = site,file = "site.csv",row.names = FALSE)
write.csv(x = condition_echantillonnage,file = "condition_echantillonnage.csv",row.names = FALSE)
write.csv(x = abondance,file = "abondance.csv",row.names = FALSE) 
