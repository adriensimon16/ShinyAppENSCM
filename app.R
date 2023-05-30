
library(shiny)
library(data.table)
library(RColorBrewer)

data<- read.csv2("https://raw.githubusercontent.com/adriensimon16/ShinyAppENSCM/main/E_Tous_Anonymat.csv",header=FALSE, stringsAsFactors=FALSE, fileEncoding="latin1")
colnames(data) = data[1,]

data<-data[2:length(data[,1]),]
data[,3]<-as.numeric(data[,3])
data[,70]<-as.numeric(data[,70])

data<-data.table(data)


ui<-fluidPage(
  
  headerPanel(""),
  
  sidebarPanel(
    selectInput("year", "Graduation year", names(table(data$`14. AnneeDiplomeVerifieParLeDiplome`))),
    selectInput("variable", "Variable of interest",choices = names(data[,c(2,4,71)]) ),
    numericInput("plus", "Number of years after graduation", value = 1, min = 1, max = 2, step = 1)
  ),
  
  mainPanel(
    plotOutput("plot1"),
    textOutput("text")
  )
)


server<-function(input, output){
  
  formulaText <- reactive({
    paste("Pick a variable ~", input$variable)
  })
  output$caption <- renderText({
    formulaText()
  })
  output$plot1 <- renderPlot({
    data1<- data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year) & data$`249. AnneeEnquete`==as.numeric(input$year)+(input$plus),] 
    Y<- get(input$variable, pos = data1) 
    barplot(height = table(Y), legend.text = names(table(Y)), space = 1, ylim = c(0,110),col = brewer.pal(length(table(Y)), "Blues"), ylab = "Number of alumni"
            , xlab = "Variable modalities")
    box()
  })
  output$text<-renderText({paste("Proportion of repondents in regards to the size of the promotion :", nrow(data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year) & data$`249. AnneeEnquete`==as.numeric(input$year)+(input$plus),])/as.numeric(data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year) & data$`249. AnneeEnquete`==as.numeric(input$year)+(input$plus),][1,63]))
    
  })
  
  
  
}


shinyApp(ui, server)