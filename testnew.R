test <- read.csv(file = "data/site_100_92_R01_2021-10-01.csv")
head(test)

nameCol <- c(date,
  site,
  date_obs,
  heure_obs,
  fraction,
  nom_sci,
  abondance,
  largeur_riviere,
  profondeur_riviere,
  vitesse_courant,
  transparence_eau,
  temperature_eau_c,
  ETIQSTATION,
  RIVIERE_TOPO,
  NIVEAU,
  CRG_ROC,
  CRG_SOL,
  CRG_HER,
  CRD_ROC,
  CRD_SOL,
  CRD_HER,
  ESUB_ALG,
  ESUB_MOU,
  ESUB_AUT,
  TEMP,
  X1_SUBSTRAT_ABRI,
  X2_SABLE_VASE,
  X3_VELOCITE,
  X4_SEDIMENT,
  REMARQUE)

test <- data.frame()

new.row <- c("2021-10-01",
             "100_92_R01",
             "2021-10-01",
             "10:00:00",
             0.2083333,
             "Baeti",
             3,
             3.86,
             0.26,
             2.644,
             "élevée",
             10.8,
             NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)

test <- rbind(test,new.row)

colnames(test) <- nameCol
