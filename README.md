# HW_Postgresql_DZ1
>1.	Создать новую базу данных с именем forum. В базе создать таблицы users, city, topic. 
Структура таблицы users: id, username,  first_name, last_name, last_activity, password
Структура таблицы city: id, city, country
Структура таблицы topic: id, name_topic, description,  last_activity, last_user
>>2.	Наполнить базу данных forum по 10 строк на каждую таблицу, заполнить все кроме last_activity, 
last_user. Базу данных forum приложить к заданию.
>>3.	Выбрать из таблицы users: username, first_name, last_name между id 3 и 7
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
create database lessons_5;
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
position_director varchar
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
('Petrov', 'President'),
('Medvedev', 'CEO');
insert into penalty (type_of_penalty, penalty_points) values 
('Опоздание', '500');
insert into project (project, project_description) values 
('Декомпозиция таблиц', 'Декомпозировать таблицу workers до 3 нормальной формы');
insert into "position" ("position", description_position) values 
('Тестировщlessons_5ик', 'Тестирование ПО');
```
# HW_Postgresql_DZ4
Задание: 
>1.	Дана таблица с товарами, поставщиками и заказчиками необходимо привести её к 3 нормальной форме в виде таблиц:
Наименование	Поставщик	Адрес поставщика	Кол - во	Цена	Тип оплаты	Заказчик	Адрес заказчика	Кол - во
Зубная паста	ООО Ромашка	г. Буржуев, ул Пушкина, д. 8	100	25р	Наложенный пдатеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	100
Зубная нить	ООО Ромашка	г. Буржуев, ул Пушкина, д. 8	34	300р	Безналичный платеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	34
Ручки шариковые	ООО Ромашка	г. Буржуев, ул Пушкина, д. 8	55	12р	Наличный платеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	55
Вода минеральная	ООО Березка	г. Грехов, ул. Ломоносова, д. 190	2	150р	Наличный платеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	2
Вода минеральная	ООО Березка	г. Павлодар, ул. Ленина, д. 1	350	500р	Безналичный платеж	ООО Рога и Копыта	г. Деревянный, ул. Смирнова, д. 4	300
>>2.	Перевести декомпозированную таблицу в код с данными и внешними ключами (код приложить в виде sql файла на GitHub или GitLab)
```sql
create database HW_DZ_4;

create sequence products_id;
create table products
(
id int not null default nextval('products_id') primary key,
"table"           uuid,
Name              Varchar,
Provider          Varchar,      -- поставщик
Supplier_address  Varchar,    -- адрес постащика
Amount_1            int,         -- кол-во
Price             real,
Payment_type      Varchar,     -- Тип оплаты
Customer          Varchar,     -- Заказчик
Customer_address  Varchar,     -- Адрес заказчика
Amount_2             int 
);

create sequence Provider_id;
create table Provider           -- ПОСТАВЩИК
(
id int not null default nextval('Provider_id') primary key,
Provider          Varchar,
Supplier_address  Varchar
);
alter table products drop column Provider, drop column Supplier_address;
alter table products add column Provider_id int references Provider(id);

insert into Provider (Provider, Supplier_address) values
('ООО Ромашка', 'г. Буржуев, ул Пушкина, д. 8'),
('ООО Березка', 'г. Грехов, ул. Ломоносова, д. 190'),
('ООО Березка', 'г. Павлодар, ул. Ленина, д. 1');

create sequence Customer_id;
create table Customer           -- ЗАКАЗЧИК
(
id int not null default nextval('Customer_id') primary key,
Customer          Varchar,     
Customer_address  Varchar,     
Amount_2             int 
);
alter table products  drop column Customer, drop column Customer_address, drop Amount_2;
alter table products  add column Customer_id int references Customer(id);

ALTER TABLE customer RENAME COLUMN Amount_2 TO Amount;   -- Заменяем атрибут в customer

insert into Customer (Customer, Customer_address, Amount) values
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '100'),
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '34'),
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '55'),
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '2'),
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д. 4', '300');

ALTER TABLE products  RENAME COLUMN Amount_1 TO Amount;   -- Заменяем атрибут в products

create extension if not exists "uuid-ossp"; --создаем генератор id

insert into products ("table", Name, amount, price, payment_type, Provider_id, Customer_id)
values 
(uuid_generate_v4(), 'Зубная паста', '100', '25', 'Наложенный пдатеж', '1', '1'),
(uuid_generate_v4(), 'Зубная нить',  '34', '300', 'Безналичный платеж',  '1', '2'),
(uuid_generate_v4(), 'Ручки шариковые', '55', '12', 'Наличный платеж', '1', '3'),
(uuid_generate_v4(), 'Вода минеральная', '2', '150', 'Наличный платеж', '2', '4'),
(uuid_generate_v4(), 'Вода минеральная', '350', '500', 'Безналичный платеж', '2', '5');

```
