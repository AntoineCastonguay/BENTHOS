# Projet benthos Antoine, Claudiane et Juliette

# Si pas deja fait, il faut ouvrir le projet BENTHOS.Rproj

# Si premiere ouverture effecteur cette commande sinon laisser cette commande en commentaire
#source("script_premiere_utilisation.R")

library(dplyr)

# Extraction des données benthos
source("read.R")
  benthos <- read.dossier()
  
# Enleve toues les colonnes avec juste des NA
source("colNA.R")
  benthos <- colNA(benthos)

# Normalise toute les format heure, minute et seconde
source("normalize_time.R")
  benthos <- normalize.time(benthos)

### WARNING : public avertis!!!!!!
# Effectue tous ce qui est lier à la taxonomie
source("la_taxonomie.R")
  taxonomie <- la.taxonomie(benthos)

# Prépare les data.frame pour la création de table
source("prep_table.R")
  prep.table(benthos,taxonomie)

# Création de la base de données
source("script_SQL.R")
  SQL.make()
