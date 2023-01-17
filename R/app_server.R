#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
    formacion <- mod_formacion_server("formacion")
    produccion <- mod_produccion_server("produccion")
    asesoria <- mod_asesoria_server("asesoria")
    
    puntajes <- list(
        puntaje_formacion = formacion$puntaje_formacion,
        puntaje_produccion = produccion$puntaje_produccion,
        puntaje_asesoria = asesoria$puntaje_asesoria,
        indice_h = produccion$indice_h
    )
    
    mod_resumen_server("resumen", puntajes = puntajes)
    
}
