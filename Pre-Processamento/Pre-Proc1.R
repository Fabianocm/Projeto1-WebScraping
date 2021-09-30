# Raspagem da Web.

# Pacotes R para Web Scraping
# RCurl
# httr
# XML
# rvest


# Formatando os dados de uma página web
library(rvest)
library(tidyr)
library(rvest)
library("xml2")
library(stringr)


# Extraindo a página web abaixo para você. Agora faça a coleta da tag "table"

webpage <- read_html("http://espn.go.com/nfl/superbowl/history/winners")
webpage

tabela<-html_nodes(webpage, 'table')
class(tabela)
# a classe desse objeto é xml_nodeset que é uma lista.

# Caso queira transformar em texto, use a função:
# texto <- html_text(webpage)

# para colar o objeto colocando espaços use a função:
# paste(texto, collapse = ",")
# texto


# Convertendo o item anterior em um dataframe. PACOTE (rvest)
tab <-html_table(tabela)[[1]]
class(tab)
head(tab)
View(tab)


# Extraindo as duas primeiras linhas e adicione nomes as colunas
tab <- tab[-(1:2), ]
head(tab)
names(tab) <- c("number", "date", "site", "result")
head(tab)
View(tab)




# Convertendo de algarismos romanos para números inteiros
tab$number <- 1:55

Sys.setlocale("LC_TIME", "English")
tab$date <-as.Date(tab$date, "%B. %d, %Y")
head(tab)
View(tab)


# Dividindo as colunas as colunas em 4 colunas
# separate: separa colunas

tab <- separate(tab, result, c("vencedor", "perdedor"), sep = ',', remove = TRUE)
head(tab)
View(tab)



# Inclua mais 2 colunas com o score dos vencedores e perdedores
# Fazendo mais uma divisão nas colunas.
pattern <- "\\d+$"
pattern

# para extrair o padrão, carregue o pacote srtingr, library(stringr),
# caso não tenha carregado.
?str_extract

tab$pontosVencedor <- as.numeric(str_extract(tab$vencedor, pattern))
tab$pontosPerdedor <- as.numeric(str_extract(tab$perdedor, pattern))

tab$vencedor <-gsub(pattern, "", tab$vencedor)
tab$perdedor <-gsub(pattern, "", tab$perdedor)
head(tab)
View(tab)



# Gravando o resultado em um arquivo csv
write.csv(tab, 'superbowl.csv', row.names = F)
write.(tab, 'superbowl.csv', row.names = F)
dir()

# Gravando o resultado em um arquivo xlsx
library(xlsx)
write.xlsx(tab,'superbol.xlsx')
detach()



