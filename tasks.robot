*** Settings ***
Documentation    Insert the sales data for the week and export it as a PDF.
Library    RPA.Browser.Selenium    auto_close=${FALSE}
Library    RPA.HTTP
Library    RPA.Excel.Files
Library    RPA.PDF

*** Tasks ***
Insert the sales data for the week and export it as a PDF.
    Open the intranet website
    Log in
    Download the Excel file
    Fill the form with the data from the Excel file
    Collect the results
    Export the table as a PDF
    [Teardown]    Log out and close the browser
Minimal task
    Log    Done.

*** Keywords ***
Open the intranet website
    Open Available Browser    https://robotsparebinindustries.com/

Log in
    Input Text    username    maria
    Input Password    password    thoushallnotpass
    Submit form
    Wait Until Page Contains Element    id:sales-form
    
Submit form
    Click Button    css: button[type=submit]

Download the Excel file
    Download    https://robotsparebinindustries.com/SalesData.xlsx    overwrite=True

Fill and submit the form for one person
    [Arguments]    ${sales_rep}
    Wait Until Page Contains Element    firstname
    Input Text    firstname    ${sales_rep}[First Name]
    Input Text    lastname    ${sales_rep}[Last Name]
    Input Text    salesresult    ${sales_rep}[Sales]
    Select From List By Value    salestarget    ${sales_rep}[Sales Target]
    Submit form

Fill the form with the data from the Excel file
    Open Workbook    SalesData.xlsx
    ${sales_reps}=    Read Worksheet As Table    header=True
    Close Workbook

    FOR    ${sales_rep}    IN    @{sales_reps}
        Fill and submit the form for one person    ${sales_rep}
        
    END
    
Fill and submit the form
    Input Text    firstname    John
    Input Text    lastname    Does
    Input Text    salesresult    123
    Submit form

Collect the results
    Screenshot    css: div.sales-summary    ${OUTPUT_DIR}${/}sales_summary.png

Export the table as a PDF
    Wait Until Element Is Visible    id:sales-results
    ${sales_results_html}=    Get Element Attribute    id:sales-results    outerHTML
    Html To Pdf    ${sales_results_html}    ${OUTPUT_DIR}${/}sales_results.pdf

Log out and close the browser
    Click Button    Log out
    Close Browser