library(tidyverse)

MSC <- read.table("Missing_Codes.txt", header = T)

#Missing EF1 and CO1
MSC <- MSC %>% 
  mutate(EF1 = as.factor(EF1)) %>% 
  mutate(CO1 = as.factor(CO1)) %>% 
  mutate(ScID = as.factor(ScID)) %>% 
  mutate(SlideID = as.factor(SlideID)) %>% 
  mutate(SpecimenID = as.factor(SpecimenID))

MSC_EF1_CO1 <- MSC %>% 
  filter(EF1 == 'non' & CO1 == 'non') %>% 
  mutate(INFO = 'Les_Deux')

MSC_EF1 <- MSC %>% 
  filter(EF1 == 'non' & CO1 == 'oui') %>% 
  mutate(INFO = 'EF1_Seul')

MSC_CO1 <- MSC %>% 
  filter(EF1 == 'oui' & CO1 == 'non') %>% 
  mutate(INFO = 'CO1_Seul') 

MSC_F <- MSC_EF1_CO1 %>% 
  full_join(MSC_CO1, by = c("NuméroCF", "SpecimenID", "SlideID", "ScID", "CO1", "EF1", "INFO")) %>% 
  full_join(MSC_EF1, by = c("NuméroCF", "SpecimenID", "SlideID", "ScID", "CO1", "EF1", "INFO")) %>% 
  write_csv("C:/Users/User/OneDrive/Documents/Phylloxera_Workshop/Data/Missing_Genes.csv")
