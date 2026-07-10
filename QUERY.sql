-- create database
create database Football_Matches_Management;


-- creating tables 
create table users (
  user_id serial primary key,
  full_name varchar(50),
  email varchar(30) unique not null,
  role varchar(20) not null
        check (role in ('Ticket Manager', 'Football Fan')),
  phone_number varchar(20)
);

create table matches (
  match_id serial primary key,
  fixture varchar(40),
  tournament_category varchar(30),
  base_ticket_price smallint,
  match_status varchar(20) not null
    check (match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

create table bookings (
  booking_id serial primary key,
  user_id smallint references users(user_id),
  match_id smallint references matches(match_id),
  seat_number varchar (10),
  payment_status varchar(10)
    check (payment_status in ('Pending', 'Confirmed' , 'Cancelled', 'Refunded')),
  total_cost smallint
);




-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.


select match_id,fixture,base_ticket_price from matches 
where tournament_category = 'Champions League' and match_status = 'Available'




-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).



select user_id,full_name, email  from users
where full_name ilike 'Tanvir%'
   or full_name ilike '%Haque%';




-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.


select
    booking_id,
    user_id,
    match_id,
    coalesce(payment_status, 'Action Required') as payment_status
    
from bookings;




-- Query 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.


select
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
from bookings as b
inner join users as u
    ON b.user_id = u.user_id
inner join matches as m
    on b.match_id = m.match_id;







-- Query 5: Display a comprehensive list of all users and their booking IDs, ensuring that fans who have never bought a ticket are still listed.

select
    u.user_id,
    u.full_name,
    b.booking_id
from users as u
left join bookings as b
    on u.user_id = b.user_id;





-- Query 6: Find all ticket bookings where the total cost is strictly higher than the average cost of all ticket bookings.


select
    booking_id,
    match_id,
    total_cost
from bookings
where total_cost > (
    select avg(total_cost)
    from bookings
);





-- Query 7: Retrieve the top 2 most expensive matches sorted by base ticket price, skipping the absolute highest premium match.



select
    match_id,
    fixture,
    base_ticket_price
   
from matches
order by base_ticket_price desc
offset 1
limit 2;

