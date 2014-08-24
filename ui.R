shinyUI(pageWithSidebar(
    headerPanel("Predict the probability of being admitted to graduate school, by using logistic regression"),
    sidebarPanel(
        textInput(inputId="gpa",label="GPA (0 to 4)"),
        textInput(inputId="gre",label="GRE (0 to 1600)"),
        
        radioButtons("rank","prestige of the undergraduate institution (1 = highest prestige)",
                     list("1"="1","2"="2","3"="3","4"="4")),
        
#         selectInput("variable", "Choose a variable (GPA or GRE) to plot a histograme", 
#             choices = c("GPA", "GRE")),

        selectInput("color", "Choose a color for the boxplot", 
            choices = c("Red", "Green", "Blue")),
        sliderInput("nobs", "Number of observations", min = 200,  max = 400, step = 20, value = 400),

#         sliderInput("bins", "Number of bins in the histogram", min = 1,  max = 50, value = 30),
        submitButton('Submit')
    ),
    mainPanel(
        h3('Instructions'),
        "A researcher is interested in how variables, such as GRE (Graduate Record Exam scores),
        GPA (grade point average) and prestige of the undergraduate institution, effect admission
        into graduate school. The response variable, admit/don't admit, is a binary variable.
        Therefore, a logistic regression can be used to predict the probability of being admitted.",
        
        "This app helps you to predict the probability of being admitted to graduate school by 
        changing the values in the panel to the left.",
        
        "A boxplot of GRE score by GPA is also included. You can change the color of the boxplot 
        and the number of observations to conduct the boxplot.",
        
        h3("results"),
        
        tabsetPanel(
            tabPanel("Predicted log odds",verbatimTextOutput("Result")),
            tabPanel("Boxplot of GRE vs GPA",plotOutput("boxplot"))        
        )
    )
))