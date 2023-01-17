#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import bslib
#' @import fontawesome
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),

    # Your application UI logic
    bslib::page_fluid(
        title = "Calculadora RENACYT",
        theme = bs_theme(version = 5, bootswatch = "sandstone"),
        layout_column_wrap(
            width = NULL,
            style = htmltools::css(grid_template_columns = "1fr 2fr"),
            heights_equal = "row",
            fill = FALSE,

            card(
                class = "border-light",
                accordion(
                    accordion_item(
                        start_open = TRUE,
                        accordion_header(
                            h1("Calculadora RENACYT")
                        ),
                        accordion_body(

                        )
                    ),
                    accordion_item(
                        accordion_header(
                            span(fa("fas fa-user-graduate"), "Formación")
                        ),
                        accordion_body(
                            mod_formacion_ui("formacion")
                        )
                    ),
                    accordion_item(
                        accordion_header(
                            span(fa("fas fa-book"), "Producción")
                        ),
                        accordion_body(
                            mod_produccion_ui("produccion")
                        )
                    ),
                    accordion_item(
                        accordion_header(
                            span(fa("fas fa-user-group"), "Asesoría")
                        ),
                        accordion_body(
                            mod_asesoria_ui("asesoria")
                        )
                    ),
                    accordion_item(
                        accordion_header(
                            span(fa("fas fa-circle-info"), "Info / Reporta errores")
                        ),
                        accordion_body(

                        )
                    )
                )
            ),
            layout_column_wrap(
                width = 1,
                fill = FALSE,
                mod_resumen_ui("resumen")

            )
        )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "Calculadora RENACYT"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
