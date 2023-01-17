#' formacion UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_formacion_ui <- function(id) {
    ns <- NS(id)
    tagList(
        # shiny::tags$h4("A. Grado académico (registrado en SUNEDU o MINEDU)"),
        shiny::selectInput(
            width = "100%",
            inputId = ns("grado"),
            label = "Grado académico (registrado en SUNEDU o MINEDU)",
            choices = c(
                "Doctor",
                "Magister",
                "Título profesional",
                "Bachiller o egresado",
                "Constancia de matrícula (Estudiante)",
                "Ninguno"
            ),
            selected = "Ninguno"
        )
    )
}

#' formacion Server Functions
#'
#' @noRd
mod_formacion_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        ns <- session$ns

        list(
            grado = shiny::reactive(input$grado),
            puntaje_formacion = shiny::reactive(
                renacytPuntajes::get_puntaje_formacion(input$grado)
            )
        )
    })
}

## To be copied in the UI
# mod_formacion_ui("formacion_1")

## To be copied in the server
# mod_formacion_server("formacion_1")
