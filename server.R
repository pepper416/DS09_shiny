library(shiny)



mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")

mydata$rank <- factor(mydata$rank)
mylogit <- glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")
mydata$gpa_group = cut(mydata$gpa, breaks = c(2,2.5,3,3.5,4))


shinyServer(function(input,output){
#     variableInput <- reactive({
#         switch(input$variable,
#                "GPA" = "gpa",
#                "GRE" = "gre")
#     })
   
#     output$histogram <- renderPlot({
#         x    <- mydata[[variableInput()]]
#         bins <- seq(min(x), max(x), length.out = input$bins + 1)
#         # draw the histogram with the specified number of bins
#         hist(x, breaks = bins, col = 'darkgray', border = 'white', main = paste("Histogram of ", toupper(variableInput()),sep=""))
#     })
    
        colorInput <- reactive({
            switch(input$color,
                   "Red" = "red",
                   "Green" = "green",
                   "Blue" = "blue")
        })
    
    output$boxplot <- renderPlot({
        boxplot(gre~gpa_group, mydata[1:input$nobs,], main = "boxplot of GRE vs GPA",
                xlab = "GPA", ylab = "GRE", col = colorInput())
    })  
    
    output$Result <- renderPrint({
        pred = predict(mylogit,newdata=list(gre=as.numeric(input$gre),gpa=as.numeric(input$gpa),rank=factor(input$rank)),
                interval=("confidence"), 
#                 level=as.number(input$confint),
                type = "link", se = TRUE)
        PredictedProb <- plogis(pred$fit)
        LL <- plogis(pred$fit - (1.96 * pred$se.fit))
        UL <- plogis(pred$fit + (1.96 * pred$se.fit))
        data.frame(GRE = as.numeric(input$gre),GPA=as.numeric(input$gpa),Rank=factor(input$rank),
                    Predicted_Probability = round(PredictedProb,2))
        
        })
})