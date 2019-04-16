dashboardPage(
  skin = HTML("blue"),
  dashboardHeader(
    title = "GCMeval: a tool for climate model ensemble evaluation",
    titleWidth = '600px',
    dropdownMenuOutput("messageMenu")
  ),
  dashboardSidebar(
    sidebarMenu(width="120px",
                menuItem("Model selection", tabName = "selection", icon=NULL, 
                         collapsed=FALSE,
                         width='210px',
                         numericInput(
                           "ngcm",
                           label = "Ensemble size",
                           value = 11, min = 1,
                           max = length(gcmnames),
                           width = '150px'
                         ),
                         actionButton(
                           "randomize", 
                           label = "Random", 
                           width = '150px'
                         ),
                         actionButton(
                           "best", 
                           label = "Best", 
                           width = '150px'
                         ),
                         actionButton(
                           "first", 
                           label = "First", 
                           width = '150px'
                         ),
                         checkboxGroupInput(
                           "gcms",
                           label = "Climate models",
                           choices = gcmnames,
                           selected = gcmnames[1:11],
                           inline=TRUE,
                           width='100%'
                         )
                ),
      menuItem("Settings for skill evaluation", tabName="rank", icon=NULL,
               menuItem("Focus regions", tabName="regionwm", icon=NULL,
                  selectInput(
                    "regionwm1", 
                    label = "Primary focus region",
                    choices = regionlist,
                    selected = "Alaska/N.W. Canada [ALA:1]"
                  ),
                  selectInput(
                    "wmreg1",
                    label = NULL,
                    choices = c(
                      "Not important (0)" = 0,
                      "Important (1)" = 1,
                      "Very important (2)" = 2
                    ),
                    selected = 2
                  ),
                  br(),
                  plotOutput("mapm1", width = '100%', height = '130px'),
                  br(),
                  selectInput(
                    "regionwm2",
                    label = "Secondary focus region",
                    choices = regionlist,
                    selected = "Amazon [AMZ:7]"
                  ),
                  selectInput(
                    "wmreg2",
                    label = NULL,
                    choices = c(
                      "Not important (0)" = 0,
                      "Important (1)" = 1,
                      "Very important (2)" = 2
                    ),
                    selected = 1
                  ),
                  br(),
                  plotOutput("mapm2", width = '100%', height = '130px'),
                  br()
              ),
              menuItem("Variables", tabName="varwm", icon=NULL,
                 selectInput(
                   "wmdt",
                   label = "Temperature",
                   choices = c(
                     "Not important (0)" = 0,
                     "Important (1)" = 1,
                     "Very important (2)" = 2
                   ),
                   selected = 1
                 ),
                 selectInput(
                   "wmdp",
                   label = "Precipitation",
                   choices = c(
                     "Not important (0)" = 0,
                     "Important (1)" = 1,
                     "Very important (2)" = 2
                   ),
                   selected = 1
                 )
              ),
              menuItem("Seasons", tabName="seasonwm", icon=NULL,
                selectInput(
                  "wmann",
                  label = "Annual",
                  choices = c(
                    "Not important (0)" = 0,
                    "Important (1)" = 1,
                    "Very important (2)" = 2
                  ),
                  selected = 1
                ),
                selectInput(
                  "wmdjf",
                  label = "Winter",
                  choices = c(
                    "Not important (0)" = 0,
                    "Important (1)" = 1,
                    "Very important (2)" = 2
                  ),
                  selected = 2
                ),
                selectInput(
                  "wmmam",
                  label = "Spring",
                  choices = c(
                    "Not important (0)" = 0,
                    "Important (1)" = 1,
                    "Very important (2)" = 2
                  ),
                  selected = 2
                ),
                selectInput(
                  "wmjja",
                  label = "Summer",
                  choices = c(
                    "Not important (0)" = 0,
                    "Important (1)" = 1,
                    "Very important (2)" = 2
                  ),
                  selected = 2
                ),
                selectInput(
                  "wmson",
                  label = "Autumn",
                  choices = c(
                    "Not important (0)" = 0,
                    "Important (1)" = 1,
                    "Very important (2)" = 2
                  ),
                  selected = 2
                )
              ),
              menuItem("Skill scores", tabName="skillwm", icon=NULL,
                selectInput(
                  "wmbias",
                  label = "Bias",
                  choices = c(
                    "Not important (0)" = 0,
                    "Important (1)" = 1,
                    "Very important (2)" = 2
                  ),
                  selected = 2
                ),
                selectInput(
                  "wmsc",
                  label = "Spatial correlation",
                  choices = c(
                    "Not important (0)" = 0,
                    "Important (1)" = 1,
                    "Very important (2)" = 2
                  ),
                  selected = 1
                ),
                selectInput(
                  "wmsd",
                  label = "Spatial sd ratio",
                  choices = c(
                    "Not important (0)" = 0,
                    "Important (1)" = 1,
                    "Very important (2)" = 2
                  ),
                  selected = 1
                ),
                selectInput(
                  "wmrmse",
                  label = HTML("RMSE"),
                  choices = c(
                    "Not important (0)" = 0,
                    "Important (1)" = 1,
                    "Very important (2)" = 2
                  ),
                  selected = 1
                )
              )
      ),
      menuItem("Settings for scatterplot", tabName="spread", icon=NULL,
              selectInput(
                "season",
                label = "Season",
                choices = c("Annual mean", "Winter", "Spring", "Summer", "Autumn"),
                selected = "Annual mean"
              ),
              selectInput(
                "period",
                label = "Time horizon",
                choices = c("Far future (2071-2100)",
                            "Near future (2021-2050)"),
                selected = "Far future (2071-2100)"
              ),
              selectInput(
                "rcp",
                label = "Emission scenario",
                choices = c("RCP 4.5", "RCP 8.5"),
                selected = "RCP 4.5"
              ),
              sliderInput("xlim", 
                          label = "Temperature range",
                          min = -20, 
                          max = 20,
                          step = 0.5,
                          value = c(-8,8)),
              sliderInput("ylim", 
                          label = "Precipitation range",
                          min = -4, 
                          max = 4,
                          step = 0.2,
                          value = c(-1.2,1.2))
      ),
      menuItem("Advanced settings", tabName="advanced", icon=icon("cog"),
               selectInput(
                 "tasref", 
                 label = "Reference data set, temperature",
                 choices = c("ERA5","ERAinterim"),
                 selected = "ERA5"
               ),
               selectInput(
                 "prref", 
                 label = "Reference data set, precipitation",
                 choices = c("ERA5","ERAinterim","GPCP"),
                 selected = "GPCP"
               ),
               menuItem("Exclude climate models", tabname="ensemble", icon=NULL,
                checkboxGroupInput(
                  "baseensemble",
                  label = "Full ensemble",
                  choices = gcmnames,
                  selected = gcmnames
                )
              )
      )
    )
  ),
  dashboardBody(fluidPage(
    theme = "bootstrap.css",
    useShinyjs(),
    extendShinyjs(text = jsresetclick, functions = c("resetClick")),
    extendShinyjs(text = jsrefocus, functions = "refocus"),
    fluidRow(
      column(
        12,
        box(label="info",
            title="How to use GCMeval",
            collapsible = TRUE,
            collapsed = FALSE,
            width="100%",
            htmlOutput("IntroText"),
            br(),
            htmlOutput("DisclaimerText")
        )
      ),
      column(
        12,
        box(
          label="skill",
          title = HTML("<font size=+1.5 color='black'><b>Model skill evaluation</b></font>"),
          width = '100%' ,
          status = 'primary',
          collapsible = TRUE,
          collapsed = FALSE,
          column(8,
                 selectInput("tabletype", 
                             label="Show ranking of ensemble",
                             choices=c("Selected models","Best performing models","All models"))
                 ),
          column(12,
                 DT::dataTableOutput("ModelsTable"),
                 br()
                 ),
          column(12,
                box(
                  label="weights",
                  title = HTML("<font size=+0>Summary of weights</font>"),
                  width = '100%' ,
                  status = 'primary',
                  collapsible = TRUE,
                  collapsed = TRUE,
                  DT::dataTableOutput("WeightsTable"),
                  br()
                )
          )
        )
      ),
      column(
        12,
        box(
          label="spread",
          title = HTML("<font size=+1.5 color='black'><b>Spread of the regional mean climate change</b></font>"),
          status = 'primary',
          width = '100%',
          collapsible = TRUE,
          collapsed = FALSE,
            box(
              label="summary",
              title = HTML("<font size=+0>Summary statistics</font>"),
              status = 'primary',
              width = '100%',
              collapsible = TRUE,
              collapsed = FALSE,
              htmlOutput("SpreadText")
            ),
          checkboxInput("show.ranking", 
                        label=HTML("<font size=-1<i>Show model ranking as color scale</i></font>"), 
                        value=FALSE),
          box(
              label="spread1",
              title = HTML("<font size=+0>Scatterplot for primary focus region</font>"),
              status = 'primary',
              width = '100%',
              collapsible = TRUE,
              collapsed = FALSE,
              br(),
              plotlyOutput("dtdpr1", width = '100%', height = 550),
              br()
            ),
            box(
              label="spread2",
              title = HTML("<font size=+0>Scatterplot for secondary focus region</font>"),
              status = 'primary',
              width = '100%',
              collapsible = TRUE,
              collapsed = FALSE,
              #checkboxInput("show.ranking", 
              #              label=HTML("<font size=-1<i>Show model ranking as color scale</i></font>"), 
              #              value=FALSE),
              br(),
              plotlyOutput("dtdpr2", width = '100%', height = 550),
              br()
            )
        )
      ),
      column(
        12,
        box(
          title = HTML('<font size=+1.5 color=black>Information</font>'),
          width = '100%' ,
          status = 'primary',
          collapsible = TRUE,
          collapsed = TRUE,
          h4("Source code"),
          "The source code for this app is available at GitHub ",
          a("(http://github.com/metno/DECM/).",
            href = "https://github.com/metno/DECM/"),
          "This code is partially based on the R-package 'esd' which is also freely available",
          a("(http://github.com/metno/esd/).", href =
              "https://github.com/metno/esd"),
          h4("Method")#,
          #helpText(HTML(
          #  paste(
          #    "The combined model performance index (CMPI) summarizes the ",
          #    "root mean square differences for multiple variables (following ",
          #    "Gleckler et al. 2008: Performance metrics for climate models, ",
          #    "J. Geophys. Res., 113, D06104, doi:10.1029/2007JD008972). ",
          #    "Here, it is normalised with respect to the median rmse within the full ensemble."
          #  )))
          )
        )
      )
    )
  )
)
