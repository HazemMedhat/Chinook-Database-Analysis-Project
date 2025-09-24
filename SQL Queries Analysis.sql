/* USE Database */
USE [Chinook Database]

/* Transformation */

-- Combine first and last name to one column
ALTER TABLE Customer ADD FullName VARCHAR(100);
UPDATE Customer 
SET FullName = FirstName + ' ' + LastName;

-- Calculate Sales Amount
ALTER TABLE InvoiceLine ADD Sales DECIMAL(5,3);
UPDATE InvoiceLine 
SET Sales = Quantity*UnitPrice;


/* Customer and Geographical Insights */

-- Top 10 Customer Based on Sales
SELECT TOP(10) 
C.FullName AS CustomerName , SUM(I.Total) AS TotalSpending 
FROM Customer C INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
GROUP BY C.FullName 
ORDER BY SUM(I.Total) DESC

-- Top 5 Countries Generate Revenue
SELECT TOP(5) 
C.Country AS CustomerCountry , SUM(I.Total) AS Revenue 
FROM Customer C INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
GROUP BY C.Country
ORDER BY SUM(I.Total) DESC

-- Top 3 Cities Generate Revenue in each Country
WITH CityRevenue AS (
    SELECT 
        c.Country,
        c.City,
        SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
    FROM Customer c
    INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
    INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
    GROUP BY c.Country, c.City
),
RankedCities AS (
    SELECT 
        Country,
        City,
        TotalRevenue,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY TotalRevenue DESC) AS CityRank
    FROM CityRevenue
)
SELECT 
    Country,
    City,
    TotalRevenue
FROM RankedCities
WHERE CityRank <= 3
ORDER BY Country,TotalRevenue DESC;

-- Customer PF VS MV
SELECT C.FullName , COUNT(I.InvoiceId) AS PF , SUM(I.Total) AS MV 
FROM Customer C INNER JOIN Invoice I 
ON C.CustomerId = I.CustomerId
GROUP BY C.FullName
ORDER BY PF DESC , MV DESC;

/* Product Performance (Tracks, Albums, Genres) */

--Top 10 Selling Tracks
SELECT TOP(10) 
T.Name AS TrackName , SUM(L.Sales) AS TotalSales
FROM Track T INNER JOIN InvoiceLine L
ON T.TrackId = L.TrackId
GROUP BY T.Name
ORDER BY TotalSales DESC;

-- TOP 5 Albums Generate Revenue
SELECT TOP(5) 
A.Title AS AlbumTitle , SUM(L.Sales) AS TotalSales
FROM Album A INNER JOIN Track T 
ON A.AlbumId = T.AlbumId
INNER JOIN InvoiceLine L
ON T.TrackId = L.TrackId
GROUP BY A.Title
ORDER BY TotalSales DESC;

--Top 3 Artist Generate Revenue
SELECT TOP(3) 
AR.Name AS ArtistName, SUM(L.Sales) AS TotalSales
FROM Artist AR INNER JOIN Album A 
ON AR.ArtistId = A.ArtistId
INNER JOIN Track T 
ON A.AlbumId = T.AlbumId
INNER JOIN InvoiceLine L
ON T.TrackId = L.TrackId
GROUP BY AR.Name
ORDER BY TotalSales DESC;

-- Most Popular Gnere
SELECT TOP 1
    G.Name AS MediaType,
    COUNT(il.InvoiceLineId) AS PurchaseCount
FROM Genre G
INNER JOIN Track t ON G.GenreId = t.GenreId
INNER JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY G.Name
ORDER BY PurchaseCount DESC;

--Most Prefered MediaType
SELECT TOP 1
    mt.Name AS MediaType,
    COUNT(il.InvoiceLineId) AS PurchaseCount
FROM MediaType mt
INNER JOIN Track t ON mt.MediaTypeId = t.MediaTypeId
INNER JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY mt.Name
ORDER BY PurchaseCount DESC;
