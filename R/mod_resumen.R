#' resumen UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_resumen_ui <- function(id) {
    ns <- NS(id)
    tagList(
        shiny::tags$h2("Puntaje obtenido"),
        shiny::tableOutput(ns("resultados")),
        shiny::tags$h2("Calificación"),
        shiny::textOutput(ns("calificacion")),
        shiny::tags$p("Considerar que para que el registro prospere se requiere al menos un item de producción en los últimos tres años")
    )
}

#' resumen Server Functions
#'
#' @noRd
mod_resumen_server <- function(id, puntajes) {
    moduleServer(id, function(input, output, session) {
        ns <- session$ns
        
        puntaje_total <- shiny::reactive(
            renacytPuntajes::get_puntaje_total(
                puntaje_formacion = puntajes$puntaje_formacion(),
                puntaje_produccion = puntajes$puntaje_produccion(),
                puntaje_asesoria = puntajes$puntaje_asesoria()
            )
        )
        
        data_resultados <- shiny::reactive({
            
            dplyr::tribble(
                ~"Criterio", ~"Puntaje",
                "Formación", puntajes$puntaje_formacion(),
                "Producción total", puntajes$puntaje_produccion(),
                "Asesoría", puntajes$puntaje_asesoria(),
                "Total", puntaje_total()
            )
        })
        
        calificacion <- shiny::reactive({
            renacytPuntajes::get_calificacion(
                puntaje_produccion = puntajes$puntaje_produccion(),
                puntaje_formacion = puntajes$puntaje_formacion(),
                puntaje_asesoria = puntajes$puntaje_asesoria(),
                # puntaje_total = puntaje_total(),
                indice_h = puntajes$indice_h()
            )
        })
        
        output$resultados <- shiny::renderTable({
            data_resultados() #|> 
                # flextable::flextable() |> 
                # flextable::theme_box()  |> 
                # flextable::set_table_properties(layout = "autofit") |> 
                # flextable::htmltools_value()
        })
        
        output$calificacion <- shiny::renderText(calificacion())
        
    })
}

## To be copied in the UI
# mod_resumen_ui("resumen_1")

## To be copied in the server
# mod_resumen_server("resumen_1")
