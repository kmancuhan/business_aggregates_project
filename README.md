# Date Created

April 30, 2022

# Project Scope

This was a project made for the completion of the "Introduction to SQL" course, offered by the Udacity platform. The project aims to simulate replying some business questions, using the database of a fictional company for DVD rentals.

## Business Questions

There are five business questions replied by the queries:

- What is the most rented out movie in each family movie category?
- What is the number of movies in each family movie category and respective rental duration quartile?
- What is the number of payments in 2007 for each top 10 paying customer?
- What is the monthly total payment in 2007 for each top 10 paying customer?
- Among the top 10 paying customers, who are the top 5 paying the most monthly difference in 2007?

I should note that the family movie categories include Animation, Children, Classics, Comedy, Family and Music; for the scope of this project.

# Files

There are 6 files in this repo. 4 files are SQL query scripts, each replying a business question above. One file is a presentation which visualizes the answer of each query. Last, I also included here the database ERD diagram, in order to give a better context about the queries. Here is the list of files:

- slide1_query.sql replies the first business question.
- slide2_query.sql replies the second business question.
- slide3_4_5_query.sql replies the third and fourth business questions. The reason why there is a single file here is that the same query can reply both questions.
- slide6.sql replies the fourth business question.
- presentation.pdf is the slides.
- DVD Rental ERD.pdf is the ERD diagram of the fictional database.

# Running Instructions

The queries are written in PostgreSQL. Running the queries would require having a DB server setup, storing the data of the fictional company. I won't be providing the database here due to copyright reasons. However, the queries should give an idea about replying similar business questions in real life.
