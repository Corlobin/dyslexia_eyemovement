library(saccades)

rm(list=ls())

path = "C:\\Users\\Ricardo\\Google Drive\\Mestrado IFES\\Dislexia Movimentos Oculares\\dyslexia_eyemovement\\Recording Data"
setwd(path)

pessoas <- list.files(path = path, pattern = NULL, all.files = FALSE,
           full.names = FALSE, recursive = FALSE,
           ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)


for (i in 1:length(pessoas)) { 
  nome_arquivo <- paste(path, "\\", sep="")
  nome_arquivo <- paste(nome_arquivo, pessoas[i],sep="")
  arquivos <- list.files(path = nome_arquivo)
  for (j in 1:length(arquivos)) {
    caminho_completo <- paste(nome_arquivo, "\\", sep="")
    caminho_completo <- paste(caminho_completo, arquivos[j], sep="")
    dados_movimentos <- read.delim2(caminho_completo, header = TRUE, sep = "\t", dec = ",")
    dados_movimentos$trial = c(1)
    
    dados_right = subset(dados_movimentos, select = c("RX", "RY", "trial", "T"))
    names(dados_right) <- c("x", "y", "trial", "time")
    fixations_right = detect.fixations(dados_right)
    
    
    dados_left  = subset(dados_movimentos, select = c("LX", "LY", "trial", "T"))
    names(dados_left) <- c("x", "y", "trial", "time")
    fixations_left = detect.fixations(dados_right)
    diagnostic.plot(dados_left, fixations_left)    

  }
}

