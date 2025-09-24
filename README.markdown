# Chinook Database Analysis Project

## Overview
This project involves analyzing the `Chinook Database`, a sample database representing a digital media store. The work includes data transformation, customer and geographical insights, and product performance analysis to derive actionable business intelligence.

## Meta Data 
### 1. Artist
*   **Purpose:** Stores information about the artists who create music.
*   **Columns:**
    *   `ArtistId` (Primary Key): Unique identifier for each artist.
    *   `Name`: The name of the artist.
### 2. Album
*   **Purpose:** Stores information about music albums.
*   **Columns:**
    *   `AlbumId` (Primary Key): Unique identifier for each album.
    *   `Title`: The title of the album.
    *   `ArtistId` (Foreign Key): Links to the `Artist` table, indicating which artist performed on this album.
### 3. Genre
*   **Purpose:** Categorizes tracks by their musical style or genre.
*   **Columns:**
    *   `GenreId` (Primary Key): Unique identifier for each genre.
    *   `Name`: The name of the genre (e.g., "Rock," "Pop," "Classical").
### 4. MediaType
*   **Purpose:** Describes the format or type of media for a track.
*   **Columns:**
    *   `MediaTypeId` (Primary Key): Unique identifier for each media type.
    *   `Name`: The name of the media type (e.g., "MPEG audio file," "Protected AAC audio file").
### 5. Track
*   **Purpose:** Stores detailed information about individual music tracks (songs). This is a central table.
*   **Columns:**
    *   `TrackId` (Primary Key): Unique identifier for each track.
    *   `Name`: The title of the track.
    *   `AlbumId` (Foreign Key): Links to the `Album` table, indicating which album the track belongs to.
    *   `MediaTypeId` (Foreign Key): Links to the `MediaType` table, specifying the track's format.
    *   `GenreId` (Foreign Key): Links to the `Genre` table, specifying the track's musical genre.
    *   `Composer`: The name of the composer(s) for the track.
    *   `Milliseconds`: The duration of the track in milliseconds.
    *   `Bytes`: The size of the track file in bytes.
    *   `UnitPrice`: The price of a single unit of this track.
### 6. Playlist
*   **Purpose:** Defines playlists created by users, grouping various tracks together.
*   **Columns:**
    *   `PlaylistId` (Primary Key): Unique identifier for each playlist.
    *   `Name`: The name of the playlist.
### 7. PlaylistTrack (Junction/Join Table)
*   **Purpose:** Connects `Playlist` and `Track` tables, allowing a track to be in multiple playlists and a playlist to contain multiple tracks. This resolves a many-to-many relationship.
*   **Columns:**
    *   `PlaylistId` (Primary Key, Foreign Key): Links to the `Playlist` table. Part of a composite primary key.
    *   `TrackId` (Primary Key, Foreign Key): Links to the `Track` table. Part of a composite primary key.
### 8. Employee
*   **Purpose:** Stores information about the employees of the company.
*   **Columns:**
    *   `EmployeeId` (Primary Key): Unique identifier for each employee.
    *   `LastName`: Employee's last name.
    *   `FirstName`: Employee's first name.
    *   `Title`: Employee's job title.
    *   `ReportsTo` (Foreign Key): Links to `Employee` table itself (self-referencing), indicating the manager of this employee. This sets up a hierarchical structure.
    *   `BirthDate`: Employee's birth date.
    *   `HireDate`: Employee's hire date.
    *   `Address`: Employee's street address.
    *   `City`: Employee's city.
    *   `State`: Employee's state/province.
    *   `Country`: Employee's country.
    *   `PostalCode`: Employee's postal code.
    *   `Phone`: Employee's phone number.
    *   `Fax`: Employee's fax number.
    *   `Email`: Employee's email address.
### 9. Customer
*   **Purpose:** Stores information about the customers of the company.
*   **Columns:**
    *   `CustomerId` (Primary Key): Unique identifier for each customer.
    *   `FirstName`: Customer's first name.
    *   `LastName`: Customer's last name.
    *   `Company`: Customer's company name (if applicable).
    *   `Address`: Customer's street address.
    *   `City`: Customer's city.
    *   `State`: Customer's state/province.
    *   `Country`: Customer's country.
    *   `PostalCode`: Customer's postal code.
    *   `Phone`: Customer's phone number.
    *   `Fax`: Customer's fax number.
    *   `Email`: Customer's email address.
    *   `SupportRepId` (Foreign Key): Links to the `Employee` table, indicating which employee is assigned as the support representative for this customer.
### 10. Invoice
*   **Purpose:** Records details of customer invoices (orders).
*   **Columns:**
    *   `InvoiceId` (Primary Key): Unique identifier for each invoice.
    *   `CustomerId` (Foreign Key): Links to the `Customer` table, indicating which customer the invoice belongs to.
    *   `InvoiceDate`: The date the invoice was generated.
    *   `BillingAddress`: The billing address for the invoice.
    *   `BillingCity`: The billing city for the invoice.
    *   `BillingState`: The billing state/province for the invoice.
    *   `BillingCountry`: The billing country for the invoice.
    *   `BillingPostalCode`: The billing postal code for the invoice.
    *   `Total`: The total amount of the invoice.
### 11. InvoiceLine (Detail/Line Item Table)
*   **Purpose:** Stores individual items or tracks included in an `Invoice`. This table details *what* was purchased on an invoice.
*   **Columns:**
    *   `InvoiceLineId` (Primary Key): Unique identifier for each invoice line item.
    *   `InvoiceId` (Foreign Key): Links to the `Invoice` table, indicating which invoice this line item belongs to.
    *   `TrackId` (Foreign Key): Links to the `Track` table, indicating which specific track was purchased.
    *   `UnitPrice`: The price of the track at the time of purchase (may differ from `Track.UnitPrice` if prices change).
    *   `Quantity`: The number of units of that track purchased.
## Relations
![Schema](https://github.com/HazemMedhat/Chinook-Database-Analysis-Project/blob/74bc5d5fb89a409eaa63ff08bd235effb1437f5e/Schema.png)

1.  **Artist to Album (One-to-Many):** An `Artist` can have many `Album`s, but an `Album` is typically by only one `Artist`.

2.  **Album to Track (One-to-Many):** An `Album` can contain many `Track`s, but each `Track` belongs to only one `Album`.

3.  **MediaType to Track (One-to-Many):** A `MediaType` (e.g., "MPEG audio") can apply to many `Track`s, but each `Track` has only one `MediaType`.

4.  **Genre to Track (One-to-Many):** A `Genre` can apply to many `Track`s, but each `Track` typically belongs to only one `Genre`.

5.  **Playlist to PlaylistTrack (One-to-Many):** A `Playlist` can have many entries in `PlaylistTrack` (i.e., contain many tracks).

6.  **Track to PlaylistTrack (One-to-Many):** A `Track` can appear in many entries in `PlaylistTrack` (i.e., be part of many playlists).

7.  **Employee (Self-Referencing - Manager/Subordinate) (One-to-Many):** An `Employee` (manager) can have many other `Employee`s reporting to them, but an `Employee` reports to only one manager (or none if they are the top).

8.  **Employee to Customer (One-to-Many):** An `Employee` (support rep) can be responsible for many `Customer`s, but each `Customer` has only one `SupportRep`.

9.  **Customer to Invoice (One-to-Many):** A `Customer` can have many `Invoice`s, but each `Invoice` belongs to only one `Customer`.

10. **Invoice to InvoiceLine (One-to-Many):** An `Invoice` can have many `InvoiceLine` items, but each `InvoiceLine` belongs to only one `Invoice`.

11. **Track to InvoiceLine (One-to-Many):**A `Track` can appear in many `InvoiceLine` items (i.e., be purchased multiple times), but each `InvoiceLine` refers to only one `Track`.

## Work Done

### Data Transformation
- Combined Customer Names: 
    Created a new `FullName` column in the Customer table by concatenating `FirstName` and `LastName` with a space separator, stored as VARCHAR(100).
- Added Sales Column: 
    Introduced a `Sales` column in the InvoiceLine table, calculated as the product of `Quantity` and `UnitPrice`, stored as DECIMAL(5,3)

### Customer and Geographical Insights
- **Top 10 Customers by Spending :** Identified the top 10 customers based on total spending from invoices, ranked in descending order.
- **Top 5 Revenue-Generating Countries :** Determined the top 5 countries contributing the most revenue, aggregated from customer invoices.
- **Top 3 Cities per Country by Revenue :** Analyzed revenue by city within each country, selecting the top 3 cities per country using a window function.
- **Customer Purchase Frequency vs. Monetary Value (PF vs. MV) :** Calculated the number of invoices (Purchase Frequency) and total spending (Monetary Value) for each customer, sorted by frequency and value.

### Product Performance (Tracks, Albums, Genres)
- **Top 10 Selling Tracks :** Listed the top 10 tracks by total sales, derived from the `Sales` column in `InvoiceLine`.
- **Top 5 Revenue-Generating Albums :** Identified the top 5 `albums` by total sales, linking through Track and `InvoiceLine`.
- **Top 3 Revenue-Generating Artists :** Ranked the top 3 `artists` by total sales, traversing Artist, Album, Track, and `InvoiceLine`.
- **Most Popular Genre:** Determined the `genre` with the highest purchase count based on `InvoiceLine` data.
- **Most Preferred Media Type:** Found the media type with the greatest number of purchases, analyzed via `MediaType` and `InvoiceLine`.
