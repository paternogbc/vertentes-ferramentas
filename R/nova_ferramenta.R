#' Cria a página de uma nova ferramenta no portfólio
#'
#' Gera content/ferramentas/<slug>.md com o cabeçalho preenchido.
#' Depois é só colocar a imagem em static/img/ferramentas/ e ajustar o texto.
#'
#' @param titulo  Nome da ferramenta (aparece no cartão)
#' @param url     Link para abrir a ferramenta
#' @param tipo    "Shiny app", "WebGIS", "Painel", "Script", ...
#' @param status  "producao", "desenvolvimento" ou "prototipo"
#' @param resumo  Uma ou duas frases para o cartão
#' @param autor   Responsável
#' @param acesso  "Equipe", "Público", "Restrito (senha)", ...
#' @param tags    Vetor de palavras-chave
#' @param imagem  Arquivo dentro de static/img/ferramentas/ (png, jpg, svg)
#' @param repo    Link do código-fonte (opcional)
#'
#' @examples
#' nova_ferramenta(
#'   titulo = "Painel de Restauração",
#'   url    = "https://usuario.shinyapps.io/restauracao",
#'   tipo   = "Shiny app",
#'   resumo = "Acompanha as áreas em restauração por núcleo.",
#'   tags   = c("restauração", "monitoramento"),
#'   imagem = "painel-restauracao.png"
#' )
nova_ferramenta <- function(titulo,
                            url,
                            tipo = "Shiny app",
                            status = c("producao", "desenvolvimento", "prototipo"),
                            resumo = "",
                            autor = "",
                            acesso = "Equipe",
                            tags = character(),
                            imagem = "",
                            repo = "") {
  status <- match.arg(status)

  slug <- iconv(titulo, to = "ASCII//TRANSLIT")
  slug <- tolower(gsub("[^A-Za-z0-9]+", "-", slug))
  slug <- gsub("^-|-$", "", slug)

  arquivo <- file.path("content", "ferramentas", paste0(slug, ".md"))
  if (file.exists(arquivo)) stop("Já existe: ", arquivo, call. = FALSE)

  q <- function(x) paste0('"', gsub('"', '\\\\"', x), '"')
  tags_yaml <- if (length(tags)) paste0("[", paste(q(tags), collapse = ", "), "]") else "[]"
  img <- if (nzchar(imagem)) paste0("img/ferramentas/", imagem) else ""

  linhas <- c(
    "---",
    paste0("title: ", q(titulo)),
    paste0("summary: ", q(resumo)),
    paste0("tool_url: ", q(url)),
    paste0("repo_url: ", q(repo)),
    paste0("image: ", q(img)),
    paste0("tipo: ", q(tipo)),
    paste0("status: ", q(status)),
    paste0("acesso: ", q(acesso)),
    paste0("autor: ", q(autor)),
    paste0("date: ", format(Sys.Date())),
    paste0("tags: ", tags_yaml),
    "weight: 50",
    "---",
    "",
    "## Para que serve",
    "",
    "Descreva aqui o objetivo da ferramenta e quem deve usá-la.",
    "",
    "## Fontes de dados",
    "",
    "- ...",
    ""
  )

  dir.create(dirname(arquivo), recursive = TRUE, showWarnings = FALSE)
  writeLines(linhas, arquivo, useBytes = TRUE)
  message("Criado: ", arquivo)
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    rstudioapi::navigateToFile(arquivo)
  }
  invisible(arquivo)
}
