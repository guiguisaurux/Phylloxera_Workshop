library(sf)
library(ggplot2)
library(rnaturalearth)

library(rnaturalearthhires)
library(tidyverse)


# Load data
samples <- read.table("Sampling_location_Data.txt", header = T)

samples$HostID <- as.factor(samples$HostID)
samples$ColID <- as.factor(samples$ColID)

# Convert to sf object
samples_Loc <- samples %>% 
  filter(!is.na(Lat) & !is.na(Lon))


samples_sf <- st_as_sf(samples_Loc, coords = c("Lon", "Lat"), crs = 4326, remove = FALSE)

# Load provinces/states polygons
admin1_all <- rnaturalearth::ne_states(
  country = c("canada", "united states of america", "mexico"),
  returnclass = "sf"
)

# Plot
ggplot() +
  geom_sf(data = admin1_all, fill = "#201030", color = "gray", size = 0.1) +
  geom_sf(data = samples_sf, aes(color = ColID), size = 0.1,alpha = 0.5) +
  scale_color_manual(values = c("green","#0CC")) +
  scale_x_continuous(limits = c(-120, -50)) +
  scale_y_continuous(limits = c(25,50)) +
  theme_minimal() + 
  ggsave(filename = "C:/Users/User/OneDrive/Documents/Phylloxera_Workshop/Figures/samples_map.png", dpi = 600)



library(tidyplots)

tidyplot(samples, y = HostID, fill = ColID) %>% 
  add_barstack_absolute() %>%
  adjust_colors(new_colors = c("green","blue")) %>% 
  adjust_size(height = 120, width = 120) %>% 
  save_plot("C:/Users/User/OneDrive/Documents/Phylloxera_Workshop/Figures/samples_unfiltered.png")

samples_Col <- samples %>% 
  filter(!grepl("\\?", HostID)) %>% 
  filter(!grepl("\\_x_", HostID)) %>% 
  filter(!grepl("\\hybrid", HostID)) %>% 
  filter(!grepl("\\_or_", HostID)) 

  
tidyplot(samples_Col, y = HostID, fill = ColID) %>% 
  add_barstack_absolute() %>%
  adjust_size(height = 120, width = 120) %>% 
  adjust_colors(new_colors = c("green","blue")) %>% 
  save_plot("C:/Users/User/OneDrive/Documents/Phylloxera_Workshop/Figures/samples_filtered.png")
