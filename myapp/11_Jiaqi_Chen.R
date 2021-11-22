#title: "Homework: Interactive Graphics"
#author: "Jiaqi Chen"

library(shiny)

ui <- fluidPage(
  
  titlePanel("cocktail recipes"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Enter an ingredient."),
      
      textInput("ingredient", h3("Text input"), 
                value = "")
    ),
    
    mainPanel(
      tableOutput("output_table")
    )
  )
)

server <- function(input, output){
  
  output$output_table <- renderTable({
    
    boston_cocktails <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/boston_cocktails.csv')
    
    name_bc <- dplyr::filter(boston_cocktails, ingredient == input$ingredient)
    
    result_table <- NULL
    
    for(i in 1:nrow(name_bc)){
      add_table <- dplyr::filter(boston_cocktails, name == name_bc$name[i])
      result_table <- rbind(result_table, add_table)
    }

    result_table
    
  })
  
}

shinyApp(ui, server)