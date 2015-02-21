shinyUI(bootstrapPage(
      titlePanel("What Hell Brownian Motion Is?"),
      
      sidebarLayout(position = "left",
                    sidebarPanel(
                          h2("How to use this app?",  align = "center"),
                          p("You can play around with the controls for a while, and later read the text in the What BM is? Tab to discover What Hell Brownian Motion Is?", align = "justify"),
                          h2("Look here for some help!", align = "center"),
                          p("You need a seet because Brownian Motion is all about randomness. Every natural number was assigned to a Brownian Motion. Be careful, you have to give me a number, and that number should have less than ten digits.", align = "justify"),
                          numericInput("seed", label = "Set a seed", value = 123),
                          p("You can see Brownian Motion in two presentations. Through the time, or through the space.", align = "justify"),
                          radioButtons("dim", label = "Dimension", 
                                       choices = list("One" = 1, "Two" = 2),
                                       selected = 1),
                          p("With this parameter, you can tell me how many simulations should I do.", align = "justify"),
                          sliderInput("sim", label = "Simulations", min = 10, 
                                      max = 100, value = 10, step = 10),
                          p("Here, the magic occurs. You can see the evolution of the process!", align = "justify"),
                          sliderInput("time", label = "Time", min = 1, 
                                      max = 99, value = 10, step = 1, 
                                      animate=animationOptions(interval=300, loop=T)),
                          p("**I was not be able to solve an issue. You have to go to the Plot Tab and then, the Statistic Tab will upload ;)")
                                 ),
            
                    mainPanel(
                          tabsetPanel(type = "tabs", 
                                      tabPanel("Plot", plotOutput("brownian1d"), 
                                               plotOutput("brownian2d")),
                                      tabPanel("Statistics", verbatimTextOutput("summary"), 
                                               tableOutput("table")),
                                      tabPanel("What BM is?", h3("A brief history of... Brownian Motion?", align = "center"),
                                               div(img(src = "brown.jpg", height = 571, width = 469), style="text-align: center;"),
                                               br(),
                                               br(),
                                               p("Brownian motion was discovered by the biologist Robert Brown [1] in 1827. While Brown was studying pollen particles floating in water in the microscope, he observed minute particles in the pollen grains executing the jittery motion. After repeating the experiment with particles of dust, he was able to conclude that the motion was due to pollen being “alive” but the origin of the motion remained unexplained.", align = "justify"),
                                               h3("Then, what is Brownian Motion?", align = "center"),
                                               p("You can imagine the Brownian motion like a very big ball that is kicked by the team of football players. The remote observer cannot see individual players (molecules) but can see the moving ball that is randomly changing its speed an direction.", align = "justify"),
                                               div(img(src = "soccer.jpg", height = 427, width = 640), style="text-align: center;"),
                                               h3("Brownian Motion really exist?", align = "center"),
                                               p("Well, the answer is YES. You can find a mathematical demostration in [2], but really, does the Brownian Motion exist in our world. Well, the answer, again is YES.", align = "justify"),
                                               p("Using a probability distribution function and the prices of the same random stock choice at random times, he was able to derive a steady state distribution function, which is precisely the probability distribution for a particle in Brownian motion. ", align = "justify"),
                                               br(),
                                               br()), 
                                      tabPanel("References", p("[1] R. Brown, A brief account of microscopical observations made in the months of June, July and August, 1827, on the particles contained in the pollen of plants; and on the general existence of active molecules in organic and inorganic bodies, Philosophical Magazine N. S.4 ,161-173, 1828."),
                                               p("[2] Mörters, P., Peres, Y., Schramm, O. & Werner, W. Brownian motion (Cambridge Univ. Press, 2010)."),
                                               div(img(src = "cc.jpg", height = 72, width = 100), style="text-align: left;"),
                                               br(),
                                               p("All images used in this app are under Creative Commons Licence."),
                                               br(),
                                               p("Any typo or comment, sent a mail to: ian.castillo@cimat.mx")
                                               )
                          )
                    )
      )
))