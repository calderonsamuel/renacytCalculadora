#' asesoria UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_asesoria_ui <- function(id) {
    ns <- NS(id)
    tagList(
        shiny::tags$h4("F. Haber asesorado o co-asesorado tesis sustentadas y aprobadas"),
        shiny::numericInput(ns("doctor"), "Para obtención de grado Doctor", value = 0, min = 0),
        shiny::numericInput(ns("magister"), "Para obtención de grado Magister", value = 0, min = 0),
        shiny::numericInput(ns("bachiller"), "Para obtención de grado Bachiller o Título profesional", value = 0, min = 0)
    )
}

#' asesoria Server Functions
#'
#' @noRd
mod_asesoria_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        ns <- session$ns
        
        list(
            puntaje_asesoria = shiny::reactive(
                renacytPuntajes::get_puntaje_asesoria(
                    n_doct = input$doctor,
                    n_mag = input$magister,
                    n_bach = input$bachiller
                )
            )
        )
        
    })
}

## To be copied in the UI
# mod_asesoria_ui("asesoria_1")

## To be copied in the server
# mod_asesoria_server("asesoria_1")
