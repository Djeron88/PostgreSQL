# HW_Postgresql_DZ1
>1.	Создать новую базу данных с именем forum. В базе создать таблицы users, city, topic. 
Структура таблицы users: id, username,  first_name, last_name, last_activity, password
Структура таблицы city: id, city, country
Структура таблицы topic: id, name_topic, description,  last_activity, last_user
>>2.	Наполнить базу данных forum по 10 строк на каждую таблицу, заполнить все кроме last_activity, 
last_user. Базу данных forum приложить к заданию.
>>>3.	Выбрать из таблицы users: username, first_name, last_name между id 3 и 7

```python
create database forum;
create table users (
    id INT PRIMARY KEY GENERATED ALWAYS AS identity,
    first_name    VARCHAR(100),
    last_name     VARCHAR(100),
    last_activity VARCHAR(100),
    password      VARCHAR(300)
);
create table city ( 
    id INT PRIMARY KEY GENERATED ALWAYS AS identity,
    city          VARCHAR(100),
    country       VARCHAR(100)  
);
create table topic (
    id INT PRIMARY KEY GENERATED ALWAYS AS identity,
    name_topic    VARCHAR(100),
    description   VARCHAR(200),
    last_activity VARCHAR(100),
    last_user     VARCHAR(100)
);
SELECT username, first_name, last_name FROM users
ORDER BY users
limit 5 offset 2; --OFFSET позволяет указать, с какой строки надо начинать выборку
```

# HW_Postgresql_DZ2 
# Тема: Декомпозиция таблиц, создание таблиц, наполнение таблиц

Задание:

>1. Создать базу данных Lessons_5 и внутри создать таблицу workers со следующими полями id, table uuid, first_name, last_name, second_name, day_of_birth, position, description_position, salary, project, project_description, type_of_penalty, penalty_points, director, position_director.
>>2. Декомпозировать таблицу workers до 3 нормальной формы
>>>3. Наполнить таблицы после декомпозиции таблицы

```sql
create sequence workers_id;
create table workers 
(
id int not null default nextval('workers_id') primary key,
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
penalty_points int,
);
alter table workers drop column penalty, drop column type_of_penalty;
alter table workers add column penalty_id int;

create sequence director_id;
create table director
(
id int not null default nextval('director_id') primary key,
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
