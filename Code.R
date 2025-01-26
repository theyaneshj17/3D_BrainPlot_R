library(RColorBrewer)    # For color palettes
library(ggseg3d)         # For 3D brain plots
library(htmlwidgets)     # For saving widgets as HTML



##Atlas Region Specifications (considering dk_3d here)

path <- "C:/Users/theya/OneDrive/Theyanesh/ResearchAssistant"

brain_regions <- data.frame(
  region = rep(c(
    "bankssts", "caudal anterior cingulate", "caudal middle frontal", "cuneus", 
    "entorhinal", "frontal pole", "fusiform", "inferior parietal", 
    "inferior temporal", "insula", "isthmus cingulate", "lateral occipital",
    "lateral orbitofrontal", "lingual", "medial orbitofrontal", "middle temporal",
    "paracentral", "parahippocampal", "pars opercularis", "pars orbitalis",
    "pars triangularis", "pericalcarine", "postcentral", "posterior cingulate",
    "precentral", "precuneus", "rostral anterior cingulate", "rostral middle frontal",
    "superior frontal", "superior parietal", "superior temporal", "supramarginal",
    "temporal pole", "transverse temporal"
  )
 
))

#Mockup values

original_values <- c(
  152, 161, 116, 117, 109, 110, 74.4, 75.1, 15.1, 15.8, 75.6, 83.1,
  87.7, 91.8, 107, 117, 102, 106, 86.9, 88.4, 115, 119, 77.2, 89.2,
  115, 120, 64.4, 68.9, 108, 116, 92.5, 102, 95.7, 99.6
)


brain_data_1 <- brain_regions
brain_data_1$value <- original_values - 50  

brain_data_2 <- brain_regions
brain_data_2$value <- original_values       

brain_data_3 <- brain_regions
brain_data_3$value <- original_values + 50  


# Calculate global range for all required plots

global_min_value <- min(c(brain_data_1$value, brain_data_2$value, brain_data_3$value))
global_max_value <- max(c(brain_data_1$value, brain_data_2$value, brain_data_3$value))

#Number of colors required between global minimum and maximum (Change as required)
n <- 10 

# Generate n colors from the RdBu palette

colors <- colorRampPalette((brewer.pal(11, "RdBu")))(n) 

# Generate n values evenly spaced between global_min_value and global_max_value

values <- seq(global_min_value, global_max_value, length.out = n) 

palette <- setNames(values,colors)


p1 <- ggseg3d(
  .data = brain_data_1,   
  atlas = "dk_3d",            
  colour = "value",          
  hemisphere =  "right"   ,  
  palette = palette,
  surface = "inflated" ,
 
)

p2 <- ggseg3d(
  .data = brain_data_2,   
  atlas = "dk_3d",            
  colour = "value",          
  hemisphere =  "right"   ,  
  palette = palette,
  surface = "inflated" ,
  
)

p3 <- ggseg3d(
  .data = brain_data_3,   
  atlas = "dk_3d",            
  colour = "value",          
  hemisphere =  "right"   ,  
  palette = palette,
  surface = "inflated" ,
  
)


# Rename the path as required

path <- "C:/Users/theya/Documents/GitHub/3D_BrainPlot_R"

# Save the widgets using the path variable
htmlwidgets::saveWidget(p1, file.path(path, "brain_plot1.html"))
htmlwidgets::saveWidget(p2, file.path(path, "brain_plot2.html"))
htmlwidgets::saveWidget(p3, file.path(path, "brain_plot3.html"))
