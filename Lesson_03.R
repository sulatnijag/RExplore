library(openxlsx)
library(dplyr)


dfBreaks <- data.frame("grp" = c('=HYPERLINK("#Timing_Issue!grp_1", "Text to Display - Link to Timing_Issue")', '=HYPERLINK("#Technical_Issue!grp_2", "Text to Display - Link to Technical_Issue")'),
                       "TXN_ID" = c(101:102)
                       )
class(dfBreaks$grp) <- c(class(dfBreaks$grp), "formula")

#####################################################################################
## Styles

hs1 <- createStyle(fgFill = "#DCE6F1", halign = "CENTER", textDecoration = "italic",
                   border = "Bottom")

hs2 <- createStyle(fontColour = "#ffffff", fgFill = "#4F80BD",
                   halign = "center", valign = "center", textDecoration = "bold",
                   border = "TopBottomLeftRight")

hyperlink <- createStyle(fontColour = "#0033cc", textDecoration = "underline")


#####################################################################################
## Create Workbook object and add worksheets
wb <- createWorkbook()
addWorksheet(wb, "Summary")
addWorksheet(wb, "Technical_Issue")
addWorksheet(wb, "Timing_Issue")


#####################################################################################
## -- write data.frame as an Excel table with column filters
## -- default table style is "TableStyleMedium2"
writeDataTable(wb, "Summary", x = dfBreaks, tableName = "Breaks")
addStyle(wb, "Summary", hyperlink, 1:(nrow(dfBreaks)+1), 1)


writeData(wb, "Technical_Issue", x=dfBreaks[1,1] , colNames = FALSE, rowNames = FALSE, startCol=2,
          startRow = 23, borders="rows", headerStyle = hs1, borderStyle = "dashed")

createNamedRegion(wb = wb,
                  sheet = "Technical_Issue",
                  name = "grp_1",
                  rows = 23:(nrow(dfBreaks)+1),
                  cols = 1:ncol(dfBreaks))



writeData(wb, "Timing_Issue", x=c("asdfasf",4) , colNames = FALSE, rowNames = FALSE, startCol=2,
          startRow = 23, borders="rows", headerStyle = hs1, borderStyle = "dashed")

createNamedRegion(wb = wb,
                  sheet = "Timing_Issue",
                  name = "grp_2",
                  rows = 23:25,
                  cols = 2)



##################################################################################### 
## Save workbook
## Open in excel without saving file: openXL(wb)

saveWorkbook(wb, "Lesson_03.xlsx", overwrite = TRUE)



