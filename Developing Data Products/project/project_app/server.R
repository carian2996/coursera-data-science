shinyServer(function(input, output) {

            output$brownian1d <- renderPlot({
                  if(input$dim == 1){
                        set.seed(input$seed)
                        N <- reactive({input$sim})
                        colors <- rainbow(N())
                        
                        x <- rnorm(1)
                        dis <- rnorm(N()-1)
                        ylim <- max(abs(cumsum(dis))) + 1
                        
                        plot(0, x, main = "Brownian Motion of a Particle in One Dimension", xlab = "Time",
                             ylab = "Displacement", pch = 20, xlim = c(0, N()), ylim = c(-ylim, ylim), 
                             col = colors[1])
                        
                        if(input$time != 0){
                              for (i in 1:input$time){
                                    x = x + dis[i]
                                    points(i , x, pch = 20, col = colors[i])
                              }
                        }
                        
                        data <- reactive({ cumsum(c(x, dis)) })
                        
                        output$table <- renderTable({
                              data.frame(data())
                        })
                        
                        output$summary <- renderPrint({
                              summary(data())
                        })
                  }
            })

            output$brownian2d <- renderPlot({
                  if(input$dim == 2){
                        set.seed(input$seed)
                        N <- reactive({input$sim})
                        colors <- rev(heat.colors(N()))
                        
                        x <- rnorm(1)
                        y <- rnorm(1)
                        dis_x <- rnorm(N()-1)
                        dis_y <- rnorm(N()-1)
                        data <- reactive({ data.frame(cumsum(dis_x), cumsum(dis_y)) })
                        
                        xlim <- max(abs(cumsum(dis_x))) + 1
                        ylim <- max(abs(cumsum(dis_y))) + 1
                        
                        plot(x, main = "Brownian Motion of a Particle in Two Dimensions", xlab = "Displacement",
                             ylab = "Displacement", pch = 20, xlim = c(-xlim, xlim), ylim = c(-ylim, ylim), 
                             col = "blue")
                        
                        for (i in 1:input$time){
                              x = x + dis_x[i]
                              y = y + dis_y[i]
                              points(x, y, pch = 20, col = colors[i+1])
                        }
                  }
            })
})