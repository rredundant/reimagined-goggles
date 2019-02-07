use sakila;

-- Question 1a
select a.first_name, a.last_name
from actor a

-- Question 1b
select concat(a.first_name, " ", a.last_name) as "Actor Name"
from actor a

-- Question 2a
select a.actor_id, a.first_name, a.last_name
from actor a
having a.first_name = 'Joe'

-- Question 2b
select a.*
from actor a
having a.last_name like '%GEN%'

-- Question 2c
select a.*
from actor a
having a.last_name like '%LI%'
order by a.last_name asc, a.first_name asc

-- Question 2d
select c.country_id, c.country
from country c
having c.country in ("Afghanistan", "Bangladesh", "China")

-- Question 3a
alter table actor
add column description blob after last_name;

-- Question 3b
alter table actor
drop column description;

-- Question 4a
select last_name, count(last_name)
from actor
group by 1
order by 2 desc;

-- Question 4b
select last_name, count(last_name) as cnt
from actor
group by 1
having cnt >=2
order by 2 desc;

-- Question 4c
update actor
set first_name = 'GROUCHO'
where first_name = 'HARPO' and last_name = "WILLIAMS"

-- Question 4d
update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO' AND last_name = "WILLIAMS"

-- Question 5a
SHOW CREATE TABLE address

-- Question 6a
select s.first_name, s.last_name, a.address
from staff s join address a on s.address_id = a.address_id

-- Question 6b
select s.first_name, s.last_name, sum(p.amount) as "total payments"
from staff s join payment p on s.staff_id = p.staff_id
group by 1,2

-- Question 6c
select f.title, count(fa.actor_id) as "actor count"
from film f join film_actor fa on f.film_id = fa.film_id
group by 1

-- Question 6d
select f.title, count(i.inventory_id) as "inventory"
from film f join inventory i on f.film_id = i.film_id
where f.title = "HUNCHBACK IMPOSSIBLE"
group by 1

-- Question 6e
select concat(c.last_name, ", ", c.first_name) as "customer_name", sum(p.amount) as "total_payments"
from customer c join payment p on c.customer_id = p.customer_id
group by 1 
order by 1 asc

-- Question 7a
select t.title, l.name as language
from(
select title, language_id
from film
having title like 'K%' or title like 'Q%') t 
join language l on t.language_id = l.language_id
having language like "English"

-- Question 7b
select a.first_name, a.last_name
from(select fa.actor_id, fa.film_id
from(select title, film_id
from film
having title like "Alone Trip") t 
join film_actor fa on t.film_id = fa.film_id) tt
join actor a on tt.actor_id = a.actor_id

-- Question 7c
select cu.last_name, cu.first_name, cu.email, co.country
from customer cu
	left join address a on cu.address_id = a.address_id
    left join city ci on a.city_id = ci.city_id
    left join country co on ci.country_id = co.country_id
where co.country = 'Canada'

-- Question 7d
select f.title, c.name as "category"
from film f
	left join film_category fc on f.film_id = fc.film_id
    left join category c on fc.category_id = c.category_id
where c.name = "family"

-- Question 7e
select f.title, count(r.rental_id) as "rent_count"
from film f
	left join inventory i on f.film_id = i.film_id
    left join rental r on i.inventory_id = r.inventory_id
group by 1
order by 2 desc

-- Question 7f
select so.store_id, sum(p.amount) as "total_sales"
from store so
	join staff sa on so.store_id = sa.store_id
    join payment p on sa.staff_id = p.staff_id
group by 1
order by 2 desc

-- Question 7g
select s.store_id, ci.city, co.country
from store s
	join address a on s.address_id = a.address_id
    join city ci on a.city_id = ci.city_id
    join country co on ci.country_id = co.country_id

-- Question 7h
select c.name, sum(p.amount) as "gross_revenue"
from category c
	join film_category f on c.category_id = f.category_id
    join inventory i on f.film_id = i.film_id
    join rental r on i.inventory_id = r.inventory_id
    join payment p on r.rental_id = p.rental_id
group by 1
order by 2 desc
limit 5

-- Question 8a
create view top_five_genres as
	select c.name, sum(p.amount) as "gross_revenue"
	from category c
		join film_category f on c.category_id = f.category_id
		join inventory i on f.film_id = i.film_id
		join rental r on i.inventory_id = r.inventory_id
		join payment p on r.rental_id = p.rental_id
	group by 1
	order by 2 desc
	limit 5
    
    -- Question 8b
    select * from top_five_genres
    
    -- Question 8c
    DROP VIEW IF EXISTS top_five_genres;