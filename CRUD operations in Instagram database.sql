/* #1: Creating SQL query to return the user names for 
5 oldest users within the sample database*/
SELECT 
    username
FROM
    users
ORDER BY created_at ASC
LIMIT 5;



/* #2: Creating SQL Query to return 
the most popular registration date (day-month-year)*/
SELECT 
    DATE(created_at), COUNT(*) AS Registrations
FROM
    users
GROUP BY DATE(created_at)
ORDER BY Registrations DESC
LIMIT 10;  #displaying top 10 because the highest registrations: 2 is for 9 dates

/* #2: Creating SQL Query to return 
the most popular registration date (day)*/
SELECT 
    DAY(created_at)
FROM
    users
GROUP BY DAY(created_at)
ORDER BY COUNT(*) DESC
LIMIT 1;  #8 registrations on the 6th day of a month is the highest




/* #3: Creating SQL Query to return user names 
of users without any photos*/
SELECT 
    username
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.id IS NULL;



/* #4: Considering that most popular photos refer to maximum likes
Most popular image url and the username */
SELECT 
    username, y.image_url
FROM
    users
        RIGHT JOIN
    (SELECT 
		user_id, image_url
    FROM
        photos
    RIGHT JOIN (SELECT 
        photo_id, COUNT(photo_id)
    FROM
        likes
    GROUP BY photo_id
    ORDER BY COUNT(photo_id) DESC
    LIMIT 1) x ON photos.id = x.photo_id) y ON users.id = y.user_id;



/* #5: Query to calculate average number of photos per user */
SELECT 
    AVG(x.mycount) AS Average
FROM
    (SELECT 
        user_id, COUNT(id) mycount
    FROM
        photos
    GROUP BY user_id) x;



/* #6: Most popular hashtags are the hashtags with maximum photos
Selecting such tag names  */
SELECT 
    tag_name
FROM
    tags
        JOIN
    (SELECT 
        tag_id, COUNT(photo_id) AS c
    FROM
        photo_tags
    GROUP BY tag_id
    ORDER BY c DESC
    LIMIT 10) x ON tags.id = x.tag_id;



/* #7: Creating query to return the users who 
have liked every single photo  */

/* Selecting count of total photos */
SELECT 
    COUNT(*)
FROM
    photos;  /* 257 photos */

 /* Selecting user names who have liked 257 photos */     
SELECT 
    username
FROM
    users
        RIGHT JOIN
    (SELECT DISTINCT
        user_id
    FROM
        likes
    GROUP BY user_id
    HAVING COUNT(photo_id) = 257) AS x ON x.user_id = users.id

   





 


