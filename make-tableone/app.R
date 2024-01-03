#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tableone)
library(data.table)
library(rio)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            fileInput(
                "file1",
                "choose CSV File",
                accept = ".csv"), 
            checkboxInput("header", "Header", TRUE)
        ),
        mainPanel(
            tableOutput("contents")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$contents <- renderTable({
        # generate bins based on input$bins from ui.R
        file    <- input$file1
        ext <- tools::file_ext(file$datapath)

        req(file)
        validate(need(ext == "csv", "Please upload a csv file"))

        # draw the histogram with the specified number of bins
        rio::import(file$datapath, heaer = input$header) 
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
