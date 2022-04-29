## The sample data are visual contrast values between 47 different flowers to each of 46 different leaves in
## four different visual systems (USM, UML, USL, USML).
raw.dat <- read.csv("data/ContrastData.csv")

## Install the required packages
library(dplyr)
library(ggplot2)

## Calculate the average contrast of against all leaves for each flower.
dat <- raw.dat %>% 
  group_by(flowerID, visual_system) %>% 
  summarize(contrast = mean(contrast))

## Calculate the average of the mean contrast for each visual system
dat.mean <- dat %>% 
  group_by(visual_system) %>% 
  summarize(contrast = mean(contrast))


## Plot the figure
ggplot(data = dat,
       aes(x = visual_system, 
           y = contrast,
           group = flowerID)) + # KEY STEP! Group the same flower in different visual systems into one group, so the lines will connect them together.
  geom_point(size = 1, alpha = 0.5) + 
  geom_line(size = 0.5, alpha = 0.2) +
  geom_point(aes(x = dat.mean$visual_system[1],
                 y = dat.mean$contrast[1]), size = 2, color = "red") +
  theme_classic()
