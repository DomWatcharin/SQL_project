-- To create a table in SQL, we can use the CREATE TABLE statement.
CREATE TABLE Customers1 (
    CustomerId INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

-- To insert data into a table in SQL, we can use the INSERT INTO statement.
INSERT INTO Customers (CustomerId, FirstName, LastName, Email, Phone)
VALUES 
  (2, 'John', 'Doe', 'johndoe@example.com', '123-456-7890'),
  (3, 'Jane', 'Smith', 'janesmith@example.com', '987-654-3210');
  
  /* if you want to modify an existing row with the CustomerId value of 1, 
  you can use an UPDATE statement instead of an INSERT INTO statement: */
UPDATE Customers1
SET FirstName = 'John',
    LastName = 'Doe',
    Email = 'johndoe@example.com',
    Phone = '123-456-7890'
WHERE CustomerId = 1;

-- To drop a table in SQL, you can use the DROP TABLE statement. Here's an example of how to drop the "Customers" table:
DROP TABLE Customers1;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Basic SQL clauses
	- SELECT	
	- FROM
	- WHERE
	- GROUP BY + AGGREGATE FUNCTION()
	- HAVING
	-ORDER BY */

-- To select every column from the Customers table, you can use the SELECT * statement. 
SELECT *
FROM Customers;

-- To Retrieve all customers and their contact information:
SELECT 
	CustomerId, 
	FirstName, 
	LastName, 
	Email, 
	Phone
FROM Customers;

-- Retrieve the customers who have made a purchase in a specific country:
SELECT 
	CustomerId, 
	FirstName, 
	LastName, 
	Country
FROM Customers
WHERE Country = 'Brazil' OR Country = 'USA' ;

-- Get the total number of customers in Brazil and USA:
SELECT 
	COUNT(*) 
FROM Customers
WHERE Country = 'Brazil' OR Country = 'USA' ;

-- Get the total number of customers broup by Brazil and USA:
SELECT 
	Country,
	COUNT(*)
FROM Customers
WHERE Country = 'Brazil' OR Country = 'USA' 
GROUP BY Country;

-- To rename column using AS
SELECT 
	FirstName AS fname,
	LastName AS lname
FROM Customers;

-- To conect 2 culumn 
SELECT 
	FirstName,
	LastName,
	FirstName || '  ' || LastName AS fullname
FROM Customers;

-- SQL will do where clause before select
SELECT 
	FirstName,
	LastName,
	FirstName || '  ' || LastName AS fullname
FROM Customers
WHERE Country = 'USA' ;

-- limit only first 5 row
SELECT 
	FirstName,
	LastName,
	FirstName || '  ' || LastName AS fullname
FROM Customers
LIMIT 5;

-- count  data in customers
SELECT 
	COUNT(*) 
FROM Customers

-- count  data in customers, name, company
SELECT 
	COUNT(*) ,
	COUNT(FirstName),
	COUNT(Company)
FROM Customers

-- order by 
SELECT 
	Country,
	COUNT(*) AS number_of_customers
FROM Customers
GROUP BY Country
ORDER BY COUNT(*)

-- order by descening and limit first 5 row
SELECT 
	Country,
	COUNT(*) AS number_of_customers
FROM Customers
GROUP BY Country
ORDER BY COUNT(*) DESC
LIMIT 5

-- or use number instead of variable
SELECT 
	Country,
	COUNT(*) AS number_of_customers
FROM Customers
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Find the top 5 tracks with the highest unit price:
SELECT 
	TrackId, 
	Name, 
	UnitPrice
FROM Tracks
ORDER BY UnitPrice DESC
LIMIT 5;

-- Get the average total duration of tracks in minutes:
SELECT 
	AVG(Milliseconds / 1000 / 60) AS AvgDurationMinutes,
	SUM(Milliseconds) AS Sum_milisec,
	MAX(Milliseconds) Max_milicec,
	MIN(Milliseconds) Min_milisec
FROM Tracks;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JOIN
SELECT *
FROM artists
JOIN albums ON artists.ArtistId=albums.AlbumId

SELECT *
FROM artists
JOIN albums ON artists.ArtistId=albums.AlbumId
JOIN tracks ON artists.ArtistId=tracks.TrackId

-- JOIN
SELECT
	artists.Name,
	albums.Title,
	tracks.Name AS TrackName,
	tracks.Composer,
	tracks.Milliseconds,
	tracks.Bytes,
	genres.Name AS Genre
FROM
	artists
JOIN
	albums ON artists.ArtistId = albums.ArtistId
JOIN
	tracks ON albums.AlbumId = tracks.AlbumId
JOIN
	genres ON tracks.GenreId = genres.GenreId;
	
-- 
SELECT
	genres.Name AS Genre,
	COUNT(*) AS Count_Song,
	SUM(tracks.Bytes) AS Total_bytes,
	SUM(tracks.Milliseconds) AS Total_milliseconds
FROM
	artists
JOIN
	albums ON artists.ArtistId = albums.ArtistId
JOIN
	tracks ON albums.AlbumId = tracks.AlbumId
JOIN
	genres ON tracks.GenreId = genres.GenreId
GROUP BY 
	genres.Name
ORDER BY 
	COUNT(*) DESC

-- Find the albums with their corresponding artists:
SELECT 
	Albums.AlbumId, 
	Albums.Title AS AlbumTitle, 
	Albums.ArtistId, 
	Artists.Name AS ArtistName
FROM Albums
JOIN Artists  ON Albums.ArtistId = Artists.ArtistId;

-- we want to retrieve information about tracks and their corresponding genres:
SELECT tracks.Name AS TrackName, genres.Name AS Genre
FROM tracks
INNER JOIN genres ON tracks.GenreId = genres.GenreId;

-- we want to retrieve information about customers and their corresponding tracks and genres:
SELECT customers.FirstName, customers.LastName, tracks.Name AS TrackName, genres.Name AS Genre
FROM customers
LEFT JOIN invoices ON customers.CustomerId = invoices.CustomerId
LEFT JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
LEFT JOIN tracks ON invoice_items.TrackId = tracks.TrackId
LEFT JOIN genres ON tracks.GenreId = genres.GenreId;