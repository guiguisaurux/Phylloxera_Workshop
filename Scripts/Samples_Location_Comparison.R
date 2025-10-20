library(sf)
library(ggplot2)
library(rnaturalearth)

library(rnaturalearthhires)
library(tidyverse)


# Load data
samples <- read.table("Sampling_location_Data.txt", header = T)

# Convert to sf object
samples <- samples %>% 
  filter(!is.na(Lat) & !is.na(Lon))


samples_sf <- st_as_sf(samples, coords = c("Lon", "Lat"), crs = 4326, remove = FALSE)

# Load provinces/states polygons
admin1_all <- rnaturalearth::ne_states(
  country = c("canada", "united states of america", "mexico"),
  returnclass = "sf"
)

# Plot
ggplot() +
  geom_sf(data = admin1_all, fill = "white", color = "black", size = 0.01) +
  geom_sf(data = samples_sf, aes(color = ColID), size = 0.001,alpha = 0.1) +
  theme_minimal() + 
  ggsave(filename = "C:/Users/User/OneDrive/Documents/Phylloxera_Workshop/Figures/samples_map.png", dpi = 1200)
