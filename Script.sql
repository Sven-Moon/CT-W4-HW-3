
-- How many actors are there with the last name ‘Wahlberg’?
select count(actor_id)  from actor a 
where last_name = 'Wahlberg' -- = 2

--How many payments were made between $3.99 and $5.99?
select count(payment_id) from payment p 
where amount between  3.99 and  5.99  --3,412

-- What film does the store have the most of? (search in inventory)
select film_id, count(film_id) from inventory i -- 200 (9)
group by film_id 
order by count(film_id) desc
limit 1

-- How many customers have the last name ‘William’?
select count(customer_id) from customer c
where last_name  = 'William' -- 0

-- What store employee (get the id) sold the most rentals?
select staff_id, count(inventory_id)   from  rental r 
group by staff_id 
order by count(inventory_id) desc
limit 1 -- 1

-- How many different district names are there?
select count(distinct district ) from address a -- 378

-- What film has the most actors in it? (use film_actor table and get film_id)
select film_id, count(actor_id)  from film_actor fa 
group by film_id 
order by count(actor_id) desc 
limit 1 -- 508

-- From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)
select count(customer_id) from customer c 
where store_id = 1
 and last_name ~* '.*es$' -- 13


-- How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
-- with ids between 380 and 430? (use group by and having > 250)
select count(agg.amount) from ( 
 select amount, count(rental_id) from payment p 
 where customer_id between 380 and 430
 group by amount
 having count(rental_id) > 250) as agg --3
 

--Within the film table, how many rating categories are there? And what rating has the most
--movies total? 
 select rating, count(film_id) as "movies", rank() over (order by count(film_id) desc) from film f 
 group by rating  -- PG-13 > NC-17 > R > PG > G

 