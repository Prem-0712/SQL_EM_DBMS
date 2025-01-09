use event_manager_db;

show tables ;

desc clients_name;

select * from clients_name;

desc clients_number;

select * from clients_number;

desc events;

select * from events;

desc venues;

select * from venues;

desc tasks;

select * from tasks;

desc payments;

select * from payments;

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

show tables; 

desc clients_name;


select full_name, event_name from every_info where pay_status =  (select pay_status from every_info where pay_status != "pending" and event_name = "Wedding Reception");