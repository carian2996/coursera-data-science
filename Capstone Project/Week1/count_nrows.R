# Ian Castillo Rosales
# Cuenta el número de filas (no vacias) que posee un archivo (.txt)
# sin necesidad de cargar el archivo. Funciona para Windows.
# 10/07/2015

numrow_windows <- function(path){
	# INPUT
	# path = Ruta del archivo
	# IMPORTANTE: El arhivo del cual se necesitan contar las filas debe estar
	# contenido en el directorio de trabajo.

	# OUTPUT
	# n = El número de lineas (no vacias) que contiene el archivo

	shell_instruction <- paste("findstr /R /N \"^\"", path, "| find /C \":\"")
	n <- shell(shell_instruction, intern = T)
	n <- as.numeric(n)

	if(is.numeric(n)){
    	print("Proceso terminado")
	} else{
    	print("Hubo un error en el proceso")
	}

	n
}