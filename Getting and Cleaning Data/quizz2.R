# Ian Castillo Rosales
# Getting and Cleaning Data
# 20072014

# Pregunta 1
library(httr)
require(httpuv)
require(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("quiz2", "041fe7d5df66f8834c1b", secret="85ab3505e732f175f8f4369367ee4db1abdbe4a6")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
output <- content(req)

list(output[[5]]$name, output[[5]]$creat)

# Pregunta 4

conexion <- url("http://biostat.jhsph.edu/~jleek/contact.html")
HTMLCode <- readLines(conexion)
close(conexion)

class(HTMLCode)
head(HTMLCode)

nchar(HTMLCode[10])
nchar(HTMLCode[20])
nchar(HTMLCode[30])
nchar(HTMLCode[100])

# Pregunta 5

con <- url("http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
data_fwf <- read.fwf(file=con, skip=4, widths=c(11,8,4,9,4,9,4,9,4))
close(con)

sum(data_fwf[, 4])
