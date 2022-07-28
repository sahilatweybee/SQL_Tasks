USE MOVIES_W3
GO

/*
1.	Write a SQL query to find the name and year of the movies. Return movie title, movie release year.
2.	write a SQL query to find when the movie ‘American Beauty’ released. Return movie release year.
3.	write a SQL query to find the movie, which was made in the year 1999. Return movie title.
4.	write a SQL query to find those movies, which was made before 1998. Return movie title.
5.	write a SQL query to find the name of all reviewers and movies together in a single list.
6.	write a SQL query to find all reviewers who have rated 7 or more stars to their rating. Return reviewer name.
7.	write a SQL query to find the movies without any rating. Return movie title.
8.	write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title.
9.	write a SQL query to find those movie titles, which include the words 'Boogie Nights'. Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year.
10.	write a SQL query to find those actors whose first name is 'Woody' and the last name is 'Allen'. Return actor ID
*/

--------------------------------------------Task 1----------------------------------------------------------------------
SELECT mov_title, mov_year FROM movie;

--------------------------------------------Task 2----------------------------------------------------------------------
SELECT mov_year FROM movie WHERE mov_title = 'American Beauty';

--------------------------------------------Task 3----------------------------------------------------------------------
SELECT mov_title FROM movie WHERE mov_year = 1999;

--------------------------------------------Task 4----------------------------------------------------------------------
SELECT mov_title FROM movie WHERE mov_year < 1998;

--------------------------------------------Task 5----------------------------------------------------------------------
SELECT mov_title , rev_name FROM movie M
INNER JOIN rating R ON M.mov_id = R.mov_id
INNER JOIN reviewer RV ON R.rev_id = RV.rev_id;

--------------------------------------------Task 6----------------------------------------------------------------------
SELECT rev_name FROM reviewer	
WHERE  rev_id = ANY (SELECT rev_id FROM rating WHERE rev_stars >= 7);

--------------------------------------------Task 7----------------------------------------------------------------------
SELECT  mov_title , num_o_ratINgs FROM movie
INNER JOIN rating ON movie.mov_id = rating.mov_id 
WHERE rating.num_o_ratINgs IS NULL;
					
--------------------------------------------Task 8----------------------------------------------------------------------
SELECT mov_title FROM movie WHERE mov_id =905 OR mov_id =907 OR mov_id = 917;

--------------------------------------------Task 9 

SELECT mov_title,mov_id ,mov_year FROM movie WHERE mov_title like '%Boogie nights%' ORDER BY mov_year;

--------------------------------------------Task 10---------------------------------------------------------------------
SELECT act_id FROM actor WHERE act_fname ='Woody' AND act_lname='Alle';

--------------------------------------------SUB QUERIES-----------------------------------------------------------------
/*
1.	Find the actors who played a role in the movie 'Annie Hall'. Return all the fields of actor table.
2.	write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name.
3.	write a SQL query to find those movies, which released in the country besides UK. Return movie title, movie year, movie time, date of release, releasing country.
4.	write a SQL query to find those movies where reviewer is unknown. Return movie title, year, release date, director first name, last name, actor first name, last name.
5.	write a SQL query to find those movies directed by the director whose first name is ‘Woddy’ and last name is ‘Allen’. Return movie title. 
6.	write a SQL query to find those years, which produced at least one movie and that, received a rating of more than three stars. Sort the result-set in ascending order by movie year. Return movie year.
7.	write a SQL query to find those movies, which have no ratings. Return movie title.
8.	write a SQL query to find those reviewers who have rated nothing for some movies. Return reviewer name.
9.	write a SQL query to find those movies, which reviewed by a reviewer and got a rating. Sort the result-set in ascending order by reviewer name, movie title, review Stars. Return reviewer name, movie title, review Stars.
10.	write a SQL query to find those reviewers who rated more than one movie. Group the result set on reviewer’s name, movie title. Return reviewer’s name, movie title.
11.	write a SQL query to find those movies, which have received highest number of stars. Group the result set on movie title and sorts the result-set in ascending order by movie title. Return movie title and maximum number of review stars. 
12.	write a SQL query to find all reviewers who rated the movie 'American Beauty'. Return reviewer name.
13.	write a SQL query to find the movies, which have reviewed by any reviewer body except by 'Paul Monks'. Return movie title. 
14.	write a SQL query to find the lowest rated movies. Return reviewer name, movie title, and number of stars for those movies. 
15. write a SQL query to find the movies directed by 'James Cameron'. Return movie title. 
16.	Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies.
*/

--------------------------------------------Task 1----------------------------------------------------------------------
SELECT * FROM actor 
WHERE act_id IN 
(SELECT act_id FROM movie_cast 
WHERE mov_id IN (SELECT mov_id FROM movie WHERE mov_title ='Annie Hall'));

--------------------------------------------Task 2----------------------------------------------------------------------
SELECT dir_fname, dir_lname FROM director
WHERE dir_id IN (SELECT dir_id FROM movie_direction 
WHERE mov_id IN (SELECT mov_id FROM movie WHERE mov_title='Eyes Wide Shut'));

--------------------------------------------Task 3----------------------------------------------------------------------
SELECT mov_title , mov_year ,mov_time,mov_dt_rel,mov_rel_country FROM movie 
WHERE mov_rel_country!='UK';

--------------------------------------------Task 4----------------------------------------------------------------------
SELECT   mov_title,mov_year,mov_dt_rel,dir_fname,dir_lname,act_fname,act_lname FROM movie, director ,actor
WHERE mov_id IN (SELECT mov_id FROM rating 
WHERE rev_id IN (SELECT rev_id FROM reviewer 
WHERE rev_name = ' ' )) AND act_id IN(SELECT act_id FROM movie_cast 
WHERE mov_id = movie.mov_id) AND dir_id IN (SELECT dir_id FROM movie_direction 
WHERE mov_id = movie.mov_id);

--------------------------------------------Task 5----------------------------------------------------------------------
SELECT mov_title FROM movie	
WHERE mov_id IN (SELECT mov_id FROM movie_direction 
WHERE dir_id IN (SELECT dir_id FROM director 
WHERE dir_fname='Woody' AND dir_lname = 'Allen'));

--------------------------------------------Task 6----------------------------------------------------------------------
SELECT mov_year FROM movie
WHERE mov_id IN (SELECT mov_id FROM rating WHERE rev_stars >3 ) ORDER BY mov_year;

--------------------------------------------Task 7----------------------------------------------------------------------
SELECT mov_title ,mov_id FROM movie
WHERE mov_id not IN (SELECT mov_id FROM ratINg WHERE mov_id = movie.mov_id)

--------------------------------------------Task 8----------------------------------------------------------------------
SELECT rev_name FROM reviewer
WHERE rev_id IN (SELECT rev_id FROM ratINg WHERE rev_stars is null)

--------------------------------------------Task 9----------------------------------------------------------------------
SELECT  rev_name, mov_title, rev_stars FROM reviewer, movie, rating
WHERE rev_stars IN ( SELECT rev_stars FROM ratINg 
WHERE mov_id= movie.mov_id AND rev_stars!='' AND num_o_ratINgs!=' ' )AND reviewer.rev_id IN (SELECT rev_id FROM ratINg 
WHERE mov_id = movie.mov_id)AND rev_name IN (SELECT rev_name FROM reviewer 
WHERE rev_id= ratINg.rev_id  AND reviewer.rev_name!=' ')
ORDER BY rev_name,mov_title,rev_stars;

--------------------------------------------Task 10---------------------------------------------------------------------
SELECT rev_name ,mov_title FROM reviewer , movie
WHERE rev_id IN (SELECT R.rev_id FROM ratINg R GROUP BY rev_id HAVING  count(r.rev_id) >1  )
AND rev_id IN (SELECT rev_id FROM rating WHERE mov_id = movie.mov_id) GROUP BY rev_name,mov_title;

--------------------------------------------Task 11---------------------------------------------------------------------
SELECT mov_title ,MAX(rev_stars) AS maximum_stars FROM movie ,rating
WHERE movie.mov_id IN(SELECT mov_id FROM rating 
WHERE rev_stars <= ANY(SELECT rev_stars FROM rating))AND rev_stars IN( SELECT rev_stars FROM rating 
WHERE mov_id= movie.mov_id) GROUP BY mov_title,rev_stars;

--------------------------------------------Task 12---------------------------------------------------------------------
SELECT rev_name ,rev_id FROM reviewer
WHERE rev_id IN (SELECT rev_id FROM rating 
WHERE mov_id IN (SELECT mov_id FROM movie 
WHERE mov_title ='American Beauty'));

--------------------------------------------Task 13---------------------------------------------------------------------
SELECT mov_title FROM movie 
WHERE mov_id IN (SELECT mov_id FROM rating 
WHERE rev_id IN (SELECT rev_id FROM reviewer 
WHERE rev_name != 'Paul Monks'));

--------------------------------------------Task 14---------------------------------------------------------------------
SELECT mov_title, MIN(rev_stars) AS minimum_stars, rev_name FROM movie, rating, reviewer
WHERE movie.mov_id IN (SELECT mov_id FROM rating 
WHERE rev_stars >= ANY (SELECT rev_stars FROM rating)) AND rev_stars IN (SELECT rev_stars FROM rating 
WHERE mov_id = movie.mov_id) AND rev_name IN (SELECT rev_name FROM reviewer
WHERE rev_id IN (SELECT rev_id FROM rating 
WHERE mov_id = movie.mov_id)) GROUP BY mov_title, rev_stars, rev_name;

--------------------------------------------Task 15---------------------------------------------------------------------
SELECT mov_title FROM movie 
WHERE mov_id IN (SELECT mov_id FROM movie_direction 
WHERE dir_id IN (SELECT dir_id FROM director
WHERE dir_fname = 'James' AND dir_lname = 'Cameron'));

--------------------------------------------Task 16---------------------------------------------------------------------
SELECT mov_title FROM movie 
WHERE mov_id IN (SELECT mov_id FROM movie_cast GROUP BY mov_id, act_id 
HAVING COUNT(mov_id) >= 1 AND act_id IN (SELECT act_id FROM movie_cast GROUP BY act_id 
HAVING COUNT(act_id) >= 2));


--------------------------------------------SQL JOINS-------------------------------------------------------------------
/*
1.	write a SQL query to find the name of all reviewers who have rated their ratings with a NULL value. Return reviewer name.
2.	write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role. 
3.	write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name and movie title.
4.	write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. Return director first name, last name and movie title.
5.	write a SQL query to find the actors who have not acted in any movie between1990 and 2000 (Begin and end values are included.). Return actor first name, last name, movie title and release year.
6.	write a SQL query to find the directors with number of genres movies. Group the result set on director first name, last name and generic title. Sort the result-set in ascending order by director first name and last name. Return director first name, last name and number of genres movies.
7.	write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title.
8.	write a SQL query to find all the movies with year, genres, and name of the director.
9.	write a SQL query to find the movies released before 1st January 1989. Sort the result-set in descending order by date of release. Return movie title, release year, date of release, duration, and first and last name of the director.
10.	write a SQL query to compute the average time and count number of movies for each genre. Return genre title, average time and number of movies for each genre.
11.	write a SQL query to find movies with the lowest duration. Return movie title, movie year, director first name, last name, actor first name, last name and role.
12.	write a SQL query to find those years when a movie received a rating of 3 or 4. Sort the result in increasing order on movie year. Return move year. 
13.	write a SQL query to get the reviewer name, movie title, and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars.
14.	write a SQL query to find those movies that have at least one rating and received highest number of stars. Sort the result-set on movie title. Return movie title and maximum review stars.
15.	write a SQL query to find those movies, which have received ratings. Return movie title, director first name, director last name and review stars.
16.	Write a SQL query in SQL to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies. 
*/

--------------------------------------------Task 1----------------------------------------------------------------------
SELECT rev_name FROM reviewer 
INNER JOIN rating ON reviewer.rev_id = rating.rev_id
WHERE rating.rev_stars IS NULL;

--------------------------------------------Task 2----------------------------------------------------------------------
SELECT actor.act_fname, actor.act_lname, movie_cast.role FROM actor 
INNER JOIN movie_cast ON actor.act_id = movie_cast.act_id 
INNER JOIN movie ON movie_cast.mov_id = movie.mov_id 
WHERE movie.mov_title = 'Annie Hall';

--------------------------------------------Task 3----------------------------------------------------------------------
SELECT dir_fname,dir_lname ,mov_title FROM movie_direction
INNER JOIN movie ON movie_direction.mov_id = movie.mov_id 
INNER JOIN director ON movie_direction.dir_id = director.dir_id
WHERE mov_title = 'Eyes Wide Shut';

--------------------------------------------Task 4----------------------------------------------------------------------
SELECT dir_fname,dir_lname ,mov_title FROM movie
INNER JOIN movie_direction ON movie.mov_id = movie_direction.mov_id
INNER JOIN director ON movie_direction.dir_id = director.dir_id
INNER JOIN movie_cast ON  movie.mov_id = movie_cast.mov_id
WHERE role ='Sean Maguire';

--------------------------------------------Task 5----------------------------------------------------------------------
SELECT act_fname,act_lname,mov_title,mov_year FROM movie	
INNER JOIN movie_cast ON movie.mov_id = movie_cast.mov_id 
INNER JOIN actor ON movie_cast.act_id = actor.act_id
WHERE movie.mov_year not between 1990 AND 2000;

--------------------------------------------Task 6----------------------------------------------------------------------
SELECT dir_fname, dir_lname, COUNT(gen_title) AS number_of_generic_movies FROM director 
INNER JOIN movie_direction ON director.dir_id = movie_direction.dir_id
INNER JOIN movie_genres ON movie_direction.mov_id = movie_genres.mov_id
INNER JOIN genres ON movie_genres.gen_id = genres.gen_id 
GROUP BY dir_fname,dir_lname,gen_title
ORDER BY dir_fname,dir_lname;

--------------------------------------------Task 7----------------------------------------------------------------------
SELECT movie.mov_title, movie.mov_year, genres.gen_title FROM movie	
INNER JOIN movie_genres ON movie.mov_id = movie_genres.mov_id
INNER JOIN genres ON movie_genres.gen_id = genres.gen_id;

--------------------------------------------Task 8----------------------------------------------------------------------
SELECT movie.mov_title, movie.mov_year, genres.gen_title, CONCAT(director.dir_fname, ' ', director.dir_lname) AS Director_Name FROM movie
INNER JOIN movie_direction ON movie.mov_id = movie_direction.mov_id 
INNER JOIN director ON movie_direction.dir_id = director.dir_id
INNER JOIN movie_genres ON movie.mov_id = movie_genres.mov_id 
INNER JOIN genres ON movie_genres.gen_id = genres.gen_id;

--------------------------------------------Task 9----------------------------------------------------------------------
SELECT movie.mov_title, movie.mov_year, movie.mov_dt_rel, movie.mov_time, director.dir_fname, director.dir_lname FROM movie
INNER JOIN movie_direction ON movie.mov_id = movie_direction.mov_id
INNER JOIN director ON movie_direction.dir_id = director.dir_id 
WHERE movie.mov_year <= 1988
ORDER BY movie.mov_year DESC, movie.mov_dt_rel DESC

--------------------------------------------Task 10---------------------------------------------------------------------
SELECT gen_title, AVG(mov_time) AS avg_mov_time, COUNT(movie_genres.mov_id) AS number_of_mov FROM movie	
INNER JOIN movie_genres ON movie.mov_id =  movie_genres.mov_id
INNER JOIN genres ON movie_genres. gen_id = genres.gen_id
GROUP BY gen_title;

--------------------------------------------Task 11---------------------------------------------------------------------
SELECT movie.mov_title, movie.mov_year, director.dir_fname, director.dir_lname, actor.act_fname, actor.act_lname, movie_cast.role FROM movie	
INNER JOIN movie_direction ON movie.mov_id = movie_direction.mov_id
INNER JOIN director ON movie_direction.dir_id = director.dir_id
INNER JOIN movie_cast ON movie.mov_id = movie_cast.mov_id
INNER JOIN actor ON movie_cast.act_id= actor.act_id
WHERE mov_time IN (SELECT mIN(mov_time) FROM movie);

--------------------------------------------Task 12---------------------------------------------------------------------
SELECT mov_year, rating.rev_stars FROM movie 
INNER JOIN rating ON movie.mov_id = rating.mov_id
WHERE rating.rev_stars BETWEEN 3 AND 4
ORDER BY movie.mov_year;

--------------------------------------------Task 13---------------------------------------------------------------------
SELECT reviewer.rev_name, movie.mov_title, rating.rev_stars FROM movie
INNER JOIN rating ON movie.mov_id = rating.mov_id 
INNER JOIN reviewer ON rating.rev_id = reviewer.rev_id 
ORDER BY reviewer.rev_name, movie.mov_title, rating.rev_stars;

--------------------------------------------Task 14---------------------------------------------------------------------
SELECT movie.mov_title, MAX(rating.rev_stars) AS Max_Stars FROM movie
INNER JOIN rating ON movie.mov_id = rating.mov_id
WHERE rating.num_o_ratings IS NOT NULL
GROUP BY movie.mov_title;

--------------------------------------------Task 15---------------------------------------------------------------------
SELECT movie.mov_title, director.dir_fname, director.dir_lname, rating.rev_stars FROM movie
INNER JOIN movie_direction ON movie.mov_id = movie_direction.mov_id 
INNER JOIN director ON movie_direction.dir_id = director.dir_id
INNER JOIN rating ON movie.mov_id = rating.mov_id
WHERE rating.rev_stars IS NOT NULL;

--------------------------------------------Task 16---------------------------------------------------------------------
--Write a SQL query to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies. 
SELECT movie.mov_title, actor.act_fname, actor.act_lname, movie_cast.role FROM movie
INNER JOIN movie_cast ON movie.mov_id = movie_cast.mov_id 
INNER JOIN actor ON movie_cast.act_id = actor.act_id
WHERE movie_cast.act_id IN (SELECT act_id FROM movie_cast 
GROUP BY act_id HAVING COUNT(act_id) > 1);