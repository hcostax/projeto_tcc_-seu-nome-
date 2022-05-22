

# install packages (if not installed)
install.packages(c("devtools",
                   "DBI",
                   "tidyverse",
                   "tidyquant",
                   "dbplyr",
                   "RSQLite",
                   "here"))


# ---
# --- pacotes necssarios 
library(DBI)
library(dbplyr)
library(tidyverse)
library(tidyquant)
library(RSQLite)
library(here)



# ---
# --- baixando dados do ibovespa para usar de exemplo:

ibov <- 
  tq_get(
    "^BVSP", 
    get = "stock.prices", 
    from = "2000-01-01", 
    to = Sys.Date() - 1
  ) %>% tibble()


tail(ibov)
glimpse(ibov)



# ---
# --- Exportando dados do R para o SQLite

# usando a funcao here() do pacote here
# essa funcao nos ajuda a especificar os
# locais de trabalho, facilitando o workflow

# criando a base 
db.sqlite <-  
  here::here(
    "dados",
    "database",       # pasta onde sera salvo      
   "db.ibov.SQLITE"   # o nome que o arquivo, sempre
  )                   # espeficicando a extensao .SQLITE
  

# abrindo a concexao com o sqlite
my_con <- dbConnect(drv = SQLite(), db.sqlite)

# escrevendo/gravando/salvando o dataframe em formato sqlite
dbWriteTable(
  conn = my_con,        # sua conexao my_con
  name = 'ibov',   # escolha o nome para a tabela, ex: 'MyDB.Ibov'
  value = tibble::as_tibble(ibov)          # data frame que ira salvar na tabela
  )

# desconectando
dbDisconnect(my_con)




# --- 
# --- abrindo a base em arquivo .SQLITE


# Buscando o arquivo SQLITE para ler a tabela
My.db.sqlite <-         # nome do dataframe, ex: My.db.sqlite
  here::here(
    "dados",
    "database",         # local onde esta a base de dados salva
    "db.ibov.SQLITE"    # base de dados que sera lida
  )

# abrindo a conexao com o sqlite
my_con <- dbConnect(
  drv = SQLite(),       # chamando o sqlite
  My.db.sqlite          # local da base a ser lida
  )

# para ver as tabelas existentes em sua base
dbListTables(my_con)

# fazendo a leitura da tabela
my_df <- DBI::dbReadTable(
  conn = my_con,
  name = dbListTables(my_con)   # nome da tabela em sqlite  
  ) 


# funcao para ver as colunas/variaveis de sua tabela
dbListFields(
  my_con,
  dbListTables(my_con)
  )


# ou pode usar a funcao glimpse() para ver a estrutura da tabela
glimpse(my_df)


my_df <- my_df %>% 
  mutate(date = as.Date(date))


glimpse(my_df)

# disconnect
dbDisconnect(my_con)








