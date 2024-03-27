Create Table dimdate (
	
	date_key integer NOT NULL PRIMARY KEY,
	date date NOT NULL,
	year smallint NOT NULL,
	quarter smallint NOT NULL,
	month smallint NOT NULL,
	day smallint NOT NULL,
	week smallint NOT NULL,
	is_week boolean
)


Create Table dimcustomer (
	
	customer_key SERIAL PRIMARY KEY,
	customer_id smallint NOT NULL,
	first_name varchar(45) NOT NULL,
	last_name varchar(45) NOT NULL,
	email varchar(50) ,
	address varchar(50) NOT NULL,
	address2 varchar(50) ,
	district varchar(30) NOT NULL,
	city varchar(40) NOT NULL,
	country varchar(40) NOT NULL,
	postal_code varchar(10),
	phone varchar(20) NOT NULL,
	active smallint NOT NULL,
	create_date timestamp NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL
	
)

Create Table dimmovie (
	movie_key SERIAL PRIMARY KEY,
	film_id smallint NOT NULL,
	title varchar(255) NOT NULL,
	description text,
	realease_year year,
	language varchar(20) NOT NULL,
	original_language varchar(20),
	rental_duration smallint NOT NULL,
	length smallint NOT NULL,
	rating smallint NOT NULL,
	special_features varchar(60) NOT NULL
)

Create Table dimstore (
	store_key SERIAL PRIMARY KEY,
	store_id smallint NOT NULL,
	address varchar(50) NOT NULL,
	address2 varchar(50) ,
	district varchar(30) NOT NULL,
	city varchar(40) NOT NULL,
	country varchar(40) NOT NULL,
	postal_code varchar(10),
	manager_first_name varchar(50) NOT NULL,
	manager_last_name varchar(50) NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL
)

INSERT INTO dimdate(date_key,date,year,quarter,month,day,week,is_week)

SELECT
	DISTINCT(TO_CHAR(payment_date :: DATE,'yyyyMMDD')::integer) as date_key,
	date(payment_date) as date,
	extract(year from payment_date) as year,
	extract(quarter from payment_date) as quarter,
	extract(month from payment_date) as month,
	extract(day from payment_date) as day,
	extract(week from payment_date) as week,
	CASE WHEN extract(ISODOW FROM payment_date) in (6,7) THEN true ELSE false end as is_week
FROM payment;


INSERT INTO dimcustomer(customer_key,customer_id,first_name,last_name,email,address,address2,district,city,country,postal_code,phone,active,create_date,start_date,end_date)

SELECT 
	c.customer_id as customer_key,
	c.customer_id,
	c.first_name,
	c.last_name,
	c.email,
	a.address,
	a.address2,
	a.district,
	ci.city,
	co.country,
	a.postal_code,
	a.phone,
	c.active,
	c.create_date,
	now() as start_date,
	now() as end_date

FROM customer c join
address a on (c.address_id=a.address_id)
join city ci on (a.city_id=ci.city_id)
join country co on (ci.country_id=co.country_id)

INSERT INTO dimstore(store_key,store_id,address,address2,district,city,country,postal_code,manager_first_name,manager_last_name,start_date,end_date)

SELECT 
	s.store_id as store_key,
	s.store_id,
	a.address,
	a.address2,
	a.district,
	ci.city,
	co.country,
	a.postal_code,
	sf.first_name as manager_first_name,
	sf.last_name as manager_last_name,
	now() as start_date,
	now() as end_date

FROM store s join
address a on (s.address_id=a.address_id)
join city ci on (a.city_id=ci.city_id)
join country co on (ci.country_id=co.country_id)
join staff sf on (s.store_id=sf.store_id)


ALTER TABLE dimmovie
DROP COLUMN rating,
DROP COLUMN original_language;

ALTER TABLE dimmovie
ADD COLUMN rating varchar(50) NOT NULL;

ALTER TABLE dimmovie
DROP COLUMN special_features;

ALTER TABLE dimmovie
ADD COLUMN special_features varchar(255) NOT NULL;	


INSERT INTO dimmovie(movie_key,film_id,title,description,realease_year,language,rental_duration,length,rating,special_features)

SELECT 
		f.film_id as movie_key,
		f.film_id,
		f.title,
		f.description,
		f.release_year,
		l.name as language,
		f.rental_duration,
		f.length,
		f.rating,
		f.fulltext
FROM film f join 
language l on (f.language_id=l.language_id)


create table factsales(

	sales_key SERIAL PRIMARY KEY,
	date_key integer REFERENCES dimdate(date_key),
	customer_key integer REFERENCES dimcustomer(customer_key),
	movie_key integer REFERENCES dimmovie(movie_key),
	store_key integer  REFERENCES dimstore(store_key),
	sales_amount integer
)

INSERT INTO factsales(date_key,customer_key,movie_key,store_key,sales_amount)
SELECT

	TO_CHAR(payment_date :: DATE,'yyyyMMDD')::integer as date_key,
	p.customer_id as customer_key,
	i.film_id as movie_key,
	i.store_id as store_key,
	p.amount as sales_amount
	
FROM payment p join
rental r on (p.rental_id=r.rental_id)
join inventory i on (i.inventory_id=r.inventory_id)
	
	


