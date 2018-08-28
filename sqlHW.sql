use sakila;


-- 1a. You need a list of all the actors who have Display the first and last names of all actors from the table actor. 
select 
	first_name,
    last_name
 from actor;
 
 -- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name. 
select 
	first_name,
    last_name,
    UPPER(CONCAT(first_name, " ",last_name)) as FullName
from actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select
	actor_id,
    first_name,
    last_name
from actor
where first_name = 'JOE';

-- 2b. Find all actors whose last name contain the letters GEN:
select *
from actor
where last_name like '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
select *
from actor
where last_name like '%LI%'
order by last_name, first_name;

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
describe country;

select *
from country
where country_id AND country IN ( 'Afghanistan', 'Bangladesh', 'China' );

-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.

alter table actor
	add column middle_name varchar(255) after first_name;

-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
alter table actor
	modify column middle_name blob;

-- 3c. Now delete the middle_name column.
alter table actor
	drop column middle_name;
    
-- 4a. List the last names of actors, as well as how many actors have that last name.
select
	last_name,
	count(last_name)
from actor
group by last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select
	last_name,
	count(last_name) as l_name
from actor
group by last_name
having l_name > 1;

-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
select
	first_name
from actor
where first_name = 'Harpo';

SET SQL_SAFE_UPDATES = 0;

update actor
set first_name = 'Harpo'
where first_name = 'Groucho';
	
SET SQL_SAFE_UPDATES = 1;    
    
-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)
    
select
	first_name
from actor
where first_name = 'Mucho Groucho';    

SET SQL_SAFE_UPDATES = 0;

update actor
set first_name = 'Mucho Groucho'
where first_name = 'Harpo';
	
SET SQL_SAFE_UPDATES = 1;  
    
    
-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
describe address;

CREATE TABLE IF NOT EXISTS address(
	address varchar(255)
);

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
select * from staff;

select * from address;

select 
	staff.first_name,
    staff.last_name,
    address.address
from staff
join address on staff.address_id = address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment. 
select * from staff;

select * from payment;

select 
	staff.first_name,
    staff.last_name,
    sum(payment.amount)
from staff
join payment on staff.staff_id = payment.staff_id
where left(payment.payment_date, 7) = '2005-08'
group by staff.staff_id;


-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

select * from film;

select * from film_actor;

select 
	film.title,
    count(film_actor.actor_id)
from film
inner join film_actor on film.film_id = film_actor.film_id
group by film.title;


-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select * from inventory;

select * from film where title = 'Hunchback Impossible';

select
	film.title,
	film.film_id,
    inventory.film_id
from film
join inventory on film.film_id = inventory.film_id
where title = 'Hunchback Impossible';

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
select * from payment;

select * from customer;


select 
	customer.first_name,
    customer.last_name,
    customer.customer_id,
    payment.amount
from customer
join payment on customer.customer_id = payment.customer_id
group by customer_id, customer.first_name, customer.last_name
order by last_name asc;	

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. 
select 
	title
from film
where(
	left(title, 1) = 'Q' or left(title, 1) = 'K'
);

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
select
	actor.first_name,
    actor.last_name
from actor





