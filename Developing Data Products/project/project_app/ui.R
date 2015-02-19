shinyUI(bootstrapPage(
      titlePanel("What Hell Brownian Motion Is?"),
      
      sidebarLayout(position = "left",
                    sidebarPanel(
                          h2("Look here for some help!", align = "center"),
                          numericInput("seed", 
                                       label = "Set a seed", 
                                       value = 123),
                          radioButtons("dim", label = "Dimension",
                                       choices = list("One" = 1, "Two" = 2),
                                       selected = 1),
                          sliderInput("sim", label = "Simulations", min = 10, 
                                      max = 100, value = 50, step = 10),
                          sliderInput("time", label = "Time", min = 0, 
                                      max = 100, value = 0, step = 1, 
                                      animate=animationOptions(interval=300, loop=T))
                                 ),
            
                    mainPanel(
                          plotOutput("brownian"),
                          h3("A brief history of... Brownian Motion?", align = "center"),
                          p("Brownian motion was discovered by the biologist Robert
Brown [*] in 1827.", align = "justify"),
                          div(img(src = "brown.jpg", height = 571, width = 469), style="text-align: center;"),
                          br(),
                          br(),
                          p("While Brown was studying pollen particles floating 
in water in the microscope, he observed minute particles in the
pollen grains executing the jittery motion. After repeating the experiment
with particles of dust, he was able to conclude that the motion
was due to pollen being “alive” but the origin of the motion remained
unexplained.", align = "justify"),
                          h3("Then, what is Brownian Motion?", align = "center"),
                          p("You can imagine the Brownian motion like a very big 
                            ball that is kicked by the team of football players. 
                            The remote observer cannot see individual players 
                            (molecules) but can see the moving ball that is randomly 
                            changing its speed an direction.", align = "justify"),
                          div(img(src = "soccer.jpg", height = 427, width = 640), style="text-align: center;")
                    )
      )
))