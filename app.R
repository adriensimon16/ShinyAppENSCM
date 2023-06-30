
library(shiny)
library(data.table)
library(RColorBrewer)
library(ggplot2)

data<- read.csv2("https://raw.githubusercontent.com/adriensimon16/ShinyAppENSCM/main/Enquete_tous.csv",sep = ",",header=FALSE, stringsAsFactors=FALSE, fileEncoding="UTF-8")
datab<- read.csv2("https://raw.githubusercontent.com/adriensimon16/ShinyAppENSCM/main/E_Tous_Anonymat.csv",header=FALSE, stringsAsFactors=FALSE, fileEncoding="latin1")

colnames(data) = data[1,]
colnames(datab) = datab[1,]
data<-data[2:length(data[,1]),]
data[,3]<-as.numeric(data[,3])
data[,65]<-as.numeric(data[,65])

data<-data.table(data)
data<-replace(data, data=="",NA)



ui<-navbarPage("MyApp", tabPanel("univarié",
                                 
                                 fluidPage(
                                   
                                   headerPanel("Data Visualization"),
                                   
                                   sidebarPanel(
                                     selectInput("year", "Graduation year", names(table(data$`14. AnneeDiplomeVerifieParLeDiplome`))),
                                     selectInput("variable", "Variable of interest",choices = names(data[,c(2,4,6,8,10,12,13,15,16,27,30,32,52,66,67)]) ),
                                     
                                     numericInput("plus", "Number of years after graduation", value = 1, min = 1, max = 2, step = 1)
                                   ),
                                   
                                   mainPanel(
                                     plotOutput("plot1"),
                                     textOutput("text")
                                   )
                                 )
),
tabPanel("Multivarié",
         fluidPage(headerPanel("Data Visualization"),
                   textOutput("textM"),
                   plotOutput("plot2"),
                   selectInput("variable3", "Y axis Variable of interest",choices = names(data[,c(4,2,6,8,10,12,13,15,16,27,30,32,66,67)]) ),
                   selectInput("variable2", "X axis Variable of interest",choices = names(data[,c(2,66,67)]) ),
                   selectInput("year1", "Graduation year", names(table(data$`14. AnneeDiplomeVerifieParLeDiplome`))),
                   numericInput("plus1", "Number of years after graduation", value = 1, min = 1, max = 2, step = 1)
                   
                   
         )      
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
    barplot(height = table(Y), space = 1, ylim = c(0,(max(table(Y))*1.5)), ylab = "Number of alumni",col = brewer.pal(n=length(table(Y)), "RdYlBu"),
            , xlab = "Variable modalities")
    box()
  })
  output$text<-renderText({paste("Proportion of repondents in regards to the size of the promotion :", signif(nrow(data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year) & data$`249. AnneeEnquete`==as.numeric(input$year)+(input$plus),])/as.numeric(data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year) & data$`249. AnneeEnquete`==as.numeric(input$year)+(input$plus),][1,58]),digits = 4),"Total size of the promotion", data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year),58][1], "number of respondants :", nrow(data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year) & data$`249. AnneeEnquete`==as.numeric(input$year)+(input$plus),]) )
    
  })
  output$textM<-renderText({paste("Proportion of repondents in regards to the size of the promotion :", nrow(data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year) & data$`249. AnneeEnquete`==as.numeric(input$year)+(input$plus),])/as.numeric(data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year) & data$`249. AnneeEnquete`==as.numeric(input$year)+(input$plus),][1,58]))
    
  })
  output$plot2 <- renderPlot({
    data1<- data[data$`14. AnneeDiplomeVerifieParLeDiplome`==as.numeric(input$year1) & data$`249. AnneeEnquete`==as.numeric(input$year1)+(input$plus1),]
    print(
      ggplot(data = data1,aes(x= get(input$variable2, pos = data1),y= get(input$variable3, pos = data1)  ))+
        geom_count()+
        theme_bw()
    )
  })
  
}


shinyApp(ui, server)

