# HW_Postgresql_DZ1
>1.	Создать новую базу данных с именем forum. В базе создать таблицы users, city, topic. 
Структура таблицы users: id, username,  first_name, last_name, last_activity, password
Структура таблицы city: id, city, country
Структура таблицы topic: id, name_topic, description,  last_activity, last_user
>>2.	Наполнить базу данных forum по 10 строк на каждую таблицу, заполнить все кроме last_activity, 
last_user. Базу данных forum приложить к заданию.
>>>3.	Выбрать из таблицы users: username, first_name, last_name между id 3 и 7

```python
create database lessons_5;
create sequence workers_id;
create table workers 
(
id int not null default nextval('workers_id'),
"table" uuid,
first_name varchar,
last_name varchar,
second_name varchar,
day_of_birth date,
"position" varchar,
description_position text,
salary real,
project varchar,
project_description text,
type_of_penalty varchar,
penalty_points int,
director varchar,
position_director varchar,
primary key(id)
);

create sequence position_id;
create table "position"
(
id int not null default nextval('position_id') primary key,
"position" varchar,
description_position text
);
alter table workers drop column "position", drop column description_position;
alter table workers add column position_id int;

create sequence project_id;
create table project 
(
id int not null default nextval('project_id') primary key,
project varchar,
project_description text
);
alter table workers drop column project, drop column project_description;
alter table workers add column project_id int;

create sequence penalty_id;
create table penalty
(
id int not null default nextval('penalty_id') primary key,
type_of_penalty varchar,
penalty_points int
);
alter table workers drop column type_of_penalty, drop column penalty_points;
alter table workers add column penalty_id int;

create sequence director_id;
create table director
(
id int not null default nextval('director_id') primary key,
director varchar,
position_director varchar
);
alter table workers drop column director, drop column position_director;
alter table workers add column director_id int;
 
insert into director (director, position_director) values 
('Putin V', 'President'),
('Medvedev', 'CEO');
insert into penalty (type_of_penalty, penalty_points) values 
('Опоздание', '500');
insert into project (project, project_description) values 
('Декомпозиция таблиц', 'Декомпозировать таблицу workers до 3 нормальной формы');
insert into "position" ("position", description_position) values 
('Тестировщlessons_5ик', 'Тестирование ПО');

```
