# Repo Reports

Serviço que recupera issues de um determinado repositório no GitHub e retorna um JSON via webhook com as issues e contribuidores que existem no projeto no momento da chamada.

## Como utilizar

- No terminal, rode o comando `mix generate_report "<repository_owner>/<repository_title>"`.

- Ou, se preferir, no console da aplicação, execute a função `RepoReports.generate_report("<repository_owner>/<repository_title>")`.

Em ambos os casos o relatório é enviado via webhook em formato JSON ao final da execução seguindo o padrão abaixo:

```
{
   "user": "nome_usuario",
   "repository": "nome_repositorio",
   "issues":[
      ["título", "autoria", ["label"]]
   ],
   "contributors":[
      ["nome", "username", <qtd_de_commits>]
   ]
}
```

## Instalação

- Instale as depencencias com `mix deps.get`.

- Renomeie o arquivo `.env.sample` para `.env` e preencha as variáveis de acordo com seu ambiente de desenvolvimento.
  - Você pode utilizar esse serviço adicionar um token para acesso ao GitHub à variável de ambiente ``. Contudo os [limites de uso sem autenticação](https://docs.github.com/en/rest/overview/rate-limits-for-the-rest-api?apiVersion=2022-11-28#primary-rate-limit-for-unauthenticated-users) são bem baixos comparados ao [uso com token de autenticação](https://docs.github.com/en/rest/overview/rate-limits-for-the-rest-api?apiVersion=2022-11-28#primary-rate-limit-for-authenticated-users). Pessoalmente eu recomendo que você crie um token de autenticação no GitHub caso queira se alongar nos testes

- Rode o comando `source .env` para usar as variáveis de ambiente na sessão atual do terminal.

## Limitações

O serviço busca até 100 entradas de issues e pessoas contribuidoras para o repositório solicitado. Para limitações de uso da API do GitHub, gentileza visitar [a página de limites da API do serviço](https://docs.github.com/en/rest/overview/rate-limits-for-the-rest-api?apiVersion=2022-11-28).

## Desenvolvimento

### Débito técnicos

- Documentação de módulos.
- [Credo](https://github.com/rrrene/credo) para análise sintática.

### Roadmap

- Iterar sobre todas páginas de issues e contributors de cada repositório para fornecer um relatório completo do momento da consulta.
- Transformar o serviço em um serviço web.
- Enviar o relatório via webhook de forma assíncrona.
