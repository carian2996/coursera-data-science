shinyServer(function(input, output) {

            output$brownian1d <- renderPlot({
                  if(input$dim == 1){
                        set.seed(input$seed)
                        N <- reactive({input$sim})
                        colors <- rainbow(N())
                        
                        x <- rnorm(1)
                        dis <- rnorm(N())
                        data <- cumsum(c(x, dis))
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

                        output$table <- renderTable({
                              data.frame(data)
                        })
                        
                        output$summary_x <- renderPrint({
                              summary(data)
                        })
                        
                        output$summary_y <- renderPrint({
                              summary(0)
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
                        dis_x <- rnorm(N())
                        dis_y <- rnorm(N())
                        
                        data_x <- cumsum(c(x, dis_x))
                        data_y <- cumsum(c(y, dis_y))
                        data <- data.frame(data_x, data_y)
                        
                        xlim <- max(abs(cumsum(dis_x))) + 1
                        ylim <- max(abs(cumsum(dis_y))) + 1
                        
                        plot(x, y, main = "Brownian Motion of a Particle in Two Dimensions", xlab = "Displacement",
                             ylab = "Displacement", pch = 20, xlim = c(-xlim, xlim), ylim = c(-ylim, ylim), 
                             col = "blue")
                        
                        for (i in 1:input$time){
                              x = x + dis_x[i]
                              y = y + dis_y[i]
                              points(x, y, pch = 20, col = colors[i+1])
                        }
                        
                        output$table <- renderTable({
                              data.frame(data)
                        })
                        
                        output$summary_x <- renderPrint({
                              summary(data_x)
                        })
                        
                        output$summary_y <- renderPrint({
                              summary(data_y)
                        })
                  }
            })
})