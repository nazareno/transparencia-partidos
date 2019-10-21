
import_data <- function(){
    library(tidyverse)
    d = readr::read_csv2(here::here("data/despesa_anual_2018_PB.csv"), locale = locale(encoding = "latin1"), 
                         col_types = cols(
                             .default = col_character(),
                             HH_GERACAO = col_time(format = ""),
                             DT_PAGAMENTO = col_date(format = "%d/%m/%Y"),
                             VR_GASTO = col_double(),
                             VR_PAGAMENTO = col_double(),
                             VR_DOCUMENTO = col_double()
                         )) %>%
        filter(!grepl(" FUNDO ESPECIAL DE FINANCIAMENTO DE CAMPANHA", DS_GASTO), 
               !grepl("ELEITORAIS", DS_GASTO)) %>% 
        mutate(DS_GASTO_CONCAT = DS_GASTO) %>% 
        separate(
            DS_GASTO,
            into = c(
                "DS_GASTO_NIVEL1",
                "DS_GASTO_NIVEL2",
                "DS_GASTO_NIVEL3",
                "DS_GASTO_NIVEL4"
            ),
            sep = "- "
        )
    d %>% write_csv(here::here("data/despesas_2018_fundo-partidario_PB.csv"))
}

read_projectdata <- function(){
    readr::read_csv(here::here("data/despesas_2018_fundo-partidario_PB.csv"), 
                    col_types = cols(
                        .default = col_character(),
                        HH_GERACAO = col_time(format = ""),
                        DT_PAGAMENTO = col_date(),
                        VR_GASTO = col_double(),
                        VR_PAGAMENTO = col_double(),
                        VR_DOCUMENTO = col_double()
                    ) )
}
