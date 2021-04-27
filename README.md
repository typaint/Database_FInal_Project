# Project2

For this project we got data from the follwing link: https://www.kaggle.com/brunacmendes/nypd-complaint-data-historic-20062019.

There is a basic walkthrough of how the front end application works at: https://www.youtube.com/watch?v=xO_VUzaD6cM.

Our applicatition is written in four languages: SQL, PHP, HTML, and CSS.

The SQL data is contained in the file project 2. It is broken into 3 major parts. The first part is the reading in of the data. The second part is the data cleaning and insertation. The third major part is the advanced feature creation. In order to succesfully import the data one needs to set the values in the SQL editor that correspond to query length to a sufficiently high number. that the user has the priviledges to read in an inline file. It is also worth noting that the advanced features in the front end file do not need to be run but are there for clarification as they are already ran in the main SQL body of code.

The PHP code is broken up into multiple parts that is contained in the frontend folder. The files deleteCrime, getCrime, and insertCrime are the main DML features that connect to database and perform the operations that the names imply. The getBorough and getType run more highlevel views. 

The HTML code is contained in the index file. This creates the home page. Also, the project.css and project2.css help to specificy how the webpage is setup. 

In order to run this code first MAMP and SQL must be downloaded. Nextall the proper files must be downloaded from the SQL and FrontEnd files. Correct the path in the SQL project2 file to the path that would read in the data from your machine. After make sure to update the time alloted as mentioned in the SQL editor as mentioned above. Next copy the frontend folder to your /applications/mamp/htdocs (for mac users and do the equalivent for windows). Next make sure that the MAMP document root is htdoc. Before launching the mamp in the conn.php change the port to the user's correct port generally this 8889. Next launch MAMP and in the serarch bar type http://localhost:8888/htdocs/FrontEnd/. This should take you to the correct page. 
