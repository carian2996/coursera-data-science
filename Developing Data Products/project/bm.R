# Ian Castillo Rosales
# Brownian Motion
# 02/18/2015

# ===== How the BM is constructed? =====
set.seed(123)
N <- 1000
dis <- rnorm(N, 0, 1)
dis <- cumsum(dis)
plot(dis, type= "l", main = "Brownian Motion in One Dimension", xlab = "time", ylab = "displacement")

# ===== How the BM (in two dimensions) is constructed? =====
set.seed(123)
dis_x <- rnorm(N, 0, 1)
dis_x <- cumsum(dis_x)
dis_y <- rnorm(N, 0, 1)
dis_y <- cumsum(dis_y)
plot(dis_x, dis_y, type= "l", main = "Brownian Motion in Two Dimension", xlab = "time", ylab = "displacement")

# ===== How can I interchange the type of the plot? =====
brownianPlot <- function(N, dim){
      if(dim == 1){
            dis <- rnorm(N, 0, 1)
            dis <- cumsum(dis)
            plot(dis, type= "l", main = "Brownian Motion in One Dimension", xlab = "time", ylab = "displacement")
      } else{
            dis_x <- rnorm(N, 0, 1)
            dis_x <- cumsum(dis_x)
            dis_y <- rnorm(N, 0, 1)
            dis_y <- cumsum(dis_y)
            plot(dis_x, dis_y, type= "l", main = "Brownian Motion in Two Dimension", xlab = "time", ylab = "displacement")
      }
}

brownianPlot(1000, 3)

# ===== How animate the plot? =====
set.seed(8)
N <- 100

colors <- rainbow(N)
ani.options(interval = 1/20)

x <- rnorm(1)
dis <- rnorm(N-1)
ylim <- max(abs(cumsum(dis))) + 1

plot(x, main = "Brownian Motion of a Particle in One Dimension", xlab = "Time",
     ylab = "Displacement", pch = 20, xlim = c(0, N), ylim = c(-ylim, ylim), 
     col = colors[1])

for (i in 1:(N-1)){
      dev.hold()
      x = x + dis[i]
      points(i + 1, x, pch = 20, col = colors[i+1])
      ani.pause()
}
# ===== How animate the plot? =====
set.seed(123)
rnorm(1)
rnorm(1)
