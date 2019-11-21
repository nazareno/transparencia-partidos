
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


unwanted_array = list(    'Š'='S', 'š'='s', 'Ž'='Z', 'ž'='z', 'À'='A', 'Á'='A', 'Â'='A', 'Ã'='A', 'Ä'='A', 'Å'='A', 'Æ'='A', 'Ç'='C', 'È'='E', 'É'='E',
                          'Ê'='E', 'Ë'='E', 'Ì'='I', 'Í'='I', 'Î'='I', 'Ï'='I', 'Ñ'='N', 'Ò'='O', 'Ó'='O', 'Ô'='O', 'Õ'='O', 'Ö'='O', 'Ø'='O', 'Ù'='U',
                          'Ú'='U', 'Û'='U', 'Ü'='U', 'Ý'='Y', 'Þ'='B', 'ß'='Ss', 'à'='a', 'á'='a', 'â'='a', 'ã'='a', 'ä'='a', 'å'='a', 'æ'='a', 'ç'='c',
                          'è'='e', 'é'='e', 'ê'='e', 'ë'='e', 'ì'='i', 'í'='i', 'î'='i', 'ï'='i', 'ð'='o', 'ñ'='n', 'ò'='o', 'ó'='o', 'ô'='o', 'õ'='o',
                          'ö'='o', 'ø'='o', 'ù'='u', 'ú'='u', 'û'='u', 'ý'='y', 'ý'='y', 'þ'='b', 'ÿ'='y' )

lower_ascii <- function(s){
    chartr(paste(names(unwanted_array), collapse=''),
           paste(unwanted_array, collapse=''),
           str_to_lower(s))
}

read_dados_issa2018 <- function(){
    r <- function(f){
        read_csv2(here::here("data/categorias/", f), col_types = "c") %>% pull(1) %>% str_trim()
    }
    rt <- function(f){
        read_csv2(here::here("data/categorias/", f), col_types = "c") %>% names() %>% str_trim()
    }
    recategoriza <- function(df, f) {
        df %>%
            mutate(categoria = if_else(
                ds_gasto_match %in% lower_ascii(r(f)),
                rt(f),
                categoria
            ))
    }
    
    d = read_csv2(here::here("data/raw/SPCA 2018.csv"),
              locale = locale(encoding = "latin1"), 
              col_types = "ccccc") %>%
        mutate(
            valor = stringr::str_replace_all(VR_GASTO, "R\\$ |\\.", "") %>% str_replace(",", ".") %>% as.double(),
            DS_GASTO = str_to_title(DS_GASTO),
            categoria = NA_character_,
            ds_gasto_match = lower_ascii(DS_GASTO) %>% str_trim()
        ) 
    
    for (i in 1:51) {
        d = d %>% recategoriza(paste0("categoria-", i, ".txt"))
    }
    
    # TODO -> Por que essa categoria dá errado? 
    d = d %>% mutate(categoria = if_else(is.na(categoria) & 
                                             str_starts(DS_GASTO, "Despesas Gerais - Mensalidades, Anuidades E Congêneres Devidos A Organismos Partidários Internacionais"),
                                         "Mensalidades para organismos internacionais", categoria))
    
    d = d %>% mutate(categoria = if_else(is.na(categoria), "Não categorizadas", categoria))
    
    return(d)
}
