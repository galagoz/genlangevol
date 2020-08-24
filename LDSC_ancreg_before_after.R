## Making a Cleveland dotplot for ENIGMA_Evolution Figure 2
library(tidyverse)
library(here)


#regionordering = read.csv("plotting/freesurfer_orderandcolor.csv")
intercepts <- read_csv("P:/workspaces/lg-genlang/Working/Evolution/LDSC_intercepts_w_and_wo_ancreg.csv", col_names = TRUE)
#intercepts <- intercepts[!intercepts$Region == "Height",]
#intercepts$Region = factor(intercepts$Region, levels = regionordering$Region)


#intercepts$Region <- fct_rev(intercepts$Region)

intercepts_sterr <- intercepts %>% 
  select(Phenotype, Anc_reg, LDSC_int_sterr) %>% 
  spread(Anc_reg, LDSC_int_sterr)
  
intercepts_wide <- intercepts %>% 
  select(Phenotype, Anc_reg, LDSC_intercept) %>% 
  spread(Anc_reg, LDSC_intercept)

plot_data <- left_join(intercepts_wide, intercepts_sterr, by = c("Phenotype"), suffix = c(".intercept", ".sterr"))
  
Surf_plot <- plot_data %>% 
  #filter(Surf_Thic == "Surface Area") %>% 
  ggplot() + 
  # geom_segment(aes(x = Region, xend = Region, y = `TRUE.intercept`,  yend = `FALSE.intercept`), color = "grey50") +
  geom_segment(aes(x = Phenotype, xend = Phenotype, y = `TRUE.intercept`+`TRUE.sterr`,  yend = `TRUE.intercept`-`TRUE.sterr`), color = "#7fbf7b") +
  geom_point(aes(x = Phenotype, y = `TRUE.intercept`), color = "#7fbf7b", size = 3) +
  geom_segment(aes(x = Phenotype, xend = Phenotype, y = `FALSE.intercept`+`FALSE.sterr`,  yend = `FALSE.intercept`-`FALSE.sterr`), color = "#af8dc3") +
  geom_point(aes(x = Phenotype, y = `FALSE.intercept`), color = "#af8dc3", size = 3) +
  labs(y = "LDSC Intercept", 
       x = "Phenotype", 
       title = "Change in LDSC intercept",
       subtitle = "Following ancestry regression (1000 Genomes, Phase 3), wo/ GC correction\nPurple = before, green = after") +
  coord_flip() +
  theme_classic()
Surf_plot

ggsave("P:/workspaces/lg-genlang/Working/Evolution/LDSC_ancreg_Rdata_before_after_w_errorbars.pdf", width = 7, height = 7, unit = "in")

# version with interleaved, rather than stacked points
Surf_plot <- intercepts %>% 
  #filter(Surf_Thic == "Surface Area") %>% 
  ggplot(aes(x = Phenotype, y = LDSC_intercept, color = Anc_reg, group = Anc_reg)) + 
  geom_errorbar(aes(ymax = LDSC_intercept + LDSC_int_sterr,  ymin = LDSC_intercept - LDSC_int_sterr), position = position_dodge(0.9)) +
  geom_point(position = position_dodge(0.9), size = 2)+
  scale_color_manual(values=c("#af8dc3", "#7fbf7b"))+
  labs(y = "LDSC Intercept", 
       x = "Phenotype", 
       title = "Fig. 1C, Change in LDSC intercept",
       subtitle = "Purple = before, green = after") +
  coord_flip() +
  theme_classic()
Surf_plot

ggsave("P:/workspaces/lg-genlang/Working/Evolution/LDSC_ancreg_Rdata_before_after_w_errorbars_grouped.pdf", width = 7, height = 9, unit = "in")





old_before_intercepts <- read.csv(here("data", "LDSC_ancreg", "LDSC_intercepts_before_after_Phase3_ancreg_old_version.csv"))







intercepts <- intercepts[!intercepts$Region == "Height",]

# Reversing order of the brain regions for the plot, so Full is on top after coord_flip
regionordering = read.csv("freesurfer_orderandcolor.csv")
intercepts$Region = factor(intercepts$Region, levels = regionordering$Region)
intercepts$Region <- fct_rev(intercepts$Region)


reading_traits_plot <- intercepts %>% 
  select(Phenotype, Anc_reg, LDSC_intercept) %>% 
  #filter(Surf_Thic == "Surface Area") %>% 
  spread(Anc_reg, LDSC_intercept) %>% 
  ggplot() + 
  geom_segment(aes(x = Phenotype, xend = Phenotype, y = `TRUE`,  yend = `FALSE`), color = "grey50") +
  geom_point(aes(x = Phenotype, y = `TRUE`), color = "#7fbf7b", size = 3) +
  geom_point(aes(x = Phenotype, y = `FALSE`), color = "#af8dc3", size = 3) +
  labs(y = "LDSC Intercept", 
       x = "Phenotype", 
       title = "Change in LDSC intercept",
       subtitle = "Purple = before, green = after") +
  coord_flip() +
  theme_classic()
Surf_plot
ggsave("P:/workspaces/lg-genlang/Working/Evolution/LDSC_ancreg_Rdata_before_after_dotplot_grouped.pdf", width = 7, height = 9, unit = "in")