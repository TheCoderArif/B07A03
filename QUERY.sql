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

select * from matches 
where tournament_category = 'Champions League' and match_status = 'Available'



-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).

select * from users
where full_name ilike 'Tanvir%'
   or full_name ilike '%Haque%';



-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.

select
    booking_id,
    user_id,
    match_id,
    seat_number,
    coalesce(payment_status, 'Action Required') as payment_status,
    total_cost
from bookings;



-- Query 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.



