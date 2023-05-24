ui<-fluidPage(
  
  headerPanel("Presentation of the variables"),
  
  sidebarPanel(
    selectInput("year", "Graduation year", names(table(data$`14. AnneeDiplomeVerifieParLeDiplome`))),
    selectInput("variable", "Variable of interest",choices = names(data[,c(2,4,71)]) )
  ),
  
  mainPanel(
    plotOutput("plot1")
  )
)


server<-function(input, output){
  
  formulaText <- reactive({
    paste("Pick a variable ~", input$variable)
  })
  output$caption <- renderText({
    formulaText()
  })
  #c'est le barplot qui pose problème, probablement le table sur Y<- reactive ... chercher des infos sur reactive
  output$plot1 <- renderPlot({
    data1<- data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year) & data$`249. AnneeEnquete`==as.numeric(input$year)+1,] 
    Y<- get(input$variable, pos = data1) 
    barplot(height = table(Y), legend.text = names(table(Y)), space = 1, ylim = c(0,110))
    box()
  })
  
  
  
}


shinyApp(ui, server)