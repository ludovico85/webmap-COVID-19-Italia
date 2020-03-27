theme_map<-function()
{
  base_size<-11
  half_line <- base_size/2
  theme_grey(base_size = 11, base_family = "",
             base_line_size = base_size/22, base_rect_size = base_size/22) %+replace%
    theme(panel.background = element_rect(fill = "grey15",
        colour = NA), plot.background = element_rect(fill = NA),
        plot.margin = margin(0, -1, 0, -1, "cm"),
        panel.grid = element_line(colour = NA),
        panel.grid.major = element_line(size = rel(0.5), colour = "grey35"),
        panel.grid.minor = element_line(size = rel(0.25), colour = "grey35"),
        axis.ticks = element_line(colour = "grey35",
            size = rel(0.5)),
        plot.title = element_text(color="white", face="bold", hjust=0, size = 12),
        axis.text.x = element_text(angle = 0, color = "white", size = 10),
        axis.text.y = element_text(angle = 0, color = "white", size = 10),
        axis.title.x = element_text(color="white", size = 10),
        axis.title.y = element_text(color="white", size = 10),
        legend.key = element_rect(fill = NA, 
            colour = NA),
        legend.position="bottom",
        legend.title = element_blank(),
        strip.background = element_rect(fill = "grey35",
            colour = NA), strip.text = element_text(colour = "grey35",
            size = rel(0.8), margin = margin(0.8 * half_line,
            0.8 * half_line, 0.8 * half_line, 0.8 * half_line)),                               
        complete = TRUE)
}


