# 1a
select first_name, last_name from actor;
# 1b
select concat(first_name, " ", last_name) as "Actor Name" from actor;
#2a
select actor_id, first_name, last_name from actor where first_name = "Joe";
#2b
select * from actor where last_name like "%GEN%";
#2c
select * from actor where last_name like "%LI%" order by last_name, first_name;
#2d
select country_id, country from country where country in ("Afghanistan", "Bangladesh", 'China'); 
#3a
alter table actor add description BLOB; 
#3b
alter table actor drop description; 
#4a
select last_name, count(last_name) from actor group by last_name;
#4b
select * from 
(select last_name, count(last_name) as count_name from actor group by last_name) as A
where count_name > 2; 
#4c
update actor 
set first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "Williams";
select first_name, last_name from actor where first_name = "HARPO";
#4d
update actor set first_name = "GROUCHO" WHERE first_name = "HARPO" and last_name = "Williams";
select first_name, last_name from actor where last_name = "WILLIAMS";
#5a
select * from address
show create table address;
#6a
select * from address;
select * from staff;
#join from address, staff on address_id;
select first_name, last_name, address from staff 
left join address
on staff.address_id = address.address_id; 
#6b
select * from payment;
select * from staff;
#6b
select first_name, last_name, total_sales_amount from 
(select staff_id, sum(amount) as total_sales_amount from payment 
where month(payment_date) = 08 and year(payment_date) = 2005 
group by staff_id) as august_sales left join staff on august_sales.staff_id = staff.staff_id;
#6c
select * from film;
select * title

select title, count(title) as title_count
from (select title, actor_id from film_actor inner join film on film_actor.film_id = film.film_id) as films
group by title; 
#6d
select film_id from film where title = "Hunchback Impossible";
# the answer is 439
select count(film_id) from inventory where film_id = 439; 
#6e
select * from payment;
select first_name, last_name, total_amount_paid from 
(select customer_id, sum(amount) as total_amount_paid from payment group by customer_id) as spending
left join customer on customer.customer_id = spending.customer_id;
#7a
select * from film where title like "Q%" or title like "K%" 
#7b

select first_name, last_name from actor where actor_id in 
(select actor_id from film_actor where film_id = 
(select film_id from film where title = "Alone Trip"))
#7c

select * from 
(select email, first_name, last_name, country from customer
left join 
(select * from address 
left join 
(select city_id as city_id1, city.country_id, country.country from city 
left join country on city.country_id = country.country_id) as city_country
on address.city_id = city_country.city_id1) as city_country_2
on customer.address_id = city_country_2.address_id) as city_country_3
where country = "Canada"

#7d
select * from film where film_id in 
(select film_id from film_category where category_id = 
(select category_id from category where name = "Family"))

#7e
select title, count(title) as "rentals" from film
inner join inventory on (film.film_id = inventory.film_id)
inner join rental on (inventory.inventory_id = rental.inventory_id)
group by title order by rentals desc; 

#7f
select s.store_id, sum(amount) as gross
from payment p 
inner join rental r on (p.rental_id = r.rental_id)
inner join inventory i on (i.inventory_id = r.inventory_id)
inner join store s on (s.store_id = i.store_id) 
group by s.store_id;

#7g
select store_id, city, country from store s
inner join address a on (s.address_id = a.address_id)
inner join city cit on (cit.city_id =  a.city_id)
inner join country ctr on (cit.country_id = ctr.country_id);

#8a
#CREATE VIEW top_five_genres AS
  SELECT SUM(amount) AS 'Total Sales', c.name AS 'Genre'
  FROM payment p
  INNER JOIN rental r
  ON (p.rental_id = r.rental_id)
  INNER JOIN inventory i
  ON (r.inventory_id = i.inventory_id)
  INNER JOIN film_category fc
  ON (i.film_id = fc.film_id)
  INNER JOIN category c
  ON (fc.category_id = c.category_id)
  GROUP BY c.name
  ORDER BY SUM(amount) DESC
  LIMIT 5;

#8b
select * from top_five_genres;

#8c
drop view top_five_genres;
	 
