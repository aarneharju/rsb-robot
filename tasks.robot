*** Settings ***
Documentation    Insert the sales data for the week and export it as a PDF.
Library    RPA.Browser.Selenium    auto_close=${FALSE}
Library    RPA.HTTP

*** Tasks ***
Insert the sales data for the week and export it as a PDF.
    Open the intranet website
    Log in
    Download the Excel file
    Fill and submit the form
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

Fill and submit the form
    Input Text    firstname    John
    Input Text    lastname    Does
    Input Text    salesresult    123
    Submit form

Download the Excel file
    Download    https://robotsparebinindustries.com/SalesData.xlsx    overwrite=True