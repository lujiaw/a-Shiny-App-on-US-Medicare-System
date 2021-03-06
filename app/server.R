server <- function(input, output) {
  output$read0 <-
    renderText({
      "We totally understand that you are upset to get sick and the hardest thing is to find a fitted hospital that you can go quickly."
    })
  output$read1 <-
    renderText({
      "Don't worry! Please look at here to find the best hospitals around you based on your preference."
    })
  
  output$read2 <-
    renderText({
      " •	Step 1: Select the state you live in or you wish to go to and the cost range you are comfortable to pay."
    })
  output$read3 <-
    renderText({
      " •	Step 2: Choose one of the most cared hospital qualities and your diagnosis related group."
    })
  output$read4 <-
    renderText({
      " •	Step 3: Check the search result table and the map for the basic information of all hospitals."
    })
  output$read5 <-
    renderText({
      " •	Step 4: Click one you are interested in from the table to zoom it in on the map to see the exact location of the hospital."
    })
  
  output$read6 <-
    renderText({
      "Want more information about spending? Please click the Overview tab to explore more!"
    })
  
  output$read7 <-
    renderText({
      "Part 1: Check the State Overview to get a overview of average charges and average medicare payments by states."
    })
  output$read8 <-
    renderText({
      "  • Select the year and diagnosis related group you are interested in.You can also search one state to see the detailed charges and payments inforamtion."
    })
  output$read9 <-
    renderText({
      "Part 2: Take a look at our Hospital Comparison by selecting year, DRG, and the hospitals you are cared about."
    })
  output$read10 <-
    renderText({
      "Part 3: Click the Spending Exploration to learn the total spending for each DRG and the year_trend spending based on selected DRG and hospital."
    })
  
  
  
  
  output$team0 <- renderText({
    "About Team"
  })
  output$team1 <-
    renderText({
      "We are five excellent students from Columbia University in Statistics and the owners of the Version 2.0 medicare app. We aim to make data more straightforward and convinent for medicare searching."
    })
  output$team2 <-
    renderText({
      "Please contact us if you have any questions or recommendations:"
    })
  output$team3 <-
    renderText({
      "•	Xinwei Feng (email: xf2168@columbia.edu)"
    })
  output$team4 <-
    renderText({
      "•	Lujia Wang (email: lw2772@columbia.edu)"
    })
  output$team5 <-
    renderText({
      "•	Binhan Wang (email: bw2544@columbia.edu)"
    })
  output$team6 <-
    renderText({
      "•	Rui Zhang (email: rz2406@columbia.edu)"
    })
  output$team7 <-
    renderText({
      "•	Yixin Zhang (email: yz3223@columbia.edu)"
    })
  output$team8 <- renderText({
    "Thank you for using!"
  })
  
  # Map output
  
  output$geo_plot = renderGvis({
    data = in_total %>%
      filter(DRG.Definition == input$select_DRG &
               year == input$select_year)
    
    gvisGeoChart(
      data,
      locationvar = "Provider.State",
      colorvar = c("Average.Covered.Charges"),
      options = list(
        region = "US",
        colors = "['red']",
        displayMode = "regions",
        resolution = "provinces",
        titleTextStyle = "{fontSize:16}",
        width = "100%"
      )
    )
    
    
  })
  
  output$g_plot = renderGvis({
    d = in_total %>%
      filter(DRG.Definition == input$select_DRG &
               year == input$select_year)
    gvisGeoChart(
      d,
      locationvar = "Provider.State",
      colorvar = "Average.Medicare.Payments",
      options = list(
        region = "US",
        colors = "['blue']",
        titleTextStyle = "{fontSize:28}",
        displayMode = "regions",
        resolution = "provinces",
        width = "100%"
      )
    )
    
  })
  
  output$hist_plot = renderGvis({
    h = in_total %>%
      filter(DRG.Definition == input$select_DRG &
               year == input$select_year) %>%
      select(Average.Covered.Charges)
    gvisHistogram(
      h,
      options = list(
        colors = "['red']",
        legend = "{position:'top'}",
        titleTextStyle = "{fontSize:16}"
      )
    )
    
  })
  
  output$histogram_plot = renderGvis({
    h = in_total %>%
      filter(DRG.Definition == input$select_DRG &
               year == input$select_year) %>%
      select(Average.Medicare.Payments)
    gvisHistogram(h,
                  options = list(colors = "['blue']",
                                 legend = "{position:'top'}"))
    
  })
  
  output$col_plot = renderGvis(
    gvisBarChart(
      in_total %>% filter(DRG.Definition == input$select_DRG &
                            year == input$select_year) %>%
        arrange(desc(Average.Covered.Charges)),
      
      xvar = "Provider.State",
      yvar = c("Average.Covered.Charges", "Average.Medicare.Payments"),
      options = list(
        colors = "['red','blue']",
        height = 600,
        width = "100%",
        legend = "{position: 'top'}",
        hAxis = paste("{",
                      "slantedText: true",
                      "}")
      )
    )
  )
  
  output$con_plot = renderGvis(
    gvisBarChart(
      in_total %>% filter(DRG.Definition == input$select_DRG &
                            year == input$select_year) %>%
        arrange(desc(Average.Covered.Charges)),
      xvar = "Provider.State",
      yvar = "Average.Total.Payments",
      options = list(
        colors = "['green']",
        height = 600,
        width = "100%",
        legend = "{position: 'top'}",
        hAxis = paste("{",
                      "slantedText: true",
                      "}"),
        vAxis = paste("{",
                      "slantedText: true",
                      "}")
      )
    )
  )
  
  output$sum_table = renderDataTable(in_total,
                                     options = list(pageLength = 10))
  
  output$bubble_plot = renderGvis({
    data_1 = switch(
      as.character(input$select_year),
      "2011" = in_2011_spending,
      "2012" = in_2012_spending,
      "2013" = in_2013_spending,
      "2014" = in_2014_spending,
      "2015" = in_2015_spending,
      "2016" = in_2016_spending
    )
    
    gvisBubbleChart(
      data_1[1:input$select_top, ],
      xvar = "Average.Medicare.Payments",
      yvar = "Average.Covered.Charges",
      colorvar = "drg",
      sizevar = "Total.Spending",
      options = list(
        vAxis = "{title:'Total Discharges'}",
        hAxis = "{title: 'Average Medicare Payments per Discharge'}",
        height = 500,
        width = "100%",
        legend = "{position: 'top'}",
        bubble = "{textStyle:{color: 'none'}}"
      )
    )
  })
  
  output$bar_plot = renderGvis(
    gvisColumnChart(
      in_total_hospital %>% filter(
        DRG.Definition == input$select_DRG_2 &
          year == input$select_year_2 &
          # year == input$select_year_2 &
          Provider.Name %in% input$select_hospital
      ),
      xvar = "Provider.Name",
      yvar = c("Average.Covered.Charges", "Average.Medicare.Payments"),
      options = list(
        height = 600,
        legend = "{position: 'top'}",
        hAxis = paste("{",
                      "slantedText: true",
                      "}")
      )
    )
  )
  
  output$line_plot = renderGvis({
    lineplot_data =
      in_total_hospital %>%
      filter(DRG.Definition == input$select_DRG_3 &
               Provider.Name == input$select_hospital_2)
    
    gvisLineChart(
      lineplot_data,
      'year',
      c('Average.Medicare.Payments', 'Average.Covered.Charges'),
      options = list(
        height = 600,
        legend = "{position: 'top'}",
        tooltip = "{isHtml:'True'}",
        pointSize = 10,
        series = "{0: { pointShape: 'circle'},
        1:{ pointShape: 'triangle'}}",
        hAxis = paste("{",
                      "slantedText: true",
                      "}")
      ),
      chartid = "Points"
  )
  })
  
  barplot_tbl = reactive(
    in_total_hospital %>%
      filter(
        DRG.Definition == input$select_DRG_2 &
          year == input$select_year_2 &
          Provider.Name %in% input$select_hospital
      )
  )
  output$subtable1 = renderGvis({
    gvisTable(barplot_tbl(),
              options = list(
                page = 'enable',
                height = 'automatic',
                width = 'automatic'
              ))
  })
  
  
  
  #data <- hospital_info
  r.state <- reactive({
    input$r.state
  })
  r.drg <- reactive({
    substr(input$r.drg, 1, 3)
  })
  r.care <- reactive({
    input$r.care
  })
  r.cost <- reactive({
    input$r.cost
  })
  # filter data with state
  df1 <- reactive({
    df1 <- hospital_info %>% filter(State == r.state())
    
  })
  # filter data with selected DRG group
  df2 <- reactive({
    df2 <- df1() %>% filter(drg == r.drg())
    
  })
  # filter data with cost range
  df3 <- reactive({
    df3 <- df2() %>% filter(Average.Covered.Charges >= r.cost()[1] &
                              Average.Covered.Charges <= r.cost()[2])
  })
  
  
  
  # reweight with selected most care aspect
  # Calculate care vector
  o.c.w <- c(1, 1, 1, 1, 1, 1, 1)
  name <- c(
    "Mortality",
    "Safety of Care",
    "Readmission Rate",
    "Patient Experience",
    "Effectiveness of Care",
    "Timeliness of Care",
    "Efficient Use of Medical Imaging"
  )
  c.weight <- reactive({
    if (r.care() == "Select") {
      o.c.w
    } else {
      o.c.w[which(name == r.care())] <- 2
      o.c.w
    }
  })
  
  # Scores of hospitals in the selected state
  score <-
    reactive(apply(data.frame(df3()), 1, getscore, care.w = c.weight()))
  
  # orders for hospitals
  ord <- reactive(order(score(), decreasing = TRUE))
  
  # ranks for hospitals
  rk <-
    reactive(floor(frankv(
      score(), order = -1, ties.method = "min"
    )))
  #Reactive expression for the map/recommendation data subsetted to what the user selected
  df4 <- reactive(cbind(df3(), Order = ord(), Rank = rk()))
  
  # Outputs
  output$r.df = renderDataTable({
    rankedtable <-
      DT::datatable(
        df4()[,c(
          "Rank",
          "Hospital.Name",
          "Hospital.overall.rating",
          "cost.w.medicare",
          "Average.Covered.Charges"
        )],colnames = c("Rank","Name",
                        "Overall Rating",
                        "Cost w/ Medicare",
                        "Total Charges"),
        selection = "single",
        options = list(
          order = list(0,'asc'),
          stateSave = TRUE,
          pageLength = 5,
          lengthMenu = c(5, 10, 15, 20),
          style = 'bootstrap',
          class = 'table-stripe'
        ),
        rownames = FALSE
      )
    rankedtable
  })
  # to keep track of previously selected row
  prev_row <- reactiveVal()
  # new icon style
  icon.flag <-
    makeAwesomeIcon(icon = "flag",
                    markerColor = "red" ,
                    iconColor = "white")
  # Observe event - select row in table
  observeEvent(input$r.df_rows_selected, {
    row_selected = df4()[input$r.df_rows_selected, ]
    proxy <- leafletProxy('map')
    proxy %>% addAwesomeMarkers(
      lng = row_selected$lon,
      lat = row_selected$lat,
      icon = icon.flag,
      layerId = as.character(row_selected$Provider.ID),
      popup = content.fun(row_selected)
    ) %>% fitBounds(
      lng1 = row_selected$lon + 0.1,
      lng2 = row_selected$lon - 0.1,
      lat1 = row_selected$lat + 0.1,
      lat2 = row_selected$lat - 0.1
    )
    # Reset previously seleted marker
    if (!is.null(prev_row())) {
      proxy %>% addMarkers(
        lng = prev_row()$lon,
        lat = prev_row()$lat,
        layerId = as.character(prev_row()$Provider.ID),
        popup = content.fun(prev_row())
      )
    }
    # set new value to reactiveVal
    prev_row(row_selected)
  })
  
  #leaflet map output (interactive with user's input)
  output$map <- renderLeaflet({
    leaflet(data = df4()) %>% addTiles() %>% addAwesomeMarkers(
      lng = ~ lon,
      lat = ~ lat,
      popup = content.fun(df4()),
      layerId = as.character(df4()$Provider.ID)
    )
  })
  # observe Event - click on map
  observeEvent(input$map_marker_click, {
    clickId <- input$map_marker_click$id
    rowNum <-
      which(input$r.df_rows_all == which(df4()$Provider.ID == clickId))
    dataTableProxy("r.df") %>%
      selectRows(which(df4()$Provider.ID == clickId)) %>%
      selectPage(
        ifelse(
          rowNum %% input$r.df_state$length == 0,
          rowNum %/% input$r.df_state$length,
          rowNum %/% input$r.df_state$length + 1
        )
      )
  })
  
  #value box - number of hospitals
  output$vbox_1 <- renderValueBox({
    valueBox(
      subtitle = "Number of Hospitals",
      value = nrow(df4()),
      color = "purple",
      icon = icon("list")
    )
  })
  
  #value box - average quality
  output$vbox_2 <- renderValueBox({
    valueBox(
      subtitle = "Average Overall Rating",
      value = round(mean(df4()$Hospital.overall.rating,na.rm = T),2),
      #value = round(100 * mean(score()[score() > 0],na.rm = T) / max(score(),na.rm = T), 0),
      color = "yellow",
      icon = icon("thumbs-up", lib = "glyphicon")
    )
  })
  
  #value box - average cost
  output$vbox_3 <- renderValueBox({
    valueBox(
      subtitle = "Average Cost",
      value = paste("$", round(
        mean(df4()$Average.Covered.Charges, na.rm = TRUE), 0
      )),
      color = "blue",
      icon = icon("credit-card")
    )
  })
  
  }
