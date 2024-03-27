# DVD Rental Dimensional Modeling Using PostgreSQL

This repository contains the implementation of a star schema based on sample DVD rental data using PostgreSQL. The star schema is designed to optimize analytical queries and reporting on DVD rental transactions.

## Introduction

The project demonstrates the creation of a star schema from sample DVD rental data. The star schema organizes data into facts and dimensions, facilitating efficient querying and analysis. This README provides an overview of the database schema, setup instructions, and loading data into the schema.

## Dimentional Schema

### Dimension Tables

1. **dimdate:**
   - `date_key` (integer): Primary key for the date dimension.
   - `date` (date): Date value.
   - `year` (smallint): Year value.
   - `quarter` (smallint): Quarter of the year.
   - `month` (smallint): Month of the year.
   - `day` (smallint): Day of the month.
   - `week` (smallint): Week of the year.
   - `is_week` (boolean): Indicates if the date falls on a weekend.

2. **dimcustomer:**
   - `customer_key` (serial): Primary key for the customer dimension.
   - `customer_id` (smallint): Customer ID.
   - `first_name` (varchar): First name of the customer.
   - `last_name` (varchar): Last name of the customer.
   - `email` (varchar): Email address of the customer.
   - `address` (varchar): Customer's address.
   - `address2` (varchar): Additional address information.
   - `district` (varchar): District of the customer's address.
   - `city` (varchar): City of the customer's address.
   - `country` (varchar): Country of the customer's address.
   - `postal_code` (varchar): Postal code of the customer's address.
   - `phone` (varchar): Phone number of the customer.
   - `active` (smallint): Indicates if the customer is active.
   - `create_date` (timestamp): Date when the customer was created.
   - `start_date` (date): Start date of customer's activity.
   - `end_date` (date): End date of customer's activity.

3. **dimmovie:**
   - `movie_key` (serial): Primary key for the movie dimension.
   - `film_id` (smallint): Film ID.
   - `title` (varchar): Title of the movie.
   - `description` (text): Description of the movie.
   - `release_year` (year): Release year of the movie.
   - `language` (varchar): Language of the movie.
   - `rental_duration` (smallint): Rental duration of the movie.
   - `length` (smallint): Length of the movie (in minutes).
   - `rating` (varchar): Rating of the movie.
   - `special_features` (varchar): Special features of the movie.

4. **dimstore:**
   - `store_key` (serial): Primary key for the store dimension.
   - `store_id` (smallint): Store ID.
   - `address` (varchar): Store address.
   - `address2` (varchar): Additional address information.
   - `district` (varchar): District of the store's address.
   - `city` (varchar): City of the store's address.
   - `country` (varchar): Country of the store's address.
   - `postal_code` (varchar): Postal code of the store's address.
   - `manager_first_name` (varchar): First name of the store manager.
   - `manager_last_name` (varchar): Last name of the store manager.
   - `start_date` (date): Start date of store's activity.
   - `end_date` (date): End date of store's activity.

### Fact Table

- **factsales:**
  - `sales_key` (serial): Primary key for the sales fact table.
  - `date_key` (integer): Foreign key referencing the date dimension.
  - `customer_key` (integer): Foreign key referencing the customer dimension.
  - `movie_key` (integer): Foreign key referencing the movie dimension.
  - `store_key` (integer): Foreign key referencing the store dimension.
  - `sales_amount` (integer): Sales amount.

## Setup

To set up the project locally, follow these steps:

1. **Clone the Repository:**
   ```bash
   https://github.com/NADIRHUSSAIN11/DVD-Rental-Dimensional-Modeling-using-PostgreSQL.git
   ```

2. **Install PostgreSQL:**
   Make sure you have PostgreSQL installed on your local machine. You can download it from [here](https://www.postgresql.org/download/).

3. **Create Database:**
   ```bash
   createdb dvdrental
   ```

4. **Connect to Database:**
   ```bash
   psql -d dvdrental
   ```

5. **Run SQL Scripts:**
   Execute the SQL scripts provided in the repository to create tables and load data into the database.

## Loading Data

To load data into the star schema, use the provided SQL scripts and follow the instructions provided in each script.

## Contributing

Contributions to the project are welcome! If you have any suggestions, improvements, or feature requests, please feel free to open an issue or create a pull request.
