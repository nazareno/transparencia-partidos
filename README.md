# Prestação de contas dos partidos políticos brasileiros

Dados vindos do TSE.

### Da documentação original

- Campos preenchidos com #NULO significam que a informação está em branco no banco de
  dados. O correspondente para #NULO nos campos numéricos é -1;
- Campos preenchidos com #NE significam que naquele ano a informação não era registrada
  em banco de dados pelos sistemas eleitorais. O correspondente para #NE nos campos numéricos é -3;
- O campo UF, alem das unidades da federação pode conter alguma das seguintes situações:
  - BR: quando se tratar de informação a nivel nacional;
  - VT: quando se tratar de voto em transito; 

| Variável | Descrição |
| --- | --- |
| DT\_GERACAO | Data de geração das informações (data da extração dos dados). |
| HH\_GERACAO | Hora de geração das informações (hora da extração dos dados) - Horário de Brasília. |
| CD\_TP\_ESFERA\_PARTIDARIA | Código do tipo de esfera partidária do prestador de contas, podendo assumir os valores: '0', '1', '2', '3' e '4'. |
| DS\_TP\_ESPERA\_PARTIDARIA | Descrição do tipo de esfera partidária do prestador de contas, podendo assumir os valores: 'Nacional', 'Estadual', 'Distrital', 'Municipal' e 'Zonal'. |
| SG\_UF | Sígla da unidade da federação de abrangência do prestador de contas. |
| CD\_MUNICIPIO | Código do município de abrangência do prestador de contas, quando a esfera partidária for municipal. |
| NM\_MUNICIPIO | Descrição do município de abrangência do prestador de contas, quando a esfera partidária for municipal. |
| NR\_ZONA | Número da zona eleitoral de abrangência do prestador de contas, quando a esfera partidária for zonal. |
| NR\_CNPJ\_PRESTADOR\_CONTA | CNPJ do prestador de contas. |
| SG\_PARTIDO | Sigla do partido prestador de contas. |
| NM\_PARTIDO | Nome do partido prestador de contas. |
| CD\_TP\_DOCUMENTO | Código de identificação do tipo de documento informada pelo prestador de contas em relação à despesa, podendo assumir os valores: '0', '1', '2', '3', '4' e '5'. |
| DS\_TP\_DOCUMENTO | Descrição do tipo de documento informado pelo prestador de contas em relação à despesa, podendo assumir os valores: 'Boleto', 'Contrato', 'Documento fiscal', 'Fatura', 'Outros', e 'Recibo'. |
| NR\_DOCUMENTO | Número do documento de gasto informado pelo prestador de contas em relação à despesa. |
| AA\_AIDF | Ano do AIDF (Autorização para Impressão de Documentos Fiscais) informado pelo prestador de contas em relação à despesa. É exigivel apenas quanto o tipo for nota fiscal. |
| NR\_AIDF | Número do AIDF (Autorização para Impressão de Documentos Fiscais) informado pelo prestador de contas em relação à despesa. |
| CD\_TP\_FORNECEDOR | Código de identificação do tipo de fornecedor informada pelo prestador de contas em relação à despesa.  |
| DS\_TP\_FORNECEDOR | Descrição do tipo de fornecedor informada pelo prestador de contas em relação à despesa, podendo assumir os valores: 'Pessoa Fisica' ou 'Pessoa Juridica'. |
| NR\_CPF\_CNPJ\_FORNECEDOR | CPF/CNPJ do fornecedor de bens e/ou serviços informada pelo prestador de contas em relação à despesa. |
| NM\_FORNECEDOR | Nome do fornecedor de bens e/ou serviços informada pelo prestador de contas em relação à despesa. |
| DS\_GASTO | Descrição do gasto no elenco de aplicações informada pelo prestador de contas em relação à despesa. No caso de incidencia de juros e/ou multas conterá o texto "DESPESAS FINANCEIRAS - OUTRAS DESPESAS FINANCEIRAS (Juros e Multas)". No caso de incidência de perda em aplicação financeira conterá o texto "DESPESAS FINANCEIRAS - OUTRAS DESPESAS FINANCEIRAS (Aplicações Financeiras)". |
| DT\_PAGAMENTO | Data do pagamento da despesa informada pelo prestador de contas em relação à despesa. |
| VR\_GASTO | Valor da despesa em Reais (R$), informada pelo prestador de contas em relação à despesa. |
| VR\_PAGAMENTO | Valor do pagamento da despesa em Reais (R$), informada pelo prestador de contas em relação à despesa. |
| VR\_DOCUMENTO | Valor do documento hábil a comprovar a despesa em Reais (R$), informada pelo prestador de contas em relação à despesa. A informação, com o mesmo valor, poderá ser representada mais de uma vez por linha a fim de representar o valor total da despesa contratada detalhada nos campos "Descrição da despesa" e "Valor da despesa", portando esse valor já se refere ao valor total contratado, não devendo ser somado.  |
