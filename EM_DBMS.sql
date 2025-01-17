use event_manager_db;

show tables ;

desc clients_name;

create table clients_name 
(
	client_id int auto_increment primary key,
    first_name varchar(100) not null,
    last_name varchar (100) not null
);

select * from clients_name;

insert into clients_name ( first_name, last_name )
values ( "Monique", "Diack" ),
( "Sibilla", "Maryman" ),
( "Willy", "Grigolashvill"),
( "John", "Doe" ),
( "Jane", "Smith" );

desc clients_number;

create table clients_number
(
	client_id int,
    client_numebr varchar ( 100 ),
    foreign key ( client_id ) references clients_name ( client_id )
);

insert into clients_number ( client_id, client_number)
values ( 1, "1094763928" ),
( 1, "1935274936" ),
( 2, "8329017564" ),
( 3, "2745372910" ), 
( 3, "4653729064" ),
( 4, "1234567890" ),
( 4, "9876543210" ),
( 5, "5551234567" ), 
( 5, "5559876543" ),
( 5, "5551112222" );

select * from clients_number;

desc events;

create table events
(
	event_id int auto_increment primary key,
    event_name varchar ( 100 ) not null,
    client_id int,
    venue_id int,
    task_id int,
    foreign key ( client_id )references clients_name ( client_id ) on update cascade,
    foreign key ( venue_id )references venues ( venue_id ) on update cascade,
    foreign key ( task_id )references tasks ( task_id ) on update cascade
);

select * from events;

insert into events ( event_name, client_id, venue_id, task_id )
values ( "Wedding Reception", 1, 1, 1 ),
( "Corporate Seminar", 3, 3, 2 ),
( "Birthday Party", 2, 2, 3 ),
( "Product Launch", 1, 4, 4 ),
( "Charity Gala", 4, 5, 5 ),
( "Engagement Ceremony", 3, 6, 6 ),
( "Anniversary Dinner", 2, 7, 7 ),
( "Fashion Show", 4, 8, 8 ),
( "Music Festival", 5, 9, 9 ),
( "Award Night", 5, 10, 10 );

desc venues;

create table venues
(
	venue_id int auto_increment primary key,
    venue_name varchar ( 100 ) not null,
    client_id int,
    foreign key ( client_id )references clients_name ( client_id )
);

select * from venues;

insert into venues ( venue_name, client_id )
values ( "Grand Banquet", 1 ),
( "Sunset Ballroom", 2 ),
( "Elite Conference", 3 ),
( "Oceanview Hall", 5 ), 
( "Skyview Terrace", 4 ),
( "Royal Gardens", 3 ),
( "Harmony Pavilion", 2 ),
( "Moonlit Meadows", 1 ),
( "Paradise Plaza", 5 ),
( "Starlit Courtyard", 4 );

desc tasks;

create table tasks
(
	task_id int auto_increment primary key,
    task_name varchar ( 100 ) not null,
    client_id int,
    foreign key ( client_id )references clients_name ( client_id )
);

select * from tasks;

insert into tasks ( task_name, client_id )
values ( "Catering Setup", 1 ),
( "Audio-Visual Setup", 3 ),
( "Decorations Setup", 2 ),
( "Guest Management", 2 ),
( "Lighting Setup", 4 ),
( "Stage Design", 3 ),
( "Photography Setup", 5 ),
( "DJ and Music Setup", 4 ),
( "Security Management", 1 ),
( "VIP Area Management", 5 );

desc payments;

create table payments
(
	pay_id int auto_increment primary key,
    pay_status varchar ( 100 ) not null,
    client_id int, 
    foreign key ( client_id )references clients_name ( client_id )on update cascade
);

select * from payments;

insert into payment ( pay_status, client_id )
values ( "Paid", 1 ),
( "Pending", 4 ),
( "Pending", 2 ),
( "Paid", 5 ),
( "Pending", 3 ),
( "Paid", 2 ),
( "Paid", 3 ),
( "Pending", 1 ),
( "Paid", 4 ),
( "Pending", 5 );

CREATE VIEW clients_info AS
SELECT 
    cn.client_id,
    CONCAT(cn.first_name, ' ', cn.last_name) AS full_name,
    cnum.client_number
FROM 
    clients_name cn
JOIN 
    clients_number cnum
ON 
    cn.client_id = cnum.client_id;
    
select * from clients_info;

select * from clients_name
left join clients_number
on clients_name.client_id = clients_number.client_id;	

select * from clients_name
right join clients_number
on clients_name.client_id = clients_number.client_id;	

select * from clients_name
natural join clients_number;

select * from clients_info
natural join venues;

create view venue_info as
select distinct 
	ci.client_id,
    ci.full_name,
    v.venue_name
from 
	clients_info ci

join 
	venues v
    
on 
	ci.client_id = v.client_id;
    
select * from venue_info;

select * from clients_info
natural join tasks;

create view tasks_info as
select distinct
	ci.client_id,
    ci.full_name,
    t.task_name
    
from
	clients_info ci
    
join 
	tasks t
    
on 
	ci.client_id = t.client_id;
    
select * from tasks_info;

select * from events;

create view events_info as
select distinct
	ci.client_id,
    ci.full_name,
    e.event_name
    
from 
	clients_info ci

join 
	events e 
    
on 
	ci.client_id = e.client_id;

select * from events_info;

SELECT 
    e.event_name,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    v.venue_name,
    t.task_name
FROM 
    events e
JOIN 
    clients_name c ON e.client_id = c.client_id
JOIN 
    venues v ON e.venue_id = v.venue_id
JOIN 
    tasks t ON e.task_id = t.task_id;


select * from payments;

select distinct
	ci.client_id,
    ci.full_name,
    p.pay_status
    
from
	clients_info ci
    
join 
	payments p
    
on 
	ci.client_id = p.client_id;
    
select * from clients_info;

select * from events;

select * from venues;

select * from tasks;

select * from payments;   

create view every_info as
select distinct 
	ci.client_id,
    ci.full_name,
    e.event_name, 
    v.venue_name,
    t.task_name,
    p.pay_status
    
FROM 
    clients_info ci
JOIN 
    events e ON ci.client_id = e.client_id
JOIN 
    venues v ON e.venue_id = v.venue_id
JOIN 
    tasks t ON e.task_id = t.task_id
JOIN 
    payments p ON ci.client_id = p.client_id;
    
select * from every_info;

select distinct * from every_info where client_id between 1 and 3; 

show tables; 

desc clients_name;


select full_name, event_name from every_info where pay_status =  (select pay_status from every_info where pay_status != "pending" and event_name = "Wedding Reception");

SELECT 
    ci.client_id, 
    ci.full_name, 
    COUNT(e.event_id) AS total_events
FROM 
    clients_info ci
JOIN 
    events e ON ci.client_id = e.client_id
GROUP BY 
    ci.client_id, ci.full_name
HAVING 
    COUNT(e.event_id) > 1;
    
select distinct full_name, venue_name from every_info where client_id between 1 and 3;

select client_id, full_name from clients_info limit 2 offset 2;

select distinct full_name, event_name from events_info where full_name like "M%";

select min(client_id) from clients_info ;
select max(client_id) from clients_info ;

select * from clients_info;

select * from clients_number;

delete from clients_number where client_number = "5559876543";

select * from venues ;

select e.event_name, v.venue_name 
from events e
join venues v
on 
e.client_id = v.client_id;

SELECT DISTINCT
    ci.client_id, 
    ci.full_name, 
    e.event_name 
FROM 
    clients_info ci
LEFT JOIN 
    events e 
ON 
    ci.client_id = e.client_id;
    
    SELECT DISTINCT
    e.event_name, 
    ci.full_name 
FROM 
    events e
RIGHT JOIN 
    clients_info ci 
ON 
    e.client_id = ci.client_id;
    
select full_name from clients_info
union
select event_name from events;

select * from events_info;

select * from payments;

update payments 
set pay_status = "Paid"
where client_id = 4;

select * from clients_name;

desc clients_name;

alter table clients_name
modify column first_name varchar ( 200 );

alter table clients_name
add column price int;

desc clients_name;

alter table clients_name
change column f_name first_name varchar (100);

select * from clients_name;
select * from events;

SELECT 
    CONCAT(cn.first_name, ' ', cn.last_name) AS full_name, 
    COUNT(e.event_id) AS event_count
FROM 
    events e
JOIN 
    clients_name cn 
ON 
    e.client_id = cn.client_id
GROUP BY 
    cn.first_name, cn.last_name
HAVING 
    COUNT(e.event_id) > 1;




alter table clients_name
drop column price;

select * from clients_name;

SELECT 
    CONCAT(cn.first_name, ' ', cn.last_name) AS full_name
FROM 
    clients_name cn
WHERE 
    cn.client_id IN (
        SELECT DISTINCT e.client_id
        FROM events e
    );
    
    
SELECT LENGTH('Event Manager') AS string_length;

SELECT UPPER('Event Manager') AS upper_case;

SELECT REPLACE('Event Manager', 'Event', 'Task') AS replaced_string;

SELECT REVERSE('Event Manager') AS reversed_string;