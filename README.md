# Vertentes · Ferramentas

Portfólio das ferramentas (Shiny apps, WebGIS, painéis) do Projeto Vertentes.
Site estático em **Hugo**, gerenciado pelo **blogdown** no RStudio. O tema é próprio
(pasta `layouts/` + `static/css/main.css`), sem dependências externas.

## Primeira vez

1. Abra `vertentes-ferramentas.Rproj` no RStudio.
2. No console:

```r
install.packages("blogdown")
blogdown::install_hugo("0.169.0")   # mesma versão do netlify.toml
blogdown::serve_site()              # pré-visualização no painel Viewer
```

Para parar a pré-visualização: `blogdown::stop_server()`.

## Adicionar uma ferramenta

**Opção A — pelo console:**

```r
nova_ferramenta(
  titulo = "Painel de Restauração",
  url    = "https://usuario.shinyapps.io/restauracao",
  tipo   = "Shiny app",
  status = "producao",
  resumo = "Acompanha as áreas em restauração por núcleo.",
  autor  = "Fulano",
  tags   = c("restauração", "monitoramento"),
  imagem = "painel-restauracao.png"
)
```

**Opção B — à mão:** copie um arquivo de `content/ferramentas/` e edite o cabeçalho.

Depois, salve a captura de tela em `static/img/ferramentas/`.

### Campos do cabeçalho

| Campo      | O que é                                                              |
|------------|----------------------------------------------------------------------|
| `title`    | Nome no cartão                                                       |
| `summary`  | Uma ou duas frases                                                   |
| `tool_url` | Link aberto ao clicar na imagem                                      |
| `repo_url` | Código-fonte (opcional; aparece na página de detalhes)               |
| `image`    | `img/ferramentas/arquivo.png`                                        |
| `tipo`     | Texto livre; vira filtro automaticamente (`Shiny app`, `WebGIS`, …)  |
| `status`   | `producao`, `desenvolvimento` ou `prototipo`                         |
| `acesso`   | Texto livre (`Equipe`, `Público`, `Restrito (senha)`)                |
| `autor`    | Responsável                                                          |
| `date`     | Data da última atualização                                           |
| `tags`     | Lista de temas                                                       |
| `weight`   | Ordem no grid (menor aparece primeiro)                               |

O texto abaixo do cabeçalho (Markdown) aparece na página "Detalhes".

### Imagens

- Proporção **16:10**, idealmente 1280 × 800 px (PNG ou JPG).
- O topo da imagem é o que fica visível se ela for mais alta.

## Personalizar

- **Textos da página inicial:** `content/_index.md`
- **Nome do projeto, rodapé, contato:** `config.yaml` (`params`)
- **Cores e fontes:** variáveis no topo de `static/css/main.css`
- **Estrutura do cartão:** `layouts/partials/card.html`

## Publicar (GitHub + Netlify)

1. Crie um repositório no GitHub e envie o projeto (`usethis::use_git()` e `usethis::use_github()`,
   ou pelo painel Git do RStudio).
2. No Netlify: **Add new site → Import an existing project → GitHub** e selecione o repositório.
   As configurações de build vêm do `netlify.toml`; não é preciso preencher nada.
3. A cada `push`, o Netlify reconstrói o site.

A pasta `public/` não vai para o Git: quem gera o site é o Netlify.

### Privacidade

O site fica acessível a quem tiver o link. `noindex: true` no `config.yaml` apenas pede aos
buscadores que não o indexem. Se o portfólio precisar ser restrito, use a proteção por senha
do Netlify (plano pago) ou mantenha fora dele os links de ferramentas sensíveis.
