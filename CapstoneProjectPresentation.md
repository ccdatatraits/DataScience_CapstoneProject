CapstoneProjectPresentation
========================================================
author: Sohail Munir Khan
date: January 24th, 2016
font-import: http://fonts.googleapis.com/css?family=Risque
font-family: 'Risque'
class: illustration
transition: rotate

Capstone Project
========================================================

Overall Tasks for the full project

- Data acquisition from www.corpora.heliohost.org
- Exploratory analysis for number of lines, words, most frequent terms
- Modeling using NGram model
- Prediction making use of multiple NGram models (5/4/3/2 Grams)
- Creative exploration on methods to optimise output: Using internal database to store results
- Shiny app for the product developed to run our predictions
- This slide deck for a quick presentation of the whole project

Algorithm Steps
========================================================

- Take (sampled) input and run these steps: stripWhitespace, tolower, removePunctuation, removeNumbers
- Using tm package, create these NGram objects: Bigram, Trigram, Quadgram, Pentagram
- Upload the frequency of these words into an SQLite database
- Retrieve (by decreasing order) the most suitable NGram that finds our input text
- If we can't find it, we go an order lower (e.g. from Trigram to Bigram)
- Show the top (at-most) 3 appropriate outputs or prediction not found

How to use the app
========================================================

- Very intuitive and simple to use
- Input your text into the imput field (Press Enter or click Submit)
- Your input will be shown in the right hand panel
- List of predictive results will be shown below after that
- (Repeat) steps to run for a different output

Result Shown
========================================================

![alt text](datascienceapp.png)
