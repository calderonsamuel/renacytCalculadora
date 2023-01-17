#' produccion UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_produccion_ui <- function(id) {
    ns <- NS(id)
    tagList(accordion(
        accordion_item(
            accordion_header("Artículos científicos en revistas indizadas"),
            accordion_body(
                shiny::numericInput(
                    inputId = ns("articulos_q1"),
                    label = "Nº de Art. cient. Scopus o Web of Science (Q1 Scimago o JCR)",
                    width = "100%",
                    min = 0,
                    value = 0
                ),
                shiny::numericInput(
                    inputId = ns("articulos_q2"),
                    label = "Nº de Art. cient. Scopus o Web of Science (Q2 Scimago o JCR)",
                    width = "100%",
                    min = 0,
                    value = 0
                ),
                shiny::numericInput(
                    inputId = ns("articulos_q3"),
                    label = "Nº de Art. cient. Scopus o Web of Science (Q3 Scimago o JCR)",
                    width = "100%",
                    min = 0,
                    value = 0
                ),
                shiny::numericInput(
                    inputId = ns("articulos_q4"),
                    label = "Nº de Art. cient. Scopus o Web of Science (Q4 Scimago o JCR)",
                    width = "100%",
                    min = 0,
                    value = 0
                ),
                shiny::numericInput(
                    inputId = ns("conference"),
                    label = "Conference Proceeding (Scopus o WoS)/Scielo",
                    width = "100%",
                    min = 0,
                    value = 0
                )
            )
        ),
        accordion_item(
            accordion_header(
                "Registros de propiedad intelectual, concedidas y registradas en INDECOPI, SCOPUS u otras"
            ),
            accordion_body(
                shiny::numericInput(
                    inputId = ns("patente_invencion"),
                    label = "Patente de invención o Certificado de Obtentor o Paquete Tecnológico",
                    width = "100%",
                    min = 0,
                    value = 0
                ),
                shiny::numericInput(
                    inputId = ns("patente_modelo"),
                    label = "Patente de modelo de utilidad o certificado de derecho de autor por software",
                    width = "100%",
                    min = 0,
                    value = 0
                ),
            )
        ),
        accordion_item(
            accordion_header("Publicaciones de libros y/o capítulos de libro indizados"),
            accordion_body(
                shiny::numericInput(
                    ns("libros"),
                    "Nº de libros",
                    width = "100%",
                    min = 0,
                    value = 0
                ),
                shiny::numericInput(
                    ns("capitulos"),
                    "Nº de capítulos de libro",
                    width = "100%",
                    min = 0,
                    value = 0
                )
            )
        ),
        accordion_item(
            accordion_header("Índice H Scopus"),
            accordion_body(
                shiny::selectInput(
                    ns("indice_h"),
                    "¿Valor del índice H > 10?",
                    width = "100%",
                    choices = c("No", "Sí"),
                    selected = "No"
                )
            )
        )
    ))
}

#' produccion Server Functions
#'
#' @noRd
mod_produccion_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        ns <- session$ns
        
        puntaje_produccion <- shiny::reactive({
            renacytPuntajes::get_puntaje_produccion(
                q1 = input$articulos_q1,
                q2 = input$articulos_q2,
                q3 = input$articulos_q3,
                q4 = input$articulos_q4, 
                conf = input$conference,
                pat_invencion = input$patente_invencion,
                pat_modelo = input$patente_modelo,
                n_libros = input$libros, 
                n_cap = input$capitulos
            )
        })
        
        list(
            puntaje_produccion = shiny::reactive(puntaje_produccion()),
            indice_h = shiny::reactive(input$indice_h)
        )

    })
}

## To be copied in the UI
# mod_produccion_ui("produccion_1")

## To be copied in the server
# mod_produccion_server("produccion_1")
