create database World_Cup_Management;

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















