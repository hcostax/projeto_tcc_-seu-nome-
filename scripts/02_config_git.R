

# https://beatrizmilz.github.io/RLadies-Git-RStudio-2019/#1

# siga o tutorial do link acima. abaixo tem um exemplo de como executei



# ---
# --- Estabelecendo conexao entre Git, Github e RStudio:

# install.packages("usethis")
library(usethis)


usethis::use_git_config(
  user.name = "hcostax",                 # Seu usuario
  user.email = "henrique@outlook.sg")    # Seu email



usethis::create_github_token()           # Configure o Personal Access Token

usethis::edit_r_environ()                # gravar as credenciais
                                         # GITHUB_PAT="0000000000000000000000000000000000000000"

usethis::git_sitrep()                    # Checando se a configuração deu certo


usethis::use_git()



