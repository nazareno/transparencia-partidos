
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

import_data_br <- function(){
    library(tidyverse)
    d = readr::read_csv2(here::here("../partidos-tse/data-2018/despesa_anual_2018_BRASIL.csv"), locale = locale(encoding = "latin1"), 
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
    d %>% write_csv(here::here("data/despesas_2018_fundo-partidario_BRASIL.csv"))
}

import_data_1718pb <- function(){
    library(tidyverse)
    d = readr::read_csv2(here::here("../partidos-tse/data-2018/despesa_anual_2018_PB.csv"), locale = locale(encoding = "latin1"), 
                         col_types = cols(
                             .default = col_character(),
                             HH_GERACAO = col_time(format = ""),
                             DT_PAGAMENTO = col_date(format = "%d/%m/%Y"),
                             VR_GASTO = col_double(),
                             VR_PAGAMENTO = col_double(),
                             VR_DOCUMENTO = col_double()
                         )) %>%
        bind_rows(readr::read_csv2(here::here("../partidos-tse/data-2017/despesa_anual_2017_PB.csv"), locale = locale(encoding = "latin1"), 
                                   col_types = cols(
                                       .default = col_character(),
                                       HH_GERACAO = col_time(format = ""),
                                       DT_PAGAMENTO = col_date(format = "%d/%m/%Y"),
                                       VR_GASTO = col_double(),
                                       VR_PAGAMENTO = col_double(),
                                       VR_DOCUMENTO = col_double()
                                   ))) %>% 
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
    d %>% write_csv(here::here("data/despesas_17-18_fundo-partidario_PB.csv"))
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

read_dados_issa2018 <- function(){
    r <- function(f){
        read_csv(here::here("data/categorias/", f)) %>% pull(1) 
    }
    rt <- function(f){
        read_csv(here::here("data/categorias/", f)) %>% names()
    }
    read_csv2(here::here("data/raw/SPCA 2018.csv"),
              locale = locale(encoding = "latin1"), 
              col_types = "ccccc") %>%
        mutate(
            valor = stringr::str_replace_all(VR_GASTO, "R\\$ |\\.", "") %>% str_replace(",", ".") %>% as.double(),
            DS_GASTO = str_to_title(DS_GASTO)
        ) %>% 
        mutate(categoria = case_when(
            DS_GASTO %in% c("Despesas Com Publicidade Por Adesivos - Eleitorais") ~ "Adesivos",
            DS_GASTO %in% c("Ativo Permanente - Bens Imóveis - Edificações", 
                            "Ativo Permanente - Bens Imóveis - Instalações",
                            "Ativo Permanente - Bens Imóveis - Outros Bens Imóveis") ~ "Aquisição e edificação de imóveis",
            DS_GASTO %in% c("Transportes E Viagens - Combustíveis, Óleos E Lubrificantes - Despesas Eleitorais",  
                            "Transportes E Viagens - Combustíveis, Óleos E Lubrificantes - Mulheres",
                            "Transportes E Viagens - Combustíveis, Óleos E Lubrificantes - Ordinárias"
            ) ~ "Combustível",
            DS_GASTO %in% c("Comícios E Militância De Rua - Despesas Eleitorais",
                            "Despesas Com Publicidade Por Carros De Som - Eleitorais"
            ) ~ "Comícios, carros de som e militância de rua",
            DS_GASTO %in% c("Congressos - Mulheres", 
                            "Congressos - Ordinárias",  
                            "Convenções - Mulheres", 
                            "Convenções Eleitorais - Despesas Eleitorais",  
                            "Convenções Partidárias - Ordinárias", 
                            "Despesas Com Convenções Partidárias - Eleitorais",  
                            "Despesas Com Eventos De Promoção De Candidaturas - Eleitorai",
                            "Eventos Promocionais - Despesas Eleitorais ", 
                            "Eventos Promocionais - Mulheres", 
                            "Eventos Promocionais - Ordinárias",  
                            "Instalação De Comitês Financeiros E De Campanha - Despesas Eleitorais", 
                            "Seminários - Mulheres",  
                            "Seminários - Ordinárias"
            ) ~ "Congressos, convenções, seminários e eventos",
            DS_GASTO %in% c("Serviços Técnico-profissionais - Serviços De Consultoria Jurídica - Despesas Eleitorais") ~ "Consultoria jurídica - eleitoral",
            DS_GASTO %in% c(r("uma")~ rt("uma")) %>% names(),
            DS_GASTO %in% c() ~ "",
            DS_GASTO %in% c() ~ "",
            DS_GASTO %in% c() ~ "",
        ))
}
