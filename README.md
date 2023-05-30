# ShinyAppENSCM

This repository contains a shiny app that I developed in the context of my Master's degree thesis in statistical analysis at the university of Montpellier during the 2022/2023 school year. This app is designed to help visualize the data that I worked with during my time as an apprentice at the Ecole supérieure nationale de chimie de Montpellier (ENSCM). 

## Packages needed

In order to run this app, you will need to have the following R packages installed : Shiny, RColorBrewer and data.table. If you are missing one or more of these packages you can install them by running the following code : 

Shiny :
install.packages("shiny")

RColorBrewer:
install.packages("RColorBrewer")

data.table :
install.packages("data.table")

## The data

The data that is being used in this app is the compiled answers of the school's alumni to it's yearly survey. Every year the graduates from up to five years prior are being surveyed. For instance the 2022 survey contains answers of alumni from the 2017 to 2021 promotions. All the data is anonymous.

## The app

Using the app you will need to first select a year. This will select only the students that graduated that year. Then you will also need to select a variable to visualize. Lastly you will need to select a survey date. This is done by choosing between the number 1 or 2. This number corresponds to the number of years after the graduation of the students that the survey took place. For instance, if you select the year 2017, only the alumni that graduated in 2017 will be shown. If you then select a variable from the list and the number 1, the plot will refresh and you will be able to see the answers of the 2017 promotion to the 2018 survey. If you select the number 2 the answers of the alumni that graduated in 2017 and answered to the 2019 survey will be shown. 

As could be expected, every former students does not answer the survey every year. Some may answer it once, some may answer it every time. This is why you will notice changes from one survey year to the other for the same promotion in categories such as sex or syllabus . This app is designed to present the available data, it is not designed to compare data from one year to another as it is not restricted to the same respondents from one year to another.  