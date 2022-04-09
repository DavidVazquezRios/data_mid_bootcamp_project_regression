# Mid-bootcamp project - Regression 
*The project is divided in three parts:
	*A sql file in sql_regression/ folder with tasks and the query for each task
	*A tableau file in tableau_regression/ folder where the tableau tasks are pressented
	*A Jupiter notebook file midcamp.ipynb where a regression model is created

This project is a part of Ironhack Data Analytics Full Time Bootcamp course. 

## 1. Project Description

**Background**: You are working as an analyst for a real estate company. Your company wants to build a machine learning model to predict the selling prices of houses based on a variety of features on which the value of the house is evaluated.

**Objective**: The task is to build a model that will predict the price of a house based on features provided in the dataset. The senior management also wants to explore the characteristics of the houses using some business intelligence tool. One of those parameters include understanding which factors are responsible for higher property value - \$650K and above.
The questions have been provided later in the document for which you can use tableau.

**Data**: The data set consists of information on some 22,000 properties.  The dataset consisted of historic data of houses sold between May 2014 to May 2015.
These are the definitions of data points provided:
(Note: For some of the variables that are self explanatory, no definition has been provided)

- **Id**: Unique identification number for the property.
- **date**: date the house was sold.
- **price**: price of the house.
- **waterfront**: house which has a view to a waterfront.
- **condition**: How good the condition is (overall). **1** indicates worn out property and **5** excellent.
- **grade**: Overall grade given to the housing unit, based on King County grading system. 1 poor ,13 excellent.
- **Sqft_above**: square footage of house apart from basement.
- **Sqft_living15**: Living room area in 2015(implies - some renovations). This might or might not have affected the lotsize area.
- **Sqft_lot15**: lotSize area in 2015(implies - some renovations).

## 2. Tools used

The tools used are Python, Tableau Public and MySQL Workbench. 


## 3. Challenges identified


* The data is a collection of different real state porperties from different counties, each county has different price ranges and tendency. A cohesive model for all the data will be an aproximation, for better acuracy each county should have it´s model but there is not enough data. 
  

## 4. How to use & install

* Fork & clone the entire repo on your hard-drive
* Run the Jupyter notebook midcampv2.ipynb 
* Open and run sql_questions_regression.sql in the sql_regression folder
* Open and explore tableau_regression.twbx file in the tableau_regression folder
* business.csv is clean data with prediction and rebuilt up to max standards prediction
* presentacion.twbx is data analysis for the presentation
## 5. Copyright

* **Author:** David Vazquez
* **LinkedIn:** www.linkedin.com/in/david-vazquez-0b9869a4
* **Github:** https://github.com/DavidVazquezRios

*Bueu, 2022*