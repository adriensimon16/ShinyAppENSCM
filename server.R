#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

data<-read.csv2("E_Tous_Anonymat.csv",header=FALSE, stringsAsFactors=FALSE, fileEncoding="latin1")

colnames(data) = data[1,]

data<-data[2:length(data[,1]),]
data[,3]<-as.numeric(data[,3])
data[,70]<-as.numeric(data[,70])

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- as.numeric(data[,65])

        # draw the histogram with the specified number of bins
        hist(x, col = 'darkgray', border = 'white',
             xlab = 'sex',
             main = 'Histogram of the repartition of Sex')

    })

})
